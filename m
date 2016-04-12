Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from stargate.chelsio.com ([12.32.117.8]:63299 "EHLO
	stargate3.asicdesigners.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932251AbcDLIXX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2016 04:23:23 -0400
Date: Tue, 12 Apr 2016 13:53:06 +0530
From: Hariprasad Shenai <hariprasad@chelsio.com>
To: Hannes Reinecke <hare@suse.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Steve Wise <swise@opengridcomputing.com>,
	"'Casey Leedom'" <leedom@chelsio.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: 4.6-rc2 regression with commit 104daa71b396: check VPD access
 offset against length
Message-ID: <20160412082304.GB2771@hari-Latitude-E5550>
References: <BY2PR12MB06483CA232B6B3BFF7179012C8910@BY2PR12MB0648.namprd12.prod.outlook.com>
 <BY2PR12MB0648F0C35D907AA640D7E56CC8940@BY2PR12MB0648.namprd12.prod.outlook.com>
 <02ec01d1941e$3dda2010$b98e6030$@opengridcomputing.com>
 <20160412053700.GF11361@localhost>
 <570C93BD.2030102@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <570C93BD.2030102@suse.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 12, 2016 at 08:20:45 +0200, Hannes Reinecke wrote:
> On 04/12/2016 07:37 AM, Bjorn Helgaas wrote:
> > On Mon, Apr 11, 2016 at 01:16:17PM -0500, Steve Wise wrote:
> >>> kernel.org commit 104daa71b396 added a check to make sure that efforts to
> >>> read/write the VPD wouldn't extend past the computed length of the VPD.
> >>> Later, kernel.org commit 408641e93aa5 folded the pci_vpd_pci22 into
> >>> struct pci_vpd so things moved around a bit after that and an error return
> >>> got changed into a silent failure instead of -EINVAL.
> >>>
> >>>   The problem is that the previous pci_vpd_pci22_read() didn't check for a
> >> read with
> >>> a VPD Offset > VPD Length and the new pci_vpd_read() is checking that.  Worse
> >>> yet, when a VPD Offset is greater than the recorded VPD Length, it simply
> >>> returns 0 rather than -EINVAL.
> >>>
> >>>   The problem is stemming from the fact that the Chelsio adapters actually
> >> have
> >>> two VPD structures stored in the VPD.  An abbreviated on at Offset 0x0 and the
> >>> complete VPD at Offset 0x400.  The abbreviated one only contains the PN, SN
> >> and
> >>> EC Keywords, while the complete VPD contains those plus various adapter
> >>> constants contained in V0, V1, etc.  And it also contains the Base Ethernet
> >> MAC
> >>> Address in the "NA" Keyword which the cxgb4 driver needs when it can't contact
> >>> the adapter firmware.  (We don't have the "NA" Keywork in the VPD Structure at
> >>> Offset 0x0 because that's not an allowed VPD Keyword in the PCI-E 3.0
> >>> specification.)
> >>>
> >>>   With the new code, the computed size of the VPD is 0x200 and so our efforts
> >>> to read the VPD at Offset 0x400 silently fails.  We check the result of the
> >>> read looking for a signature 0x82 byte but we're checking against random stack
> >>> garbage.
> >>>
> >>>   The end result is that the cxgb4 driver now fails the PCI-E Probe.
> >>>
> >>
> >> Silently failing is wrong, in my opinion.  And I even question truncating which
> >> is also done in pci_vpd_read().  To the PCI maintainers:  Should the length
> >> checks just be removed?    If not, what is the correct solution?  Adding a
> >> different "expert" API that ignores the length checks, or somehow allowing the
> >> device driver to set the actual VPD size? 
> > 
> > I think everybody would prefer if it the kernel could just read
> > whatever VPD region the user requested, without parsing the data or
> > checking for length (as long as we're within the 32K space allowed by
> > the spec).
> > 
> > The problem is that some cards crash if you read too much:
> > 
> >   commit 104daa71b396
> >   Author: Hannes Reinecke <hare@suse.de>
> >   Date:   Mon Feb 15 09:42:01 2016 +0100
> > 
> >     PCI: Determine actual VPD size on first access
> >     
> >     PCI-2.2 VPD entries have a maximum size of 32k, but might actually be
> >     smaller than that.  To figure out the actual size one has to read the VPD
> >     area until the 'end marker' is reached.
> >     
> >     Per spec, reading outside of the VPD space is "not allowed."  In practice,
> >     it may cause simple read errors or even crash the card.  To make matters
> >     worse not every PCI card implements this properly, leaving us with no 'end'
> >     marker or even completely invalid data.
> >     
> >     Try to determine the size of the VPD data when it's first accessed.  If no
> >     valid data can be read an I/O error will be returned when reading or
> >     writing the sysfs attribute.
> > 
> > So if you want to get rid of the length checks, you have to propose
> > some other mechanism to avoid these issues.
> > 
> > The only ideas I have are to (1) parse the data as we do in
> > 104daa71b396, (2) add quirks to prevent VPD access (as in
> > 7c20078a8197 ("PCI: Prevent VPD access for buggy devices"), and/or (3)
> > add quirks to allow access to more VPD than parsing says we can
> > access.  These aren't mutually exclusive -- we already have (1) and
> > (2), and I think we could easily add (3) into the mix.
> > 
> > (3) seems like a possible solution for Chelsio.  In that case, it's
> > the driver that needs the data, so the driver could maintain a quirk.
> > 
> That's my suggestion, too.
> The generic code should be handling things according to the standard.
> If other drivers require a different handling we should be adding a
> quirk for them.
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke		               zSeries & Storage
> hare@suse.com			               +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
> GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
> HRB 21284 (AG Nürnberg)


Hi,

How about adding a PCI helper function to set the actual VPD_SIZE.

Some thing like below. We have tested this and works. The bnx2x and the tg3
drive may also need this, because I see them calling pci_read_vpd()
with non-zero offsets. The bnx2x in particular looks like it's doing something
similar to cxgb4 so it would also probably benefit from this change (once it's
fixed to call the new pci_set_size_vpd() API).

Thanks,
Hari

====

--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c	
+++ a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c	
@@ -2557,6 +2557,7 @@ void t4_get_regs(struct adapter *adap, void *buf, size_t buf_size)
 }
 
 #define EEPROM_STAT_ADDR   0x7bfc
+#define VPD_SIZE           0x800
 #define VPD_BASE           0x400
 #define VPD_BASE_OLD       0
 #define VPD_LEN            1024
@@ -2594,6 +2595,15 @@ int t4_get_raw_vpd_params(struct adapter *adapter, struct vpd_params *p)
 	if (!vpd)
 		return -ENOMEM;
 
+	/* We have two VPD data structures stored in the adapter VPD area.
+	 * By default, Linux calculates the size of the VPD area by traversing
+	 * the first VPD area at offset 0x0, so we need to tell the OS what
+	 * our real VPD size is.
+	 */
+	ret = pci_set_size_vpd(adapter->pdev, VPD_SIZE);
+	if (ret < 0)
+		goto out;
+
 	/* Card information normally starts at VPD_BASE but early cards had
 	 * it at 0.
 	 */
--- a/drivers/pci/access.c	
+++ a/drivers/pci/access.c	
@@ -275,6 +275,19 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
 }
 EXPORT_SYMBOL(pci_write_vpd);
 
