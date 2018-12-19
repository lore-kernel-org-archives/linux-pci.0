Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125ADC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 19:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90AC217D7
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 19:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="Ygoh/Gn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeLSTYC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:24:02 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:45634 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbeLSTYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 14:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1545247442; x=1576783442;
  h=cc:from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=n1YtXccqxYr1erSIOt1YeepruzXMVqCykLF+5jQvA88=;
  b=Ygoh/Gn6VYxceqsySz8lswBfouoVjsS4kwYO9LO+qN1HD19wUp0MIRj9
   TtMi2WmNMunj4XL8FfkoCsA6JwVI7N+Cc94ZEGLep4p/F9ENK30dFrzWg
   J8fJ5uFhzNHPbhvNGk3TWGvm4/YrpQsa3XkcRTKxssS8LtuaX32on7QrN
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EnAADQmRpchyWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUwUBAQsBg2sxjGuNKpdeFIFnCwEBhGyCbiI2Bw0BAwEBAgEBAgEBAhA?=
 =?us-ascii?q?BAQEKCwkIKS+CNiKCZgEBAQMSFRM/EAIBIB4FC1cCBBsagwCCAptvPQKBbok?=
 =?us-ascii?q?GAQEBgWozijKMP4IWgRGEUwGDGA+FdwKJPzaHMpANCQWRVSCRWAGZWwIEAgQ?=
 =?us-ascii?q?FAhSBTAGCCHCDPYImDgkSjgtAAYxLgS6BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EnAADQmRpchyWd50NkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?2sxjGuNKpdeFIFnCwEBhGyCbiI2Bw0BAwEBAgEBAgEBAhABAQEKCwkIKS+CN?=
 =?us-ascii?q?iKCZgEBAQMSFRM/EAIBIB4FC1cCBBsagwCCAptvPQKBbokGAQEBgWozijKMP?=
 =?us-ascii?q?4IWgRGEUwGDGA+FdwKJPzaHMpANCQWRVSCRWAGZWwIEAgQFAhSBTAGCCHCDP?=
 =?us-ascii?q?YImDgkSjgtAAYxLgS6BHwEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Dec 2018 13:24:01 -0600
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBJJMaa9078617
        for <linux-pci@vger.kernel.org>; Wed, 19 Dec 2018 14:24:00 -0500
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0b-00154901.pphosted.com with ESMTP id 2pfnu7aeaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Wed, 19 Dec 2018 14:24:00 -0500
Cc:     <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <Austin.Bolen@dell.com>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Dec 2018 01:23:22 +0600
X-LoopCount0: from 10.166.134.83
X-IronPort-AV: E=Sophos;i="5.56,373,1539666000"; 
   d="scan'208";a="1174212462"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <keith.busch@intel.com>
Subject: [REGRESSION] Deadlock in nvme drive removal (Was: Problems with
 commit "cb4bfda62afa nvme-pci: fix hot removal during error handling")
Thread-Topic: [REGRESSION] Deadlock in nvme drive removal (Was: Problems with
 commit "cb4bfda62afa nvme-pci: fix hot removal during error handling")
