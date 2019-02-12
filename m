Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D2AC282C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 23:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC356222A8
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 23:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="wP2hTuEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfBLX6B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:58:01 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:65376 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbfBLX6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2019 18:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1550015880; x=1581551880;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4i6tT/j0epsZwWvUMo0P86JYbjHMAjxumLjbiTLVauQ=;
  b=wP2hTuEr/ueE56uMBDAYqYTW7Jeeb9yPu8B77qqczTWgws8l1ULoW7BX
   qF4dNDbqBVBU4CNUhRZfhWMu4QmSg0TxSxPqMtw7idOm8IVbblLIICQIh
   VNRwo3QCHFaQKyErT5kjVcPH1T7T+ijb4roZHs7EI6AJxdKIdMU4oB5Xi
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EbAADUXGNchiWd50NjGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBVAMBAQELAYJZgRQxjHOLEoINgX2YEQsBASyEQINIIjcGDQEDAQE?=
 =?us-ascii?q?CAQECAQECEAEBAQoJCwgpL4I6IoJvAQEBAwESKD8FCwIBCBgeEFcCBBsTB4M?=
 =?us-ascii?q?CgXoInls9Am2BAYkHAQEBgh6KLIxDghaBEYJkLoUBTYUTAol7ggaXHgkFkkM?=
 =?us-ascii?q?hkmCcFQIEAgQFAhSBXIF5cIM9gicOCY4eQYFZjV4BgR4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EbAADUXGNchiWd50NjGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYJZgRQxjHOLEoINgX2YEQsBASyEQINIIjcGDQEDAQECAQECAQECEAEBA?=
 =?us-ascii?q?QoJCwgpL4I6IoJvAQEBAwESKD8FCwIBCBgeEFcCBBsTB4MCgXoInls9Am2BA?=
 =?us-ascii?q?YkHAQEBgh6KLIxDghaBEYJkLoUBTYUTAol7ggaXHgkFkkMhkmCcFQIEAgQFA?=
 =?us-ascii?q?hSBXIF5cIM9gicOCY4eQYFZjV4BgR4BAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Feb 2019 17:57:59 -0600
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1CNllV4113570;
        Tue, 12 Feb 2019 18:57:58 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2qm310sm2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 18:57:58 -0500
Cc:     <mr.nuke.me@gmail.com>, <bhelgaas@google.com>,
        <Austin.Bolen@dell.com>, <keith.busch@intel.com>,
        <Shyam.Iyer@dell.com>, <gustavo@embeddedor.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Feb 2019 05:56:42 +0600
X-LoopCount0: from 10.166.134.84
X-IronPort-AV: E=Sophos;i="5.58,364,1544508000"; 
   d="scan'208";a="352948300"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>
Subject: Re: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Thread-Topic: [PATCH] PCI: pciehp: Do not turn off slot if presence comes up
 after link
Thread-Index: AQHUvZbN4kEiyNA8xUGy+Uw4G87SXw==
Date:   Tue, 12 Feb 2019 23:57:55 +0000
Message-ID: <b2fffa5beb7941ebaceb8b8ce6e5b133@ausx13mps321.AMER.DELL.COM>
References: <20190205210701.25387-1-mr.nuke.me@gmail.com>
 <20190209115849.244u67h7wmn3eb7o@wunner.de>
 <52afa1c45f684dbda6a8771b65583a22@ausx13mps321.AMER.DELL.COM>
 <20190212083031.2no7mzn5xug7nba3@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902120161
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/12/19 2:30 AM, Lukas Wunner wrote:=0A=
> The PCI SIG=0A=
> should probably consider granting access to specs to open source=0A=
> developers to ease adoption of new features in Linux et al.=0A=
=0A=
Don't get me started on just how ridiculous I think PCI-SIG's policy is =0A=
with respect to public availability of standards.=0A=
=0A=
>>> Table 4-14 in sec 4.2.6 is also important because it shows the differen=
ce=0A=
>>> between Link Up and in-band presence.=0A=
>>=0A=
>> So, we'd expect PD to come up at the same time or before DLL?=0A=
> =0A=
> Per table 4-14 and figure 4-23 (immediately below the table) in r4.0,=0A=
> PDC ought to be signaled before DLLSC.  As said, Linux can handle PDC=0A=
> after DLLSC if they're not too far apart (100 ms, see pcie_wait_for_link(=
)).=0A=
> =0A=
> =0A=
>> I'd like a generic solution. I suspect supporting 'in-band PD disabled'=
=0A=
>> and quirking for that would be a saner way to do things. If we support=
=0A=
>> it, then we need to handle PDSC after DLLSC scenarios anyway.=0A=
> =0A=
> I agree, having support for this new ECN would be great.=0A=
> =0A=
> If you look at struct controller in drivers/pci/hotplug/pciehp.h,=0A=
> there's a section labelled /* capabilities and quirks */.  An idea=0A=
> would be to add an unsigned int there to indicate whether in-band=0A=
> presence is disabled.  An alternative would be to add a flag to=0A=
> struct pci_dev.=0A=
=0A=
> Instead of modifying the logic in pciehp_handle_presence_or_link_change()=
,=0A=
> you could amend pcie_wait_for_link() to poll PDS until it's set, in=0A=
> addition to DLLLA.  The rationale would be that although the link is up,=
=0A=
> the hot-added device cannot really be considered accessible until PDS=0A=
> is also set.  Unfortunately we cannot do this for all devices because=0A=
> (as I've said before), some broken devices hardwire PDS to zero.  But=0A=
> it should be safe to constrain it to those which can disable in-band=0A=
> presence.=0A=
=0A=
=0A=
The recommendation is to set the "in-band PD disable" bit, and it's =0A=
possible that platform firmware may have set it at boot time (*). I'm =0A=
not sure that there is a spec-justifiable reason to not access a device =0A=
whose DLL is up, but PD isn't.=0A=
=0A=
(*) A bit hypothetical: There is no hardware yet implementing the ECN.=0A=
=0A=
> Be mindful however that pcie_wait_for_link() is also called from the=0A=
> DPC driver.  Keith should be able to judge whether a change to that=0A=
> function breaks DPC.=0A=
=0A=
That's why I went for ammending pciehp_handle_presence_or_link_change(). =
=0A=
Smaller bug surface ;). What I'm thinking at this point is, keep the =0A=
patch as is, but, also check for in-band PD disable before aborting the =0A=
shutdown. Old behavior stays the same.=0A=
=0A=
I'll rework this a little bit for in-band PD disable (what's a good =0A=
acronym for that, BTW?), and then quirk those machines that are known to =
=0A=
'disable' this in hardware.=0A=
=0A=
Alex=0A=
