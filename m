Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C74FC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 22:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60901218D2
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 22:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="hU0jOBzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfAXWnR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:43:17 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:3224 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfAXWnR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 17:43:17 -0500
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2019 17:43:17 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1548369796; x=1579905796;
  h=from:cc:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1PzMuH4oGxgZpTiW/ME0EBj5c+8I7/VYk3TM8rofc3k=;
  b=hU0jOBzcmkvtW0mvQMYxXGonMhKnmwPFxngR8AJR3g6E2A8U+TnHv/6N
   WBdZ0NSn7fBS1cx76Lp9tJxdvFN8ZceGF0Lgn31i3z5ZVoqW6g1V/FhNX
   pxn+aWZZKjahxvN9r5y0ZrnpvPMn1FUdGaGRpg7o7XM5N9qfcxb6umIn/
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FWAQCoPEpchyWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZYFWghgxjHCLFIINgX6YBAsBAYRsgwYiOBIBAwEBAgEBAgEBAhABAQE?=
 =?us-ascii?q?KCwkIKS+COiKCbwEBAQECARIoPxACAQgYHhBXAgQBGhMHgwCBegigSj0CgW6?=
 =?us-ascii?q?JBwEBAYIeii+MQYIWgRGCZC6FAYVgAqItBwKLBYcZIJIfigyRBAIEAgQFAhS?=
 =?us-ascii?q?BXYF4cIM9gjSOJ0ABikCBHwEB?=
X-IPAS-Result: =?us-ascii?q?A2FWAQCoPEpchyWd50NkHAEBAQQBAQcEAQGBZYFWghgxj?=
 =?us-ascii?q?HCLFIINgX6YBAsBAYRsgwYiOBIBAwEBAgEBAgEBAhABAQEKCwkIKS+COiKCb?=
 =?us-ascii?q?wEBAQECARIoPxACAQgYHhBXAgQBGhMHgwCBegigSj0CgW6JBwEBAYIeii+MQ?=
 =?us-ascii?q?YIWgRGCZC6FAYVgAqItBwKLBYcZIJIfigyRBAIEAgQFAhSBXYF4cIM9gjSOJ?=
 =?us-ascii?q?0ABikCBHwEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2019 16:33:53 -0600
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OMSF2o044482
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 17:33:53 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2q7etc2pf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 17:33:53 -0500
From:   <Austin.Bolen@dell.com>
Cc:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <keith.busch@intel.com>, <Austin.Bolen@dell.com>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Jan 2019 04:33:38 +0600
X-LoopCount0: from 10.166.135.137
X-IronPort-AV: E=Sophos;i="5.56,518,1539666000"; 
   d="scan'208";a="344033959"
To:     <lukas@wunner.de>, <Alex_Gagniuc@Dellteam.com>
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Topic: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Index: AQHUs0hi5mR8YZ0nPk+DZaS87pNxDw==
Date:   Thu, 24 Jan 2019 22:33:50 +0000
Message-ID: <99e0b159d31a4f70ab9572d0f4093a31@AUSX13MPC131.AMER.DELL.COM>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123185420.2pennvzvkuhqfmtj@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=730 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240153
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/23/2019 12:54 PM, Lukas Wunner wrote:=0A=
> =0A=
=0A=
<snip=0A=
=0A=
> =0A=
> So I don't see a perfect solution.  What device are we talking about=0A=
> anyway?  400 ms is a *long* time.=0A=
=0A=
Some people have slow hands :-).  This is a U.2 device.  There are 2 =0A=
pins (Pin 4 =3D IfDet#/Pin 10 =3D PRSNT#) that determine presence and each =
=0A=
pin is a different length (On insert, IfDet# mates first, PRSNT# mates =0A=
second, PCIe data lanes mate 3rd).=0A=
=0A=
SAS drive:  IfDet# =3D 0, PRSNT# =3D 0=0A=
NVMe drive: IfDet# =3D 0, PRSNT# =3D 1.=0A=
=0A=
These 2 pins determine if it is a SAS or NVMe drive.  We have to wait =0A=
until both pins mate in order to know for sure it's an NVMe drive and =0A=
therefore generate PRSNT# to DSP above the drive.  But there is no way =0A=
to know when both pins have mated due to the way the U.2 connector =0A=
signals were defined so we have to dead wait.=0A=
=0A=
The time delta between these 2 pins mating on insert can vary =0A=
substantially with different users.  The time delta between these 2 pins =
=0A=
mating for some users we measured was > 100 ms (others were less than 10 =
=0A=
ms).  That was for "normal" insert.  It takes much longer if user =0A=
intentionally tries to insert slowly.=0A=
=0A=
We chose 500 ms as the delay after P4 (IfDet#) mates before sampling the =
=0A=
P10 (PRSNT#). About 100 ms of that is chewed up by the time delta of =0A=
presence pins mating and PCIe data lanes mating plus the time to train =0A=
the link leaving around 400 ms of time between DLLSC interrupt and PDSC =0A=
interrupt.=0A=
=0A=
For future, we will hide the U.2 device from OS for 1 second after =0A=
insert to all device to be fully inserted (in most cases) and reach =0A=
steady state.=0A=
=0A=
New form factors will (hopefully) have presence pins that are =0A=
last-to-mate so platforms/OSes do not have to rely on such guesswork to =0A=
know when devices are fully inserted.=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Lukas=0A=
> =0A=
=0A=
