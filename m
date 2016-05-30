Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36551 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbcE3M0r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 May 2016 08:26:47 -0400
Received: by mail-io0-f195.google.com with SMTP id m17so11031178ioi.3
        for <linux-pci@vger.kernel.org>; Mon, 30 May 2016 05:26:46 -0700 (PDT)
From: Chris Blake <chrisrblake93@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Chris Blake <chrisrblake93@gmail.com>
Subject: [PATCH 0/2] Add AR9485 & QCA988X to no_bus_reset quirk
Date: Mon, 30 May 2016 07:26:36 -0500
Message-Id: <1464611198-11494-1-git-send-email-chrisrblake93@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Both the AR9485 and QCA988x require the no_bus_reset quirk to be set for them
to work correctly with PCI Passthrough. Both of these have been tested on
Linux 4.4.8 and work as intended.

Chris Blake (2):
  Add Quirk for Atheros AR9485 Bus Reset
  Add Quirk for Qualcom Atheros QCA9882 Bus Reset

 drivers/pci/quirks.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--
1.9.1
