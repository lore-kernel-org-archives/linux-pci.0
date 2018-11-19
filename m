Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A6C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 23:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E862C2086A
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 23:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="deWliD/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E862C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbeKTKPq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:15:46 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:46800 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727583AbeKTKPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 05:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1542671278; x=1574207278;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NAxAvGot0khMKPE5N+9ISDgf1cKvBtg3TvGfwGYmPkw=;
  b=deWliD/Qdms4+Jx3aKpIlDD8V1lbnY731uml8qFT2X9YxhFjjkuRJyBm
   gjFku8jkHXqh65zyis52y0r75Zxi1jkUAgPRIwS3A3n+2jnDrSIN+OR8V
   mLWFv+HxROirtmJXX4f4I3xXw3U3yYgF146UTDqnCrsertXFXdBmLAc/V
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GxAQA9S/NbhiWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZQKDWBIxjGWNLIF6lVCBZgsBAYRshBI4EgEDAQECAQECAQECEAEBAQo?=
 =?us-ascii?q?JCwgpL0IBEAGBYiKCZQEBAQECARIoPwULAgEIGB4QVwIEARoagn+BegicHgK?=
 =?us-ascii?q?BEIlYAQEBgh2KKI4bgRGDEoRLARIBH4VbAosIlGcJBZEaIIdIiTUsl0MCBAI?=
 =?us-ascii?q?EBQIUgV2BBnFwgz2CJg4JjhxAAYI5iheBH4EfAQE?=
X-IPAS-Result: =?us-ascii?q?A2GxAQA9S/NbhiWd50NkHAEBAQQBAQcEAQGBZQKDWBIxj?=
 =?us-ascii?q?GWNLIF6lVCBZgsBAYRshBI4EgEDAQECAQECAQECEAEBAQoJCwgpL0IBEAGBY?=
 =?us-ascii?q?iKCZQEBAQECARIoPwULAgEIGB4QVwIEARoagn+BegicHgKBEIlYAQEBgh2KK?=
 =?us-ascii?q?I4bgRGDEoRLARIBH4VbAosIlGcJBZEaIIdIiTUsl0MCBAIEBQIUgV2BBnFwg?=
 =?us-ascii?q?z2CJg4JjhxAAYI5iheBH4EfAQE?=
Received: from mx0b-00154901.pphosted.com (HELO mx0a-00154901.pphosted.com) ([67.231.157.37])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2018 17:47:57 -0600
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAJNnagN124279;
        Mon, 19 Nov 2018 18:49:36 -0500
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com [68.232.153.201])
        by mx0b-00154901.pphosted.com with ESMTP id 2nv5ap0fu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 18:49:36 -0500
Cc:     <baicar.tyler@gmail.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <lukas@wunner.de>, <bhelgaas@google.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <ruscur@russell.cc>,
        <sbobroff@linux.ibm.com>, <oohall@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Nov 2018 05:49:20 +0600
X-LoopCount0: from 10.166.134.84
X-IronPort-AV: E=Sophos;i="5.56,254,1539666000"; 
   d="scan'208";a="1163380859"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <okaya@kernel.org>, <mr.nuke.me@gmail.com>, <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Topic: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Index: AQHUfTk2X+FUHiVWnkuZssuLn5DqDg==
Date:   Mon, 19 Nov 2018 23:49:32 +0000
Message-ID: <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
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
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.193]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811190209
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/2018 02:33 PM, Sinan Kaya wrote:=0A=
> True. I was trying to get it out in a rush. I omitted words.=0A=
=0A=
Sounds like you'd make an top notch spec writer! :p=0A=
=0A=
> However; table assumes governance about for which entities firmware first=
=0A=
> should be enabled. There is no cross reference to _OSC or permission=0A=
> negotiation like _OST.=0A=
=0A=
Well, from an OSPM perspective, is FFS something that can be enabled or =0A=
disabled? FFS seems to be static to OSPM, which would change the sort of =
=0A=
assumptions we can reasonably make here.=0A=
=0A=
=0A=
>>> As I said in my previous email, the right place to talk about this is U=
EFI=0A=
>>> forum.=0A=
>>=0A=
>> The way I would present the problem to he spec writers is that, although=
=0A=
>> the spec appears to be consistent, we've seen firmware vendors that made=
=0A=
>> the wrong assumptions about HEST/_OSC. Instead of describing AER=0A=
>> ownership with _OSC, they attempted to do it with HEST. So we should add=
=0A=
>> an implementation note, or clarification about this.=0A=
> =0A=
> I agree.=0A=
=0A=
Cool. While the UEFI Secret Society debates, can we figure out if/how =0A=
[patch 1/2] breaks those systems, or is it only [patch 2/2] of this =0A=
series that we suspect?=0A=
=0A=
Alex=0A=
