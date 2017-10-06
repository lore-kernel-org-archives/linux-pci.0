Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: add support for firmware initialized DesignWare
 RCs
Date: Fri,  6 Oct 2017 17:39:17 +0100
Message-Id: <20171006163919.14898-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

UEFI based systems incorporating a Synopsys DesignWare PCIe controller
in RC mode will typically configure it before entering the OS. If this
configuration is fully static and ECAM compliant, there is no need to
expose particulars of the device to the OS, and we can simply describe
it as "pci-host-ecam-generic".

However, the Synopsys IP may be synthesized in a way where a quirk is
needed for config space accesses to the first bus. It makes little sense
to instantiate yet another pcie-designware driver that contains all the
low level setup code, so instead, add some quirks handling to the generic
ECAM driver.

v4: - merge with pci-host-generic
    - add Rob's ack to the DT binding doc

v3: - use SoC specific compatible strings
    - drop MSI patch [for now], since it turns out we may not need it

v2: - use dev->fwnode directly
    - replace an instance of pr_err with dev_err, and clarify the error message
    - fix Kconfig/Makefile dependency errors reported by kbuild

Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>

Ard Biesheuvel (2):
  PCI: pci-host-generic: add support for Synopsys DesignWare RC in ECAM
    mode
  dt-bindings: designware: add binding for Designware PCIe in ECAM mode

 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt | 42 ++++++++++++++++++
 drivers/pci/host/pci-host-generic.c                            | 46 ++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
