Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:59431 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaDQRqY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Apr 2014 13:46:24 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <sebott@linux.vnet.ibm.com>;
	Thu, 17 Apr 2014 18:46:23 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id DDB8E1B08051
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2014 18:46:22 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3HHkK8m26738868
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2014 17:46:20 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3HHkIde024960
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2014 11:46:19 -0600
Date: Thu, 17 Apr 2014 19:46:15 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <monstr@monstr.eu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [Resend] pcibios_add_platform_entries usage
In-Reply-To: <alpine.LFD.2.11.1404141958120.1561@denkbrett>
Message-ID: <alpine.LFD.2.11.1404171938190.1588@denkbrett>
References: <alpine.LFD.2.11.1403281931410.1516@denkbrett> <alpine.LFD.2.11.1404141101500.1529@denkbrett> <20140414173541.GA4417@google.com> <alpine.LFD.2.11.1404141958120.1561@denkbrett>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463805518-1966309307-1397756777=:1588"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463805518-1966309307-1397756777=:1588
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 14 Apr 2014, Sebastian Ott wrote:
> On Mon, 14 Apr 2014, Bjorn Helgaas wrote:
> > On Mon, Apr 14, 2014 at 11:03:42AM +0200, Sebastian Ott wrote:
> > > for pci on s390 we currently use pcibios_add_platform_entries to add
> > > some arch specific attributes to pdevs. This has 2 downsides - it will
> > > race with userspace which is triggered by udev events and expecting
> > > these attributes (but that's a theoretical issue). More important to
> > > me is that one cannot use attribute_groups with this. Both issues could
> > > be addressed by using pdev->dev.groups and let the driver core handle
> > > attribute creation.
> > > 
> > > So would it be ok if we set pdev->dev.groups in pcibios_add_device?
> > > (It should be since it's not used by pci common code which uses bus_type,
> > > dev_type, and class groups).
> > 
> > Hi Sebastian,
> > 
> > Sorry, I meant to respond to this earlier, but forgot.  This sounds
> > reasonable to me, but Greg can give you a much better answer than I can.
> > 
> > Documentation/driver-model/device.txt says the dev->groups pointer
> > should be set before calling device_register().  PCI calls
> > device_initialize() and device_add() instead of using device_register(),
> > and pcibios_add_device() looks like it happens at the right time:
> > 
> >     pci_scan_root_bus
> >       pci_scan_child_bus
> >         pci_scan_slot
> >           pci_scan_single_device
> >             pci_device_add
> >               device_initialize
> >               pcibios_add_device                # <---
> >               device_add
> >       pci_bus_add_devices
> >         pci_bus_add_device
> >           pci_create_sysfs_dev_files
> >             pcibios_add_platform_entries        # 8d4cd0833107 (benh)
> >           device_attach
> > 
> > I'm not sure why pci_create_sysfs_dev_files() is done later.  It seems
> > like that should be done before device_add() as well.  Maybe it's
> > because BARs might not be valid yet (that doesn't seem like a very good
> > excuse, but it's all I can think of).
> > 
> > I assume that if you change s390, you'll also change microblaze and
> > powerpc?  They look structurally similar to s390.
> 
> Yes, that sounds like a plan - this way we can get rid of
> pcibios_add_platform_entries altogether. I'll send these patches soon.

Hm, pcibios_add_platform_entries for microblaze and power is identical
and this OF stuff seems not to be arch specific. How about the following
patch?


pci: move open fabric devspec attribute to pci common code

Move the devspec OF attribute to pci common code's set of device
attributes since it's not architecture dependent.
As a side effect microblaze and powerpc no longer need to use
pcibios_add_platform_entries.

Link: https://lkml.kernel.org/r/alpine.LFD.2.11.1404141101500.1529@denkbrett
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 arch/microblaze/pci/pci-common.c |   20 --------------------
 arch/powerpc/kernel/pci-common.c |   20 --------------------
 drivers/pci/pci-sysfs.c          |   17 +++++++++++++++++
 3 files changed, 17 insertions(+), 40 deletions(-)

--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -168,26 +168,6 @@ struct pci_controller *pci_find_hose_for
 	return NULL;
 }
 
-static ssize_t pci_show_devspec(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct pci_dev *pdev;
-	struct device_node *np;
-
-	pdev = to_pci_dev(dev);
-	np = pci_device_to_OF_node(pdev);
-	if (np == NULL || np->full_name == NULL)
-		return 0;
-	return sprintf(buf, "%s", np->full_name);
-}
-static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
-
-/* Add sysfs properties */
-int pcibios_add_platform_entries(struct pci_dev *pdev)
-{
-	return device_create_file(&pdev->dev, &dev_attr_devspec);
-}
-
 void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -201,26 +201,6 @@ struct pci_controller* pci_find_hose_for
 	return NULL;
 }
 
-static ssize_t pci_show_devspec(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct pci_dev *pdev;
-	struct device_node *np;
-
-	pdev = to_pci_dev (dev);
-	np = pci_device_to_OF_node(pdev);
-	if (np == NULL || np->full_name == NULL)
-		return 0;
-	return sprintf(buf, "%s", np->full_name);
-}
-static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
-
-/* Add sysfs properties */
-int pcibios_add_platform_entries(struct pci_dev *pdev)
-{
-	return device_create_file(&pdev->dev, &dev_attr_devspec);
-}
-
 /*
  * Reads the interrupt pin to determine if interrupt is use by card.
  * If the interrupt is used, then gets the interrupt line from the
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -416,6 +416,20 @@ static ssize_t d3cold_allowed_show(struc
 static DEVICE_ATTR_RW(d3cold_allowed);
 #endif
 
+#ifdef CONFIG_OF
+static ssize_t devspec_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct device_node *np = pci_device_to_OF_node(pdev);
+
+	if (np == NULL || np->full_name == NULL)
+		return 0;
+	return sprintf(buf, "%s", np->full_name);
+}
+static DEVICE_ATTR_RO(devspec);
+#endif
+
 #ifdef CONFIG_PCI_IOV
 static ssize_t sriov_totalvfs_show(struct device *dev,
 				   struct device_attribute *attr,
@@ -521,6 +535,9 @@ static struct attribute *pci_dev_attrs[]
 #if defined(CONFIG_PM_RUNTIME) && defined(CONFIG_ACPI)
 	&dev_attr_d3cold_allowed.attr,
 #endif
+#ifdef CONFIG_OF
+	&dev_attr_devspec.attr,
+#endif
 	NULL,
 };
 
---1463805518-1966309307-1397756777=:1588--

