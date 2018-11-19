Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6C3C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 20:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787352086A
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 20:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="qaZAkqGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787352086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbeKTGmT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:42:19 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:49119 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728844AbeKTGmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 01:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1542658624; x=1574194624;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xZxbI4lACu2SbRtSOT54faqcXVe0ZqTunVMUKNclKVE=;
  b=qaZAkqGUNTzNF26y/o1HuDdRh9+XeIlhl46mGp/HuLUkWatXZ3ycv6Mk
   pjQlqUZzbBbs+UJIdMIWketS25VSEWWspCjTvj62fuVyUB+vOtWeNPDjk
   832qa7eUqxL2ySO7SpyFQpjeDz/alp55pGjPRQTwz/AmjTuN1OWBJmZvb
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GxAQCSGfNbhiWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZQKBWYF/EjGMZY0rgXqVUIFmCwEBhGyEEjgSAQMBAQIBAQIBAQIQAQE?=
 =?us-ascii?q?BCgkLCCkvQgEQAYFiIoJlAQEBAQIBEhUTPwULAgEIGB4QVwIEARoRCYJ/gXo?=
 =?us-ascii?q?InDICgRCJWAEBAYFqM4okjhuBEYMShEsBEgEfhVsCiRiBcJRnCQWRGiCHSIk?=
 =?us-ascii?q?1LJdDAgQCBAUCFIFdgQZxcIM9giYOCX8BB40VQAGCOYoXgR+BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2GxAQCSGfNbhiWd50NkHAEBAQQBAQcEAQGBZQKBWYF/E?=
 =?us-ascii?q?jGMZY0rgXqVUIFmCwEBhGyEEjgSAQMBAQIBAQIBAQIQAQEBCgkLCCkvQgEQA?=
 =?us-ascii?q?YFiIoJlAQEBAQIBEhUTPwULAgEIGB4QVwIEARoRCYJ/gXoInDICgRCJWAEBA?=
 =?us-ascii?q?YFqM4okjhuBEYMShEsBEgEfhVsCiRiBcJRnCQWRGiCHSIk1LJdDAgQCBAUCF?=
 =?us-ascii?q?IFdgQZxcIM9giYOCX8BB40VQAGCOYoXgR+BHwEB?=
Received: from mx0b-00154901.pphosted.com (HELO mx0a-00154901.pphosted.com) ([67.231.157.37])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2018 14:17:03 -0600
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAJKCup6139457;
        Mon, 19 Nov 2018 15:17:02 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2nusf43x52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 15:17:02 -0500
Cc:     <baicar.tyler@gmail.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <lukas@wunner.de>, <bhelgaas@google.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <ruscur@russell.cc>,
        <sbobroff@linux.ibm.com>, <oohall@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Received: from ausxipps310.us.dell.com ([143.166.148.211])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Nov 2018 02:17:00 +0600
X-LoopCount0: from 10.166.134.86
X-IronPort-AV: E=Sophos;i="5.56,254,1539666000"; 
   d="scan'208";a="285285730"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <okaya@kernel.org>, <mr.nuke.me@gmail.com>, <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Topic: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Index: AQHUfTk2X+FUHiVWnkuZssuLn5DqDg==
Date:   Mon, 19 Nov 2018 20:16:59 +0000
Message-ID: <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
 <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.193]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811190181
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/2018 01:32 PM, Sinan Kaya wrote:=0A=
> ACPI 6.2:=0A=
> =0A=
> 18.3.2.4 PCI Express Root Port AER Structure=0A=
> =0A=
> Flags:=0A=
> =0A=
> Bit [0] - FIRMWARE_FIRST: If set, this bit indicates to the OSPM that sys=
tem=0A=
> firmware will handle errors from this source first.=0A=
> Bit [1] - GLOBAL: If set, indicates that the settings contained in this=
=0A=
> structure apply globally to all PCI Express Devices.=0A=
> All other bits must be set to zero.=0A=
> =0A=
> It doesn't say shall, may or might. It says will.=0A=
=0A=
It says "system firmware will handle errors". It does not say "system =0A=
firmware owns AER registers". In absence on any descriptor text on the =0A=
meaning of these tables, this really looks to me like it should be =0A=
interpreted as a descriptor of APEI error sources, not a mutex on who =0A=
writes to certain bits-- AER in this case.=0A=
=0A=
I don't think that is contradictory or inconsistent.=0A=
I also wasn't able to find any reference to HEST in UEFI 2.7, only in =0A=
ACPI spec.=0A=
=0A=
> I think It depends on your PCI topology.=0A=
> =0A=
> For other topologies with multiple PCI root complexes, I can see this bei=
ng=0A=
> used per root complex flag to indicate which root complex needs firmware =
first=0A=
> and which one doesn't.=0A=
=0A=
_OSC is per root bus, so it's already granular enough, right? Why would =0A=
it depend on PCI topology?=0A=
=0A=
=0A=
>> I'd like see how exactly we break one of those elusive systems with _OSC=
. I=0A=
>> suspect _OSC and HEST end up having the same information, and that's why=
 we=0A=
>> didn't see any real-life issue with mixing the approaches.=0A=
> =0A=
> I'm already aware of two systems that rely on HEST table to pass informat=
ion to=0A=
> the OS that firmware first is enabled. Both of the systems do not change =
their=0A=
> _OSC bits during this assuming HEST table has priority over _OSC for firm=
ware=0A=
> first.=0A=
=0A=
Are those hax86 systems?=0A=
It seems like the systems have broken firmware. I see several ways to =0A=
handle broken systems like those:=0A=
  - Parse both HEST and _OSC, and decide AER ownership with root bridge =0A=
granularity. i.e. host_bridge->native_aer is authoritative, but is =0A=
derived from both HEST and _OSC=0A=
  - Add quirks for the broken systems=0A=
  - Keep doing what we're doing until current code breaks a new system=0A=
=0A=
> If we add this patch, OS will try to claim the AER address space while fi=
rmware=0A=
> wants exclusive access.=0A=
=0A=
Yay! FFS wants exclusive access, but does not claim it. Oh, FFS!=0A=
=0A=
=0A=
> As I said in my previous email, the right place to talk about this is UEF=
I=0A=
> forum.=0A=
=0A=
The way I would present the problem to he spec writers is that, although =
=0A=
the spec appears to be consistent, we've seen firmware vendors that made =
=0A=
the wrong assumptions about HEST/_OSC. Instead of describing AER =0A=
ownership with _OSC, they attempted to do it with HEST. So we should add =
=0A=
an implementation note, or clarification about this.=0A=
=0A=
Alex=0A=
