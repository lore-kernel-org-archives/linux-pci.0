Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB96C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 22:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DD8218D2
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 22:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="MoLGdsF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfAXWL4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:11:56 -0500
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:42419 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfAXWL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 17:11:56 -0500
X-Greylist: delayed 664 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2019 17:11:56 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1548367913; x=1579903913;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AQXJATamgwFvlhU+5qaEPpN1G7Yichp7m8/7wH7cw5U=;
  b=MoLGdsF7WaSf/FfURo6/QRNLiOe/t4Nki5H07DkwzzapB8ug+kw4Jjf7
   idgfZE7otOE4SIa1mOXgr8YlNFi0NTNN3SyFJGBHAS/F6ix8+/VDQzyzo
   I+DF6TH52Ehv+cJ2rmBJNASjLQJfkcDWocqyKvff55KS53Eh/PEShrC/U
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EGAAAoNUpchyeV50NkGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUQYBAQELAYJZgRQVHIwRX4sUgg2BfpYJgXsLAQGBd4J1gwYiNAk?=
 =?us-ascii?q?NAQMBAQIBAQIBAQIQAQEBFQkIKS+COiKCbwEBAQECARIoPwULAgEIGB4QVwI?=
 =?us-ascii?q?EAQ0NGoMAgXoIoE09AoFuiQcBAQGCHoovjEGCFoERgmQuhQGFYAKiLQcCkh4?=
 =?us-ascii?q?gkh+KDJEEAgQCBAUCFIFGN4FYcIM9gjSOJ0ABikCBHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EGAAAoNUpchyeV50NkGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYJZgRQVHIwRX4sUgg2BfpYJgXsLAQGBd4J1gwYiNAkNAQMBAQIBAQIBA?=
 =?us-ascii?q?QIQAQEBFQkIKS+COiKCbwEBAQECARIoPwULAgEIGB4QVwIEAQ0NGoMAgXoIo?=
 =?us-ascii?q?E09AoFuiQcBAQGCHoovjEGCFoERgmQuhQGFYAKiLQcCkh4gkh+KDJEEAgQCB?=
 =?us-ascii?q?AUCFIFGN4FYcIM9gjSOJ0ABikCBHwEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2019 16:00:42 -0600
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OLw4ko031214
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 17:00:52 -0500
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com [68.232.153.201])
        by mx0b-00154901.pphosted.com with ESMTP id 2q7hqa9mc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 17:00:52 -0500
From:   <Austin.Bolen@dell.com>
To:     <keith.busch@intel.com>, <Austin.Bolen@dell.com>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Jan 2019 04:00:51 +0600
X-LoopCount0: from 10.166.134.89
X-IronPort-AV: E=Sophos;i="5.56,518,1539666000"; 
   d="scan'208";a="264746659"
CC:     <Alex_Gagniuc@Dellteam.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <lukas@wunner.de>
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Topic: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Index: AQHUs0hi5mR8YZ0nPk+DZaS87pNxDw==
Date:   Thu, 24 Jan 2019 22:00:49 +0000
Message-ID: <8242ccdc28e04fca9f9264ec75112b8b@AUSX13MPC131.AMER.DELL.COM>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123184453.GB6629@localhost.localdomain>
 <b32e6ca62ae2494f98450df81ca1ee14@AUSX13MPC131.AMER.DELL.COM>
 <20190124202020.GB9600@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240149
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/24/2019 2:21 PM, Keith Busch wrote:=0A=
> =0A=
=0A=
<snip>=0A=
=0A=
=0A=
> My copy of the 5.0-0.9 spec missed out on this ECN. The new changes look=
=0A=
> like it more clearly defines expected software and hardware behavior,=0A=
> so I'm looking forward to seeing the hardware implementations. Thanks=0A=
> for driving that.=0A=
> =0A=
=0A=
You're welcome!  And yes, this ECN is not yet in 5.0 draft but should be =
=0A=
there soon.  Much of what is in the ECN can be implemented with existing =
=0A=
DPC hardware.  There are associated ECNs in ACPI and PCI Firmware =0A=
Specifications as well.  The ACPI spec changes will not be public until =0A=
the 6.3 spec is released (soon).  The PCI Firmware Specification changes =
=0A=
should be ratified in a few weeks as well.  In the meantime, UEFI org =0A=
(which ACPI is a part of) has a git repo accessible to UEFI forum =0A=
members where the Linux code to support these new async hot-plug =0A=
mechanisms is being developed.  Will be made public once the specs are =0A=
public.=0A=
=0A=
Thanks,=0A=
Austin=0A=
