Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44920 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbbCJXOq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 19:14:46 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: bhelgaas@google.com, mingo@redhat.com, tglx@linutronix.de,
	hpa@zytor.com, pure.logic@nexus-software.ie, jgross@suse.com,
	luto@amacapital.net, andy.shevchenko@gmail.com,
	thomas.petazzoni@free-electrons.com, JBeulich@suse.com, bp@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [RFC v1 0/2] x86: kconfig: simplify APIC entries
Date: Tue, 10 Mar 2015 16:14:33 -0700
Message-Id: <1426029275-9594-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

There's quite a bit of Kconfig entries related to X86_LOCAL_APIC
and X86_IO_APIC, and all for 32-bit purposes. Since 32-bit isn't in
a magical state of flux we now *should* know when to enable or disable
APIC stuff for these systems. Through history we've observed for
instance PCI_MSI requires these under specific scenarios, just enable
it for those learned scenarios and expect future requirements to also
be explicit about the requirements on 32-bit. This lets us remove
clutter (3 Kconfig entries) from x86 Kconfig simply for 32-bit build
purposes.

Luis R. Rodriguez (2):
  x86: kconfig: simplify enabling [IO]APIC for PCI_MSI
  x86: kconfig: remove UP [IO]APIC options

 Documentation/PCI/MSI-HOWTO.txt |  5 +----
 arch/x86/Kconfig                | 33 ++-------------------------------
 drivers/pci/Kconfig             |  2 ++
 3 files changed, 5 insertions(+), 35 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

