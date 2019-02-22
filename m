Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFA6C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 19:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DF120700
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 19:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="uIMUwW7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfBVTTT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:19:19 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:41554 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbfBVTTT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 14:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1550863158; x=1582399158;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WMxBvZ0LSIpFX0vUXKVZnb0yHV1iHE0/Huw9G8W0hI0=;
  b=uIMUwW7tJpWayYc9H8WWrLuclA1nEJFFDgA0IynJovoyzDGEYvc9fktN
   Ngd5tzvdVOMDxB+CfqNU7/yNtIl060tJOgMTACgQ7FDKdPRMfnZWSED/0
   0rj8h5/qqHCYoiR/XeFCWoSE+VFfH0SmCsaDSfufVDLt2ExoRHxGWMLLl
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FrAACfSHBchyWd50NkHQEBBQEHBQG?=
 =?us-ascii?q?BUwYBCwGCWYEUJwqMdop7gg2BfZYhgXsLAQEshECEASI2Bw0BAwEBAgEBAgE?=
 =?us-ascii?q?BAhABAQEKCwkIKS+COiKCcAEBAQMSKDUKEAIBCBgeEFcCBBMIGoJ+gXOfTD0?=
 =?us-ascii?q?CbYEBiQcBAQGCHooyjEiCFoN1LoRlHE2FFAKMD5dKCQWSUyGBcYVbi0OcXAI?=
 =?us-ascii?q?EAgQFAhSBTgSCBHCDPII2jidBMYEojUQBgR4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2FrAACfSHBchyWd50NkHQEBBQEHBQGBUwYBCwGCWYEUJ?=
 =?us-ascii?q?wqMdop7gg2BfZYhgXsLAQEshECEASI2Bw0BAwEBAgEBAgEBAhABAQEKCwkIK?=
 =?us-ascii?q?S+COiKCcAEBAQMSKDUKEAIBCBgeEFcCBBMIGoJ+gXOfTD0CbYEBiQcBAQGCH?=
 =?us-ascii?q?ooyjEiCFoN1LoRlHE2FFAKMD5dKCQWSUyGBcYVbi0OcXAIEAgQFAhSBTgSCB?=
 =?us-ascii?q?HCDPII2jidBMYEojUQBgR4BAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2019 13:19:16 -0600
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MJDBnn196550;
        Fri, 22 Feb 2019 14:19:16 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2qtmm9gsge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Feb 2019 14:19:15 -0500
Cc:     <lukas@wunner.de>, <mr.nuke.me@gmail.com>, <bhelgaas@google.com>,
        <Austin.Bolen@dell.com>, <keith.busch@intel.com>,
        <Shyam.Iyer@dell.com>, <okaya@kernel.org>,
        <linux-pci@vger.kernel.org>, <mika.westerberg@linux.intel.com>,
        <okaya@codeaurora.org>, <poza@codeaurora.org>,
        <linux-kernel@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Feb 2019 01:18:58 +0600
X-LoopCount0: from 10.166.134.85
X-IronPort-AV: E=Sophos;i="5.58,400,1544508000"; 
   d="scan'208";a="1365407354"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <oohall@gmail.com>
Subject: Re: [PATCH RFC v2 4/4] PCI: hotplug: Add quirk For Dell nvme pcie
 switches
Thread-Topic: [PATCH RFC v2 4/4] PCI: hotplug: Add quirk For Dell nvme pcie
 switches
Thread-Index: AQHUyLqRKxehBZutlk6MputMunrGNg==
Date:   Fri, 22 Feb 2019 19:19:10 +0000
Message-ID: <747feb2ef93c4c5e97813232904de829@ausx13mps321.AMER.DELL.COM>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
 <20190220012031.10741-5-mr.nuke.me@gmail.com>
 <20190221075634.uih5ysqwkna7cku4@wunner.de>
 <027101b4652c4e0c98b86649aa3e4732@ausx13mps321.AMER.DELL.COM>
 <CAOSf1CGqKePUE7Z9R3ojX6Ba_RxsdS7Y2rHONzbZNPNti8MtwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=979 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220132
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/21/19 8:05 PM, Oliver wrote:=0A=
> On Fri, Feb 22, 2019 at 5:38 AM <Alex_Gagniuc@dellteam.com> wrote:=0A=
>> On 2/21/19 1:57 AM, Lukas Wunner wrote:=0A=
[snip]=0A=
>>> If the quirk is x86-specific, please enclose it in "#ifdef CONFIG_X86"=
=0A=
>>> to reduce kernel footprint on other arches.=0A=
>>=0A=
>> That's a tricky one. If you look at p. 185 of [1], items 9, 11, and 12=
=0A=
>> are standard x16 cards that would fit in any x16 slot. Those cards have=
=0A=
>> the offending switches.=0A=
>>=0A=
>> On the one hand, you could take the cards and backplane and put them in=
=0A=
>> a non-hax86 system. On the other hand, I don't see why someone would=0A=
>> want to do this.=0A=
> =0A=
> I have a couple of POWER boxes with Dell branded switch cards in them.=0A=
> I have no idea why either, but it does happen.=0A=
=0A=
The hardware debouncer, I think, is on the backplane, so you'd really =0A=
need both the switch and backplane combo. I've seen other marketing =0A=
departments call the switches "NVMe HBA".=0A=
=0A=
Alex=0A=
