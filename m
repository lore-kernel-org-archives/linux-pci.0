Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:57618 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab1K2CBn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2011 21:01:43 -0500
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <aik@au1.ibm.com>;
	Tue, 29 Nov 2011 01:49:18 +1000
Message-ID: <4ED43CFE.8040009@au1.ibm.com>
Date: Tue, 29 Nov 2011 13:01:34 +1100
From: Alexey Kardashevskiy <aik@au1.ibm.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: chrisw@sous-sol.org, pmac@au1.ibm.com, dwg@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de, benve@cisco.com,
	aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com,
	avi@redhat.com, konrad.wilk@oracle.com, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
References: <20111103195452.21259.93021.stgit@bling.home> <4ED43AD9.5090509@au1.ibm.com>
In-Reply-To: <4ED43AD9.5090509@au1.ibm.com>
Content-Type: text/plain; charset=KOI8-R
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

Another problem I hit on POWER - MSI interrupts allocation. The existing VFIO does not expect a PBH
to support less interrupts that a device might request. In my case, PHB's limit is 8 interrupts
while my test card (10Gb ethernet CXGB3) wants 9. Below are the patches to demonstrate the idea.


KERNEL patch:

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 7d45c6b..d44b9bf 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -458,17 +458,32 @@ int vfio_pci_setup_msix(struct vfio_pci_device *vdev, int nvec, int __user *inta
 		vdev->msix[i].entry = i;
 		vdev->ev_msix[i] = ctx;
 	}
-	if (!ret)
+	if (!ret) {
 		ret = pci_enable_msix(pdev, vdev->msix, nvec);
+		/*
+		   The kernel is unable to allocate requested number of IRQs
+		   and returned the available number.
+		 */
+		if (0 < ret) {
+			ret = pci_enable_msix(pdev, vdev->msix, ret);
+		}
+	}
 	vdev->msix_nvec = 0;
-	for (i = 0; i < nvec && !ret; i++) {
-		ret = request_irq(vdev->msix[i].vector, msihandler, 0,
-				  "vfio", vdev->ev_msix[i]);
-		if (ret)
-			break;
-		vdev->msix_nvec = i+1;
+	if (0 == ret) {
+		vdev->msix_nvec = 0;
+		ret = 0;
+		for (i = 0; i < nvec && !ret; i++) {
+			ret = request_irq(vdev->msix[i].vector, msihandler, 0,
+					"vfio", vdev->ev_msix[i]);
+			if (ret)
+				break;
+			vdev->msix_nvec = i+1;
+		}
+		if ((0 == vdev->msix_nvec) && (0 != ret))
+			vfio_pci_drop_msix(vdev);
+		else
+			ret = vdev->msix_nvec;
 	}
-	if (ret)
-		vfio_pci_drop_msix(vdev);
+
 	return ret;
 }

=== end ===


QEMU patch:

diff --git a/hw/vfio_pci.c b/hw/vfio_pci.c
index 020961a..980eec7 100644
--- a/hw/vfio_pci.c
+++ b/hw/vfio_pci.c
@@ -341,7 +341,8 @@ static void vfio_enable_msi(VFIODevice *vdev, bool msix)
         }
     }

-    if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQ_EVENTFDS, fds)) {
+    ret = ioctl(vdev->fd, VFIO_DEVICE_SET_IRQ_EVENTFDS, fds);
+    if (0 > ret) {
         fprintf(stderr, "vfio: Error: Failed to setup MSI/X fds %s\n",
                 strerror(errno));
         for (i = 0; i < vdev->nr_vectors; i++) {
@@ -355,6 +356,8 @@ static void vfio_enable_msi(VFIODevice *vdev, bool msix)
         qemu_free(vdev->msi_vectors);
         vdev->nr_vectors = 0;
         return;
+    } else if (0 < ret) {
+        vdev->nr_vectors = ret;
     }

     vdev->interrupt = msix ? INT_MSIX : INT_MSI;


=== end ===




On 29/11/11 12:52, Alexey Kardashevskiy wrote:
> Hi!
> 
> I tried (successfully) to run it on POWER and while doing that I found some issues. I'll try to
> explain them in separate mails.
> 
> 
> 
> On 04/11/11 07:12, Alex Williamson wrote:
>> VFIO provides a secure, IOMMU based interface for user space
>> drivers, including device assignment to virtual machines.
>> This provides the base management of IOMMU groups, devices,
>> and IOMMU objects.  See Documentation/vfio.txt included in
>> this patch for user and kernel API description.
>>
>> Note, this implements the new API discussed at KVM Forum
>> 2011, as represented by the drvier version 0.2.  It's hoped
>> that this provides a modular enough interface to support PCI
>> and non-PCI userspace drivers across various architectures
>> and IOMMU implementations.
>>
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>>
>> Fingers crossed, this is the last RFC for VFIO, but we need
>> the iommu group support before this can go upstream
>> (http://lkml.indiana.edu/hypermail/linux/kernel/1110.2/02303.html),
>> hoping this helps push that along.
>>
>> Since the last posting, this version completely modularizes
>> the device backends and better defines the APIs between the
>> core VFIO code and the device backends.  I expect that we
>> might also adopt a modular IOMMU interface as iommu_ops learns
>> about different types of hardware.  Also many, many cleanups.
>> Check the complete git history for details:
>>
>> git://github.com/awilliam/linux-vfio.git vfio-ng
>>
>> (matching qemu tree: git://github.com/awilliam/qemu-vfio.git)
>>
>> This version, along with the supporting VFIO PCI backend can
>> be found here:
>>
>> git://github.com/awilliam/linux-vfio.git vfio-next-20111103
>>
>> I've held off on implementing a kernel->user signaling
>> mechanism for now since the previous netlink version produced
>> too many gag reflexes.  It's easy enough to set a bit in the
>> group flags too indicate such support in the future, so I
>> think we can move ahead without it.
>>
>> Appreciate any feedback or suggestions.  Thanks,
>>
>> Alex
>>
> 
> 


-- 
Alexey Kardashevskiy
IBM OzLabs, LTC Team

e-mail: aik@au1.ibm.com
notes: Alexey Kardashevskiy/Australia/IBM

