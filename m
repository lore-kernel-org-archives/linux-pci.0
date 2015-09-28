Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33495 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298AbbI1WJB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Sep 2015 18:09:01 -0400
Date: Mon, 28 Sep 2015 17:08:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-pci@vger.kernel.org
Subject: pci_generic_config_write32() access size problem
Message-ID: <20150928220854.GA16110@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

Russell pointed out a problem with 1f94a94f67e1 ("PCI: Add generic config
accessors").  pci_generic_config_write32() does a read/modify/write if the
size is less than 32 bits, so I think we have problem if this is used with
8- or 16-bit registers that contain RW1C bits.  Any thoughts on how we can
fix this?

Bjorn
