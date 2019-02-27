Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6660C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 20:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A33213A2
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 20:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="I/ENQWiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfB0UWK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:22:10 -0500
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:47264 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727240AbfB0UWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 15:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1551298910; x=1582834910;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FLxNDByFidAGh+qAvy5vd61CQ7gHdJj8hcDuZlNNBXg=;
  b=I/ENQWizbRlXtxZVTcQJInSBFjXdj0eo4j7PX88J698RGJeJhE03nT9v
   +j92mR00LxzJKbXMSoSD8Sk7MbDGkJ86adNyl568VIVic01sRiQfI4Eb6
   cZazFq6q33aeqnSyw5jApG6sOyDAu1RjQA9Jxv6xuc/BdUkJr7zyVIcAz
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EOAAAm8XZchieV50NkGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBVAIBAQEBCwGCWYEUMYx3jHyYNIFnCwEBLIRAhBAiNwYNAQM?=
 =?us-ascii?q?BAQIBAQIBAQIQAQEBCgkLCCkvgjoigm8BAQEDARIoPQIFCwIBCBgeEFcCBAE?=
 =?us-ascii?q?aGoJ+gWsIoCM9Am2BAYkHAQEBgh6KKoxIghaDdS6BJoNEF4VhAowSl1gJBZJ?=
 =?us-ascii?q?dIZMcil2SFwIEAgQFAhSBXYF5cIM9gicOCROOC0GBWY9/AYEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2EOAAAm8XZchieV50NkGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?AIBAQEBCwGCWYEUMYx3jHyYNIFnCwEBLIRAhBAiNwYNAQMBAQIBAQIBAQIQA?=
 =?us-ascii?q?QEBCgkLCCkvgjoigm8BAQEDARIoPQIFCwIBCBgeEFcCBAEaGoJ+gWsIoCM9A?=
 =?us-ascii?q?m2BAYkHAQEBgh6KKoxIghaDdS6BJoNEF4VhAowSl1gJBZJdIZMcil2SFwIEA?=
 =?us-ascii?q?gQFAhSBXYF5cIM9gicOCROOC0GBWY9/AYEeAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2019 14:21:43 -0600
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RKDP1j066679;
        Wed, 27 Feb 2019 15:22:01 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0a-00154901.pphosted.com with ESMTP id 2qwsvh34cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Feb 2019 15:22:01 -0500
Cc:     <helgaas@kernel.org>, <Austin.Bolen@dell.com>,
        <Shyam.Iyer@dell.com>, <bhelgaas@google.com>,
        <rafael.j.wysocki@intel.com>, <keith.busch@intel.com>,
        <poza@codeaurora.org>, <mika.westerberg@linux.intel.com>,
        <fred@fredlawl.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Feb 2019 02:21:35 +0600
X-LoopCount0: from 10.166.134.83
X-IronPort-AV: E=Sophos;i="5.58,420,1544508000"; 
   d="scan'208";a="1367840416"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <lukas@wunner.de>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v2] PCI: pciehp: Report degraded links via link bandwidth
 notification
Thread-Topic: [PATCH v2] PCI: pciehp: Report degraded links via link bandwidth
 notification
Thread-Index: AQHUjlm7N2lQKXAHOEmL/Rp7Y7d0Qw==
Date:   Wed, 27 Feb 2019 20:21:58 +0000
Message-ID: <a941304f8cc244adb265aa7c27027938@ausx13mps317.AMER.DELL.COM>
References: <20181129230454.GF178809@google.com>
 <20181207182021.16344-1-mr.nuke.me@gmail.com>
 <20190225022857.awuspuxb4bedirjp@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270134
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/24/19 8:29 PM, Lukas Wunner wrote:=0A=
> On Fri, Dec 07, 2018 at 12:20:00PM -0600, Alexandru Gagniuc wrote:=0A=
> =0A=
> =0A=
>> Q: Why is this unconditionally compiled in?=0A=
>> A: The symmetrical check in pci probe() is also always compiled in.=0A=
> =0A=
> Hm, it looks like the convention is to provide a separate Kconfig entry=
=0A=
> for each port service.=0A=
=0A=
Does the convention still make sense in light of the symmetry reason?=0A=
=0A=
>> Q: Why call module_init() instead of adding a call in pcie_init_services=
() ?=0A=
>> A: A call in pcie_init_services() also requires a prototype in portdrv.h=
, a=0A=
>> non-static implementation in bw_notification.c. Using module_init() is=
=0A=
>> functionally equivalent, and takes less code.=0A=
> =0A=
> Commit c29de84149ab ("PCI: portdrv: Initialize service drivers directly")=
=0A=
> moved away from module_init() on purpose, apparently to fix a race=0A=
> condition.=0A=
=0A=
*GROWL*=0A=
=0A=
=0A=
> What if the link is retrained at the same speed/width?  Intuitively=0A=
> I'd compare the speed in the Link Status Register to what is cached=0A=
> in the cur_bus_speed member of struct pci_bus and print a message=0A=
> only if the speed has changed.  (Don't we need to cache the width as=0A=
> well?)=0A=
=0A=
There are two mechanisms to bring a degraded link back to full BW.=0A=
   1. Secondary bus reset, which results in the device being tore down =0A=
along with our cached speed value.=0A=
   2. Set the PCI_EXP_LNKCTL_LD (Link Disable) bit and clear it. We do =0A=
that as part of the pciehp teardown path. We'd lose our cached value =0A=
just like in the first case.=0A=
=0A=
>> +static irqreturn_t pcie_bw_notification_irq(int irq, void *context)=0A=
>> [...]=0A=
> =0A=
> You need to hold pci_bus_sem [...]=0A=
> This may sleep, so request the IRQ with request_threaded_irq() [...]=0A=
=0A=
Good catch! Thanks!=0A=
All other issues you pointed out should be resolved in next version.=0A=
=0A=
Alex=0A=
