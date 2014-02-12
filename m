Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:43493 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaBLIAY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 03:00:24 -0500
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2EEA23EE1B9
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 17:00:23 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2145C45DF43
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 17:00:23 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0AAC045DF40
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 17:00:23 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EB3FD1DB803C
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 17:00:22 +0900 (JST)
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9AFB81DB802C
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 17:00:22 +0900 (JST)
From: "Izumi, Taku" <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>
Subject: RE: [PATCH] PCI: pciehp: Fix the problem that the present bit is
 not cleared though slot is empty
Date: Wed, 12 Feb 2014 08:00:20 +0000
Message-ID: <E86EADE93E2D054CBCD4E708C38D364A53C32F56@G01JPEXMBYT01>
References: <20140203160724.949a0ee5.izumi.taku@jp.fujitsu.com>
 <20140212004927.GH21057@google.com>
In-Reply-To: <20140212004927.GH21057@google.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

> Hi Taku,
> 
> Thanks a lot for finding and bisecting this problem.  I recently merged
> some patches from Rajat that partially revert 2debd9289997.  Can you try
> out my pci/pciehp branch and see whether it is enough to fix the problem
> for you?
> 
> Here's the branch:
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/pciehp
> 
> and the specific change Rajat made is:
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/pciehp&id=b1811d2455f32754cc3d8725bf2e961c
> 5eda2a72
> 
> Let me know if that isn't enough to fix the problem you're seeing, and we
> can work on it some more.

 I tested the kernel checkouted from remotes/origin/pci/pciehp.
 The original problem I reported was fixed.
 However the sequence of hot-plug operation got changed.
 The slot power becomes ON the moment when I insert PCIe card on the slot.
 This behavior is unacceptable to me.

 (before)
   - hot-add
     1. insert PCIe card
     2. echo 1 > power
   - hot-remove
     1. echo 0 > power
     2. eject PCIe card

 (after)
   - hot-add
    1. insert PCIe card (and automatically power-on)

   - hot-remove
    1. echo 0 > power
    2. eject PCIe card
   

 Best regards,
 Taku Izumi
