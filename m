Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:58381 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933589AbaD3OlB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Apr 2014 10:41:01 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <sebott@linux.vnet.ibm.com>;
	Wed, 30 Apr 2014 15:40:59 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 63F3417D8056
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2014 15:41:58 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3UEeueV45416586
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2014 14:40:56 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3UEet1l025676
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2014 08:40:55 -0600
Date: Wed, 30 Apr 2014 16:40:52 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <monstr@monstr.eu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [Resend] pcibios_add_platform_entries usage
In-Reply-To: <20140429233020.GA9912@google.com>
Message-ID: <alpine.LFD.2.11.1404301638070.4081@denkbrett>
References: <alpine.LFD.2.11.1403281931410.1516@denkbrett> <alpine.LFD.2.11.1404141101500.1529@denkbrett> <20140414173541.GA4417@google.com> <alpine.LFD.2.11.1404141958120.1561@denkbrett> <alpine.LFD.2.11.1404171938190.1588@denkbrett>
 <20140429233020.GA9912@google.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463805518-403214053-1398868854=:4081"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463805518-403214053-1398868854=:4081
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 29 Apr 2014, Bjorn Helgaas wrote:
> On Thu, Apr 17, 2014 at 07:46:15PM +0200, Sebastian Ott wrote:
> > On Mon, 14 Apr 2014, Sebastian Ott wrote:
> > > On Mon, 14 Apr 2014, Bjorn Helgaas wrote:
> > > > On Mon, Apr 14, 2014 at 11:03:42AM +0200, Sebastian Ott wrote:
> > > > > for pci on s390 we currently use pcibios_add_platform_entries to add
> > > > > some arch specific attributes to pdevs. This has 2 downsides - it will
> > > > > race with userspace which is triggered by udev events and expecting
> > > > > these attributes (but that's a theoretical issue). More important to
> > > > > me is that one cannot use attribute_groups with this. Both issues could
> > > > > be addressed by using pdev->dev.groups and let the driver core handle
> > > > > attribute creation.
> > > > > 
> > > > > So would it be ok if we set pdev->dev.groups in pcibios_add_device?
> > > > > (It should be since it's not used by pci common code which uses bus_type,
> > > > > dev_type, and class groups).
> > > > 
> > > > Hi Sebastian,
> > > > 
> > > > Sorry, I meant to respond to this earlier, but forgot.  This sounds
> > > > reasonable to me, but Greg can give you a much better answer than I can.
> > > > 
> > > > Documentation/driver-model/device.txt says the dev->groups pointer
> > > > should be set before calling device_register().  PCI calls
> > > > device_initialize() and device_add() instead of using device_register(),
> > > > and pcibios_add_device() looks like it happens at the right time:
> > > > 
> > > >     pci_scan_root_bus
> > > >       pci_scan_child_bus
> > > >         pci_scan_slot
> > > >           pci_scan_single_device
> > > >             pci_device_add
> > > >               device_initialize
> > > >               pcibios_add_device                # <---
> > > >               device_add
> > > >       pci_bus_add_devices
> > > >         pci_bus_add_device
> > > >           pci_create_sysfs_dev_files
> > > >             pcibios_add_platform_entries        # 8d4cd0833107 (benh)
> > > >           device_attach
> > > > 
> > > > I'm not sure why pci_create_sysfs_dev_files() is done later.  It seems
> > > > like that should be done before device_add() as well.  Maybe it's
> > > > because BARs might not be valid yet (that doesn't seem like a very good
> > > > excuse, but it's all I can think of).
> > > > 
> > > > I assume that if you change s390, you'll also change microblaze and
> > > > powerpc?  They look structurally similar to s390.
> > > 
> > > Yes, that sounds like a plan - this way we can get rid of
> > > pcibios_add_platform_entries altogether. I'll send these patches soon.
> > 
> > Hm, pcibios_add_platform_entries for microblaze and power is identical
> > and this OF stuff seems not to be arch specific. How about the following
> > patch?
> > 
> > 
> > pci: move open fabric devspec attribute to pci common code
> > 
> > Move the devspec OF attribute to pci common code's set of device
> > attributes since it's not architecture dependent.
> > As a side effect microblaze and powerpc no longer need to use
> > pcibios_add_platform_entries.
> > 
> > Link: https://lkml.kernel.org/r/alpine.LFD.2.11.1404141101500.1529@denkbrett
> > Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> 
> I applied this with Ben's ack to pci/misc for v3.16.
> 
> I don't see a corresponding s390 patch; did I miss it?  I don't want to
> apply the "Remove pcibios_add_platform_entries()" patch until s390 is
> fixed up too.

My bad. It's in the feature branch of Martin's s390 tree:
https://git.kernel.org/cgit/linux/kernel/git/s390/linux.git/commit/?h=features&id=8e209e424f8b816f9d957b99ac8d514dc1402f38

>From 8e209e424f8b816f9d957b99ac8d514dc1402f38 Mon Sep 17 00:00:00 2001
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Date: Wed, 16 Apr 2014 16:11:00 +0200
Subject: [PATCH] s390/pci: use pdev->dev.groups for attribute creation

Let the driver core handle attribute creation by putting all s390
specific pci attributes in an attribute group which is referenced
by pdev->dev.groups in pcibios_add_device.

Link: https://lkml.kernel.org/r/alpine.LFD.2.11.1404141101500.1529@denkbrett
Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/pci.h |  6 ++----
 arch/s390/pci/pci.c         |  6 +-----
 arch/s390/pci/pci_sysfs.c   | 44 +++++++++++++-------------------------------
 3 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 2583466..79b5f07 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -120,6 +120,8 @@ static inline bool zdev_enabled(struct zpci_dev *zdev)
 	return (zdev->fh & (1UL << 31)) ? true : false;
 }
 
+extern const struct attribute_group *zpci_attr_groups[];
+
 /* -----------------------------------------------------------------------------
   Prototypes
 ----------------------------------------------------------------------------- */
@@ -166,10 +168,6 @@ static inline void zpci_exit_slot(struct zpci_dev *zdev) {}
 struct zpci_dev *get_zdev(struct pci_dev *);
 struct zpci_dev *get_zdev_by_fid(u32);
 
-/* sysfs */
-int zpci_sysfs_add_device(struct device *);
-void zpci_sysfs_remove_device(struct device *);
-
 /* DMA */
 int zpci_dma_init(void);
 void zpci_dma_exit(void);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 1df1d29..bdf0257 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -530,11 +530,6 @@ static void zpci_unmap_resources(struct zpci_dev *zdev)
 	}
 }
 
