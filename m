Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:45587 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbdBQAUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 19:20:11 -0500
From: Yadi Hu <yadi.hu@windriver.com>
To: <yadi.hu@windriver.com>, <lftan@altera.com>
CC: <linux-pci@vger.kernel.org>, <rfi@lists.rocketboards.org>
Subject: PCI: altera: Fix TLP completion status 
Date: Fri, 17 Feb 2017 08:19:55 +0800
Message-ID: <1487290796-21192-1-git-send-email-yadi.hu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

'Completion Status' value in TLP should be b15:13 while the fix is
using b14:12. 
