Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/2] x86/PCI: Use host bridge _CRS info on systems with >32
 bit addressing
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	dayer3@gmail.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
Date: Tue, 16 Jun 2015 11:55:50 -0500
Message-ID: <20150616165550.9306.58789.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150616165033.9306.78046.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150616165033.9306.78046.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We enable _CRS on all systems from 2008 and later.  On older systems, we
ignore _CRS and assume the whole physical address space (excluding RAM and
other devices) is available for PCI devices, but on systems that support
physical address spaces larger than 4GB, it's doubtful that the area above
4GB is really available for PCI.

After d56dbf5bab8c ("PCI: Allocate 64-bit BARs above 4G when possible"), we
try to use that space above 4GB *first*, so we're more likely to put a
device there.

Several people have reported sound problems related to putting a device
above 4GB.  This could happen with any device; I assume it's more likely
for sound devices because the BIOS is more likely to leave them unassigned.

Keep _CRS enabled even on pre-2008 systems if they support physical address
space larger than 4GB.

Fixes: d56dbf5bab8c ("PCI: Allocate 64-bit BARs above 4G when possible")
Reported-by: dayer <dayer3@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=99221
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=907092
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index d8e2258..2ae7ce2 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -132,8 +132,10 @@ void __init pci_acpi_crs_quirks(void)
 {
 	int year;
 
-	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year < 2008)
-		pci_use_crs = false;
+	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year < 2008) {
+		if (iomem_resource.end <= 0xffffffff)
+			pci_use_crs = false;
+	}
 
 	dmi_check_system(pci_crs_quirks);
 