Thread-Index: AQHUl9Bjjk1UkCV6B0S1+xCICLRfKg==
Date:   Wed, 19 Dec 2018 19:23:57 +0000
Message-ID: <240b79e0c3c442c88de378f522ba5813@ausx13mps321.AMER.DELL.COM>
References: <ab932da928c242ab976ff469be2fdc44@ausx13mps321.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.194]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812190151
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I've tracked down the problem to pciehp_ist() deadlocking on nvme =0A=
removal. I blame this on nvme bugs.=0A=
=0A=
#$ ls /sys/bus/pci/devices/0000\:b0\:04.0/msi_irqs/=0A=
44=0A=
=0A=
# ps aux |grep pcie=0A=
root       529  0.0  0.0      0     0 ?        D    11:04   0:00 =0A=
[irq/44-pciehp]=0A=
=0A=
# cat /proc/529/stack=0A=
[<0>] __flush_work+0x11a/0x1d0=0A=
[<0>] __cancel_work_timer+0x10a/0x190=0A=
[<0>] nvme_remove+0x38/0x170 [nvme]=0A=
[<0>] pci_device_remove+0x3b/0xc0=0A=
[<0>] device_release_driver_internal+0x180/0x240=0A=
[<0>] pci_stop_bus_device+0x69/0x90=0A=
[<0>] pci_stop_and_remove_bus_device+0xe/0x20=0A=
[<0>] pciehp_unconfigure_device+0x84/0x140=0A=
[<0>] pciehp_disable_slot+0x67/0x110=0A=
[<0>] pciehp_handle_presence_or_link_change+0x25f/0x400=0A=
[<0>] pciehp_ist+0x22b/0x230=0A=
[<0>] irq_thread_fn+0x1f/0x50=0A=
[<0>] irq_thread+0xf3/0x190=0A=
[<0>] kthread+0x112/0x130=0A=
[<0>] ret_from_fork+0x35/0x40=0A=
[<0>] 0xffffffffffffffff=0A=
=0A=
This is about two hours after the drive was removed, give or take a =0A=
timezone.=0A=
=0A=
<abridged_obligatory_frustrated_developer_rant>=0A=
This took about two damn weeks to track down. Where do I have to go to =0A=
collect the coffee rations?=0A=
<\abridged_obligatory_frustrated_developer_rant>=0A=
=0A=
Alex=0A=
=0A=
On 12/18/2018 04:28 PM, Gagniuc, Alexandru - Dell Team wrote:=0A=
> Hi,=0A=
> =0A=
> I've been seeing two issues with this commit. One was a NULL dereference=
=0A=
> that appears to have been fixed in 4.20-rc7.=0A=
> =0A=
> For the second issue, I've included a system log in Appendix B with an=0A=
> explanation of what events are being generated -- all done with a=0A=
> hardware yanker, not ACPI or fake injection techniques.=0A=
> =0A=
> After the second or so removal, the kernel will think the device is=0A=
> gone, and fails to recognize hotplug interrupts that bring the device=0A=
> back online. The hardware continues to send hotplug interrupts, but the=
=0A=
> handler doesn't want to recognize them -- look for "pciehp_isr hit"=0A=
> message in the logs.=0A=
> =0A=
> I'm seeing this issue starting with commit=0A=
> cb4bfda62afa "nvme-pci: fix hot removal during error handling"=0A=
> I can't reproduce it with the commit right before it.=0A=
> =0A=
> I'm not sure if this is a PCI or NVME bug, and it is baffling as to what=
=0A=
> the heck is going on. Even if I revert the commit from v4.20-rc7, I=0A=
> continue to see the hotplug interrupt misfire. I suspect it's the=0A=
> combination of several changes that breaks things.=0A=
> =0A=
> Who let the bugs out?=0A=
> =0A=
> Alex=0A=
> =0A=
> =0A=
> Appendix B: System log with explanations=0A=
> =0A=
> [  133.772812] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready=0A=
> =0A=
> **** Lanes 0-2 are disconnected here=0A=
> =0A=
> [  599.231003] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> [  599.231067] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Down=0A=
> [  599.272506] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> [  599.299943] pciehp 0000:b0:04.0:pcie204: Slot(178): Card present=0A=
> [  599.299947] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up=0A=
> [  599.605523] pci 0000:b1:00.0: [8086:0a55] type 00 class 0x010802=0A=
> [  599.605565] pci 0000:b1:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64b=
it]=0A=
> [  599.605612] pci 0000:b1:00.0: Max Payload Size set to 256 (was 128,=0A=
> max 512)=0A=
> [  599.605618] pci 0000:b1:00.0: enabling Extended Tags=0A=
> [  599.605845] acpi_run_hpx: Type 3 record not supported=0A=
> [  599.605984] pci 0000:b1:00.0: 7.876 Gb/s available PCIe bandwidth,=0A=
> limited by 8 GT/s x1 link at 0000:b0:04.0 (capable of 31.504 Gb/s with 8=
=0A=
> GT/s x4 link)=0A=
> [  599.606356] pcieport 0000:b0:04.0: bridge window [io  0x1000-0x0fff]=
=0A=
> to [bus b1] add_size 1000=0A=
> [  599.606364] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x10=
00]=0A=
> [  599.606368] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size=
=0A=
> 0x1000]=0A=
> [  599.606371] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x10=
00]=0A=
> [  599.606375] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size=
=0A=
> 0x1000]=0A=
> [  599.606382] pci 0000:b1:00.0: BAR 0: assigned [mem=0A=
> 0xe1500000-0xe1503fff 64bit]=0A=
> [  599.606426] pcieport 0000:b0:04.0: PCI bridge to [bus b1]=0A=
> [  599.606434] pcieport 0000:b0:04.0:   bridge window [mem=0A=
> 0xe1500000-0xe15fffff]=0A=
> [  599.606440] pcieport 0000:b0:04.0:   bridge window [mem=0A=
> 0x386000000000-0x3860001fffff 64bit pref]=0A=
> [  599.608379] nvme nvme4: pci function 0000:b1:00.0=0A=
> [  599.608680] nvme 0000:b1:00.0: enabling device (0000 -> 0002)=0A=
> [  603.386826]  nvme1n2: p1=0A=
> [  603.475185] md: super_written gets error=3D10=0A=
> [  603.475192] md/raid1:mdX: Disk failure on dm-13, disabling device.=0A=
>                  md/raid1:mdX: Operation continuing on 2 devices.=0A=
> [  603.519511] device-mapper: raid: Faulty raid1 device #1 has readable=
=0A=
> super block.  Attempting to revive it.=0A=
> =0A=
> *** Lanes 0-2 are reconnected=0A=
> =0A=
> [  603.548495] md: recovery of RAID array mdX=0A=
> =0A=
> *** All PCIe lanes are disconnected here=0A=
> =0A=
> [  623.162103] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> [  623.162169] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Down=0A=
> [  623.168534] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> [  623.185774] print_req_error: I/O error, dev nvme1n2, sector 7860864=0A=
> [  623.185812] print_req_error: I/O error, dev nvme1n2, sector 7861248=0A=
> [  623.185817] print_req_error: I/O error, dev nvme1n2, sector 7857920=0A=
> [  623.185822] print_req_error: I/O error, dev nvme1n2, sector 7858432=0A=
> [  623.185826] print_req_error: I/O error, dev nvme1n2, sector 7858560=0A=
> [  623.185830] print_req_error: I/O error, dev nvme1n2, sector 7862144=0A=
> [  623.185835] print_req_error: I/O error, dev nvme1n2, sector 7858944=0A=
> [  623.185870] md/raid1:mdX: Disk failure on dm-13, disabling device.=0A=
>                  md/raid1:mdX: Operation continuing on 2 devices.=0A=
> [  623.185873] md: mdX: recovery interrupted.=0A=
> [  623.185881] print_req_error: I/O error, dev nvme1n2, sector 7861376=0A=
> [  623.197723] print_req_error: I/O error, dev nvme1n2, sector 7859072=0A=
> [  623.197727] print_req_error: I/O error, dev nvme1n2, sector 7862528=0A=
> =0A=
> *** All PCIe lanes are re-connected=0A=
> =0A=
> [  628.842766] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> [  628.842829] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up=0A=
> [  629.147089] pci 0000:b1:00.0: [8086:0a55] type 00 class 0x010802=0A=
> [  629.147130] pci 0000:b1:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64b=
it]=0A=
> [  629.147177] pci 0000:b1:00.0: Max Payload Size set to 256 (was 128,=0A=
> max 512)=0A=
> [  629.147182] pci 0000:b1:00.0: enabling Extended Tags=0A=
> [  629.147401] acpi_run_hpx: Type 3 record not supported=0A=
> [  629.147888] pcieport 0000:b0:04.0: bridge window [io  0x1000-0x0fff]=
=0A=
> to [bus b1] add_size 1000=0A=
> [  629.147896] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x10=
00]=0A=
> [  629.147899] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size=
=0A=
> 0x1000]=0A=
> [  629.147903] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x10=
00]=0A=
> [  629.147906] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size=
=0A=
> 0x1000]=0A=
> [  629.147913] pci 0000:b1:00.0: BAR 0: assigned [mem=0A=
> 0xe1500000-0xe1503fff 64bit]=0A=
> [  629.147926] pcieport 0000:b0:04.0: PCI bridge to [bus b1]=0A=
> [  629.147933] pcieport 0000:b0:04.0:   bridge window [mem=0A=
> 0xe1500000-0xe15fffff]=0A=
> [  629.147939] pcieport 0000:b0:04.0:   bridge window [mem=0A=
> 0x386000000000-0x3860001fffff 64bit pref]=0A=
> [  629.148891] nvme nvme2: pci function 0000:b1:00.0=0A=
> [  629.148932] nvme 0000:b1:00.0: enabling device (0000 -> 0002)=0A=
> [  629.239386] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> [  629.239420] pciehp 0000:b0:04.0:pcie204: Slot(178): Card not present=
=0A=
> =0A=
> *** Lanes not disconnected again until here=0A=
> =0A=
> [  635.951171] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> [  635.992718] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> [  659.866526] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> [  659.877189] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> [  665.555242] pcieport 0000:b0:04.0: pciehp_isr hit=0A=
> =0A=
=0A=
