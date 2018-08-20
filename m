Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeHUCYA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Aug 2018 22:24:00 -0400
Date: Mon, 20 Aug 2018 18:06:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
        mmyangfl@gmail.com
Subject: Enumeration issue with QCA9005 AR9462
Message-ID: <20180820230624.GB154536@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mmyangfl@gmail.com reported a problem [1]: on v4.17, a QCA9005 AR9462
wifi device was present at boot, but disappeared after suspend/resume.

He/she also tested a recent kernel (5c60a7389d79, from Thu Aug 16),
where the suspend/resume problem doesn't seem to happen, but the wifi
device isn't enumerated correctly at boot-time.

  pci 0000:00:1c.3: PCIe Root Port to [bus 03-07]
  pci 0000:03:00.0: [1ae9:0101] PCIe Switch Upstream Port to [bus 04-07]
  pci 0000:04:00.0: [1ae9:0200] PCIe Switch Downstream Port to [bus 05]
  pci 0000:05:00.0: [168c:0034] QCA9005 AR9462 wifi NIC

These messages are extracted from [2]:

[    0.928714] pciehp 0000:04:00.0:pcie204: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
[    0.928752] pciehp 0000:04:00.0:pcie204: Slot(0-1): Card not present
[    0.928811] pciehp 0000:04:00.0:pcie204: Slot(0-1): Link Up
[    0.928815] pciehp 0000:04:00.0:pcie204: Slot(0-1): No adapter

After manually executing:

  echo 1 > /sys/devices/pci0000\:00/0000\:00\:1c.3/0000\:03\:00.0/0000\:04\:00.0/rescan

the wifi NIC is discovered correctly:

[  114.649896] pci 0000:05:00.0: [168c:0034] type 00 class 0x028000
[  114.649977] pci 0000:05:00.0: reg 0x10: [mem 0xf7400000-0xf747ffff 64bit]
[  114.650090] pci 0000:05:00.0: reg 0x30: [mem 0xf7480000-0xf748ffff pref]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=200839
[2] https://bugzilla.kernel.org/attachment.cgi?id=277923
