Return-Path: <SRS0=Vm9w=K6=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=Vm9w=K6=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Sinan Kaya <okaya@kernel.org>,
	Oza Pawandeep <poza@codeaurora.org>,
	Dongdong Liu <liudongdong3@huawei.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/2] Documentation: Document pci=nodpc
Date: Wed, 15 Aug 2018 15:26:40 -0600
Message-Id: <1534368400-2807-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Document disabling downstream port containment through pci parameter

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e372208..1a2fd78 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3041,6 +3041,9 @@
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
+		nodpc		[PCIE] If the PCIE_DPC kernel config parameter is
+				enabled, this kernel boot option can be used to
+				disable the use of PCIE downstream port containment
 		nodomains	[PCI] Disable support for multiple PCI
 				root domains (aka PCI segments, in ACPI-speak).
 		nommconf	[X86] Disable use of MMCONFIG for PCI
-- 
1.8.3.1
