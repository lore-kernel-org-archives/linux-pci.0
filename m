Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E1C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 23:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A0821019
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 23:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="wiWdVHyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfAWXvS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:51:18 -0500
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:6188 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfAWXvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 18:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1548287459; x=1579823459;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VTyI9zllp2ax0uT7XxrmkFwx4fNpqigqAYeKmIuE7RE=;
  b=wiWdVHyxdNbmh8v3BYNP8d24WR/eVS97smwOzR4WIjHAPJyS3yf/s4we
   v18YW1YN+YrBX4GtK1w+1ct84/6IRhlBwfvRsDphTfm5aEJwEj8ZnbIw+
   OY3N1AqEo4o6bGx3MNQ9Tjnn94S1VMmSrA3ZvhG3OgyqwHrSTy7M/grrB
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EIAACj/UhchyeV50NbCBsBAQEBAwE?=
 =?us-ascii?q?BAQcDAQEBgVIFAQEBCwGDazGMcI0hgX6WBRSBZwsBASyEQIJ/IjUIDQEDAQE?=
 =?us-ascii?q?CAQECAQECEAEBARUJCCkvgjoignABAQEDEhUTPxACAQgYHhBXAgQbEweDAII?=
 =?us-ascii?q?CoCg9AoFuiQcBAQGBazOKOIxBghaBEYJkLoROAQ0FAQcYTYUTAoldiAeEf4t?=
 =?us-ascii?q?DCQWSEyCSGJsHAgQCBAUCFIFIATRncXCDPYI0jidBgVmHPoEfAYEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2EIAACj/UhchyeV50NbCBsBAQEBAwEBAQcDAQEBgVIFA?=
 =?us-ascii?q?QEBCwGDazGMcI0hgX6WBRSBZwsBASyEQIJ/IjUIDQEDAQECAQECAQECEAEBA?=
 =?us-ascii?q?RUJCCkvgjoignABAQEDEhUTPxACAQgYHhBXAgQbEweDAIICoCg9AoFuiQcBA?=
 =?us-ascii?q?QGBazOKOIxBghaBEYJkLoROAQ0FAQcYTYUTAoldiAeEf4tDCQWSEyCSGJsHA?=
 =?us-ascii?q?gQCBAUCFIFIATRncXCDPYI0jidBgVmHPoEfAYEeAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2019 17:50:59 -0600
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NNh3g8156494
        for <linux-pci@vger.kernel.org>; Wed, 23 Jan 2019 18:51:16 -0500
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0a-00154901.pphosted.com with ESMTP id 2q6v2nabgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Wed, 23 Jan 2019 18:51:16 -0500
Cc:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <keith.busch@intel.com>, <Austin.Bolen@dell.com>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2019 05:50:54 +0600
X-LoopCount0: from 10.166.134.83
X-IronPort-AV: E=Sophos;i="5.56,513,1539666000"; 
   d="scan'208";a="264329905"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Topic: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Index: AQHUs0hi5mR8YZ0nPk+DZaS87pNxDw==
Date:   Wed, 23 Jan 2019 23:50:30 +0000
Message-ID: <c43a8be3d0754d78a8c10b2ddb0a5c37@ausx13mps317.AMER.DELL.COM>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123185420.2pennvzvkuhqfmtj@wunner.de>
 <20190123190723.rnt5llkek5st7ddt@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=504 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230170
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/23/19 1:07 PM, Lukas Wunner wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Wed, Jan 23, 2019 at 07:54:20PM +0100, Lukas Wunner wrote:=0A=
>> So I don't see a perfect solution.  What device are we talking about=0A=
>> anyway?  400 ms is a *long* time.=0A=
> =0A=
> Also, how exactly does this issue manifest itself:  Is it just an=0A=
> annoyance that the slot is brought up/down/up or does it not work=0A=
> at all?=0A=
=0A=
nvme issue aside, the device is removed. Then, a few seconds later, we =0A=
see Link Up and Card Present events, but no pciehp_isr() invocation. I =0A=
think it all happens in one pciehp_handle_presence_or_link_change(), so =0A=
pciehp_ist() is held up for a few seconds -- but that's a matter for a =0A=
different thread.=0A=
=0A=
Alex.=0A=
=0A=
=0A=
[  785.007640] nvme 0000:b1:00.0: enabling device (0000 -> 0002)=0A=
[  785.099567] pcieport 0000:b0:04.0: ZOPA: Status(0x00000040): =0A=
presence-detected=0A=
[  785.099574] pcieport 0000:b0:04.0: ZOPA: Events(0x00000008): =0A=
presence-detect-changed=0A=
[  785.099580] pcieport 0000:b0:04.0: ZOPA: Queued up(0x00000008): =0A=
presence-detect-changed=0A=
[  785.099582] pcieport 0000:b0:04.0: ZOPA: pciehp_isr: exiting=0A=
[  785.099611] pcieport 0000:b0:04.0: ZOPA: pciehp_ist: Entered with =0A=
events(0x00000008): presence-detect-changed=0A=
[  785.099615] pciehp 0000:b0:04.0:pcie204: ZOPA: =0A=
pciehp_handle_presence_or_link_change: locked &ctrl->state_lock=0A=
[  785.099618] pciehp 0000:b0:04.0:pcie204: ZOPA: =0A=
pciehp_handle_presence_or_link_change unlocked (POWEROFF)=0A=
[  785.099621] pciehp 0000:b0:04.0:pcie204: Slot(178): Card not present=0A=
[  788.756953] nvme nvme4: failed to mark controller CONNECTING=0A=
[  788.756958] nvme nvme4: Removing after probe failure status: 0=0A=
[  788.763317] pciehp 0000:b0:04.0:pcie204: ZOPA: =0A=
pciehp_handle_presence_or_link_change unlocked (POWERON)=0A=
[  788.763322] pciehp 0000:b0:04.0:pcie204: Slot(178): Card present=0A=
[  788.763349] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up=0A=
[  788.892432] pci 0000:b1:00.0: [8086:0a55] type 00 class 0x010802=0A=
[  788.892474] pci 0000:b1:00.0: reg 0x10: [mem 0xe1500000-0xe1503fff 64bit=
]=0A=
=0A=
