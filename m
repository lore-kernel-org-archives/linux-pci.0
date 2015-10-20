Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55699 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbbJTPjp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 20 Oct 2015 11:39:45 -0400
Date: Tue, 20 Oct 2015 10:39:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: PCI Device Tree binding documentation links broken
Message-ID: <20151020153942.GE8224@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

301d2d87cb4f ("Documentation/devicetree: add a small note on PCI")
added some useful links:

  +PCI Bus Binding to: IEEE Std 1275-1994
  +http://www.openfirmware.org/ofwg/bindings/pci/pci2_1.pdf

  +Open Firmware Recommended Practice: Interrupt Mapping
  +http://www.openfirmware.org/1275/practice/imap/imap0_9d.pdf

But both links are now broken.  I looked a little bit, but didn't find
anything that looked like a reliable source.  Do you know of anything
better?

Bjorn
