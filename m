Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49060C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 18:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028D02083B
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 18:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="aSiDrPug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfBUSRa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:17:30 -0500
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:54644 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbfBUSRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 13:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1550773041; x=1582309041;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8i6/nUnqP7AVh1vH/JTQaE2bmdF4VPFWUdVQ/ZinIco=;
  b=aSiDrPugA5HMMfdJYUGFEURM9wvynnv1BVD2oYPZtaIookBJMZxqOrb6
   npkjHnSOSpzmlsPsF+z6WNuU8mvCR6kJ8OgHIa7KvZcSO3K0Z4Bb1VFsE
   jsYpxje2Jcw0O5ai9n+UNyuvSqcN4Sq+NpIVT2ooeQSI7POf4+D3nyPQQ
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EBAACq6m5chieV50NkGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUQUBAQEBCwGCWYEUMYwXX40DmB6BewsBASyEQIN9IjQJDQE?=
 =?us-ascii?q?DAQECAQECAQECEAEBAQoJCwgpL4I6IoJwAQEBAxIoPxACAQgYHhBXAgQBGhq?=
 =?us-ascii?q?CfoFzoDo9Am2BAYkHAQEBgh6KLoxIghaDdS6FAYVgAowOl0UJBZJRIYFikSm?=
 =?us-ascii?q?KSZIHAgQCBAUCFIFHgg9wgz2CNRyOC0GBWY1EAYEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2EBAACq6m5chieV50NkGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?QUBAQEBCwGCWYEUMYwXX40DmB6BewsBASyEQIN9IjQJDQEDAQECAQECAQECE?=
 =?us-ascii?q?AEBAQoJCwgpL4I6IoJwAQEBAxIoPxACAQgYHhBXAgQBGhqCfoFzoDo9Am2BA?=
 =?us-ascii?q?YkHAQEBgh6KLoxIghaDdS6FAYVgAowOl0UJBZJRIYFikSmKSZIHAgQCBAUCF?=
 =?us-ascii?q?IFHgg9wgz2CNRyOC0GBWY1EAYEeAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2019 12:17:21 -0600
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LI8Oxl056435
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2019 13:17:29 -0500
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com [68.232.153.201])
        by mx0a-00154901.pphosted.com with ESMTP id 2qpdmuu5se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Thu, 21 Feb 2019 13:17:28 -0500
Cc:     <bhelgaas@google.com>, <Austin.Bolen@dell.com>,
        <keith.busch@intel.com>, <Shyam.Iyer@dell.com>, <okaya@kernel.org>,
        <linux-pci@vger.kernel.org>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Feb 2019 00:17:29 +0600
X-LoopCount0: from 10.166.134.82
X-IronPort-AV: E=Sophos;i="5.58,396,1544508000"; 
   d="scan'208";a="275478783"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH RFC v2 0/4] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Thread-Topic: [PATCH RFC v2 0/4] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Thread-Index: AQHUyLqLRGHkzWQAhU+LNBt7eWsl5A==
Date:   Thu, 21 Feb 2019 18:17:27 +0000
Message-ID: <0e092401097e4c83871e1ff2d004d30d@ausx13mps321.AMER.DELL.COM>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
 <20190221153828.vd5uufymaut5j6o2@wunner.de>
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
 mlxlogscore=702 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210128
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/21/19 9:39 AM, Lukas Wunner wrote:=0A=
> On Tue, Feb 19, 2019 at 07:20:26PM -0600, Alexandru Gagniuc wrote:=0A=
>> (*) ECN was approved in Nov 2018, and is normative spec text. A lot of=
=0A=
>> the leaked PCIe 4.0 specs do not have this change.=0A=
> =0A=
> I thought it will be incorporated into 5.0, which is why it's missing=0A=
> in all 4.0 specs?=0A=
=0A=
Once an ECR is approved and promoted to ECN, it becomes normative spec =0A=
text. It's then up to the editors to incorporate the ECN into the =0A=
official spec and publish a more betterrer spec. AFAIK this should =0A=
officially be part of 4.0.=0A=
=0A=
Alex=0A=
