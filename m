Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37C4F68AD;
	Wed, 14 Oct 2026 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975576; cv=none; b=JDQRwr9N+NpXkHY6DjX5b/0rO8DddODxU88SKGMXfaonwnQTyheFmYhQNa+x4pWs1wXyI7UqujjrTizniht8z8VboqjCkUW4kdlFDf6aYMtK5xlBk5onEPVMN8BBBfHuY8k0JQ8PumYrPBXjKoA9L391352iPaO7qhzMi+JH5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975576; c=relaxed/simple;
	bh=KSF9k092edLku1kkCDS+2NRkgH9zctS3hcszlXKZ9xE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=s83kFcLZQuQA3PNSp+Pr4vcNHWmfbhqGh9tJkAZjS1OaV1oLeL/LH5FqvaVm5lh1UUaQmQGHvy2/TBVqngU9QpS675saYU9jaEjZi9gTLVy7eJAsgNl0AO++l8QDHkpoi5XqC69fQ0NKrARP/5vEnpyzZk/XhQL+CGqImTbfH78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44771F000FF;
	Wed, 14 Oct 2026 10:59:27 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Semih Baskan <strst.gs@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
 rjui@broadcom.com, sbranden@broadcom.com, 
 bcm-kernel-feedback-list@broadcom.com, rafal@milecki.pl, zajec5@gmail.com, 
 florian.fainelli@broadcom.com, arnd@arndb.de, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 rosenp@gmail.com, rani.hod@gmail.com