-int pcibios_add_platform_entries(struct pci_dev *pdev)
-{
-	return zpci_sysfs_add_device(&pdev->dev);
-}
-
 static int __init zpci_irq_init(void)
 {
 	int rc;
@@ -671,6 +666,7 @@ int pcibios_add_device(struct pci_dev *pdev)
 	int i;
 
 	zdev->pdev = pdev;
+	pdev->dev.groups = zpci_attr_groups;
 	zpci_map_resources(zdev);
 
 	for (i = 0; i < PCI_BAR_COUNT; i++) {
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index ebe2c16..f23da1c 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -51,36 +51,18 @@ static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(recover);
 
-static struct device_attribute *zpci_dev_attrs[] = {
-	&dev_attr_function_id,
-	&dev_attr_function_handle,
-	&dev_attr_pchid,
-	&dev_attr_pfgid,
-	&dev_attr_recover,
+static struct attribute *zpci_dev_attrs[] = {
+	&dev_attr_function_id.attr,
+	&dev_attr_function_handle.attr,
+	&dev_attr_pchid.attr,
+	&dev_attr_pfgid.attr,
+	&dev_attr_recover.attr,
+	NULL,
+};
+static struct attribute_group zpci_attr_group = {
+	.attrs = zpci_dev_attrs,
+};
+const struct attribute_group *zpci_attr_groups[] = {
+	&zpci_attr_group,
 	NULL,
 };
-
-int zpci_sysfs_add_device(struct device *dev)
-{
-	int i, rc = 0;
-
-	for (i = 0; zpci_dev_attrs[i]; i++) {
-		rc = device_create_file(dev, zpci_dev_attrs[i]);
-		if (rc)
-			goto error;
-	}
-	return 0;
-
-error:
-	while (--i >= 0)
-		device_remove_file(dev, zpci_dev_attrs[i]);
-	return rc;
-}
-
-void zpci_sysfs_remove_device(struct device *dev)
-{
-	int i;
-
-	for (i = 0; zpci_dev_attrs[i]; i++)
-		device_remove_file(dev, zpci_dev_attrs[i]);
-}
-- 
1.8.5.5
---1463805518-403214053-1398868854=:4081--

