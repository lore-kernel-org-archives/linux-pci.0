Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651FAC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351B52146D
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="BUS5YFaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351B52146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeK1FVF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:21:05 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:6590 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbeK1FVF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 00:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1543342940; x=1574878940;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hurL8EwyUQszf5IY19+ZGB7He+ZXs+g2ggV8DqcOpV8=;
  b=BUS5YFaUqPU1XWi2WmSwYYJc+GFFcQcHTirKDhHJIymiu8GWBvABW/4T
   fg4ThC5Ozg6N/0WtUFxcwwk3mCGrINDm2GmOdhusA+vPZi5MCdKd4g+x9
   ZY9qaix7o7rHV1oN6EIE0aCr6YqWdEhCuKXmocStMzU1tuHmU7KSgH1t2
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FRAQCqiv1bhiWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZYNsMYxmiymCDYF9lz0LAQGEbIMbIjgSAQMBAQIBAQIBAQIQAQEBCgk?=
 =?us-ascii?q?LCCkvgjYigmYBAQEDEig/EAIBCBgeEFcCBAEaGoJ/ggKaFwKBEIlYAQEBgh2?=
 =?us-ascii?q?KLIwNghaBEYMShQGFWwKLFZR3CQWRIyCBSgGPQCyXZAIEAgQFAhSBXYF3cIM?=
 =?us-ascii?q?9gjSOJkABjSiBHwEB?=
X-IPAS-Result: =?us-ascii?q?A2FRAQCqiv1bhiWd50NkHAEBAQQBAQcEAQGBZYNsMYxmi?=
 =?us-ascii?q?ymCDYF9lz0LAQGEbIMbIjgSAQMBAQIBAQIBAQIQAQEBCgkLCCkvgjYigmYBA?=
 =?us-ascii?q?QEDEig/EAIBCBgeEFcCBAEaGoJ/ggKaFwKBEIlYAQEBgh2KLIwNghaBEYMSh?=
 =?us-ascii?q?QGFWwKLFZR3CQWRIyCBSgGPQCyXZAIEAgQFAhSBXYF3cIM9gjSOJkABjSiBH?=
 =?us-ascii?q?wEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Nov 2018 12:22:19 -0600
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARIDxID143519;
        Tue, 27 Nov 2018 13:22:19 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2p19t40fsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 13:22:19 -0500
Cc:     <baicar.tyler@gmail.com>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <lukas@wunner.de>, <bhelgaas@google.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <ruscur@russell.cc>,
        <sbobroff@linux.ibm.com>, <oohall@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Received: from ausxippc110.us.dell.com ([143.166.85.200])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Nov 2018 00:21:57 +0600
X-LoopCount0: from 10.166.134.89
X-IronPort-AV: E=Sophos;i="5.56,287,1539666000"; 
   d="scan'208";a="734245329"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <okaya@kernel.org>, <mr.nuke.me@gmail.com>, <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Topic: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Index: AQHUfTk2X+FUHiVWnkuZssuLn5DqDg==
Date:   Tue, 27 Nov 2018 18:22:15 +0000
Message-ID: <336e233b1ad642dcac9638d5fb275810@ausx13mps321.AMER.DELL.COM>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
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
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
 <4728316eb84446358e0a07bbf1e42b57@ausx13mps321.AMER.DELL.COM>
 <bac2c78a-cd56-7287-e4fd-6042e9b3432c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.193]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=731 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270155
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/20/2018 04:08 PM, Sinan Kaya wrote:=0A=
> I followed the ASWG thread yesterday. There will be a meeting next week t=
o=0A=
> discuss this.=0A=
=0A=
Any updates on the meeting?=0A=
=0A=
