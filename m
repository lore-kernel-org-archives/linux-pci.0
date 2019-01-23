Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC337C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 18:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C6821872
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 18:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="h17H6T14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfAWSaV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:30:21 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:38641 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfAWSaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 13:30:20 -0500
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 13:30:20 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1548268220; x=1579804220;
  h=cc:from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Y00C7tRnYEjWi1r2ndnCHmhJVs790HaQTGz2mZbQDYc=;
  b=h17H6T14uMRw80zvAV3Yu/P13tWo14RW1r2CXsbS+wK4s3oGI8eInYVP
   qF1iyz3/6Zkk7JvHPsLY7kP2YYmbYy5bxjo1puCwObF44eDWgB7Z4ChTk
   xI7KsJ0c4NR4u6ApPV4iGceIqCUdJ5HkI6TbO2eiyGC0Mtm/tnQ85b+v7
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EXAADCr0hchyWd50NkHQEBBQEHBQG?=
 =?us-ascii?q?BUQgBCwGBWoIRMYwRX4sQmhAUgWcLAQEshECCfyI0CQ0BAwEBAgEBAgEBAhA?=
 =?us-ascii?q?BAQEVCQgpL4I6IoJyFig/EgE+aQQbEweCNUuCAqAyPQKBbokHAQEBgh6KMYx?=
 =?us-ascii?q?BghaDdYUXZYUTAqImCQWKe4cYIJIXAZsHAgQCBAUCFIFGN4FYcIM9gjSBCQE?=
 =?us-ascii?q?OjQ9BgVmIWwGBHgEB?=
X-IPAS-Result: =?us-ascii?q?A2EXAADCr0hchyWd50NkHQEBBQEHBQGBUQgBCwGBWoIRM?=
 =?us-ascii?q?YwRX4sQmhAUgWcLAQEshECCfyI0CQ0BAwEBAgEBAgEBAhABAQEVCQgpL4I6I?=
 =?us-ascii?q?oJyFig/EgE+aQQbEweCNUuCAqAyPQKBbokHAQEBgh6KMYxBghaDdYUXZYUTA?=
 =?us-ascii?q?qImCQWKe4cYIJIXAZsHAgQCBAUCFIFGN4FYcIM9gjSBCQEOjQ9BgVmIWwGBH?=
 =?us-ascii?q?gEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2019 12:21:01 -0600
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NIJ1KW051385
        for <linux-pci@vger.kernel.org>; Wed, 23 Jan 2019 13:21:00 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com [68.232.154.99])
        by mx0b-00154901.pphosted.com with ESMTP id 2q6vqm099d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Wed, 23 Jan 2019 13:21:00 -0500
Cc:     <bhelgaas@google.com>, <lukas@wunner.de>, <keith.busch@intel.com>,
        <Austin.Bolen@dell.com>
Received: from ausxipps310.us.dell.com ([143.166.148.211])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2019 00:20:59 +0600
X-LoopCount0: from 10.166.134.82
X-IronPort-AV: E=Sophos;i="5.56,512,1539666000"; 
   d="scan'208";a="309987357"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <linux-pci@vger.kernel.org>
Subject: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Topic: hotplug: Erroneous removal of hotplug PCI devices
Thread-Index: AQHUs0hi5mR8YZ0nPk+DZaS87pNxDw==
Date:   Wed, 23 Jan 2019 18:20:57 +0000
Message-ID: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=687 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230134
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,=0A=
=0A=
This may be a mind-twisting explanation, so pleas bear with me.=0A=
=0A=
In PCIe, the presence detect bit (PD) in the slot status register should =
=0A=
be a logical OR of in-band and out-of band presence. In-band presence is =
=0A=
the data link layer status. So one would expect that a link up event, =0A=
would be accompanied by a PD changed event with PD set. Not everyone =0A=
follows that.=0A=
=0A=
I have a system here with the following order of events:=0A=
  *   0 ms : Link up=0A=
  * 400 ms : Presence detect up=0A=
On the first event, the device is probed as expected, and on the second =0A=
event, the device is removed as a SURPRISE!!!_REMOVAL. This is a bug.=0A=
=0A=
The logic is that on every change of presence detect:=0A=
/* Even if [the slot]'s occupied again, we cannot assume the card is the =
=0A=
same. */=0A=
Reasonable, but the resulting behavior is a bug.=0A=
=0A=
Solution 1 is to say it's a spec violation, so ignore it. They'll change =
=0A=
the "logical OR" thing in the next PCIe spec, so we still will have to =0A=
worry about this.=0A=
=0A=
It's obvious that just relying on presence detect state is prone to race =
=0A=
conditions. However, if a device is replaced, we'd expect the data link =0A=
layer state to change as well. So I think the best way to proceed is to =0A=
skip the SURPRISE!!!_REMOVAL if the following are true:=0A=
  * presence detect is set=0A=
  * DLL changed is not set=0A=
  * presence detect was not previously set=0A=
=0A=
Thoughts?=0A=
=0A=
Alex=0A=
