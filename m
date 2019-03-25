Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C35C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3183220830
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="NEDlIcLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfCYSuM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:50:12 -0400
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:51875 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728912AbfCYSuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 14:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1553539765; x=1585075765;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Jq8LLOHfDnSwDrEY/5/B8R0fRJzvwjf6q23Ht59UBfM=;
  b=NEDlIcLlhcmNfrzKxP8KKbtpjMOqyw6A9c4ls+NfVN9FzllgFCn+3fVE
   RZmXh4zH1cchl1068FV0y65yvfsnp2HAtkN5X5T7NfRI25TBO5RnOtjUI
   n7BPnjwocR04QarHzg0MbkDIk+9vs9riAAhpfWn4pCLZCIN/vp/s8JqFN
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EDAAA5IZlchyWd50NkGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUgQBAQEBCwGCZ4EUJwqMf4xQmDoUgWcNAQEshECFFSI1CA0?=
 =?us-ascii?q?BAQMBAQkBAwIBAQIQAQEBCgsJCCkvgjoignABAQQSKD8QAgEIGB4QVwIEARI?=
 =?us-ascii?q?IGoMAgXaiJT0Cb4EBiQcBAQGCHoorgS8BizGCFoQjPoQRARIBH4VhA4oYgiy?=
 =?us-ascii?q?YUgkFkywhk34tim+TKgIEAgQFAhWBTgGBHHFwgzyCFg4Jjh5BMYEojECBHwG?=
 =?us-ascii?q?BHgEB?=
X-IPAS-Result: =?us-ascii?q?A2EDAAA5IZlchyWd50NkGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?gQBAQEBCwGCZ4EUJwqMf4xQmDoUgWcNAQEshECFFSI1CA0BAQMBAQkBAwIBA?=
 =?us-ascii?q?QIQAQEBCgsJCCkvgjoignABAQQSKD8QAgEIGB4QVwIEARIIGoMAgXaiJT0Cb?=
 =?us-ascii?q?4EBiQcBAQGCHoorgS8BizGCFoQjPoQRARIBH4VhA4oYgiyYUgkFkywhk34ti?=
 =?us-ascii?q?m+TKgIEAgQFAhWBTgGBHHFwgzyCFg4Jjh5BMYEojECBHwGBHgEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Mar 2019 13:49:25 -0500
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PImtOn033477
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2019 14:50:10 -0400
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0b-00154901.pphosted.com with ESMTP id 2rf0ywhcgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2019 14:50:10 -0400
Cc:     <linux-pci@vger.kernel.org>, <Austin.Bolen@dell.com>,
        <keith.busch@intel.com>, <Shyam.Iyer@dell.com>, <okaya@kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Mar 2019 00:49:57 +0600
X-LoopCount0: from 10.166.134.86
X-IronPort-AV: E=Sophos;i="5.60,269,1549951200"; 
   d="scan'208";a="1215748814"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>, <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH 1/2] PCI/LINK: bw_notification: Clear interrupt before
 enabling it
Thread-Topic: [PATCH 1/2] PCI/LINK: bw_notification: Clear interrupt before
 enabling it
Thread-Index: AQHU3w4Qu8i89LzvBkCFT261H367qQ==
Date:   Mon, 25 Mar 2019 18:50:06 +0000
Message-ID: <5d58348d5bba4003861d8aeb993fdb7f@ausx13mps321.AMER.DELL.COM>
References: <cover.1553078908.git.lukas@wunner.de>
 <87006d1f5b6868c0a6bb2fbb2765ee4dde550f28.1553078908.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=671 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250135
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/20/19 6:14 AM, Lukas Wunner wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> When booting a MacBookPro9,1, duplicate link downtraining messages are=0A=
> logged for the devices directly attached to the two CPU-internal Root=0A=
> Ports of the Core i7 3615QM:  Once on device enumeration and once on=0A=
> enablement of the bandwidth notification interrupt on the Root Ports.=0A=
> =0A=
> Duplicate messages do not occur with Root Ports on the PCH and Downstream=
=0A=
> Ports on the Thunderbolt controller:  Only a single message is logged for=
=0A=
> these, namely on device enumeration.=0A=
> =0A=
> The reason for the duplicate messages is a stale interrupt in the Link=0A=
> Status register of the 3615QM's internal Root Ports.  Avoid by clearing=
=0A=
> the interrupt before enabling it.=0A=
> =0A=
> An alternative approach would be to clear the interrupt already on device=
=0A=
> enumeration or to report link downtraining only if the speed has changed.=
=0A=
> That way, link downtraining occurring between device enumeration and=0A=
> enablement of the bandwidth notification interrupt could be catched.=0A=
> However clearing stale interrupts before enabling them is a standard=0A=
> operating procedure for any driver and keeping the two steps in one place=
=0A=
> makes the code easier to follow.=0A=
> =0A=
> Signed-off-by: Lukas Wunner <lukas@wunner.de>=0A=
=0A=
Reviewed-by: Alexandru Gagniuc <alex.gagniuc@dellteam.com>=0A=
=0A=
> ---=0A=
>   drivers/pci/pcie/bw_notification.c | 2 ++=0A=
>   1 file changed, 2 insertions(+)=0A=
> =0A=
> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_not=
ification.c=0A=
> index 001d6253ad48..69e6ba2558bf 100644=0A=
> --- a/drivers/pci/pcie/bw_notification.c=0A=
> +++ b/drivers/pci/pcie/bw_notification.c=0A=
> @@ -30,6 +30,8 @@ static void pcie_enable_link_bandwidth_notification(str=
uct pci_dev *dev)=0A=
>   {=0A=
>   	u16 lnk_ctl;=0A=
>   =0A=
> +	pcie_capability_write_word(dev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);=
=0A=
> +=0A=
>   	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnk_ctl);=0A=
>   	lnk_ctl |=3D PCI_EXP_LNKCTL_LBMIE;=0A=
>   	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);=0A=
> =0A=
=0A=
