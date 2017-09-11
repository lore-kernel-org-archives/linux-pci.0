Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicolai Stange <nstange@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adrian Salido <salidoa@google.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 2/3] PCI: don't use snprintf() in driver_override_show()
Date: Mon, 11 Sep 2017 09:45:41 +0200
Message-Id: <20170911074542.16777-3-nstange@suse.de>
In-Reply-To: <20170911074542.16777-1-nstange@suse.de>
References: <20170911074542.16777-1-nstange@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Quote from Documentation/filesystems/sysfs.txt:

  show() must not use snprintf() when formatting the value to be
  returned to user space. If you can guarantee that an overflow
  will never happen you can use sprintf() otherwise you must use
  scnprintf().

Commit 4efe874aace5 ("PCI: Don't read past the end of sysfs
"driver_override" buffer") introduced such a snprintf() usage from
driver_override_show() while at the same time tweaking
driver_override_store() such that the write buffer can't ever get
overflowed.

Reasoning:
Since aforementioned commit, driver_override_store() only accepts to be
written buffers less than PAGE_SIZE - 1 in size.

The then kstrndup()'ed driver_override string will be at most PAGE_SIZE - 1
in length, including the trailing '\0'.

After the addition of a '\n' in driver_override_show(), the result won't
exceed PAGE_SIZE characters in length, again including the trailing '\0'.

Hence, snprintf(buf, PAGE_SIZE, ...) and sprintf(buf, ...) are equivalent
at this point.

Replace the former by the latter in order to adhere to the rules in
Documentation/filesystems/sysfs.txt.

This is a style fix only and there's no change in functionality.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 8e075ea2743e..43f7fbede448 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -722,7 +722,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = snprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
+	len = sprintf(buf, "%s\n", pdev->driver_override);
 	device_unlock(dev);
 	return len;
 }
-- 
2.13.5
