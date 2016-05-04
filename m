Return-Path: <yhlu.kernel@gmail.com>
Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20160504012531.GB17170@localhost>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
	<1460074573-7481-5-git-send-email-yinghai@kernel.org>
	<20160422204920.GA17215@localhost>
	<CAE9FiQWQ2ke3_P4Qhj+ON7pMiVCx4myhVNVaSYO4vYAL_P4njg@mail.gmail.com>
	<20160428135607.GA12470@localhost>
	<CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
	<CAE9FiQX_8oXj=FD8pKe=eBL=YWZY-=C8sZ6yMbmkwegLVOR-fA@mail.gmail.com>
	<1462322260.30470.76.camel@kernel.crashing.org>
	<20160504012531.GB17170@localhost>
Date: Tue, 3 May 2016 22:08:07 -0700
Message-ID: <CAE9FiQU=e2bf=+KDrOETf_T-KPLQsSDiG5GqVFqgtvSWXwUz4w@mail.gmail.com>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 3, 2016 at 6:25 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, May 04, 2016 at 10:37:40AM +1000, Benjamin Herrenschmidt wrote:
>>
>> The problem tends to be old Xserver expectations...
>>
>> That stuff has been a can of worms over the years and we did things in
>> the kernel to work around X limitations. I'm not that keen on touching
>> /proc at all in that regard. Leave it there do what it does today, it's
>> a user visible ABI, don't change it.
>
> I did not propose changing any user-visible ABI.  To recap what I did
> propose:

I want to avoid introduce one strange pci_user_to_resource.

>
>   - The sysfs path uses offsets between 0 and BAR size on all arches.
>     It uses pci_resource_to_user() today, but I think it should not.
>
>   - The procfs path uses offsets of resource values (CPU physical
>     addresses) on most architectures, but uses something else, e.g.,
>     BAR values, on others.  pci_resource_to_user() does this
>     translation.  The procfs path does not use pci_resource_to_user()
>     today, but I think it should.

current powerpc pci_resource_to_user is strange:
it will return resource start for io mem.
but will return BAR (?) start for io port.

sparc pci_resource_to_user does return BAR value for iomem.

>
>   - This implies that pci_mmap_page_range() should deal with resource
>     values (CPU physical addresses), and proc_bus_pci_mmap() should do
>     any necessary arch-specific translation from BAR values to
>     resource values.

so will need one different version pci_user_to_resource.
and can not use pcibios_bus_to_resource directly, and will be another mess.

Can you reconsider to keep the pci_mmap_page_range still use BAR value
and only touch pci_mmap_fits() ?

like i suggested before, and it does not conflict with the patchset.

Subject: [PATCH] PCI: Fix pci_mmap_fits() with proc interface

Passed value is user address, so need to compare it with
user addr that is converted from dev resource.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/pci-sysfs.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/pci/pci-sysfs.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-sysfs.c
+++ linux-2.6/drivers/pci/pci-sysfs.c
@@ -969,15 +969,19 @@ void pci_remove_legacy_files(struct pci_
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
           enum pci_mmap_api mmap_api)
 {
-    unsigned long nr, start, size, pci_start;
+    unsigned long nr, start, size;
+    resource_size_t pci_start = 0, pci_end;

     if (pci_resource_len(pdev, resno) == 0)
         return 0;
     nr = vma_pages(vma);
     start = vma->vm_pgoff;
     size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
-    pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
-            pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
+    if (mmap_api == PCI_MMAP_PROCFS) {
+        pci_resource_to_user(pdev, resno, &pdev->resource[resno],
+                     &pci_start, &pci_end);
+        pci_start >>= PAGE_SHIFT;
+    }
     if (start >= pci_start && start < pci_start + size &&
             start + nr <= pci_start + size)
         return 1;
