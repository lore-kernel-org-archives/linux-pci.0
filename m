Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V2 07/29] ibft: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:02 -0500
Message-Id: <1511390964-9979-8-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>, Konrad Rzeszutek Wilk <konrad@kernel.org>,
 Peter Jones <pjones@redhat.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

We don't search for the device in other domains than zero. This is because
on x86 platforms the BIOS executes only devices which are in domain 0.
Furthermore, the iBFT spec doesn't have a domain id field.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/firmware/iscsi_ibft.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 14042a6..6bc8e66 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -719,8 +719,9 @@ static int __init ibft_create_kobject(struct acpi_table_ibft *header,
 		* executes only devices which are in domain 0. Furthermore, the
 		* iBFT spec doesn't have a domain id field :-(
 		*/
-		pci_dev = pci_get_bus_and_slot((nic->pci_bdf & 0xff00) >> 8,
-					       (nic->pci_bdf & 0xff));
+		pci_dev = pci_get_domain_bus_and_slot(0,
+						(nic->pci_bdf & 0xff00) >> 8,
+						(nic->pci_bdf & 0xff));
 		if (pci_dev) {
 			rc = sysfs_create_link(&boot_kobj->kobj,
 					       &pci_dev->dev.kobj, "device");
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
