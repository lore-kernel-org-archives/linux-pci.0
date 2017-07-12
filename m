Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbdGLWXS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jul 2017 18:23:18 -0400
Date: Wed, 12 Jul 2017 17:23:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org, matthieu.bouron@gmail.com,
        Victor Gu <xigu@marvell.com>, Evan Wang <xswang@marvell.com>
Subject: [bugzilla-daemon@bugzilla.kernel.org: [Bug 196339] New:
 pci-aardvark: kernel panics on espressobin (and upstreaming fixes from the
 marvell tree)]
Message-ID: <20170712222313.GK14614@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----

Date: Wed, 12 Jul 2017 08:55:11 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: bugzilla.pci@gmail.com
Subject: [Bug 196339] New: pci-aardvark: kernel panics on espressobin (and upstreaming fixes from the
	marvell tree)

https://bugzilla.kernel.org/show_bug.cgi?id=196339

            Bug ID: 196339
           Summary: pci-aardvark: kernel panics on espressobin (and
                    upstreaming fixes from the marvell tree)
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.12
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: matthieu.bouron@gmail.com
        Regression: No

Booting the espressobin board with an Intel 7260 mini pcie wifi card plugged
leads to the following kernel panic: http://sprunge.us/haED

It happens with a bare 4.12 kernel and with the one provided by Arch Linux [1]
which a 4.12 with the following patches (taken from the linux-arm ml) applied:
  * ARM64: dts: marvell: armada37xx: Fix timer interrupt specifiers
  * ARM64: dts: marvell: armada37xx: Fix GIC maintenance interrupt
  * ARM64: dts: marvell: armada37xx: Enable memory-mapped GIC CPU interface
  * ARM64: dts: marvell: armada37xx: Wire PMUv3
  * ARM64: dts: marvell: armada37xx: Enable USB2 on espressobin
  * arm64: dts: marvell: Enable second SDHCI controller in Armada 37xx
  * arm64: dts: marvell: Add microsd card definition for the ESPRESSObin
  * arm64: marvell: armada37xx: Add eth0 alias

I found out that the marvell tree [2] have some fixes for the Aardvark PCI
driver:
  *
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/d3f1b58f7759f376cff71b0f87bd838035dee995
  *
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/ca899e6ee055a938ffab20d820dbfbea531e5ee7
  *
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/7ce8f8c52db804157a7bc6689cd0b7db154b3204
  *
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/e2c75634d9e930b66bdb29b7a42f56f357e329f5

Applying those patches to a 4.12 kernel (plus the patches that uses Arch Linux)
fixes the kernel panic and the wifi card work properly. The kernel
configuration I used is:
  * make defconfig
  * enable cfg80211 extensions compatibility
  * enable network DSA
  * enable marvell DSA specific drivers
  * enable iwlwifi

Let me know if you need more information.

[1]
https://github.com/archlinuxarm/PKGBUILDs/tree/master/core/linux-espressobin
[2]
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commits/linux-4.4.52-armada-17.06

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----
