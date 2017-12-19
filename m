Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 19/26] xen: deprecate pci_get_bus_and_slot()
Date: Tue, 19 Dec 2017 00:37:55 -0500
Message-Id: <1513661883-28662-20-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Juergen Gross <jgross@suse.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 drivers/pci/xen-pcifront.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 8fc2e95..94b25b5 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -595,6 +595,7 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 	struct pci_driver *pdrv;
 	int bus = pdev->sh_info->aer_op.bus;
 	int devfn = pdev->sh_info->aer_op.devfn;
+	int domain = pdev->sh_info->aer_op.domain;
 	struct pci_dev *pcidev;
 	int flag = 0;
 
@@ -603,7 +604,7 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 		cmd, bus, devfn);
 	result = PCI_ERS_RESULT_NONE;
 
-	pcidev = pci_get_bus_and_slot(bus, devfn);
+	pcidev = pci_get_domain_bus_and_slot(domain, bus, devfn);
 	if (!pcidev || !pcidev->driver) {
 		dev_err(&pdev->xdev->dev, "device or AER driver is NULL\n");
 		pci_dev_put(pcidev);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
