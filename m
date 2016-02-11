Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 11 Feb 2016 17:17:00 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: Re: [PATCH V4 22/23] arm64, pci, acpi: Assign legacy IRQs once
 device is enable.
Message-ID: <20160211171700.GB25235@red-moon>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
 <1454606941-9523-23-git-send-email-tn@semihalf.com>
 <20160211115843.GA24136@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160211115843.GA24136@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 11, 2016 at 11:58:53AM +0000, Lorenzo Pieralisi wrote:
> On Thu, Feb 04, 2016 at 06:29:00PM +0100, Tomasz Nowicki wrote:
> > This is the last step before enabling generic ACPI PCI host controller
> > for ARM64. We need to take care of legacy IRQ mapping for non-MSI(X)
> > PCI devices. pcibios_enable_device() boot order is not sensitive to
> > ACPI device enumeration, so it is the best place to assign device's IRQs.
> 
> I guess you are referring to:
> 
> https://lists.linaro.org/pipermail/linaro-acpi/2015-October/005944.html
> 
> It is weird that the dependency can't be enforced, I will have a look
> into this, it would be nice to have DT and ACPI legacy IRQs mapping
> confined in pcibios_add_device() so that we can remove them in one go
> when Matthew's series is merged.

One option, that is not ideal but has the merit of setting the stage
for pcibios_enable_device() AND pcibios_add_device() removal, is to add
IRQ mapping (by adding the call) in a pcibios_alloc_irq() callback (if
Bjorn does not remove it from core code before we manage to add it,
I think he is only reverting the x86 version).

https://lkml.org/lkml/2016/2/9/648

That's called at device probe time, it should not change DT probing path
(unless we use the irq number before the device is probed, which I doubt)
and should allow the ACPI scan handlers to be installed so that the ACPI
IRQ mapping can be effectively carried out.

pcibios_alloc_irq() replaces pcibios_add_device().

When Matthew's patchset lands in mainline, pcibios_alloc_irq() will
be removed too (at least we have a place where all legacy IRQ mappings
are carried out and I can obliterate it easily).

Other option is to change ACPI core code, I see no other way.

Tested on KVM PCI host generic (that uses pci_fixup_irqs() so it does
not really count for DT).

Here (on top of your series), ready for flak.

Lorenzo

-- >8 --
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 0b53262..26ee291 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -45,28 +45,23 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
-	int ret;
-
 	if (pci_has_flag(PCI_PROBE_ONLY))
 		return 0;
 
-	ret = pci_enable_resources(dev, mask);
-	if (ret < 0)
-		return ret;
-
-#ifdef CONFIG_ACPI
-	if (!pci_dev_msi_enabled(dev))
-		return acpi_pci_irq_enable(dev);
-#endif
-	return 0;
+	return pci_enable_resources(dev, mask);
 }
 
 /*
- * Try to assign the IRQ number from DT when adding a new device
+ * Try to assign the IRQ number when probing a new device
  */
-int pcibios_add_device(struct pci_dev *dev)
+int pcibios_alloc_irq(struct pci_dev *dev)
 {
-	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+	if (acpi_disabled)
+		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+#ifdef CONFIG_ACPI
+	else
+		return acpi_pci_irq_enable(dev);
+#endif
 
 	return 0;
 }
