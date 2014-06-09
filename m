Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51340 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755611AbaFIIUA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Jun 2014 04:20:00 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch V4 18/42] ce4100, irq: do not set legacy_pic to null_legacy_pic
Date: Mon,  9 Jun 2014 16:19:47 +0800
Message-Id: <1402302011-23642-19-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1402302011-23642-1-git-send-email-jiang.liu@linux.intel.com>
References: <1402302011-23642-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intel CE4100 platforms has i8259 legacy interrupt controllers, so don't
set legacy_pic to null_legacy_pic in late booting stage because we need
legacy_pic to mask i8259 pins when enabling IOAPIC pins for safety.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/platform/ce4100/ce4100.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index 0a54a586559b..701fd5843c87 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -138,8 +138,6 @@ static void __init sdv_arch_setup(void)
 static void sdv_pci_init(void)
 {
 	x86_of_pci_init();
-	/* We can't set this earlier, because we need to calibrate the timer */
-	legacy_pic = &null_legacy_pic;
 }
 
 /*
-- 
1.7.10.4

