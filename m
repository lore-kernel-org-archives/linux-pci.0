Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:39857 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbbH1DxF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2015 23:53:05 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 28 Aug 2015 13:53:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 913972BB0052
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2015 13:53:01 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t7S3qr7Y64618632
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2015 13:53:01 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t7S3qSv5020640
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2015 13:52:29 +1000
Date: Fri, 28 Aug 2015 11:51:47 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2] PCI: Don't update VF's BAR
Message-ID: <20150828035147.GA4390@Richards-MBP.lan>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20150714221511.GM24416@google.com>
 <1438159978-32285-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150827172753.GA27056@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150827172753.GA27056@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 27, 2015 at 12:27:53PM -0500, Bjorn Helgaas wrote:
>[+cc Alex]
>
>On Wed, Jul 29, 2015 at 04:52:58PM +0800, Wei Yang wrote:
>> VF BARs are RO zero, so updating VF BARs will not take any effect.
>> See the SR-IOV spec r1.1, sec 3.4.1.11.
>> 
>> Also this patch adds a warning in pci_update_resource() in case someone
>> really tries to update it.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
>I applied this with some whitespace and changelog fixes to
>pci-4.4/virtualization for v4.4, thanks!  I will rebase this branch
>v4.3-rc1 or later.
>
>You mentioned the justification (avoids "error updating" messages) on the
>mailing list.  It helps me out if you include that in the changelog, but I
>added it for you.

Bjorn,

You are always nice to us :-)

Have a good weekend.

>
>Bjorn
>
>commit fa47e4466c567b43bcf8e152a4425277b6d033d9
>Author: Wei Yang <weiyang@linux.vnet.ibm.com>
>Date:   Wed Jul 29 16:52:58 2015 +0800
>
>    PCI: Don't try to restore VF BARs
>    
>    VF BARs are read-only zero, so updating VF BARs will not have any effect.
>    See the SR-IOV spec r1.1, sec 3.4.1.11.
>    
>    Don't update VF BARs in pci_restore_bars().
>    
>    This avoids spurious "BAR %d: error updating" messages that we see when
>    doing vfio pass-through after 6eb7018705de ("vfio-pci: Move idle devices to
>    D3hot power state").
>    
>    [bhelgaas: changelog, fix whitespace]
>    Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index 0008c95..1a682f8 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -473,7 +473,7 @@ int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask)
> }
>
> /**
>- * pci_restore_bars - restore a devices BAR values (e.g. after wake-up)
>+ * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
>  * @dev: PCI device to have its BARs restored
>  *
>  * Restore the BAR values for a given device, so as to make it
>@@ -483,6 +483,10 @@ static void pci_restore_bars(struct pci_dev *dev)
> {
> 	int i;
>
>+	/* Per SR-IOV spec 3.4.1.11, VF BARs are RO zero */
>+	if (dev->is_virtfn)
>+		return;
>+
> 	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
> 		pci_update_resource(dev, i);
> }
>diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>index 232f925..152de5c 100644
>--- a/drivers/pci/setup-res.c
>+++ b/drivers/pci/setup-res.c
>@@ -36,6 +36,11 @@ void pci_update_resource(struct pci_dev *dev, int resno)
> 	enum pci_bar_type type;
> 	struct resource *res = dev->resource + resno;
>
>+	if (dev->is_virtfn) {
>+		dev_warn(&dev->dev, "can't update VF BAR%d\n", resno);
>+		return;
>+	}
>+
> 	/*
> 	 * Ignore resources for unimplemented BARs and unused resource slots
> 	 * for 64 bit BARs.

-- 
Richard Yang
Help you, Help me

