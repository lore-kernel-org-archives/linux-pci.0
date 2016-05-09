Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56846 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbcEITyO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 May 2016 15:54:14 -0400
Date: Mon, 9 May 2016 14:54:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-pci@vger.kernel.org
Subject: Build warning regression (104daa71b396 ("PCI: Determine actual VPD
 size on first access"))
Message-ID: <20160509195410.GB18166@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hannes,

Geert's list of build regressions and improvements
(http://lkml.kernel.org/r/1462782250-6231-1-git-send-email-geert@linux-m68k.org)
shows these new warnings:

  drivers/pci/access.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 318:8
  drivers/pci/access.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 340:6

which I think are due to 104daa71b396 ("PCI: Determine actual VPD size on
first access").

Would you mind fixing those up and sending me a patch?  These were in
the v4.6-rc1 regressions email, and I should have noticed then, but I
didn't.

Bjorn
