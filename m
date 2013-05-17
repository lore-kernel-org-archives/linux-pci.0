Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45141 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab3EQTsV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2013 15:48:21 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so10069459ieb.38
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2013 12:48:21 -0700 (PDT)
Subject: [PATCH] lspci: Fully decode ASPM support from Link Capabilities
To: Martin Mares <mj@ucw.cz>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phillip Susi <psusi@ubuntu.com>, linux-pci@vger.kernel.org
Date: Fri, 17 May 2013 13:48:19 -0600
Message-ID: <20130517194819.20832.31070.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ASPM Support field in Link Capabilities is two bits, and all four
possible encodings are defined as of PCIe spec r3.0.  Previously, lspci
only decoded values 1, 2, and 3.  This adds 0, so lspci will show "ASPM
not supported" instead of "ASPM unknown".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 ls-caps.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/ls-caps.c b/ls-caps.c
index bddb455..752a771 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -728,6 +728,8 @@ static char *aspm_support(int code)
 {
   switch (code)
     {
+      case 0:
+        return "not supported";
       case 1:
 	return "L0s";
       case 2:

