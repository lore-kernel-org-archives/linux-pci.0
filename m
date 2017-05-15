Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:60289 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752353AbdEOQpF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 May 2017 12:45:05 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 15 May 2017 10:44:51 -0600
Message-Id: <1494866693-2850-1-git-send-email-logang@deltatee.com>
Subject: [PATCH 0/2] Fixes for Switchtec Driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Can you please apply the following two patches? The first is
a cleanup to use a new helper function I added (it had to wait
until both patchsets were in). The second is a minor bug fix to
the driver we found last week.

Thanks!

Logan


Logan Gunthorpe (2):
  switchtec: utilize new device_add_cdev helper function
  switchtec: fix minor bug with partition id register

 drivers/pci/switch/switchtec.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--
2.1.4
