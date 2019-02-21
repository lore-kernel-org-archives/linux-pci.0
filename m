Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A431C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 18:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD88B2081B
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 18:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="oOuxhN/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfBUSh4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:37:56 -0500
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:46303 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfBUSh4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 13:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1550774271; x=1582310271;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3nQ6CgGn3CFs3OO6t+hDDJiKgwtM9DreeC8pU7Qp2zY=;
  b=oOuxhN/fzYlyrvQ423awBXoXqUyahpmD9w4mYJ5R/qGghFjO6ltGmLYa
   azVg2IFNDm6ZVmgaeAD+f4j51um/ZudekTEwwLQ9sZ9/2orapun00h+Jt
   goPHlGltRdBtaZwKKWyrHJVsAT+6TA/0SuIre0pk2MLnmCTjyU952TFGT
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2H/AADU7m5chieV50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZYJaEYEDJwqHR4UvizGBUpgygSs8CwEBJQcCgQKDPIN9IjgSAQMBAQI?=
 =?us-ascii?q?BAQIBAQIQAQEBCgkLCCkjDII6IhgETTgDLwEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BARUCDSYjAQEYAQEBAQEBARIVEz8FCwIBCBgeEFcCBAEaGoJ+AYFqCA+gJD0?=
 =?us-ascii?q?CbYEBiQcBAQGBazODc4Y8jEiBDoEIg3UugnkMGQIBgS0BEgELFIVgAowOhEC?=
 =?us-ascii?q?TBQkFhzmLGCGBcViFAotAikmFToh6AYM+AgQCBAUCFIFegQdxcIM8CYIfDgm?=
 =?us-ascii?q?DS4VChRFBMQGBJ4wXDheBCAGBHgEB?=
X-IPAS-Result: =?us-ascii?q?A2H/AADU7m5chieV50NkHAEBAQQBAQcEAQGBZYJaEYEDJ?=
 =?us-ascii?q?wqHR4UvizGBUpgygSs8CwEBJQcCgQKDPIN9IjgSAQMBAQIBAQIBAQIQAQEBC?=
 =?us-ascii?q?gkLCCkjDII6IhgETTgDLwEBAQEBAQEBAQEBAQEBAQEBAQEBARUCDSYjAQEYA?=
 =?us-ascii?q?QEBAQEBARIVEz8FCwIBCBgeEFcCBAEaGoJ+AYFqCA+gJD0CbYEBiQcBAQGBa?=
 =?us-ascii?q?zODc4Y8jEiBDoEIg3UugnkMGQIBgS0BEgELFIVgAowOhECTBQkFhzmLGCGBc?=
 =?us-ascii?q?ViFAotAikmFToh6AYM+AgQCBAUCFIFegQdxcIM8CYIfDgmDS4VChRFBMQGBJ?=
 =?us-ascii?q?4wXDheBCAGBHgEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2019 12:34:52 -0600
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LIXZAB086755;
        Thu, 21 Feb 2019 13:35:15 -0500
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2qsyugrhyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 13:35:15 -0500
Cc:     <bhelgaas@google.com>, <Austin.Bolen@dell.com>,
        <keith.busch@intel.com>, <Shyam.Iyer@dell.com>, <okaya@kernel.org>,
        <linux-pci@vger.kernel.org>, <mika.westerberg@linux.intel.com>,
        <okaya@codeaurora.org>, <poza@codeaurora.org>,
        <linux-kernel@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Feb 2019 00:35:07 +0600
X-LoopCount0: from 10.166.134.89
X-IronPort-AV: E=Sophos;i="5.58,396,1544508000"; 
   d="scan'208";a="1260447609"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH RFC v2 4/4] PCI: hotplug: Add quirk For Dell nvme pcie
 switches
Thread-Topic: [PATCH RFC v2 4/4] PCI: hotplug: Add quirk For Dell nvme pcie
 switches
Thread-Index: AQHUyLqRKxehBZutlk6MputMunrGNg==
Date:   Thu, 21 Feb 2019 18:35:12 +0000
Message-ID: <027101b4652c4e0c98b86649aa3e4732@ausx13mps321.AMER.DELL.COM>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
 <20190220012031.10741-5-mr.nuke.me@gmail.com>
 <20190221075634.uih5ysqwkna7cku4@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210130
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/21/19 1:57 AM, Lukas Wunner wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Tue, Feb 19, 2019 at 07:20:30PM -0600, Alexandru Gagniuc wrote:=0A=
>> --- a/drivers/pci/hotplug/pciehp_hpc.c=0A=
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c=0A=
>> @@ -952,3 +952,23 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0=
x0400,=0A=
>>   			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);=0A=
>>   DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,=0A=
>>   			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);=0A=
>> +=0A=
>> +=0A=
> =0A=
> Duplicate newline.=0A=
> =0A=
> =0A=
>> +static void fixup_dell_nvme_backplane_switches(struct pci_dev *pdev)=0A=
> =0A=
> Can we have a little code comment above the function such as:=0A=
> =0A=
> +/*=0A=
> + * Dell <product name> NVMe storage backplanes disable in-band presence=
=0A=
> + * (PCIe r5.0 sec X.Y.Z) but neglect to set the corresponding flag in th=
e=0A=
> + * Slot Capabilities 2 register.=0A=
> + */=0A=
> =0A=
> =0A=
>> +	if (pdev->subsystem_vendor !=3D PCI_VENDOR_ID_DELL=0A=
>> +		|| pdev->subsystem_device !=3D 0x1fc7)=0A=
> =0A=
> This looks a little unpolished, how about:=0A=
> =0A=
> +	if (pdev->subsystem_vendor !=3D PCI_VENDOR_ID_DELL ||=0A=
> +	    pdev->subsystem_device !=3D 0x1fc7)=0A=
> =0A=
> =0A=
>> +		return;=0A=
>> +=0A=
>> +	pdev->no_in_band_presence =3D 1;=0A=
>> +}=0A=
>> +=0A=
>> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_PLX, 0x9733,=0A=
> =0A=
> By convention there's no blank line between the closing curly brace=0A=
> and the DECLARE_PCI_FIXUP_CLASS_FINAL().=0A=
=0A=
I'm sorry for all the style issues. I realize it's noise and should just =
=0A=
be done right from the beginning. Is there a way to make checkpatch.pl =0A=
catch these before they go out?=0A=
=0A=
=0A=
> If the quirk is x86-specific, please enclose it in "#ifdef CONFIG_X86"=0A=
> to reduce kernel footprint on other arches.=0A=
=0A=
That's a tricky one. If you look at p. 185 of [1], items 9, 11, and 12 =0A=
are standard x16 cards that would fit in any x16 slot. Those cards have =0A=
the offending switches.=0A=
=0A=
On the one hand, you could take the cards and backplane and put them in =0A=
a non-hax86 system. On the other hand, I don't see why someone would =0A=
want to do this.=0A=
=0A=
Alex=0A=
=0A=
[1] https://topics-cdn.dell.com/pdf/poweredge-r740xd_owners-manual_en-us.pd=
f=0A=
=0A=
=0A=
