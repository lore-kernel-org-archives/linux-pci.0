Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34814 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbdBQA1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 19:27:22 -0500
From: Yadi Hu <yadi.hu@windriver.com>
To: <yadi.hu@windriver.com>, <lftan@altera.com>
CC: <linux-pci@vger.kernel.org>, <rfi@lists.rocketboards.org>
Subject: PCI: altera: Fix TLP completion status 
Date: Fri, 17 Feb 2017 08:27:09 +0800
Message-ID: <1487291230-21495-1-git-send-email-yadi.hu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

the upstream driver does not use exactly 'Completion Status' value 
in TLP, these bits should be b15:13 not b14:12.
