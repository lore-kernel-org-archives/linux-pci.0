Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PCI: brcmstb: Add Broadcom Settopbox PCIe support
Date: Wed, 11 Oct 2017 18:34:20 -0400
Message-Id: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
 Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>,
 Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This patch series adds support for the Broadcom Settopbox PCIe host
controller.  It is targeted to Broadcom Settopbox chips running on ARM,
ARM64, and MIPS platforms.  As the HW of the controller is intimately
tied to the memory subsystem, there are some patches required that are
not typical of a PCIe host controller driver.

pci-brcmstb.c -- is the core functionality of the RC driver.
pci-brcmstb-msi.c -- provides the driver for the PCIe's built-in
	MSI controller.
pci-brcmstb-dma.c -- provides the non-standard mapping between
	system memory and the PCIe address space.
drivers/soc/bcm/brcmstb/memory.c -- provides a single call to inform
	the PCIe controller about the size of populated memory in
	the memory controllers.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
