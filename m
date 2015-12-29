Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:57731 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbL2Fcj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Dec 2015 00:32:39 -0500
From: <Jordan_Hargrave@Dell.com>
To: <hare@suse.de>, <alexander.duyck@gmail.com>
CC: <bhelgaas@google.com>, <mkubecek@suse.com>,
	<shane.seymour@hpe.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <helgaas@kernel.org>
Date: Mon, 28 Dec 2015 23:29:30 -0600
Subject: RE: [PATCH 2/2] pci: Update VPD size with correct length
Message-ID: <8B8F62BE6EB1824D91A8BF961FDC40B9179AE6E3DD@AUSX7MCPS305.AMER.DELL.COM>
References: <1450427719-29619-1-git-send-email-hare@suse.de>
 <1450427719-29619-3-git-send-email-hare@suse.de>
 <CAKgT0Uceg2CmiXu926nfAWg25pSb24UhbmNBw2noNKRNHwDMow@mail.gmail.com>
 <567410D3.7030909@suse.de>
 <CAKgT0Uc9vZGHvtUuzv4EkE2d4-U5F=22-YeSAOWBH=vGa4yJ5Q@mail.gmail.com>,<567414BE.5090800@suse.de>
In-Reply-To: <567414BE.5090800@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>On 12/18/2015 03:02 PM, Alexander Duyck wrote:
>> On Fri, Dec 18, 2015 at 5:57 AM, Hannes Reinecke <hare@suse.de> wrote:
>>> On 12/18/2015 02:49 PM, Alexander Duyck wrote:
>>>>
>>>> On Fri, Dec 18, 2015 at 12:35 AM, Hannes Reinecke <hare@suse.de> wrote:
>>>>>
>>>>> PCI-2.2 VPD entries have a maximum size of 32k, but might actually
>>>>> be smaller than that. To figure out the actual size one has to read
>>>>> the VPD area until the 'end marker' is reached.
>>>>> Trying to read VPD data beyond that marker results in 'interesting'
>>>>> effects, from simple read errors to crashing the card. And to make
>>>>> matters worse not every PCI card implements this properly, leaving
>>>>> us with no 'end' marker or even completely invalid data.
>>>>> This path modifies the size of the VPD attribute to the available
>>>>> size, or set it to '0' if no valid data could be read.
>>>>
>>>>
>>>> This isn't what I had in mind.  There is no need to add an f0 version
>>>> of the size function.  The size for all functions other than function
>>>> 0 when the F0 flag is set is 0.  We aren't going to be reading their
>>>> VPD, we only read the VPD region of function 0.
>>>>
>>> Ah. (I'm a bit confused about the proposed action for VPD other than
>>> function 0).
>>> So the idea here is to _disallow_ access to VPDs from functions other than
>>> '0' unless these functions have different PCI IDs?
>>
>> If you take a look at the F0 functions what they do is bypass the VPD
>> of the functions other than function 0.  As such setting the size to 0
>> should really have no effect since the VPD of the function isn't
>> actually read if the F0 flag is set.
>>
>Setting the size to '0' effectively inhibits you to read the VPD
>data. So if we were to return '0' for PCI devices with the F0 bit
>set we will never ever to be able to read (or write) _any_ VPD data
>for that PCI device/function.
>Which would be rendering all these F0 accessors pointless, and we
>might as well remove them.
>

I had posted a patch recently to enable exposing the VPD-R valyes to sysfs.  I need access 
to these to parse into systemd for network naming (biosdevname style names).


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

>Hence my confusion.
>
>Cheers,
>
>Hannes
>--
>Dr. Hannes Reinecke                            zSeries & Storage
>hare@suse.de                                   +49 911 74053 688
>SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
>GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
>HRB 21284 (AG Nürnberg)
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>