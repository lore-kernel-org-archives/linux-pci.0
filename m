Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12716 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756577Ab2CEKBk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 5 Mar 2012 05:01:40 -0500
Date: Mon, 05 Mar 2012 10:00:36 +0000
From: Tadeusz Struk <tadeusz.struk@intel.com>
To: bhelgaas@google.com, jbarnes@virtuousgeek.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org, tadeusz.struk@intel.com
Subject: [PATCH 0/1] PCI: Device specific reset function
Message-ID: <4f548ec4.01v4tKU1J3lDCjP5%tadeusz.struk@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
I have a use case where I need to cleanup resource allocated for Virtual
Functions after a guest OS that used it crashed. This cleanup needs to
be done before the VF is being FLRed. The only possible way to do this
seems to be by using pci_dev_specific_reset() function. Unfortunately
this function only works for devices defined in a static table in the
drivers/pci/quirks.c file. This patch changes it so that specific reset
handler is part of pci_driver struct.


 drivers/pci/pci.h    |    1 +
 drivers/pci/quirks.c |   33 +++++++++++++++++++++++++++------
 include/linux/pci.h  |    1 +
 3 files changed, 29 insertions(+), 6 deletions(-)

--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). Any review or distribution by others is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.


