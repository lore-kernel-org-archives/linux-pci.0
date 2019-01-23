Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D98CC282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D38F218A1
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 20:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="h+LqmrGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfAWUVi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:21:38 -0500
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:11099 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfAWUVi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 15:21:38 -0500
X-Greylist: delayed 668 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 15:21:38 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1548274876; x=1579810876;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jHRV8hbauziyb1UYvrlyhwgqQ8i7+tkUOO3dFQpIcXM=;
  b=h+LqmrGwup7yIIHz0e6ZK0HP2WlaYMQa+mEZA5HNgvP5sNetY6Th+F5m
   MN5uSdSJaT/nxz4jFaMufNj51SPGmBTrt0pid15oHlpKOoiPjqWG3A1H+
   WKSfXAVLpEEdiJJPf+mQQxz8cVSYGAc6+LpPJgePgk0quYRyWjuysM+pT
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EIAADzyEhchyeV50NjGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUgUBAQELAYJpgQInCoxwixSCDZgDFIFnCwEBIwkChD6CfyI1CA0?=
 =?us-ascii?q?BAwEBAgEBAgEBAhABAQEVCQgpIwyCOiIcTWsBAQEBAQEjAg1kAQEBAxIoPxA?=
 =?us-ascii?q?CAQgYHhBXAgQBGhMHgwABggEPoCg9AoFuiQcBAQGCHoovBYxBghaBEYJkLoM?=
 =?us-ascii?q?eBBiBFAESAR+FYAKKGJgOCQWHIYpyIIFnkDGKB4EIhBmLXwIEAgQFAhSBRwE?=
 =?us-ascii?q?1Z3Fwgz2CNIhohT9BMQGBJ4c8gR8BgR4BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EIAADzyEhchyeV50NjGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYJpgQInCoxwixSCDZgDFIFnCwEBIwkChD6CfyI1CA0BAwEBAgEBAgEBA?=
 =?us-ascii?q?hABAQEVCQgpIwyCOiIcTWsBAQEBAQEjAg1kAQEBAxIoPxACAQgYHhBXAgQBG?=
 =?us-ascii?q?hMHgwABggEPoCg9AoFuiQcBAQGCHoovBYxBghaBEYJkLoMeBBiBFAESAR+FY?=
 =?us-ascii?q?AKKGJgOCQWHIYpyIIFnkDGKB4EIhBmLXwIEAgQFAhSBRwE1Z3Fwgz2CNIhoh?=
 =?us-ascii?q?T9BMQGBJ4c8gR8BgR4BAQ?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2019 14:10:21 -0600
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NK7mUA159036
        for <linux-pci@vger.kernel.org>; Wed, 23 Jan 2019 15:10:29 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com [68.232.154.99])
        by mx0a-00154901.pphosted.com with ESMTP id 2q6vxxgrqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Wed, 23 Jan 2019 15:10:29 -0500
Cc:     <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <Austin.Bolen@dell.com>
Received: from ausxipps310.us.dell.com ([143.166.148.211])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2019 02:10:28 +0600
X-LoopCount0: from 10.166.134.89
X-IronPort-AV: E=Sophos;i="5.56,513,1539666000"; 
   d="scan'208";a="310025087"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <keith.busch@intel.com>, <lukas@wunner.de>
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Topic: PCI: hotplug: Erroneous removal of hotplug PCI devices
Thread-Index: AQHUs0hi5mR8YZ0nPk+DZaS87pNxDw==
Date:   Wed, 23 Jan 2019 20:10:27 +0000
Message-ID: <8a4bdec599594570ab71cdfc0ba22ffb@ausx13mps317.AMER.DELL.COM>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123185420.2pennvzvkuhqfmtj@wunner.de>
 <20190123190723.rnt5llkek5st7ddt@wunner.de>
 <20190123190945.GD6629@localhost.localdomain>
 <20190123192829.qjxjhsmi7avasjnh@wunner.de>
 <20190123194727.GB8193@localhost.localdomain>
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
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230148
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/23/19 1:53 PM, Keith Busch wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Wed, Jan 23, 2019 at 08:28:29PM +0100, Lukas Wunner wrote:=0A=
>> On Wed, Jan 23, 2019 at 12:09:46PM -0700, Keith Busch wrote:=0A=
>>> On Wed, Jan 23, 2019 at 08:07:23PM +0100, Lukas Wunner wrote:=0A=
>>>> On Wed, Jan 23, 2019 at 07:54:20PM +0100, Lukas Wunner wrote:=0A=
>>>>> So I don't see a perfect solution.  What device are we talking about=
=0A=
>>>>> anyway?  400 ms is a *long* time.=0A=
>>>>=0A=
>>>> Also, how exactly does this issue manifest itself:  Is it just an=0A=
>>>> annoyance that the slot is brought up/down/up or does it not work=0A=
>>>> at all?=0A=
>>>=0A=
>>> Yeah, there is an nvme driver bug that hits a dead lock if you bring=0A=
>>> a very quick add-remove sequence. The nvme remove tries to delete IO=0A=
>>> resources before the async probe side set them up, so the driver doesn'=
t=0A=
>>> actually see that they're invalid. I have a proposed fix, but waiting t=
o=0A=
>>> here if it is successful.=0A=
>>>=0A=
>>> bz: https://bugzilla.kernel.org/show_bug.cgi?id=3D202081=0A=
>>=0A=
>> Hm, there's no full dmesg output attached, so it's not possible to=0A=
>> tell what the topology looks like and what the vendor/device ID of=0A=
>> 0000:b0:04.0 is.=0A=
>>=0A=
>> Also, there's only a card present / link up sequence visible in the=0A=
>> abridged dmesg output which has a 4 usec delay, but no link up / card=0A=
>> present sequence with a 400 msec delay?=0A=
> =0A=
> Yeah, not easy to follow, and some discussion was off the bz.=0A=
> =0A=
> Link Change:=0A=
> =0A=
>    [  838.784541] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up=0A=
> =0A=
> Presence Detect Change +4msec:=0A=
> =0A=
>    [  839.183506] pciehp 0000:b0:04.0:pcie204: Slot(178): Card not presen=
t=0A=
> =0A=
> Inbetween these two entries has nvme start setting up its controller=0A=
> detected on the link up. The "not present" side tries to remove the same=
=0A=
> nvme device, but fails to invalidate the IO resources because it's racing=
=0A=
> with probe before it even set them up, leaving probe unable to complete=
=0A=
> IO a moment later because its IRQ resources were disabled.=0A=
> =0A=
> Meanwhile, the blk-mq timeout handler can't do anything because the=0A=
> device state is disconnected and believes the removal side is handling=0A=
> things. What a mess...=0A=
> =0A=
> We can fix it, just want to hear if Alex can confirm the proposal is=0A=
> successful.=0A=
=0A=
OOPS! Totally missed there was a patch on bz. Will update bz once =0A=
testing is done.=0A=
=0A=
Alex=0A=
=0A=
