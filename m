Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37582 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdHPKRJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2017 06:17:09 -0400
Received: by mail-lf0-f67.google.com with SMTP id x16so2184182lfb.4
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2017 03:17:08 -0700 (PDT)
Date: Wed, 16 Aug 2017 12:17:05 +0200
From: Stan Drozd <drozdziak1@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] tools/pci: Add a missing option help line
Message-ID: <20170816101702.GA22874@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Stan Drozd <drozdziak1@gmail.com>
---
 tools/pci/pcitest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index ad54a58d7dda..eece9d1124b6 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -173,6 +173,7 @@ int main(int argc, char **argv)
 			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
 			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
 			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
+			"\t-l 			Legacy irq test\n"
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
-- 
2.13.4
