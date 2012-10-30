Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:54477 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab2J3GV1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 02:21:27 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C6A903EE0AE
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:21:25 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id AD28A45DE62
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:21:25 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F65B45DE5F
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:21:25 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7A6FE1DB8041
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:21:25 +0900 (JST)
Received: from m003.s.css.fujitsu.com (m003.s.css.fujitsu.com [10.23.4.33])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 279F31DB8040
	for <linux-pci@vger.kernel.org>; Tue, 30 Oct 2012 15:21:25 +0900 (JST)
Date: Tue, 30 Oct 2012 15:21:14 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Yinghai Lu <yinghai@kernel.org>
Subject: [RFC PATCH 0/5] acpi,pci: disentangle ACPI-related code and
 PCI-related code at hostbridge
Message-Id: <20121030062124.BE34D2E0805@m003.s.css.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

addition/removal code
Message-Id: <20121030152114.f342e669.izumi.taku@jp.fujitsu.com>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.10.14; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,
 
    This patchset is to disentangle ACPI-related code and PCI-related code 
    at hostbridge addition/removal code.    
    This is based on the comment Bjorn suggested at
        http://marc.info/?l=linux-pci&m=134825820111705&w=2

  * [PATCH 1/5] ACPI: Pass segment/bus to _PRT add/del so they don't depend on pci_bus  
  * [PATCH 2/5] PCI,ACPI: Add _PRT interrupt routing info before enumerating devices
  * [PATCH 3/5] PCI,ACPI: Remove _PRT info when removing a host bridge
  * [PATCH 4/5] PCI: Change the signature of pci_ext_cfg_avail function
  * [PATCH 5/5] PCI,ACPI: Requesting _OSC control before scanning pci tree in acpi_pci_root_add()
  
-- 
Best regards,
Taku Izumi <izumi.taku@jp.fujitsu.com>

