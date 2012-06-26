Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1027 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758058Ab2FZDd0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jun 2012 23:33:26 -0400
From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH 13/16] unicore32/PCI: adjust section annotations for
	'pcibios_setup()'
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, rth@twiddle.net,
	ink@jurassic.park.msu.ru, mattst88@gmail.com,
	linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com,
	tony.luck@intel.com, fenghua.yu@intel.com, monstr@monstr.eu,
	ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com,
	jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
	paulus@samba.org, lethal@linux-sh.org, davem@davemloft.net,
	cmetcalf@tilera.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org, chris@zankel.net,
	linux-kernel@vger.kernel.org
Date: Mon, 25 Jun 2012 21:32:25 -0600
Message-ID: <20120626033225.16434.26282.stgit@amt.stowe>
In-Reply-To: <20120626033045.16434.17412.stgit@amt.stowe>
References: <20120626033045.16434.17412.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make pcibios_setup() consistently use the "__init" section annotation.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---

 arch/unicore32/kernel/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index 2fc2b1b..46cb6c9 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -296,7 +296,7 @@ static int __init pci_common_init(void)
 }
 subsys_initcall(pci_common_init);
 
-char * __devinit pcibios_setup(char *str)
+char * __init pcibios_setup(char *str)
 {
 	if (!strcmp(str, "debug")) {
 		debug_pci = 1;

