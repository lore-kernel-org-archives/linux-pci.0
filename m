Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FE3C04EB9
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 23:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DE320989
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 23:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="mRN1gYmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DE320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeK3KcM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:32:12 -0500
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:29334 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbeK3KcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Nov 2018 05:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1543533834; x=1575069834;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Oe0hfSdrcm+17ps9Ue+Ri0aZp6S6pvitj68xl3nHTyM=;
  b=mRN1gYmZALYLB98P93SgfjUisBe09QP0kP95Eo+6zC2cN9LGoWX/ovAz
   KoxVyGVHxuCLqZ3KRIdjVzVoXLyeM/2f12M947shladuRj9neIj2qSuZB
   kwRnI8rKVS3xdvFFvNfQNmnigvHGRhCLPuA0czcFcwM31RnHGy6xHJ3NO
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EJAAC5dABchyeV50NlGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUgUBAQELAYNrMYxmiyqCDYF9lUeBegsBAYRsgzUiNQgNAQMBAQI?=
 =?us-ascii?q?BAQIBAQIQAQEBCgsJCCkvgjYigmYBAQEDEig9AhACAQgYHhBXAgQBGhqCf4I?=
 =?us-ascii?q?CnRM9AoEQiVgBAQGCHYovjBaCFoN1LoEmg1uFWwKLGZUKCQWRJSCRHIh4jy8?=
 =?us-ascii?q?CBAIEBQIUgUgBggtwgz2CNI4mQAGNWIEfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EJAAC5dABchyeV50NlGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYNrMYxmiyqCDYF9lUeBegsBAYRsgzUiNQgNAQMBAQIBAQIBAQIQAQEBC?=
 =?us-ascii?q?gsJCCkvgjYigmYBAQEDEig9AhACAQgYHhBXAgQBGhqCf4ICnRM9AoEQiVgBA?=
 =?us-ascii?q?QGCHYovjBaCFoN1LoEmg1uFWwKLGZUKCQWRJSCRHIh4jy8CBAIEBQIUgUgBg?=
 =?us-ascii?q?gtwgz2CNI4mQAGNWIEfAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2018 17:23:54 -0600
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wATNILZq022309;
        Thu, 29 Nov 2018 18:25:00 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2p2q378wau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 18:25:00 -0500
Cc:     <mr.nuke.me@gmail.com>, <Austin.Bolen@dell.com>,
        <keith.busch@intel.com>, <Shyam.Iyer@dell.com>,
        <mika.westerberg@linux.intel.com>, <okaya@codeaurora.org>,
        <rafael.j.wysocki@intel.com>, <poza@codeaurora.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Nov 2018 05:24:46 +0600
X-LoopCount0: from 10.166.134.82
X-IronPort-AV: E=Sophos;i="5.56,296,1539666000"; 
   d="scan'208";a="324619136"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <helgaas@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Thread-Topic: [PATCH] PCI: pciehp: Report degraded links via link bandwidth
 notification
Thread-Index: AQHUh3extvl0RTSvTEW+XZDJcp0hUQ==
Date:   Thu, 29 Nov 2018 23:24:58 +0000
Message-ID: <10579c9bf79a42dd878c1e201bc9d254@ausx13mps321.AMER.DELL.COM>
References: <20181129000829.14751-1-mr.nuke.me@gmail.com>
 <20181129173553.GD178809@google.com>
 <1828edee07fa483d9600aeb5b9b69456@ausx13mps321.AMER.DELL.COM>
 <20181129191312.6ksdzjv6qojacv4j@wunner.de>
 <20181129230454.GF178809@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.193]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=998 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290196
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/29/2018 5:05 PM, Bjorn Helgaas wrote:=0A=
> On Thu, Nov 29, 2018 at 08:13:12PM +0100, Lukas Wunner wrote:=0A=
>> I guess the interrupt is shared with hotplug and PME?  In that case writ=
e=0A=
>> a separate pcie_port_service_driver and request the interrupt with=0A=
>> IRQF_SHARED.  Define a new service type in drivers/pci/pcie/portdrv.h.=
=0A=
>> Amend get_port_device_capability() to check for PCI_EXP_LNKCAP_LBNC.=0A=
> =0A=
> I really don't like the port driver design.  I'd rather integrate=0A=
> those services more tightly into the PCI core.  But realistically=0A=
> that's wishful thinking and may never happen, so this might be the=0A=
> most expedient approach.=0A=
=0A=
So, how would it get integrated? I don't like the port service driver =0A=
either. It's too dicky on how it creates some new devices that other =0A=
drives bind to. If we could have a 1:1 mapping between service drivers =0A=
and PCI capabilities, then it might make better sense.=0A=
=0A=
So, do I go the new service driver route?=0A=
=0A=
Alex=0A=
