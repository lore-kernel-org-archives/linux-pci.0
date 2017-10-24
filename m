Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Florian Fainelli <f.fainelli@gmail.com>
Subject: Subject: PCI: brcmstb: Add Broadcom Settopbox PCIe support (V2)
Date: Tue, 24 Oct 2017 14:15:41 -0400
Message-Id: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-mips@linux-mips.org, linux-pci@vger.kernel.org,
 Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
 bcm-kernel-feedback-list@broadcom.com, Gregory Fong <gregory.0xf0@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds support for the Broadcom Settopbox PCIe host
controller.  It is targeted to Broadcom Settopbox chips running on
ARM, ARM64, and MIPS platforms.

Changes from V1:

* Patch brcmstb-add-memory-API:
  - fix DT_PROP_DATA_TO_U32 macro.
  - dropped one EXPORT_SYMBOL, changed the other to GPL.
* Patch DT-docs-for-Brcmstb-PCIe:
  - change 'brcm,gen' prop to standard 'max-link-speed'. 
  - rewrite bindings commit to omit standard prop defs.
  - change props "supplies", "supply-names" to "xyz-supply"
* Patch removed: export-symbol-arch_setup_dma_ops [4/9] 
* Patch brcmstb-add-dma-ranges:
  - use get_dma_ops(); also use a const dma_map_ops structure.
  - rewrite map_sg(), unmap_sg(), other calls like syng_sg_*()
  - omit brcm_mapping_error(), but added code in brcm_dma_supported()
  - put all of the notifier code in one compilation unit.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
