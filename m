Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E19CC169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 23:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE4C20873
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 23:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="UeDrTOSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBKXsl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:48:41 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:35529 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbfBKXsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 18:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1549928921; x=1581464921;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dWU3uJKB7UZGqpg+aQtWyCYQtudkdyay/sbdi0nlJy0=;
  b=UeDrTOSVUjgLB/auxR25prEfL2bY/MHI0BhqXFDH/UZ0stW1SE5RsEe+
   Y8GZTRXT6b8Bfw3wUtTLshEbgK+OE4xSIXdBCuiwh4610AULgS45Po/MB
   xVxWGY1oD4mwmHZvwTXXlDYPwcnbuvSJP++CnULdDmxWFeABVVFTITZqG
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EaAADKCGJchyeV50NZChwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVIGAQELAYJZgRQxjHONH4F9lhYUgWcLAQEshECDZDUIDQEDAQECAQE?=
 =?us-ascii?q?CAQECEAEBAQoLCQgpL4I6IoJvAQEBAQIBEhUTPwULAgEIGB4QVwIEARoTB4M?=
 =?us-ascii?q?CgXoInzI9Am2BAYkHAQEBgWszii+OWYERgmQuhE4BBwsBBxiFYAKJezWBUZc?=
 =?us-ascii?q?eCQWOUoNxIYITkE2KM5FiAgQCBAUCFIFHAYEccXCDPYI1jidBgVmKUIEfAYE?=
 =?us-ascii?q?eAQE?=
X-IPAS-Result: =?us-ascii?q?A2EaAADKCGJchyeV50NZChwBAQEEAQEHBAEBgVIGAQELA?=
 =?us-ascii?q?YJZgRQxjHONH4F9lhYUgWcLAQEshECDZDUIDQEDAQECAQECAQECEAEBAQoLC?=
 =?us-ascii?q?QgpL4I6IoJvAQEBAQIBEhUTPwULAgEIGB4QVwIEARoTB4MCgXoInzI9Am2BA?=
 =?us-ascii?q?YkHAQEBgWszii+OWYERgmQuhE4BBwsBBxiFYAKJezWBUZceCQWOUoNxIYITk?=
 =?us-ascii?q?E2KM5FiAgQCBAUCFIFHAYEccXCDPYI1jidBgVmKUIEfAYEeAQE?=
Received: from mx0a-00154901.pphosted.com (HELO mx0b-00154901.pphosted.com) ([67.231.149.39])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2019 17:48:40 -0600
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BNbx62064495;
        Mon, 11 Feb 2019 18:48:40 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2qke78shfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 18:48:37 -0500
Cc:     <bhelgaas@google.com>, <Austin.Bolen@dell.com>,
        <keith.busch@intel.com>, <Shyam.Iyer@dell.com>,
        <gustavo@embeddedor.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Received: from ausxipps310.us.dell.com ([143.166.148.211])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2019 05:48:36 +0600
X-LoopCount0: from 10.166.134.84
X-IronPort-AV: E=Sophos;i="5.58,360,1544508000"; 
   d="scan'208";a="317548304"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Thread-Topic: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Thread-Index: AQHUvZbN4kEiyNA8xUGy+Uw4G87SXw==
Date:   Mon, 11 Feb 2019 23:48:12 +0000
Message-ID: <52afa1c45f684dbda6a8771b65583a22@ausx13mps321.AMER.DELL.COM>
References: <20190205210701.25387-1-mr.nuke.me@gmail.com>
 <20190209115849.244u67h7wmn3eb7o@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110166
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/9/19 5:58 AM, Lukas Wunner wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Tue, Feb 05, 2019 at 03:06:56PM -0600, Alexandru Gagniuc wrote:=0A=
>> According to PCIe 3.0, the presence detect state is a logical OR of=0A=
>> in-band and out-of-band presence.=0A=
> =0A=
> Since Bjorn asked for a spec reference:=0A=
> =0A=
> PCIe r4.0 sec 7.8.11: "Presence Detect State - This bit indicates the=0A=
> presence of an adapter in the slot, reflected by the logical OR of the=0A=
> Physical Layer in-band presence detect mechanism and, if present, any=0A=
> out-of-band presence detect mechanism defined for the slot's=0A=
> corresponding form factor."=0A=
=0A=
ECN [1] was approved last November, so it's normative spec text. Sorry =0A=
if the Ukranians didn't get ahold of it yet. I'll try to explain the delta.=
=0A=
There's an in-band PD supported/disable set of bits. If 'supported' is =0A=
set, then you can set 'disable', which removes the 'logical OR" and now =0A=
PD is only out-of-band presence.=0A=
=0A=
> Table 4-14 in sec 4.2.6 is also important because it shows the difference=
=0A=
> between Link Up and in-band presence.=0A=
=0A=
So, we'd expect PD to come up at the same time or before DLL?=0A=
=0A=
>> With this, we'd expect the presence=0A=
>> state to always be asserted when the link comes up.=0A=
>>=0A=
>> Not all hardware follows this, and it is possible for the presence to=0A=
>> come up after the link. In this case, the PCIe device would be=0A=
>> erroneously disabled and re-probed. It is possible to distinguish=0A=
>> between a delayed presence and a card swap by looking at the DLL state=
=0A=
>> changed bit -- The link has to come down if the card is removed.=0A=
> =0A=
> So in reality, PDC and DLLSC events rarely come in simultaneously and=0A=
> we do allow some leeway in pcie_wait_for_link(), it's just not enough=0A=
> in your particular case due to the way presence is detected by the=0A=
> platform.=0A=
> =0A=
> I think in this case instead of changing the behavior for everyone,=0A=
> it's more appropriate to add a quirk for your hardware.  Two ideas:=0A=
> =0A=
> * Amend pcie_init() to set slot_cap |=3D PCI_EXP_SLTCAP_ABP.  Insert=0A=
>    this as a quirk right below the existing Thunderbolt quirk and=0A=
>    use PCI vendor/device IDs and/or DMI checks to identify your=0A=
>    particular hardware.  If the ABP bit is set, PDC events are not=0A=
>    enabled by pcie_enable_notification(), so you will solely rely on=0A=
>    DLLSC events.  Problem solved.  (Hopefully.)=0A=
> =0A=
> * Alternatively, add a DECLARE_PCI_FIXUP_FINAL() quirk which sets=0A=
>    pdev->link_active_reporting =3D false.  This causes pcie_wait_for_link=
()=0A=
>    to wait 1100 msec before the hot-added device's config space is=0A=
>    accessed for the first time.=0A=
=0A=
These are both hacks right? We're declaring something untrue about the =0A=
hardware because we want to obtain a specific side-effect. BUt the =0A=
side-effects are not guaranteed not to change.=0A=
=0A=
> Would this work for you?=0A=
=0A=
I'm certain it's doable. In theory one could use the PCI ID of the DP, =0A=
and the vendor and machine names to filter the quirk. But what happens =0A=
in situations where the same PCI ID switch is used in different parts of =
=0A=
the system? You want the quirk here or not there. It quickly becomes a =0A=
shartstorm.=0A=
=0A=
I'd like a generic solution. I suspect supporting 'in-band PD disabled' =0A=
and quirking for that would be a saner way to do things. If we support =0A=
it, then we need to handle PDSC after DLLSC scenarios anyway.=0A=
=0A=
Alex=0A=
=0A=
[1] PCI-SIG ENGINEERING CHANGE NOTICE=0A=
	Async Hot-Plug Updates=0A=
	Nov 29, 2018=0A=
