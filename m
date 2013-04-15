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
Subject: [PATCH 4/6] char: use vma_pages() to replace (vm_end - vm_start) >> PAGE_SHIFT
Date: Mon, 15 Apr 2013 20:48:56 +0800
Message-ID: <1366030138-71292-4-git-send-email-huawei.libin@huawei.com>
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
 drivers/char/mspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/mspec.c b/drivers/char/mspec.c
index e1f60f9..ed0703f 100644
--- a/drivers/char/mspec.c
+++ b/drivers/char/mspec.c
@@ -168,7 +168,7 @@ mspec_close(struct vm_area_struct *vma)
 	if (!atomic_dec_and_test(&vdata->refcnt))
 		return;
 
-	last_index = (vdata->vm_end - vdata->vm_start) >> PAGE_SHIFT;
+	last_index = vma_pages(vdata);
 	for (index = 0; index < last_index; index++) {
 		if (vdata->maddr[index] == 0)
 			continue;
-- 
1.8.2.1


