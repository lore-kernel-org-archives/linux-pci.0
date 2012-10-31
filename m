Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41454 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293Ab2JaAwY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 20:52:24 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id BE9693EE0BC
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 09:52:22 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id A312045DE51
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 09:52:22 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8E76345DE4E
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 09:52:22 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 815A51DB803F
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 09:52:22 +0900 (JST)
Received: from m0000.s.css.fujitsu.com (m0000.s.css.fujitsu.com [10.23.4.183])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3B8C51DB8037
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 09:52:22 +0900 (JST)
Date: Wed, 31 Oct 2012 09:51:48 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jiang Liu <jiang.liu@huawei.com>, wangyijing@huawei.com
Cc: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI/portdrv: Fix regression introduced by commit 2dcfaf85
Message-Id: <20121031095148.75dbb6e8.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


PCI/portdrv: Fix regression introduced by commit 2dcfaf85

After commit 2dcfaf85, hotplug slots for port devices 
w/o slot implementation come to be created.  
This patch fixes this problem.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 drivers/pci/pcie/portdrv_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: pci/drivers/pci/pcie/portdrv_core.c
===================================================================
--- pci.orig/drivers/pci/pcie/portdrv_core.c
+++ pci/drivers/pci/pcie/portdrv_core.c
@@ -272,7 +272,8 @@ static int get_port_device_capability(st
 	}
 
 	/* Hot-Plug Capable */
-	if (cap_mask & PCIE_PORT_SERVICE_HP) {
+	if ((cap_mask & PCIE_PORT_SERVICE_HP) &&
+	    dev->pcie_flags_reg & PCI_EXP_FLAGS_SLOT) {
 		pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &reg32);
 		if (reg32 & PCI_EXP_SLTCAP_HPC) {
 			services |= PCIE_PORT_SERVICE_HP;

