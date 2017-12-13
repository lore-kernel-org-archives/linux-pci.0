Return-Path: <SRS0=3ogL=DJ=linux.vnet.ibm.com=bryantly@kernel.org>
Return-Path: <SRS0=3ogL=DJ=linux.vnet.ibm.com=bryantly@kernel.org>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
        alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
        ruscur@russell.cc, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
        saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v1 1/7] platform/pseries: Update VF config space after EEH
Date: Wed, 13 Dec 2017 09:32:36 -0600
In-Reply-To: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171213153242.98015-2-bryantly@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

Add EEH platform operations for pseries to update VF
config space. With this change after EEH, the VF
will have updated config space for pseries platform.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 85 +++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 2295f117e2d3..1a9a6fa91151 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -708,6 +708,89 @@ static int pseries_eeh_write_config(struct pci_dn *pdn, int where, int size, u32
 	return rtas_write_config(pdn, where, size, val);
 }
 
+static int pseries_eeh_restore_vf_config(struct pci_dn *pdn)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	u32 devctl, cmd, cap2, aer_capctl;
+	int old_mps;
+
+	if (edev->pcie_cap) {
+		/* Restore MPS */
+		old_mps = (ffs(pdn->mps) - 8) << 5;
+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				     2, &devctl);
+		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
+		devctl |= old_mps;
+		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				      2, devctl);
+
+		/* Disable Completion Timeout */
+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP2,
+				     4, &cap2);
+		if (cap2 & 0x10) {
+			eeh_ops->read_config(pdn,
+					     edev->pcie_cap + PCI_EXP_DEVCTL2,
+					     4, &cap2);
+			cap2 |= 0x10;
+			eeh_ops->write_config(pdn,
+					      edev->pcie_cap + PCI_EXP_DEVCTL2,
+					      4, cap2);
+		}
+	}
+
+	/* Enable SERR and parity checking */
+	eeh_ops->read_config(pdn, PCI_COMMAND, 2, &cmd);
+	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
+	eeh_ops->write_config(pdn, PCI_COMMAND, 2, cmd);
+
+	/* Enable report various errors */
+	if (edev->pcie_cap) {
+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				     2, &devctl);
+		devctl &= ~PCI_EXP_DEVCTL_CERE;
+		devctl |= (PCI_EXP_DEVCTL_NFERE |
+			   PCI_EXP_DEVCTL_FERE |
+			   PCI_EXP_DEVCTL_URRE);
+		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				      2, devctl);
+	}
+
+	/* Enable ECRC generation and check */
+	if (edev->pcie_cap && edev->aer_cap) {
+		eeh_ops->read_config(pdn, edev->aer_cap + PCI_ERR_CAP,
+				     4, &aer_capctl);
+		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
+		eeh_ops->write_config(pdn, edev->aer_cap + PCI_ERR_CAP,
+				      4, aer_capctl);
+	}
+
+	return 0;
+}
+
+static int pseries_eeh_restore_config(struct pci_dn *pdn)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	s64 ret;
+
+	if (!edev)
+		return -EEXIST;
+
+	/*
+	 * FIXME: The MPS, error routing rules, timeout setting are worthy
+	 * to be exported by firmware in extendible way.
+	 */
+	if (edev->physfn)
+		ret = pseries_eeh_restore_vf_config(pdn);
+
+	if (ret) {
+		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
+			__func__, edev->pe_config_addr, ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static struct eeh_ops pseries_eeh_ops = {
 	.name			= "pseries",
 	.init			= pseries_eeh_init,
@@ -723,7 +806,7 @@ static struct eeh_ops pseries_eeh_ops = {
 	.read_config		= pseries_eeh_read_config,
 	.write_config		= pseries_eeh_write_config,
 	.next_error		= NULL,
-	.restore_config		= NULL
+	.restore_config		= pseries_eeh_restore_config
 };
 
 /**
-- 
2.14.3 (Apple Git-98)
