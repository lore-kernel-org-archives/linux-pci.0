Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jordan Hargrave <Jordan_Hargrave@dell.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Subject: [PATCH] Create sysfs entries for VPD-R keys
Date: Tue,  8 Dec 2015 11:55:55 -0600
Message-Id: <1449597355-4693-1-git-send-email-Jordan_Hargrave@dell.com>
To: Jordan_Hargrave@dell.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The VPD-R is a readonly area contained within the PCI Vital Product
data.  There are some standard and vendor-specific keys stored in
this region.

PN = Part Number
SN = Serial Number
MN = Manufacturer ID
Vx = Vendor-specific (x=0..9 A..Z)

Biosdevname/Systemd will use these VPD keys for determining Network
partitioning and port numbers for NIC cards

Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
---
 drivers/pci/pci-sysfs.c |  216 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |    2 +
 2 files changed, 218 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index eead54c..4966ece 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1295,6 +1295,210 @@ static struct bin_attribute pcie_config_attr = {
 	.write = pci_write_config,
 };
 
+static umode_t vpd_attr_exist(struct kobject *kobj,
+			      struct attribute *attr, int n)
+{
+	struct device *dev;
+	struct pci_dev *pdev;
+	const char *name;
+	int i;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdev = to_pci_dev(dev);
+
+	name = attr->name;
+	if (pdev->vpdr_data == NULL)
+		return 0;
+	i = pci_vpd_find_info_keyword(pdev->vpdr_data, 0,
+				      pdev->vpdr_len, name);
+	return (i >= 0 ? S_IRUGO : 0);
+}
+
+static ssize_t vpd_attr_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev;
+	const char *name;
+	char kv_data[257] = { 0 };
+	int i, len;
+
+	pdev = to_pci_dev(dev);
+	name = attr->attr.name;
+	if (pdev->vpdr_data == NULL)
+		return 0;
+	i = pci_vpd_find_info_keyword(pdev->vpdr_data, 0,
+				      pdev->vpdr_len, name);
+	if (i >= 0) {
+		len = pci_vpd_info_field_size(&pdev->vpdr_data[i]);
+		memcpy(kv_data, pdev->vpdr_data + i +
+		       PCI_VPD_INFO_FLD_HDR_SIZE, len);
+		return scnprintf(buf, PAGE_SIZE, "%s\n", kv_data);
+	}
+	return 0;
+}
+
+#define VPD_ATTR_RO(x) \
+struct device_attribute vpd ## x = { \
+	.attr = { .name = #x, .mode = S_IRUGO | S_IWUSR }, \
+	.show = vpd_attr_show \
+}
+
+VPD_ATTR_RO(PN);
+VPD_ATTR_RO(EC);
+VPD_ATTR_RO(MN);
+VPD_ATTR_RO(SN);
+VPD_ATTR_RO(V0);
+VPD_ATTR_RO(V1);
+VPD_ATTR_RO(V2);
+VPD_ATTR_RO(V3);
+VPD_ATTR_RO(V4);
+VPD_ATTR_RO(V5);
+VPD_ATTR_RO(V6);
+VPD_ATTR_RO(V7);
+VPD_ATTR_RO(V8);
+VPD_ATTR_RO(V9);
+VPD_ATTR_RO(VA);
+VPD_ATTR_RO(VB);
+VPD_ATTR_RO(VC);
+VPD_ATTR_RO(VD);
+VPD_ATTR_RO(VE);
+VPD_ATTR_RO(VF);
+VPD_ATTR_RO(VG);
+VPD_ATTR_RO(VH);
+VPD_ATTR_RO(VI);
+VPD_ATTR_RO(VJ);
+VPD_ATTR_RO(VK);
+VPD_ATTR_RO(VL);
+VPD_ATTR_RO(VM);
+VPD_ATTR_RO(VN);
+VPD_ATTR_RO(VO);
+VPD_ATTR_RO(VP);
+VPD_ATTR_RO(VQ);
+VPD_ATTR_RO(VR);
+VPD_ATTR_RO(VS);
+VPD_ATTR_RO(VT);
+VPD_ATTR_RO(VU);
+VPD_ATTR_RO(VV);
+VPD_ATTR_RO(VW);
+VPD_ATTR_RO(VX);
+VPD_ATTR_RO(VY);
+VPD_ATTR_RO(VZ);
+
+static struct attribute *vpd_attributes[] = {
+	&vpdPN.attr,
+	&vpdEC.attr,
+	&vpdMN.attr,
+	&vpdSN.attr,
+	&vpdV0.attr,
+	&vpdV1.attr,
+	&vpdV2.attr,
+	&vpdV3.attr,
+	&vpdV4.attr,
+	&vpdV5.attr,
+	&vpdV6.attr,
+	&vpdV7.attr,
+	&vpdV8.attr,
+	&vpdV9.attr,
+	&vpdVA.attr,
+	&vpdVB.attr,
+	&vpdVC.attr,
+	&vpdVD.attr,
+	&vpdVE.attr,
+	&vpdVF.attr,
+	&vpdVG.attr,
+	&vpdVH.attr,
+	&vpdVI.attr,
+	&vpdVJ.attr,
+	&vpdVK.attr,
+	&vpdVL.attr,
+	&vpdVM.attr,
+	&vpdVN.attr,
+	&vpdVO.attr,
+	&vpdVP.attr,
+	&vpdVQ.attr,
+	&vpdVR.attr,
+	&vpdVS.attr,
+	&vpdVT.attr,
+	&vpdVU.attr,
+	&vpdVV.attr,
+	&vpdVW.attr,
+	&vpdVX.attr,
+	&vpdVY.attr,
+	&vpdVZ.attr,
+	NULL,
+};
+
+static struct attribute_group vpd_attr_group = {
+	.name = "vpdr",
+	.attrs = vpd_attributes,
+	.is_visible = vpd_attr_exist,
+};
+
+
+static int pci_get_vpd_tag(struct pci_dev *dev, int off, int *len)
+{
+	u8  tag[3];
+	int rc, tlen;
+
+	*len = 0;
+	/* Quirk Atheros cards, reading VPD hangs system for 20s */
+	if (dev->vendor == PCI_VENDOR_ID_ATHEROS ||
+	    dev->vendor == PCI_VENDOR_ID_ATTANSIC)
+		return -ENOENT;
+	rc = pci_read_vpd(dev, off, 1, tag);
+	if (rc != 1)
+		return -ENOENT;
+	if (tag[0] == 0x00 || tag[0] == 0xFF || tag[0] == 0x7F)
+		return -ENOENT;
+	if (tag[0] & PCI_VPD_LRDT) {
+		rc = pci_read_vpd(dev, off+1, 2, tag+1);
+		if (rc != 2)
+			return -ENOENT;
+		tlen = pci_vpd_lrdt_size(tag) +
+			PCI_VPD_LRDT_TAG_SIZE;
+	} else {
+		tlen = pci_vpd_srdt_size(tag) +
+			PCI_VPD_SRDT_TAG_SIZE;
+		tag[0] &= ~PCI_VPD_SRDT_LEN_MASK;
+	}
+	/* Verify VPD tag fits in area */
+	if (tlen + off > dev->vpd->len)
+		return -ENOENT;
+	*len = tlen;
+	return tag[0];
+}
+
+static int pci_load_vpdr(struct pci_dev *dev)
+{
+	int rlen, ilen, tag, rc;
+
+	/* Check for VPD-I and VPD-R tag */
+	tag = pci_get_vpd_tag(dev, 0, &ilen);
+	if (tag != PCI_VPD_LRDT_ID_STRING)
+		return -ENOENT;
+	tag = pci_get_vpd_tag(dev, ilen, &rlen);
+	if (tag != PCI_VPD_LRDT_RO_DATA)
+		return -ENOENT;
+
+	rlen -= PCI_VPD_LRDT_TAG_SIZE;
+	dev->vpdr_len = rlen;
+	dev->vpdr_data = kzalloc(rlen, GFP_ATOMIC);
+	if (dev->vpdr_data == NULL)
+		return -ENOMEM;
+
+	rc = pci_read_vpd(dev, ilen + PCI_VPD_LRDT_TAG_SIZE,
+			  rlen, dev->vpdr_data);
+	if (rc != rlen)
+		goto error;
+	if (sysfs_create_group(&dev->dev.kobj, &vpd_attr_group))
+		goto error;
+	return 0;
+ error:
+	kfree(dev->vpdr_data);
+	dev->vpdr_len = 0;
+	return -ENOENT;
+}
+
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
@@ -1340,6 +1544,8 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 			return retval;
 		}
 		dev->vpd->attr = attr;
