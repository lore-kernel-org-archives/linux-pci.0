Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:46469 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab1K2CLM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2011 21:11:12 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <aik@au1.ibm.com>;
	Tue, 29 Nov 2011 02:09:35 +1000
Message-ID: <4ED43F39.8050606@au1.ibm.com>
Date: Tue, 29 Nov 2011 13:11:05 +1100
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
References: <20111103195452.21259.93021.stgit@bling.home> <4ED43AD9.5090509@au1.ibm.com> <4ED43CFE.8040009@au1.ibm.com>
In-Reply-To: <4ED43CFE.8040009@au1.ibm.com>
Content-Type: text/plain; charset=KOI8-R
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all again,

It was actually the very first problem - endianess :-)
I am still not sure what format is better for cached config space or whether we should cache it all.

Also, as Benh already mentioned, vfio_virt_init reads a config space to a cache by pci_read_config_dword
for the whole space while some devices may not like it as they might distinguish length of PCI
transactions.



KERNEL patch:

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index b3bab99..9d563b4 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -757,6 +757,16 @@ static int vfio_virt_init(struct vfio_pci_device *vdev)
 	vdev->rbar[5] = *(u32 *)&vdev->vconfig[PCI_BASE_ADDRESS_5];
 	vdev->rbar[6] = *(u32 *)&vdev->vconfig[PCI_ROM_ADDRESS];

+	/*
+	 * As pci_read_config_XXXX returns data in native format,
+	 * and the cached copy is used in assumption that it is
+	 * native PCI format, fix endianness in the cached copy.
+	 */
+	lp = (u32 *)vdev->vconfig;
+	for (i = 0; i < pdev->cfg_size/sizeof(u32); i++, lp++) {
+		*lp = cpu_to_le32(*lp);
+	}
+
 	/* for sr-iov devices */
 	vdev->vconfig[PCI_VENDOR_ID] = pdev->vendor & 0xFF;
 	vdev->vconfig[PCI_VENDOR_ID+1] = pdev->vendor >> 8;
@@ -807,18 +817,18 @@ static void vfio_bar_fixup(struct vfio_pci_device *vdev)
 		else
 			mask = 0;
 		lp = (u32 *)(vdev->vconfig + PCI_BASE_ADDRESS_0 + 4*bar);
-		*lp &= (u32)mask;
+		*lp &= cpu_to_le32((u32)mask);

 		if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
-			*lp |= PCI_BASE_ADDRESS_SPACE_IO;
+			*lp |= cpu_to_le32(PCI_BASE_ADDRESS_SPACE_IO);
 		else if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
-			*lp |= PCI_BASE_ADDRESS_SPACE_MEMORY;
+			*lp |= cpu_to_le32(PCI_BASE_ADDRESS_SPACE_MEMORY);
 			if (pci_resource_flags(pdev, bar) & IORESOURCE_PREFETCH)
-				*lp |= PCI_BASE_ADDRESS_MEM_PREFETCH;
+				*lp |= cpu_to_le32(PCI_BASE_ADDRESS_MEM_PREFETCH);
 			if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM_64) {
-				*lp |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+				*lp |= cpu_to_le32(PCI_BASE_ADDRESS_MEM_TYPE_64);
 				lp++;
-				*lp &= (u32)(mask >> 32);
+				*lp &= cpu_to_le32((u32)(mask >> 32));
 				bar++;
 			}
 		}
@@ -830,7 +840,7 @@ static void vfio_bar_fixup(struct vfio_pci_device *vdev)
 	} else
 		mask = 0;
 	lp = (u32 *)(vdev->vconfig + PCI_ROM_ADDRESS);
-	*lp &= (u32)mask;
+	*lp &= cpu_to_le32((u32)mask);

 	vdev->bardirty = 0;
 }


=== end ===




QEMU patch:


