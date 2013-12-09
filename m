Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:58340 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760399Ab3LITdd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Dec 2013 14:33:33 -0500
Date: Mon, 9 Dec 2013 12:33:32 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Stop clearing bridge Secondary Status when
 setting up I/O aperture
Message-ID: <20131209193332.GB20199@obsidianresearch.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131206001954.27659.78163.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131206001954.27659.78163.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 05, 2013 at 05:19:55PM -0700, Bjorn Helgaas wrote:
> pci_setup_bridge_io() accessed PCI_IO_BASE and PCI_IO_LIMIT using dword
> (32-bit) reads and writes, which also access the Secondary Status register.
> Since the Secondary Status register is in the upper 16 bits of the dword,
> and we preserved those upper 16 bits, this had the effect of clearing any
> of the write-1-to-clear bits that happened to be set in the Secondary
> Status register.

This is a good catch!

> -	pci_write_config_dword(bridge, PCI_IO_BASE, l);
> +	pci_write_config_word(bridge, PCI_IO_BASE, l);

But this is a problem :(

tegra and mvebu at least do not have HW to do non-32 bit writes, so
their implementation of pci_write_config_word does the RMW internally
and will still have this same bug.

I think you have to keep the 32 bit write here, but zero the
write-one-to-clear bits :(

Regards,
Jason