+
+		pci_load_vpdr(dev);
 	}
 
 	/* Active State Power Management */
@@ -1356,6 +1562,11 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 error:
 	pcie_aspm_remove_sysfs_dev_files(dev);
 	if (dev->vpd && dev->vpd->attr) {
+		if (dev->vpdr_data) {
+			sysfs_remove_group(&dev->dev.kobj, &vpd_attr_group);
+			kfree(dev->vpdr_data);
+			dev->vpdr_data = NULL;
+		}
 		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
 		kfree(dev->vpd->attr);
 	}
@@ -1438,6 +1649,11 @@ err:
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
 	if (dev->vpd && dev->vpd->attr) {
+		if (dev->vpdr_data) {
+			sysfs_remove_group(&dev->dev.kobj, &vpd_attr_group);
+			kfree(dev->vpdr_data);
+			dev->vpdr_data = NULL;
+		}
 		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
 		kfree(dev->vpd->attr);
 	}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6ae25aa..699cf11 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -372,6 +372,8 @@ struct pci_dev {
 	const struct attribute_group **msi_irq_groups;
 #endif
 	struct pci_vpd *vpd;
+	int vpdr_len;
+	u8 *vpdr_data;
 #ifdef CONFIG_PCI_ATS
 	union {
 		struct pci_sriov *sriov;	/* SR-IOV capability related */
-- 
1.7.1

