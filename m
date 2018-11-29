Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE324C43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 18:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865802082F
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 18:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="KM4fXjyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865802082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbeK3GEE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:04:04 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:20488 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbeK3GEE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Nov 2018 01:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1543517861; x=1575053861;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FTFnN1BsmJTwfNfmFVxT6UakrtjsP3Ns+sJmB2+rBSw=;
  b=KM4fXjyRGQflFh3bZpoetNIZr0RvcVOHuLvBnhsiGF1NeOYOzGerTlZs
   ohNWH9t+4dtEgn22kg0jXsXZxSxoajphO0oG/YknZ0IDnnWUrXgOMDZ9y
   7CrnYBqSwKwxS8QCIA8yF06tv3wbIy49QVsb4+2jwijmIzK5Ctf7kJRQ4
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EGAADJNQBchyeV50NkGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUQYBAQELAYNrMYRRhASDMl+LKYINgX2VR4F6CwEBhGyDNSI0CQ0?=
 =?us-ascii?q?BAwEBAgEBAgEBAhABAQEKCwkIKS+CNiKCZgEBAQMSKD0CEAIBCBgeEFcCBAE?=
 =?us-ascii?q?aGoJ/ggKbcz0CgRCJWAEBAYIdii+MFoIWg3UugSaDW4VbAokngXKVCgkFjUS?=
 =?us-ascii?q?DYSCBfY8fiHiPLwIEAgQFAhSBRoIOcIM9gjSOJkABjViBHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EGAADJNQBchyeV50NkGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYNrMYRRhASDMl+LKYINgX2VR4F6CwEBhGyDNSI0CQ0BAwEBAgEBAgEBA?=
 =?us-ascii?q?hABAQEKCwkIKS+CNiKCZgEBAQMSKD0CEAIBCBgeEFcCBAEaGoJ/ggKbcz0Cg?=
 =?us-ascii?q?RCJWAEBAYIdii+MFoIWg3UugSaDW4VbAokngXKVCgkFjUSDYSCBfY8fiHiPL?=
 =?us-ascii?q?wIEAgQFAhSBRoIOcIM9gjSOJkABjViBHwEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2018 12:57:40 -0600
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wATIlgt1155006;
        Thu, 29 Nov 2018 13:57:40 -0500
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0a-00154901.pphosted.com with ESMTP id 2p2gf5j6f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 13:57:40 -0500
Cc:     <Austin.Bolen@dell.com>, <keith.busch@intel.com>,
        <Shyam.Iyer@dell.com>, <lukas@wunner.de>,
        <mika.westerberg@linux.intel.com>, <okaya@codeaurora.org>,
        <rafael.j.wysocki@intel.com>, <poza@codeaurora.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Nov 2018 00:57:27 +0600
X-LoopCount0: from 10.166.134.89
X-IronPort-AV: E=Sophos;i="5.56,295,1539666000"; 
   d="scan'208";a="244747003"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Thread-Topic: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Thread-Index: AQHUh3extvl0RTSvTEW+XZDJcp0hUQ==
Date:   Thu, 29 Nov 2018 18:57:37 +0000
Message-ID: <1828edee07fa483d9600aeb5b9b69456@ausx13mps321.AMER.DELL.COM>
References: <20181129000829.14751-1-mr.nuke.me@gmail.com>
 <20181129173553.GD178809@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.193]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=741 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290155
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/29/2018 11:36 AM, Bjorn Helgaas wrote:=0A=
> On Wed, Nov 28, 2018 at 06:08:24PM -0600, Alexandru Gagniuc wrote:=0A=
>> A warning is generated when a PCIe device is probed with a degraded=0A=
>> link, but there was no similar mechanism to warn when the link becomes=
=0A=
>> degraded after probing. The Link Bandwidth Notification provides this=0A=
>> mechanism.=0A=
>>=0A=
>> Use the link bandwidth notification interrupt to detect bandwidth=0A=
>> changes, and rescan the bandwidth, looking for the weakest point. This=
=0A=
>> is the same logic used in probe().=0A=
> =0A=
> I like the concept of this.  What I don't like is the fact that it's=0A=
> tied to pciehp, since I don't think the concept of Link Bandwidth=0A=
> Notification is related to hotplug.  So I think we'll only notice this=0A=
> for ports that support hotplug.  Maybe it's worth doing it this way=0A=
> anyway, even if it could be generalized in the future?=0A=
=0A=
That makes sense. At first, I thought that BW notification was tied to =0A=
hotplug, but our PCIe spec writer disagreed with that assertion. I'm =0A=
just not sure where to handle the interrupt otherwise.=0A=
=0A=
Alex=0A=
=0A=
