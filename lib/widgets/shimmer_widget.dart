import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      child: ListView.builder(
          itemCount: 12,
          itemBuilder: (
            context,
            index,
          ) =>
              shimmerItem(context: context)),
    );
  }

  Widget verticalSpace(double height) => SizedBox(
        height: height,
      );

  Widget littleContainer(
          {required context,
          required double width,
          required double height,
          required double radius}) =>
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(radius),
        ),
      );

  Widget shimmerItem({required context}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.22,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Theme.of(context).splashColor,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blueGrey),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                helperColumnShimmer(context),
              ],
            ),
          ),
        ],
      );

  Column helperColumnShimmer(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Theme.of(context).splashColor,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: littleContainer(
              context: context,
              width: MediaQuery.of(context).size.width * 0.35,
              height: 30,
              radius: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Shimmer.fromColors(
          baseColor: Theme.of(context).splashColor,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: littleContainer(
              context: context,
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.height * 0.02,
              radius: 16),
        ),
      ],
    );
  }
}