+/**
+ * pci_set_size_vpd - Set size of Vital Product Data space
+ * @dev:	pci device struct
+ * @len:	size of vpd space
+ */
+ssize_t pci_set_size_vpd(struct pci_dev *dev, size_t len)
+{
+	if (!dev->vpd || !dev->vpd->ops)
+		return -ENODEV;
+	return dev->vpd->ops->set_size(dev, len);
+}
+EXPORT_SYMBOL(pci_set_size_vpd);
+
 #define PCI_VPD_MAX_SIZE (PCI_VPD_ADDR_MASK + 1)
 
 /**
@@ -392,13 +405,8 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
 	if (vpd->len == 0)
 		return -EIO;
 
-	if (pos > vpd->len)
-		return 0;
-
-	if (end > vpd->len) {
-		end = vpd->len;
-		count = end - pos;
-	}
+	if (end > vpd->len)
+		return -EINVAL;
 
 	if (mutex_lock_killable(&vpd->lock))
 		return -EINTR;
@@ -498,9 +506,23 @@ out:
 	return ret ? ret : count;
 }
 
+static ssize_t pci_vpd_set_size(struct pci_dev *dev, size_t len)
+{
+	struct pci_vpd *vpd = dev->vpd;
+
+	if (len == 0 || len > PCI_VPD_MAX_SIZE)
+		return -EIO;
+
+	vpd->valid = 1;
+	vpd->len = len;
+
+	return 0;
+}
+
 static const struct pci_vpd_ops pci_vpd_ops = {
 	.read = pci_vpd_read,
 	.write = pci_vpd_write,
+	.set_size = pci_vpd_set_size,
 };
 
 static ssize_t pci_vpd_f0_read(struct pci_dev *dev, loff_t pos, size_t count,
@@ -533,9 +555,24 @@ static ssize_t pci_vpd_f0_write(struct pci_dev *dev, loff_t pos, size_t count,
 	return ret;
 }
 
+static ssize_t pci_vpd_f0_set_size(struct pci_dev *dev, size_t len)
+{
+	struct pci_dev *tdev = pci_get_slot(dev->bus,
+					    PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	ssize_t ret;
+
+	if (!tdev)
+		return -ENODEV;
+
+	ret = pci_set_size_vpd(tdev, len);
+	pci_dev_put(tdev);
+	return ret;
+}
+
 static const struct pci_vpd_ops pci_vpd_f0_ops = {
 	.read = pci_vpd_f0_read,
 	.write = pci_vpd_f0_write,
+	.set_size = pci_vpd_f0_set_size,
 };
 
 int pci_vpd_init(struct pci_dev *dev)
--- a/drivers/pci/pci.h	
+++ a/drivers/pci/pci.h	
@@ -97,6 +97,7 @@ static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
 struct pci_vpd_ops {
 	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
+	ssize_t (*set_size)(struct pci_dev *dev, size_t len);
 };
 
 struct pci_vpd {
--- a/include/linux/pci.h	
+++ a/include/linux/pci.h	
@@ -1111,6 +1111,7 @@ void pci_unlock_rescan_remove(void);
 /* Vital product data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
+ssize_t pci_set_size_vpd(struct pci_dev *dev, size_t len);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);

