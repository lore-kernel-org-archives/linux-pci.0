Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50736 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbcBDUph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 15:45:37 -0500
Date: Thu, 4 Feb 2016 14:45:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
Subject: dra7xx driver status
Message-ID: <20160204204534.GC7031@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

What's the state of dra7xx?  In my tree, it's still marked with
CONFIG_BROKEN.  Last I heard there was a reset issue that needed to
be worked out, but I don't know whether that's been done yet.

Bjorn
