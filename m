Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8950C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A74A2086C
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="tkH3b2RS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A74A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeKPFnF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:43:05 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:22042 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbeKPFnF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Nov 2018 00:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1542310437; x=1573846437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VQip/TrRTfb5FzDvAYT0yUl71BfNR0TbXzY6hJNk3Z0=;
  b=tkH3b2RS3YpQA+LaTUrvRiHJ0T2uW3Dcv/VRAqOFqSBN6BlahHA5xQ5E
   tGYqOQwRvFSjTUxS4qPjvbUhMj43ILdaGWjeGkQJxupk9YQZ4za1K1dP8
   IWL5WtEPajQ+L0Jb4OPjhhgcQOUpEgMhCe7wTeX+z8FKAuTvZJID53BMj
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EBAABeye1bhyeV50NZChkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEHAQEBAQEBgVEEAQEBAQELAQGDWBInCowGX40rgXqVPBSBZgsBARi?=
 =?us-ascii?q?EVAKDczQJDQEDAQECAQECAQECEAEBAQoLCQgpL0IBDgGBZCKCZQEBAQEDARE?=
 =?us-ascii?q?VEz8MBAIBCBEEAQEBHhAoIQEFCAIEAQ0FCBqCf4ICnC0CgRCJWAEBAYFqM4o?=
 =?us-ascii?q?mjhuBEYMShEsBBwsBhXoCiQ6BdoVMjk5GBwKNDYQPIJB2l2ACBAIEBQIUgUa?=
 =?us-ascii?q?BHXFwgzyCNY4lQAExAYJViHiBH4EfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EBAABeye1bhyeV50NZChkBAQEBAQEBAQEBAQEHAQEBA?=
 =?us-ascii?q?QEBgVEEAQEBAQELAQGDWBInCowGX40rgXqVPBSBZgsBARiEVAKDczQJDQEDA?=
 =?us-ascii?q?QECAQECAQECEAEBAQoLCQgpL0IBDgGBZCKCZQEBAQEDAREVEz8MBAIBCBEEA?=
 =?us-ascii?q?QEBHhAoIQEFCAIEAQ0FCBqCf4ICnC0CgRCJWAEBAYFqM4omjhuBEYMShEsBB?=
 =?us-ascii?q?wsBhXoCiQ6BdoVMjk5GBwKNDYQPIJB2l2ACBAIEBQIUgUaBHXFwgzyCNY4lQ?=
 =?us-ascii?q?AExAYJViHiBH4EfAQE?=
Received: from mx0a-00154901.pphosted.com (HELO mx0b-00154901.pphosted.com) ([67.231.149.39])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2018 13:33:57 -0600
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAFJMjp1067855;
        Thu, 15 Nov 2018 14:33:56 -0500
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0b-00154901.pphosted.com with ESMTP id 2ns8ycafq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Nov 2018 14:33:56 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Nov 2018 01:33:53 +0600
X-LoopCount0: from 10.166.132.190
X-IronPort-AV: E=Sophos;i="5.56,237,1539666000"; 
   d="scan'208";a="238898926"
To:     <mika.westerberg@linux.intel.com>, <lorenzo.pieralisi@arm.com>
CC:     <lukas@wunner.de>, <iommu@lists.linux-foundation.org>,
        <joro@8bytes.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <ashok.raj@intel.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>,
        <jacob.jun.pan@intel.com>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <YehezkelShB@gmail.com>,
        <ckellner@redhat.com>, <anthony.wong@canonical.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Thread-Topic: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Thread-Index: AQHUeqH3m6Bzl9jyAUGXGzFcP9h+yqVM0vKAgAEbdgCAAAh/AIAABTIAgAMNfYCAAA5UAIAABp6AgAAIYACAAAJ5gIAAXB0AgAAU5AD//6RacA==
Date:   Thu, 15 Nov 2018 19:33:54 +0000
Message-ID: <372db397d5384efd8e7264ba8e1b9cbd@ausx13mpc120.AMER.DELL.COM>
References: <20181112180203.lx72gjfplb6xlur7@wunner.de>
 <20181113105636.GB11202@e107981-ln.cambridge.arm.com>
 <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <20181115190054.GD4179@lahna.fi.intel.com>
In-Reply-To: <20181115190054.GD4179@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=895 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150169
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Thursday, November 15, 2018 1:01 PM
> To: Lorenzo Pieralisi
> Cc: Lukas Wunner; iommu@lists.linux-foundation.org; Joerg Roedel; David
> Woodhouse; Lu Baolu; Ashok Raj; Bjorn Helgaas; Rafael J. Wysocki; Jacob j=
un Pan;
> Andreas Noever; Michael Jamet; Yehezkel Bernat; Christian Kellner; Limonc=
iello,
> Mario; Anthony Wong; linux-acpi@vger.kernel.org; linux-pci@vger.kernel.or=
g; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Thu, Nov 15, 2018 at 05:46:08PM +0000, Lorenzo Pieralisi wrote:
> > Do you really need to parse it if the dev->is_thunderbolt check is enou=
gh ?
>=20
> Yes, we need to parse it one way or another. dev->is_thunderbolt is
> based on heuristics which do not apply anymore when the thing gets
> integrated in the SoC.
>=20
> The _DSD is there already (on existing systems) and is being used by
> Windows so I don't understand why we cannot take advantage of it? Every
> new system with Thunderbolt ports will have it.

Furthermore it's entirely in the BIOS writers best interest to do this corr=
ectly
as it applies proper policy on Windows as well.

I wouldn't be surprised if WHCK failed if it was done wrong.
