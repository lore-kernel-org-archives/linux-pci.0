Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35320 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850Ab2DZKhY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2012 06:37:24 -0400
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id DA4FF3EE0BB
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:37:22 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C357245DE56
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:37:22 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 95FB245DE55
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:37:22 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 86AE71DB804D
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:37:22 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4021BE38004
	for <linux-pci@vger.kernel.org>; Thu, 26 Apr 2012 19:37:22 +0900 (JST)
Date: Thu, 26 Apr 2012 19:37:12 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: liuj97@gmail.com, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Keping Chen <chenkeping@huawei.com>, ddutile@redhat.com,
	greg.pearson@hp.com
Subject: [PATCH 0/6][RFC] pci, x86: change the way to add MMCFG region on
 x86
Message-Id: <20120426193712.11256973.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


 This patchset is based on the following Jiang Liu's patchset:
   http://marc.info/?l=linux-pci&m=133410334617298&w=2

 This changes the way to add MMCFG region on x86.
 MMCFG region information provided by ACPI MCFG table 
 or _CBA method will be added at acpi_pci_root_add()
 of pci_root driver.
 
 patch1-4 is exactly same as Liu's.

  *[PATCH 1/6] PCI, x86: split out pci_mmcfg_check_reserved() for code reuse
  *[PATCH 2/6] PCI, x86: split out pci_mmconfig_alloc() for code reuse
  *[PATCH 3/6] PCI, x86: use RCU list to protect mmconfig list
  *[PATCH 4/6] PCI, x86: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
  *[PATCH 5/6] PCI, x86: introduce pci_mmcongi_add() / pci_mmconfig_delete()
  *[PATCH 6/6] PCI, x86: change the way to add MMCFG region on x86
  
-
Best regards,
Taku Izumi

