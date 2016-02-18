Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from AUSXIPPS310.us.dell.com ([143.166.148.211]:6545 "EHLO
	ausxipps310.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947689AbcBRUI0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2016 15:08:26 -0500
From: Jordan Hargrave <Jordan_Hargrave@dell.com>
To: jordan_hargrave@dell.com, bhelgaas@google.com
Cc: alexander.duyck@gmail.com, linux-pci@vger.kernel.org,
	babu.moger@oracle.com, hare@suse.de, linux-kernel@vger.kernel.org,
	jharg93@gmail.com, Jordan Hargrave <Jordan_Hargrave@dell.com>
Subject: [PATCH] Create sysfs entries for PCI VPDI and VPDR tags
Date: Thu, 18 Feb 2016 14:04:55 -0600
Message-Id: <1455825895-10951-1-git-send-email-Jordan_Hargrave@dell.com>
To: Jordan_Hargrave@dell.com
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The VPD-R is a readonly area of the PCI Vital Product Data region.
There are some standard keywords for serial number, manufacturer,
and vendor-specific values.  Dell Servers use a vendor-specific
tag to store number of ports and port mapping of partitioned NICs.

info = VPD-Info string
PN = Part Number
SN = Serial Number
MN = Manufacturer ID
Vx = Vendor-specific (x=0..9 A..Z)

This creates a sysfs subdirectory in the pci device: vpdattr with
'info', 'EC', 'SN', 'V0', etc. files containing the tag values.

Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
---
 drivers/pci/pci-sysfs.c | 240 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d750870..e5f3779 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1295,6 +1295,230 @@ static struct bin_attribute pcie_config_attr = {
 	.write = pci_write_config,
 };
 
+static umode_t vpd_attr_exist(struct kobject *kobj,
+			      struct attribute *attr, int n)
+{
+	struct device *dev;
+	struct pci_dev *pdev;
+	int i;
+
+	dev = container_of(kobj, struct device, kobj);
+	pdev = to_pci_dev(dev);
+
+	if (!strcmp(attr->name, "info"))
+		return pdev->vpdi_data ? S_IRUGO : 0;
+	if (pdev->vpdr_data == NULL)
+		return 0;
+	i = pci_vpd_find_info_keyword(pdev->vpdr_data, 0,
+				      pdev->vpdr_len,
+				      attr->name);
+	return i >= 0 ? S_IRUGO : 0;
+}
+
+static ssize_t vpd_attr_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev;
+	int i, len;
+
+	pdev = to_pci_dev(dev);
+	if (!strcmp(attr->attr.name, "info")) {
+		if (pdev->vpdi_data == NULL)
+			return 0;
+		return scnprintf(buf, PAGE_SIZE, "%s\n",
+				 pdev->vpdi_data);
+	}
+	if (pdev->vpdr_data == NULL)
+		return 0;
+	i = pci_vpd_find_info_keyword(pdev->vpdr_data, 0,
+				      pdev->vpdr_len,
+				      attr->attr.name);
+	if (i >= 0) {
+		len = pci_vpd_info_field_size(&pdev->vpdr_data[i]);
+		return scnprintf(buf, PAGE_SIZE, "%.*s\n", len,
+				 pdev->vpdr_data + i +
+				 PCI_VPD_INFO_FLD_HDR_SIZE);
+	}
+	return 0;
+}
+
+#define VPD_ATTR_RO(x) \
+static struct device_attribute vpd ## x = { \
+	.attr = { .name = #x, .mode = S_IRUGO | S_IWUSR }, \
+	.show = vpd_attr_show \
+}
+VPD_ATTR_RO(info);
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
+	&vpdinfo.attr,
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
+	.name = "vpdattr",
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
+	rc = pci_read_vpd(dev, off, 1, tag);
+	if (rc != 1)
+		return -ENOENT;
+	/* Ignore invalid/end tags */
+	if (tag[0] == 0x00 || tag[0] == 0xFF || tag[0] == 0x7F)
+		return -ENOENT;
+	if (tag[0] & PCI_VPD_LRDT) {
+		/* Large tag */
+		rc = pci_read_vpd(dev, off+1, 2, tag+1);
+		if (rc != 2)
+			return -ENOENT;
+		tlen = pci_vpd_lrdt_size(tag) +
+			PCI_VPD_LRDT_TAG_SIZE;
+	} else {
+		/* Small tag (shouldn't happen in VPD...) */
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
+	/* Check for VPD-I tag */
+	tag = pci_get_vpd_tag(dev, 0, &ilen);
+	if (tag != PCI_VPD_LRDT_ID_STRING)
+		return -ENOENT;
+
+	/* Read VPDI string */
+	ilen -= PCI_VPD_LRDT_TAG_SIZE;
+	dev->vpdi_data = kzalloc(ilen + 1, GFP_ATOMIC);
+	if (dev->vpdi_data == NULL)
+		return  -ENOMEM;
+	rc = pci_read_vpd(dev, PCI_VPD_LRDT_TAG_SIZE,
+			  ilen, dev->vpdi_data);
+	if (rc != ilen)
+		goto error;
+	ilen += PCI_VPD_LRDT_TAG_SIZE;
+
+	/* Check for VPD-R tag */
+	tag = pci_get_vpd_tag(dev, ilen, &rlen);
+	if (tag != PCI_VPD_LRDT_RO_DATA)
+		return -ENOENT;
+
+	/* Read VPDR area */
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
+	kfree(dev->vpdi_data);
+	kfree(dev->vpdr_data);
+	dev->vpdr_data = NULL;
+	return -ENOENT;
+}
+
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
@@ -1340,6 +1564,8 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 			return retval;
 		}
 		dev->vpd->attr = attr;
+
+		pci_load_vpdr(dev);
 	}
 
 	/* Active State Power Management */
@@ -1356,6 +1582,13 @@ static int pci_create_capabilities_sysfs(struct pci_dev *dev)
 error:
 	pcie_aspm_remove_sysfs_dev_files(dev);
 	if (dev->vpd && dev->vpd->attr) {
+		if (dev->vpdr_data) {
+			sysfs_remove_group(&dev->dev.kobj, &vpd_attr_group);
+			kfree(dev->vpdr_data);
+			dev->vpdr_data = NULL;
+		}
+		kfree(dev->vpdi_data);
+		dev->vpdi_data = NULL;
 		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
 		kfree(dev->vpd->attr);
 	}
@@ -1438,6 +1671,13 @@ err:
 static void pci_remove_capabilities_sysfs(struct pci_dev *dev)
 {
 	if (dev->vpd && dev->vpd->attr) {
+		if (dev->vpdr_data) {
+			sysfs_remove_group(&dev->dev.kobj, &vpd_attr_group);
+			kfree(dev->vpdr_data);
+			dev->vpdr_data = NULL;
+		}
+		kfree(dev->vpdi_data);
+		dev->vpdi_data = NULL;
 		sysfs_remove_bin_file(&dev->dev.kobj, dev->vpd->attr);
 		kfree(dev->vpd->attr);
 	}
-- 
2.5.0

