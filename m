Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751522AbdJFRZI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2017 13:25:08 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v96HNtgI056797
        for <linux-pci@vger.kernel.org>; Fri, 6 Oct 2017 13:25:07 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dedptsm6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 06 Oct 2017 13:25:07 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-pci@vger.kernel.org> from <jwalthour@us.ibm.com>;
        Fri, 6 Oct 2017 17:25:06 -0000
To: linux-pci@vger.kernel.org
Cc: mj@ucw.cz
Subject: [PATCH] pciutils: change vpd keyword MN to text
From: "John W Walthour" <jwalthour@us.ibm.com>
Date: Fri, 6 Oct 2017 12:25:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Message-Id: <OF11986481.9DE311D9-ON002581B1.005E606E-862581B1.005FAD2B@notes.na.collabserv.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI spec defines all keyword data fields as ASCII unless otherwise 
noted.
The MN keyword is not otherwise noted. To make this field human readable 
in
lspci verbose outputs, this patch changes the MN keyword definition from
F_BINARY to F_TEXT.

Signed-off-by: John Walthour <return.0@me.com>
---
 ls-vpd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ls-vpd.c b/ls-vpd.c
index 35c2bfa..b79abfc 100644
--- a/ls-vpd.c
+++ b/ls-vpd.c
@@ -33,7 +33,7 @@ static const struct vpd_item {
 } vpd_items[] = {
   { 'C','P', F_BINARY, "Extended capability" },
   { 'E','C', F_TEXT,   "Engineering changes" },
-  { 'M','N', F_BINARY, "Manufacture ID" },
+  { 'M','N', F_TEXT,   "Manufacture ID" },
   { 'P','N', F_TEXT,   "Part number" },
   { 'R','V', F_RESVD,  "Reserved" },
   { 'R','W', F_RDWR,   "Read-write area" },
--
2.11.0 (Apple Git-81)
