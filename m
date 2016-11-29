Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v2] PCI: Add information about describing PCI in ACPI
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Date: Tue, 29 Nov 2016 15:39:48 -0600
Message-ID: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>,
 linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
 linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Lv Zheng <lv.zheng@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Here's another stab at this writeup.  I'd appreciate any comments!

Changes from v1 to v2:
  - Consumer/Producer is defined for Extended Address Space descriptors;
    should be ignored for QWord/DWord/Word Address Space descriptors
  - New arches may use Extended Address Space descriptors in PNP0A03 for
    bridge registers, including ECAM (if the arch adds support for this)
  - Add more details about MCFG and _CBA (Lv's suggestion)
  - Incorporate Rafael's suggestions

---

Bjorn Helgaas (1):
      PCI: Add information about describing PCI in ACPI


 Documentation/PCI/00-INDEX      |    2 
 Documentation/PCI/acpi-info.txt |  180 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 Documentation/PCI/acpi-info.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
