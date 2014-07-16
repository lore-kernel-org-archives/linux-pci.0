Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:38889 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757220AbaGPII4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 04:08:56 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Wed, 16 Jul 2014 13:38:53 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 05010E0057
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 13:40:25 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s6G897db61341858
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 13:39:07 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s6G88lxL021025
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 13:38:48 +0530
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: [PATCH] Fix build warnings in aer.h
Date: Wed, 16 Jul 2014 04:08:44 -0400
Message-Id: <1405498124-11519-1-git-send-email-qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

build log:

In file included from include/ras/ras_event.h:11:0,
                 from drivers/ras/ras.c:13:
include/linux/aer.h:42:129: warning: ‘struct pci_dev’
declared inside parameter list [enabled by default]

include/linux/aer.h:42:129: warning: its scope is only
this definition or declaration, which is probably not
what you want [enabled by default]

include/linux/aer.h:46:130: warning: ‘struct pci_dev’
declared inside parameter list [enabled by default]

include/linux/aer.h:50:136: warning: ‘struct pci_dev’
declared inside parameter list [enabled by default]

include/linux/aer.h:57:14: warning: ‘struct pci_dev’
declared inside parameter list [enabled by default]

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 include/linux/aer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4dbaa70..c826d1c 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -11,6 +11,8 @@
 #define AER_FATAL			1
 #define AER_CORRECTABLE			2
 
+struct pci_dev;
+
 struct aer_header_log_regs {
 	unsigned int dw0;
 	unsigned int dw1;
-- 
1.8.1.4

