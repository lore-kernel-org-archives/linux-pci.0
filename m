Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Libin <huawei.libin@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Hans J. Koch" <hjk@hansjkoch.de>,
	Petr Vandrovec <petr@vandrovec.name>,
	Andrew Morton <akpm@linux-foundation.org>
CC: Konstantin Khlebnikov <khlebnikov@openvz.org>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Dave Airlie <airlied@redhat.com>,
	Nadia Yvette Chambers <nyc@holomorphy.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>,
	Rik van Riel <riel@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Michel Lespinasse <walken@google.com>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
	<guohanjun@huawei.com>, <wangyijing@huawei.com>
Subject: [PATCH 2/6] PCI: use vma_pages() to replace (vm_end - vm_start) >> PAGE_SHIFT
Date: Mon, 15 Apr 2013 20:48:54 +0800
Message-ID: <1366030138-71292-2-git-send-email-huawei.libin@huawei.com>
In-Reply-To: <1366030138-71292-1-git-send-email-huawei.libin@huawei.com>
References: <1366030138-71292-1-git-send-email-huawei.libin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(*->vm_end - *->vm_start) >> PAGE_SHIFT operation is implemented
as a inline funcion vma_pages() in linux/mm.h, so using it.

Signed-off-by: Libin <huawei.libin@huawei.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9c6e9bb..5b4a9d9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -897,7 +897,7 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
 
 	if (pci_resource_len(pdev, resno) == 0)
 		return 0;
-	nr = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	nr = vma_pages(vma);
 	start = vma->vm_pgoff;
 	size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
 	pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
-- 
1.8.2.1


