Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:53054 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbbBYPPY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 10:15:24 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joachim Nilsson <troglobit@gmail.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] pci-versatile.c: Update for API change in list_for_each_entry()
Date: Wed, 25 Feb 2015 16:15:02 +0100
Message-ID: <5150533.nuGgOOyLIn@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joachim Nilsson <troglobit@gmail.com>

In Linux 4.0-rc1 ARM Versatile PCI build fails to build due to what
appears to be an API update.  This patch is a very simple correction,
merely posted as a heads-up to the maintainers.  Hopefully a better
fix can be forwarded to Linus.

[arnd: the patch actually looks correct, so let's take this version]

Signed-off-by: Joachim Nilsson <troglobit@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Joachim reported the bug, and I independently found the same problem.
The patch he sent to the list did not apply for me for an unknown reason,
but I fixed it up and forward it now to the right list of recipients.

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 1ec694a52379..464bf492ee2a 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -80,7 +80,7 @@ static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
 	if (err)
 		return err;
 
-	resource_list_for_each_entry(win, res, list) {
+	resource_list_for_each_entry(win, res) {
 		struct resource *parent, *res = win->res;
 
 		switch (resource_type(res)) {

