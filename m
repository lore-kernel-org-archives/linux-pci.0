Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH 11/16] sparc/PCI: Factor 'pcibios_setup()' out of sparc
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
Date: Mon, 25 Jun 2012 21:32:12 -0600
Message-ID: <20120626033212.16434.95081.stgit@amt.stowe>
In-Reply-To: <20120626033045.16434.17412.stgit@amt.stowe>
References: <20120626033045.16434.17412.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI core provides a generic (__weak) 'pcibios_setup()' routine
that can be used by all architectures as a default.  Drop sparc's
architecture specific version in favor of that as it does not need to be
over-ridden.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---

 arch/sparc/kernel/leon_pci.c |    8 --------
 arch/sparc/kernel/pci.c      |    5 -----
 arch/sparc/kernel/pcic.c     |    8 --------
 3 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index 19f5605..21dcda7 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -91,14 +91,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *pbus)
 	}
 }
 
-/*
- * Other archs parse arguments here.
- */
-char * __devinit pcibios_setup(char *str)
-{
-	return str;
-}
-
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				resource_size_t size, resource_size_t align)
 {
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index fdaf218..3e7fba0 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -747,11 +747,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-char * __devinit pcibios_setup(char *str)
-{
-	return str;
-}
-
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
 
 /* If the user uses a host-bridge as the PCI device, he may use
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index ded3f60..97eb529 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -767,14 +767,6 @@ static void watchdog_reset() {
 }
 #endif
 
-/*
- * Other archs parse arguments here.
- */
-char * __devinit pcibios_setup(char *str)
-{
-	return str;
-}
-
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				resource_size_t size, resource_size_t align)
 {

