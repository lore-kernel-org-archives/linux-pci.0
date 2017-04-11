Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/2] arm64: acpi/pci: allow the firmware BAR configuration to
 be preserved
Date: Tue, 11 Apr 2017 17:33:11 +0100
Message-Id: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, catalin.marinas@arm.com,
 will.deacon@arm.com, leif.lindholm@linaro.org, okaya@codeaurora.org,
 tn@semihalf.com, bhelgaas@google.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This is a followup to the discussion regarding whether ACPI/arm64 systems
should preserve the PCI configuration performed by the firmware, or always
reconfigure it from scratch.

This series proposes to put it under the control of the firmware, by invoking
the _DSM method, and preserving the firmware configuration only when it
returns 0.

Patch #1 is a preparatory bugfix that solves the issue that I/O bridge
windows starting at 0x0 are dismissed when looking for parent resources.

Patch #2 adds the logic to invoke the _DSM and claim the existing
configuration rather than reallocate it from scratch if it returns '0'

Ard Biesheuvel (2):
  drivers: pci: do not disregard parent resources starting at 0x0
  arm64: acpi/pci: invoke _DSM whether to preserve firmware PCI setup

 arch/arm64/kernel/pci.c  | 20 ++++++++++++++++++--
 drivers/pci/pci.c        |  2 +-
 include/linux/pci-acpi.h |  7 ++++---
 3 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.9.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
