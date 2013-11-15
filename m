Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:49285 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab3KOLkv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 06:40:51 -0500
Received: by mail-la0-f53.google.com with SMTP id ea20so2621785lab.26
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2013 03:40:50 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 1/2] PM / Runtime: Fix error path for prepare
Date: Fri, 15 Nov 2013 12:40:44 +0100
Message-Id: <1384515645-8696-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If a device prepare callback for some reason would fail, the PM core
prevented the device from going inactive forever.

In this case, to reverse the pm_runtime_get_noresume() we invokes the
asyncronous pm_runtime_put(), thus restoring the usage count.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/main.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index ee039af..2a1b06a 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1350,6 +1350,9 @@ static int device_prepare(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
+	if (error)
+		pm_runtime_put(dev);
+
 	return error;
 }
 
-- 
1.7.9.5

