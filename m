Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDA7C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FA42075D
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="VaJhjjb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfCYSwn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:52:43 -0400
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:61437 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728912AbfCYSwm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 14:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1553539962; x=1585075962;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NQ4EKrbsxL42Cgw/Qp30KDenbByYdmg35CVDYfnkn30=;
  b=VaJhjjb0mnUJeFYZifUi9UZ0QGN6r7Oe2IWfdZ/MJWZrLSvhff/VkV2X
   k1qKek/QDWsuwD7lDWZK05dOjlLANncOXpWCkHT5GrS1VV46jqxE2eMYO
   aiw/8QakWbItlmHeEv4R4FJy0IftNZvpa2T9ES+fad+9c14IXwaKLAK+7
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EDAACBIZlchyWd50NkGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUgQBAQEBCwGCZ4EUJwqMf4xQmDoUgWcNAQEshECFFSI1CA0?=
 =?us-ascii?q?BAQMBAQkBAwIBAQIQAQEBCgsJCCkvgjoigm8BAQEDARIVEz8FCwIBCBgeEFc?=
 =?us-ascii?q?CBAESCBqDAIFuCKInPQJvgQGJBwEBAYFrM4orgS8BizGCFoQjPmmDKAELBwE?=
 =?us-ascii?q?fhWEDihiCLJhSCQWTLCGTfi2Kb5MqAgQCBAUCFYFPAoEacXCDPIIWDgkTjgt?=
 =?us-ascii?q?BMYEojDEPF4EIAYEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2EDAACBIZlchyWd50NkGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?gQBAQEBCwGCZ4EUJwqMf4xQmDoUgWcNAQEshECFFSI1CA0BAQMBAQkBAwIBA?=
 =?us-ascii?q?QIQAQEBCgsJCCkvgjoigm8BAQEDARIVEz8FCwIBCBgeEFcCBAESCBqDAIFuC?=
 =?us-ascii?q?KInPQJvgQGJBwEBAYFrM4orgS8BizGCFoQjPmmDKAELBwEfhWEDihiCLJhSC?=
 =?us-ascii?q?QWTLCGTfi2Kb5MqAgQCBAUCFYFPAoEacXCDPIIWDgkTjgtBMYEojDEPF4EIA?=
 =?us-ascii?q?YEeAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Mar 2019 13:52:41 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PImicJ072911
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2019 14:52:41 -0400
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0b-00154901.pphosted.com with ESMTP id 2rf1k2h4e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2019 14:52:41 -0400
Cc:     <linux-pci@vger.kernel.org>, <Austin.Bolen@dell.com>,
        <keith.busch@intel.com>, <Shyam.Iyer@dell.com>, <okaya@kernel.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Mar 2019 00:52:10 +0600
X-LoopCount0: from 10.166.134.84
X-IronPort-AV: E=Sophos;i="5.60,269,1549951200"; 
   d="scan'208";a="1215749450"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>, <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH 2/2] PCI/LINK: bw_notification: Deduplicate reports for
 multi-function devices
Thread-Topic: [PATCH 2/2] PCI/LINK: bw_notification: Deduplicate reports for
 multi-function devices
Thread-Index: AQHU3w5LqhubxTTSeUyD2y5gghEO5g==
Date:   Mon, 25 Mar 2019 18:52:38 +0000
Message-ID: <769ac857205c425fa7b6bab7dddc7f68@ausx13mps321.AMER.DELL.COM>
References: <cover.1553078908.git.lukas@wunner.de>
 <70cb1754e3f0da3b84712460b1017ac707cd2616.1553078908.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250135
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/20/19 6:15 AM, Lukas Wunner wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> If a multi-function device's bandwidth is already limited when it is=0A=
> enumerated, a message is logged only for function 0.  By contrast, when=
=0A=
> downtraining occurs after enumeration, a message is logged for all=0A=
> functions.  That's because the former uses pcie_report_downtraining(),=0A=
> whereas the latter uses __pcie_print_link_status() (which doesn't filter=
=0A=
> functions !=3D 0).  I am seeing this happen on a MacBookPro9,1 with a GPU=
=0A=
> (function 0) and an integrated HDA controller (function 1).=0A=
> =0A=
> Avoid this incongruence by calling pcie_report_downtraining() in both=0A=
> cases.=0A=
=0A=
Good catch! Thank you for engineering the fixes.=0A=
=0A=
> Signed-off-by: Lukas Wunner <lukas@wunner.de>=0A=
=0A=
Reviewed-by: Alexandru Gagniuc <alex.gagniuc@dellteam.com>=0A=
=0A=
> ---=0A=
>   drivers/pci/pci.h                  | 1 +=0A=
>   drivers/pci/pcie/bw_notification.c | 2 +-=0A=
>   drivers/pci/probe.c                | 2 +-=0A=
>   3 files changed, 3 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h=0A=
> index 224d88634115..d994839a3e24 100644=0A=
> --- a/drivers/pci/pci.h=0A=
> +++ b/drivers/pci/pci.h=0A=
> @@ -273,6 +273,7 @@ enum pcie_link_width pcie_get_width_cap(struct pci_de=
v *dev);=0A=
>   u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *spe=
ed,=0A=
>   			   enum pcie_link_width *width);=0A=
>   void __pcie_print_link_status(struct pci_dev *dev, bool verbose);=0A=
> +void pcie_report_downtraining(struct pci_dev *dev);=0A=
>   =0A=
>   /* Single Root I/O Virtualization */=0A=
>   struct pci_sriov {=0A=
> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_not=
ification.c=0A=
> index 69e6ba2558bf..c26045f2a890 100644=0A=
> --- a/drivers/pci/pcie/bw_notification.c=0A=
> +++ b/drivers/pci/pcie/bw_notification.c=0A=
> @@ -76,7 +76,7 @@ static irqreturn_t pcie_bw_notification_handler(int irq=
, void *context)=0A=
>   	 */=0A=
>   	down_read(&pci_bus_sem);=0A=
>   	list_for_each_entry(dev, &port->subordinate->devices, bus_list)=0A=
> -		__pcie_print_link_status(dev, false);=0A=
> +		pcie_report_downtraining(dev);=0A=
>   	up_read(&pci_bus_sem);=0A=
>   =0A=
>   	pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);=0A=
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c=0A=
> index 2ec0df04e0dc..7e12d0163863 100644=0A=
> --- a/drivers/pci/probe.c=0A=
> +++ b/drivers/pci/probe.c=0A=
> @@ -2388,7 +2388,7 @@ static struct pci_dev *pci_scan_device(struct pci_b=
us *bus, int devfn)=0A=
>   	return dev;=0A=
>   }=0A=
>   =0A=
> -static void pcie_report_downtraining(struct pci_dev *dev)=0A=
> +void pcie_report_downtraining(struct pci_dev *dev)=0A=
>   {=0A=
>   	if (!pci_is_pcie(dev))=0A=
>   		return;=0A=
> =0A=
=0A=