diff --git a/hw/vfio_pci.c b/hw/vfio_pci.c
index 980eec7..1c97c35 100644
--- a/hw/vfio_pci.c
+++ b/hw/vfio_pci.c
@@ -405,6 +405,8 @@ static void vfio_resource_write(void *opaque, target_phys_addr_t addr,
 {
     PCIResource *res = opaque;

+    fprintf(stderr, "change endianness????\n");
+
     if (pwrite(res->fd, &data, size, res->offset + addr) != size) {
         fprintf(stderr, "%s(,0x%"PRIx64", 0x%"PRIx64", %d) failed: %s\n",
                 __FUNCTION__, addr, data, size, strerror(errno));
@@ -429,6 +431,9 @@ static uint64_t vfio_resource_read(void *opaque,
     DPRINTF("%s(BAR%d+0x%"PRIx64", %d) = 0x%"PRIx64"\n",
             __FUNCTION__, res->bar, addr, size, data);

+    data = le32_to_cpu(data);
+    DPRINTF("%s(BAR%d+0x%"PRIx64", %d) = 0x%"PRIx64" --- CPU\n",
+            __FUNCTION__, res->bar, addr, size, data);
     return data;
 }

@@ -454,13 +459,25 @@ static uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)

         val = pci_default_read_config(pdev, addr, len);
     } else {
-        if (pread(vdev->fd, &val, len, vdev->config_offset + addr) != len) {
+        u8 buf[4] = {0};
+        if (pread(vdev->fd, buf, len, vdev->config_offset + addr) != len) {
             fprintf(stderr, "%s(%04x:%02x:%02x.%x, 0x%x, 0x%x) failed: %s\n",
                     __FUNCTION__, vdev->host.seg, vdev->host.bus,
                     vdev->host.dev, vdev->host.func, addr, len,
                     strerror(errno));
             return -1;
         }
+    	switch (len) {
+            case 1: val = buf[0]; break;
+            case 2: val = le16_to_cpupu((uint16_t*)buf); break;
+            case 4: val = le32_to_cpupu((uint32_t*)buf); break;
+            default:
+                    fprintf(stderr, "%s(%04x:%02x:%02x.%x, 0x%x, 0x%x) failed: %s\n",
+                            __FUNCTION__, vdev->host.seg, vdev->host.bus,
+                            vdev->host.dev, vdev->host.func, addr, len,
+                            strerror(errno));
+                    break;
+	    }
     }
     DPRINTF("%s(%04x:%02x:%02x.%x, 0x%x, 0x%x) %x\n", __FUNCTION__,
             vdev->host.seg, vdev->host.bus, vdev->host.dev,
@@ -477,8 +494,20 @@ static void vfio_pci_write_config(PCIDevice *pdev, uint32_t addr,
             vdev->host.seg, vdev->host.bus, vdev->host.dev,
             vdev->host.func, addr, val, len);

+    u8 buf[4] = {0};
+    switch (len) {
+        case 1: buf[0] = val & 0xFF; break;
+        case 2: cpu_to_le16wu((uint16_t*)buf, val); break;
+        case 4: cpu_to_le32wu((uint32_t*)buf, val); break;
+        default:
+            fprintf(stderr, "%s(%04x:%02x:%02x.%x, 0x%x, 0x%x, 0x%x) failed: %s\n",
+                 __FUNCTION__, vdev->host.seg, vdev->host.bus, vdev->host.dev,
+                 vdev->host.func, addr, val, len, strerror(errno));
+            return;
+    }
+
     /* Write everything to VFIO, let it filter out what we can't write */
-    if (pwrite(vdev->fd, &val, len, vdev->config_offset + addr) != len) {
+    if (pwrite(vdev->fd, buf, len, vdev->config_offset + addr) != len) {
         fprintf(stderr, "%s(%04x:%02x:%02x.%x, 0x%x, 0x%x, 0x%x) failed: %s\n",
                 __FUNCTION__, vdev->host.seg, vdev->host.bus, vdev->host.dev,
                 vdev->host.func, addr, val, len, strerror(errno));
@@ -675,6 +704,7 @@ static int vfio_setup_msi(VFIODevice *vdev)
                   vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
             return -1;
         }
+        ctrl = le16_to_cpu(ctrl);

         msi_64bit = !!(ctrl & PCI_MSI_FLAGS_64BIT);
         msi_maskbit = !!(ctrl & PCI_MSI_FLAGS_MASKBIT);

=== end ===





On 29/11/11 13:01, Alexey Kardashevskiy wrote:
> Hi all,
> 
> Another problem I hit on POWER - MSI interrupts allocation. The existing VFIO does not expect a PBH
> to support less interrupts that a device might request. In my case, PHB's limit is 8 interrupts
> while my test card (10Gb ethernet CXGB3) wants 9. Below are the patches to demonstrate the idea.
> 
> 
> 
> 
> 
> On 29/11/11 12:52, Alexey Kardashevskiy wrote:
>> Hi!
>>
>> I tried (successfully) to run it on POWER and while doing that I found some issues. I'll try to
>> explain them in separate mails.
>>
>>
>>
>> On 04/11/11 07:12, Alex Williamson wrote:
>>> VFIO provides a secure, IOMMU based interface for user space
>>> drivers, including device assignment to virtual machines.
>>> This provides the base management of IOMMU groups, devices,
>>> and IOMMU objects.  See Documentation/vfio.txt included in
>>> this patch for user and kernel API description.
>>>
>>> Note, this implements the new API discussed at KVM Forum
>>> 2011, as represented by the drvier version 0.2.  It's hoped
>>> that this provides a modular enough interface to support PCI
>>> and non-PCI userspace drivers across various architectures
>>> and IOMMU implementations.
>>>
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>>
>>> Fingers crossed, this is the last RFC for VFIO, but we need
>>> the iommu group support before this can go upstream
>>> (http://lkml.indiana.edu/hypermail/linux/kernel/1110.2/02303.html),
>>> hoping this helps push that along.
>>>
>>> Since the last posting, this version completely modularizes
>>> the device backends and better defines the APIs between the
>>> core VFIO code and the device backends.  I expect that we
>>> might also adopt a modular IOMMU interface as iommu_ops learns
>>> about different types of hardware.  Also many, many cleanups.
>>> Check the complete git history for details:
>>>
>>> git://github.com/awilliam/linux-vfio.git vfio-ng
>>>
>>> (matching qemu tree: git://github.com/awilliam/qemu-vfio.git)
>>>
>>> This version, along with the supporting VFIO PCI backend can
>>> be found here:
>>>
>>> git://github.com/awilliam/linux-vfio.git vfio-next-20111103
>>>
>>> I've held off on implementing a kernel->user signaling
>>> mechanism for now since the previous netlink version produced
>>> too many gag reflexes.  It's easy enough to set a bit in the
>>> group flags too indicate such support in the future, so I
>>> think we can move ahead without it.
>>>
>>> Appreciate any feedback or suggestions.  Thanks,
>>>
>>> Alex
>>>
>>
>>
> 
> 


-- 
Alexey Kardashevskiy
IBM OzLabs, LTC Team

e-mail: aik@au1.ibm.com
notes: Alexey Kardashevskiy/Australia/IBM

