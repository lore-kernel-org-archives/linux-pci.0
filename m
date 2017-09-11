Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47701 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751089AbdIKHpv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Sep 2017 03:45:51 -0400
From: Nicolai Stange <nstange@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adrian Salido <salidoa@google.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 3/3] driver core: platform: Don't read past the end of "driver_override" buffer
Date: Mon, 11 Sep 2017 09:45:42 +0200
Message-Id: <20170911074542.16777-4-nstange@suse.de>
In-Reply-To: <20170911074542.16777-1-nstange@suse.de>
References: <20170911074542.16777-1-nstange@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When printing the driver_override parameter when it is 4095 and 4094 bytes
long, the printing code would access invalid memory because we need count+1
bytes for printing.

Reject driver_override values of these lengths in driver_override_store().

This is in close analogy to commit 4efe874aace5 ("PCI: Don't read past the
end of sysfs "driver_override" buffer") from Sasha Levin.

Fixes: 3d713e0e382e ("driver core: platform: add device binding path 'driver_override'")
Cc: stable@vger.kernel.org	# v3.17+
Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/base/platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d1bd99271066..9045c5f3734e 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -868,7 +868,8 @@ static ssize_t driver_override_store(struct device *dev,
 	struct platform_device *pdev = to_platform_device(dev);
 	char *driver_override, *old, *cp;
 
-	if (count > PATH_MAX)
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
 	driver_override = kstrndup(buf, count, GFP_KERNEL);
-- 
2.13.5
