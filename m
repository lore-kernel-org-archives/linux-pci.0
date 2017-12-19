Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 13/26] bnx2x: deprecate pci_get_bus_and_slot()
Date: Tue, 19 Dec 2017 00:37:49 -0500
Message-Id: <1513661883-28662-14-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>, Ariel Elior <ariel.elior@cavium.com>,
 "open list:BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>,
 "supporter:BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER"
 <everest-linux-l2@cavium.com>, linux-arm-kernel@lists.infradead.org
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

Introduce bnx2x_vf_domain() function to extract the domain information
and save it to VF specific data structure.

Use the saved domain value while calling pci_get_domain_bus_and_slot().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c | 10 +++++++++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index 3591077..ffa7959 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -812,7 +812,7 @@ static u8 bnx2x_vf_is_pcie_pending(struct bnx2x *bp, u8 abs_vfid)
 	if (!vf)
 		return false;
 
-	dev = pci_get_bus_and_slot(vf->bus, vf->devfn);
+	dev = pci_get_domain_bus_and_slot(vf->domain, vf->bus, vf->devfn);
 	if (dev)
 		return bnx2x_is_pcie_pending(dev);
 	return false;
@@ -1041,6 +1041,13 @@ void bnx2x_iov_init_dmae(struct bnx2x *bp)
 		REG_WR(bp, DMAE_REG_BACKWARD_COMP_EN, 0);
 }
 
+static int bnx2x_vf_domain(struct bnx2x *bp, int vfid)
+{
+	struct pci_dev *dev = bp->pdev;
+
+	return pci_domain_nr(dev->bus);
+}
+
 static int bnx2x_vf_bus(struct bnx2x *bp, int vfid)
 {
 	struct pci_dev *dev = bp->pdev;
@@ -1606,6 +1613,7 @@ int bnx2x_iov_nic_init(struct bnx2x *bp)
 		struct bnx2x_virtf *vf = BP_VF(bp, vfid);
 
 		/* fill in the BDF and bars */
+		vf->domain = bnx2x_vf_domain(bp, vfid);
 		vf->bus = bnx2x_vf_bus(bp, vfid);
 		vf->devfn = bnx2x_vf_devfn(bp, vfid);
 		bnx2x_vf_set_bars(bp, vf);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h
index 53466f6..eb814c6 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h
@@ -182,6 +182,7 @@ struct bnx2x_virtf {
 	u32 error;	/* 0 means all's-well */
 
 	/* BDF */
+	unsigned int domain;
 	unsigned int bus;
 	unsigned int devfn;
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
