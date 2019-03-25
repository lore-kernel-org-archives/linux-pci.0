Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7348C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D142085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vK1/5+Kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfCYJRw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:17:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36690 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfCYJRw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 05:17:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P98RhA185490;
        Mon, 25 Mar 2019 09:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=GkCk2Rp2YNBTUML3PpPU0rkGsoVMgR2Fd2LI4BVag9U=;
 b=vK1/5+KfvPPjW4Xbo74yvS0JKe8b1c0cs0AABTGJjyXj/IxIJMZjMR4ZCeO/KwqleNTm
 H6VRgZ0w3g2EkikOFuXy1qaikM8oypi7vJ4cPygFVIv7Oy4Ei08QHG2vLGCqRHhibN1u
 XfOEbzTWHh4JUm95vAyNm6eAfQWeYYd3o5yEldpFR/nE9nu8xHAhMeDEnAtpn/9tPBTD
 0TpakwZHKm4GSCYtxoQSp/3i5S/DdQMXEsPADRnByUir9UegkfVnvrgB+4pOiSmLCv9Z
 K0+H1AjvKG8nSZva2eWAtmIwpu/f3HcUPyPeYO5w278XppRtDzW6fhAd3JPJnFtB2f/J dw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2re6dj2v41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 09:17:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2P9HgO9022460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 09:17:42 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2P9Hd4L013442;
        Mon, 25 Mar 2019 09:17:41 GMT
Received: from kadam (/197.157.34.176)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 02:17:39 -0700
Date:   Mon, 25 Mar 2019 12:17:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Kelvin Cao <kelvin.cao@microsemi.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
Subject: [PATCH] ntb_hw_switchtec: potential shift wrapping bug in
 switchtec_ntb_init_sndev()
Message-ID: <20190325091726.GD16023@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250070
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This code triggers a Smatch warning:

    drivers/ntb/hw/mscc/ntb_hw_switchtec.c:884 switchtec_ntb_init_sndev()
    warn: should '(1 << sndev->peer_partition)' be a 64 bit type?

The "part_map" and "tpart_vec" variables are u64 type so this seems like
a valid warning.

Fixes: 3df54c870f52 ("ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index d905d368d28c..26a88731b0cb 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -881,7 +881,7 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 		}
 
 		sndev->peer_partition = ffs(tpart_vec) - 1;
-		if (!(part_map & (1 << sndev->peer_partition))) {
+		if (!(part_map & (1ULL << sndev->peer_partition))) {
 			dev_err(&sndev->stdev->dev,
 				"ntb target partition is not NT partition\n");
 			return -ENODEV;
-- 
2.17.1

