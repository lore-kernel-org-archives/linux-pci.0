Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33946 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752888Ab3IQTFY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2013 15:05:24 -0400
Date: Tue, 17 Sep 2013 21:05:20 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: mvebu: Dynamically detect if the PEX link is up to
 enable hot plug
Message-ID: <20130917210520.284b36bc@skate>
In-Reply-To: <20130917183250.GA21230@obsidianresearch.com>
References: <20130917183250.GA21230@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Tue, 17 Sep 2013 12:32:50 -0600, Jason Gunthorpe wrote:
> Otherwise hotplugging the PEX doesn't work at all since the driver
> detects the link state at probe time. Simply replacing the two tests
> of haslink with a register read is enough to fix discovery.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

I don't have the hardware to test, but this seems to make sense to me.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