In-Reply-To: <20261012181637.GA1313446@bhelgaas>
References: <20261012181637.GA1313446@bhelgaas>
Date: Wed, 14 Oct 2026 16:29:18 +0530
Message-Id: <179197555828.38040.6359970121400952902.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7862;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=KSF9k092edLku1kkCDS+2NRkgH9zctS3hcszlXKZ9xE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz2CJqgbbMoVYwQbKmkJK+1j/ufZW5b9A9T9cm
 CzX3TZtwIaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas9giQAKCRBVnxHm/pHO
 9UfPB/45UVgsiHlnB55ICLCA7TTM9QYivpnXhXRhF9kWusLH2XPR8f4qgdXTbB7bRFfROoAiPaq
 Gaqz1sNnSFpgKo9AJeu2gCpL9N0Dw2FSuTitSlJW/RYb+57rcZYDCdlZrzgBHKTzK+q/hGsVA5e
 f339kqyrb+9BX8xdwKXw2QirsqVQvi1ScOrK1IBYIRBr5/UzV9HRXhEybQ9nLzlviM5oETEMJ0J
 3/4PoICpm+LT/CF4zXARu4wTxtx9dHxfoyWx6GbMGoazfbiJKg8htO1Ck4Sv0n5ZKvxrOFYL+5k
 73M2Mm5+r+2jOaTWEVQWn/DCOLgmrt/3SnAdkAGN3IrJK8BJ
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-12 13:16 -0500, Bjorn Helgaas wrote:
> [cc->to: Mani]
> 
> On Sat, Sep 12, 2026 at 07:36:26AM +0300, Semih Baskan wrote:
> > The BCMA driver takes its register base and, since commit 552aa843e4c5
> > ("PCI: iproc: Use the EROM outbound window on BCMA"), its outbound
> > window from what bcma read out of the enumeration ROM. It still
> > allocates its host bridge with devm_pci_alloc_host_bridge(), which since
> > commit 669cbc708122 ("PCI: Move DT resource setup into
> > devm_pci_alloc_host_bridge()") parses ranges, dma-ranges and bus-range
> > from the device's OF node and requests the windows it finds. None of
> > that reaches the hardware here: need_ob_cfg is only ever set by the
> > platform driver, so iproc_pcie_setup() never maps the parsed windows,
> > and the EROM commit above had to throw them away again to keep them
> > from colliding with its own window.
> > 
> > Allocate the bridge with pci_alloc_host_bridge() instead, so nothing
> > from the devicetree is requested or handed to the PCI core, and free it
> > on the error paths and in remove(). The driver now sets
> > bridge->dev.parent itself, as devm_pci_alloc_host_bridge() did, since
> > the wifi nodes under pcie_bridge0 in bcm4709-netgear-r8000.dts are
> > resolved through the root bus. The window request
> > moves from devm to request_resource() and release_resource() because
> > the resource lives inside the bridge allocation and has to be released
> > before the bridge is freed.
> > 
> > The ranges property is still read, but only to compare. bcm-ns.dtsi
> > describes the same window for the platform driver, and on core revision
> > 0x01 it points at an address the hardware does not decode. The warning
> > from the EROM commit stays for that reason: a wrong dts is visible on
> > BCMA boots, where nothing else would show it. Without bus-range the
> > root bus also logs "No busn resource found for root bus, will use
> > [bus 00-ff]" again, which changes nothing else.
> > 
> > With PCIE_IPROC_PLATFORM and PCIE_IPROC_BCMA both enabled, the platform
> > driver binds the same nodes first and claims the devicetree window. On
> > core revision 0x07 that is the EROM window, so this driver's request
> > still fails and the probe backs out as before. On revision 0x01 the
> > devicetree window is elsewhere, so this driver now probes as well, next
> > to a platform driver instance whose window the hardware does not decode.
> > That instance does not work either; the only difference is that the
> > second probe is no longer stopped by the collision.
> > 
> > Tested on an ASUS RT-N18U (BCM47081, core revision 0x01): the warning
> > lines are identical to the applied version, /proc/iomem and the
> > enumerated devices are unchanged.
> 
> What do you think about this, Mani?
> 
> I still don't quite understand the issue with the DT and discovering
> this via both platform and bcma bus drivers, but we should make
> progress.
> 

Sorry for the delay. Vacation + LPC kept me off for some time...

I read through the whole thread, and compared the driver + devicetree. Let me
try to explain what I understood on this issue.

Before commit 767012397976, every Northstar SoC relied on the
drivers/pci/controller/pcie-iproc-bcma.c driver to initialize the PCIe
controllers present in the SoC. This driver only relied on the bcma bus driver
for probing and getting the Host bridge resources such as MEM range, register
base address etc... and ignored devicetree. So the devm_pci_alloc_host_bridge()
call was only allocating the host bridge struct and devm_of_pci_bridge_init()
ended up being a NOP.

But with the advent of the commit 767012397976, the PCIe nodes present in the
bcm-ns.dtsi got compatibles and resource properties. Unfortunately, the values
provided in the resource properties (ranges specifically), only matched the
BCM47094 SoC. What the author overlooked was, they added these properties to the
common bcm-ns.dtsi which was included by several other SoCs as well. Typically,
the resources are only added to the common dtsi when they are common to all SoCs
inheriting the common dtsi. Otherwise, they get added to the specific SoC dtsi.
So this started all the issues as the added ranges properties were only valid
for BCM47094 SoC and not on other SoCs using bcm-ns.dtsi. I believe the author
was not aware of this incompatibility.

But then there was one more issue that the author of commit 767012397976
overlooked. When the compatible got added to the PCIe nodes, they got matched
with the pcie-iproc-platform driver and that driver started driving the PCIe
controller instead of the existing pcie-iproc-bcma driver. By probe ordering, I
think the pcie-iproc-platform driver got probed first and it made use of the
devicetree resources like the ranges property. Since the ranges value matched
the BCM47094 SoC, the pcie-iproc-platform probed fine and the controllers were
initialized properly.

But here is the catch, the author must've failed to notice the issue coming from
pcie-iproc-bcma driver when it tried probing later. When the pcie-iproc-bcma
driver probed, devm_of_pci_bridge_init() inside devm_pci_alloc_host_bridge()
would've tried parsing the ranges property again and should've failed with
-EBUSY as the memory was already mapped by the pcie-iproc-platform driver.
Either the author didn't notice this or the pcie-iproc-bcma driver could've been
disabled on their setup.

Now, when the same devicetree was used on other Northstar SoCs like BCM47081,
BCM4709, the ranges value were invalid and the pcie-iproc-platform driver's
probe got failed. Then the pcie-iproc-bcma driver also got probed later (it
should be noted that these two are separate, so platform driver probe doesn't
affect this bus driver probe), it also ended up parsing the wrong ranges from
the devicetree. And this is what fixed by the patch from Semih [1] which forced
the driver to use the ranges from EROM only and ignore devicetree. The reason
why EROM parsing was added to the brcm driver instead of the platform driver
was, only the brcm driver got access to the EROM region as it gets populated by
the brcm bus code.

Even though [1] allowed the PCIe controllers to be working again, it didn't
prevent the platform driver from probing first and claiming the invalid
resource. For fixing this specific issue, I think we need two fixes:

1. Override the ranges property in the SoC dtsi with correct values.
2. Prevent the pcie-iproc-platform driver from probing for the Northstar SoCs
and just rely on pcie-iproc-bcma driver to initialize the PCIe controllers. This
can be achieved by the below patch:

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index 4c9a0c4bb923..d2237a56dd79 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -45,6 +45,9 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
        struct pci_host_bridge *bridge;
        int ret;
 
+       if (of_device_is_compatible(np->parent, "brcm,bus-axi"))
+               return -EINVAL;
+
        bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
        if (!bridge)
                return -ENOMEM;

IMO, we need both fixes because, devicetree has to describe the hardware
properly and we should not have two drivers claiming the same resource.

[1] https://lore.kernel.org/linux-pci/20260807162149.7CC9E1F000E9@smtp.kernel.org

> I *think* that if we squash this patch into 552aa843e4c5 ("PCI: iproc:
> Use the EROM outbound window on BCMA") and use
> devm_add_action_or_reset(), it will simplify down to this, which is
> less intrusive and would need less explanation:
> 

This LGTM!

- Mani

