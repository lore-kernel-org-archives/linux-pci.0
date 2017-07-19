Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] powerpc: simplify and fix VGA default device behaviour
Date: Wed, 19 Jul 2017 12:15:13 +1000
Message-Id: <20170719021516.24718-2-dja@axtens.net>
In-Reply-To: <20170719021516.24718-1-dja@axtens.net>
References: <20170719021516.24718-1-dja@axtens.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: gabriele.paoloni@huawei.com, airlied@linux.ie, benh@kernel.crashing.org,
 Brian King <brking@linux.vnet.ibm.com>, will.deacon@arm.com,
 z.liuxinliang@hisilicon.com, bhelgaas@google.com, alex.williamson@redhat.com,
 catalin.marinas@arm.com, zourongrong@gmail.com, daniel.vetter@intel.com,
 Daniel Axtens <dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Some powerpc devices provide a PCI display that isn't picked up by
the VGA arbiter, presumably because it doesn't support the PCI
legacy VGA ranges.

Commit c2e1d84523ad ("powerpc: Set default VGA device") introduced
an arch quirk to mark these devices as default to fix X autoconfig.

The commit message stated that the patch:

    Ensures a default VGA is always set if a graphics adapter is present,
    even if firmware did not initialize it. If more than one graphics
    adapter is present, ensure the one initialized by firmware is set
    as the default VGA device.

The patch used the following test to decide whether or not to mark
a device as default:

  pci_read_config_word(pdev, PCI_COMMAND, &cmd);
  if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
          vga_set_default_device(pdev);

This doesn't seem like it works quite as intended. Because of the
logical OR, the default device will be set in 2 cases:

 1) if there is no default device
OR
 2) if this device has normal memory/IO decoding turned on

This will work as intended if there is only one device, but if
there are multiple devices, we may override the device the VGA
arbiter picked.

Instead, set a device as default if there is no default device AND
this device decodes.

This will not change behaviour on single-headed systems.

Cc: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Tested in TCG (the card provided by qemu doesn't automatically
register with vgaarb, so the relevant code path has been tested)
but I would appreciate any tests on real hardware.
---
 arch/powerpc/kernel/pci-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 341a7469cab8..c95fdda3a2dc 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1746,8 +1746,11 @@ static void fixup_vga(struct pci_dev *pdev)
 {
 	u16 cmd;
 
+	if (vga_default_device())
+		return;
+
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
+	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
 		vga_set_default_device(pdev);
 
 }
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
