Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:41715 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab3CRLLk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Mar 2013 07:11:40 -0400
From: Lin Feng <linfeng@cn.fujitsu.com>
To: akpm@linux-foundation.org, bhelgaas@google.com
Cc: linux-mm@kvack.org, x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, yinghai@kernel.org,
	Lin Feng <linfeng@cn.fujitsu.com>
Subject: [PATCH] kernel/range.c: subtract_range: return instead of continue to save some loops
Date: Mon, 18 Mar 2013 18:21:49 +0800
Message-Id: <1363602109-12001-1-git-send-email-linfeng@cn.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we fall into that branch it means that there is a range fully covering the
subtract range, so it's suffice to return there if there isn't any other
overlapping ranges.

Also fix the broken phrase issued by printk.

Cc: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Lin Feng <linfeng@cn.fujitsu.com>
---
 kernel/range.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/range.c b/kernel/range.c
index 9b8ae2d..223c6fe 100644
--- a/kernel/range.c
+++ b/kernel/range.c
@@ -97,10 +97,10 @@ void subtract_range(struct range *range, int az, u64 start, u64 end)
 				range[i].end = range[j].end;
 				range[i].start = end;
 			} else {
-				printk(KERN_ERR "run of slot in ranges\n");
+				printk(KERN_ERR "run out of slot in ranges\n");
 			}
 			range[j].end = start;
-			continue;
+			return;
 		}
 	}
 }
-- 
1.8.0.1

