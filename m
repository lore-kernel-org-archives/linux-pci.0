Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43791 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932533AbcAHUhk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 15:37:40 -0500
Date: Fri, 8 Jan 2016 14:37:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Simon Horman <horms@verge.net.au>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 0/2] drivers/pci: use builtin_platform_driver in renesas
Message-ID: <20160108203737.GJ5354@localhost>
References: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 21, 2015 at 07:59:07PM -0500, Paul Gortmaker wrote:
> These two commits are extracted from what was a larger series[1] of
> demodularization in PCI host code that was bool Kconfig.
> 
> With the other commits, there was some mixed opinions whether we
> should make it explicitly non-modular or move towards making it
> functionally working as a tristate in order to reduce the size of
> built-in code for multi-platform kernels.
> 
> However with the renesas changes, there was no ".remove" and no
> "module_exit" code stripped out ; it is just a straight 1:1 mapping
> of the modular macros onto what they become in the non-modular case
> anyway -- meaning the runtime remains unchanged.

Is there any reason these drivers can't be made modular?  I'd rather
do that, if we can.

Bjorn
