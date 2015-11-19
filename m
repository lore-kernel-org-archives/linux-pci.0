Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35463 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755AbbKSQIY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 Nov 2015 11:08:24 -0500
From: Andy Lutomirski <luto@kernel.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/2] Minor _OSC error handling improvements
Date: Thu, 19 Nov 2015 08:08:18 -0800
Message-Id: <cover.1447949171.git.luto@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This doesn't fix any bugs, but it makes the debugging output a
little more useful.

Andy Lutomirski (2):
  acpi: Tidy up _OSC error spacing
  acpi: Show _OSC UUID when _OSC fails

 drivers/acpi/bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.5.0

