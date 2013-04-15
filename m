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
Subject: [PATCH 6/6] uio: use vma_pages() to replace (vm_end - vm_start) >> PAGE_SHIFT
Date: Mon, 15 Apr 2013 20:48:58 +0800
Message-ID: <1366030138-71292-6-git-send-email-huawei.libin@huawei.com>
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
 drivers/uio/uio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index c8b9262..ba5447f 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -676,7 +676,7 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 	if (mi < 0)
 		return -EINVAL;
 
-	requested_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+	requested_pages = vma_pages(vma);
 	actual_pages = ((idev->info->mem[mi].addr & ~PAGE_MASK)
 			+ idev->info->mem[mi].size + PAGE_SIZE -1) >> PAGE_SHIFT;
 	if (requested_pages > actual_pages)
-- 
1.8.2.1


