Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43801 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab2EHIWI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2012 04:22:08 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 867D13EE0BD
	for <linux-pci@vger.kernel.org>; Tue,  8 May 2012 17:22:05 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 67EED45DEB8
	for <linux-pci@vger.kernel.org>; Tue,  8 May 2012 17:22:05 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 41CA745DEB3
	for <linux-pci@vger.kernel.org>; Tue,  8 May 2012 17:22:05 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2A5BA1DB8047
	for <linux-pci@vger.kernel.org>; Tue,  8 May 2012 17:22:05 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id D353C1DB803F
	for <linux-pci@vger.kernel.org>; Tue,  8 May 2012 17:22:04 +0900 (JST)
Date: Tue, 8 May 2012 17:21:53 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/6] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
Message-Id: <20120508172153.b67a8cc6.izumi.taku@jp.fujitsu.com>
In-Reply-To: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com>
References: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Jiang,

 I tested this pachset.
  (to be honest, as I used Bjorn tree, I changed a little of Patch6/6 
   to apply to his tree.)

 My machine failed to boot after applied your patchset.
 The reason is:
    My machine's MCFG table shows that End bus number is 0x13.

[000h 0000  4]                    Signature : "MCFG"    /* Memory Mapped Configuration table */
[004h 0004  4]                 Table Length : 00000040
[008h 0008  1]                     Revision : 01
[009h 0009  1]                     Checksum : 3E
[00Ah 0010  6]                       Oem ID : "PTLTD "
[010h 0016  8]                 Oem Table ID : "  MCFG  "
[018h 0024  4]                 Oem Revision : 06040001
[01Ch 0028  4]              Asl Compiler ID : " LTP"
[020h 0032  4]        Asl Compiler Revision : 00000000

[024h 0036  8]                     Reserved : 0000000000000000

[02Ch 0044  8]                 Base Address : 00000000F0000000
[034h 0052  2]         Segment Group Number : 0000
[036h 0054  1]             Start Bus Number : 00
[037h 0055  1]               End Bus Number : 13
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[038h 0056  4]                     Reserved : 00000000

   But CRS shows bus range is 0x00 - 0xff. So arch_acpi_pci_root_add() failed
   because pci_mmconfig_insert() returns not -EEXIST but -EINVAL.

[    0.094236] PCI: MMCONFIG for domain 0000 [bus 00-ff] conflicts with domain 0000 [bus 00-13]

int __devinit pci_mmconfig_insert(int segment, int start, int end, u64 addr)
{
..
(snip)
...
        mutex_lock(&pci_mmcfg_lock);
        cfg = pci_mmconfig_lookup(segment, start);
        if (cfg) {
                if (cfg->start_bus <= start && cfg->end_bus >= end) {
                        rc = -EEXIST;
                } else {
                        printk(KERN_WARNING PREFIX
                               "MMCONFIG for domain %04x [bus %02x-%02x] "
                               "conflicts with domain %04x [bus %02x-%02x]\n",
                               segment, start, end,
                               cfg->segment, cfg->start_bus, cfg->end_bus);
                }
                goto out;


  My impression is my machine's firmware is broken.
  Howerver my machine boots well without your patchset. So I report as a problem.

   
Best regards,
Taku Izumi <izumi.taku@jp.fujitsu.com>

