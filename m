Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40966 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753896AbcBZQzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Feb 2016 11:55:53 -0500
Date: Fri, 26 Feb 2016 08:55:52 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>,
	Rob Herring <robh@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/3] PCI: Avoid touching non-compliant BARs
Message-ID: <20160226165552.GA23621@tassilo.jf.intel.com>
References: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 26, 2016 at 09:58:42AM -0600, Bjorn Helgaas wrote:
> Hi guys,
> 
> Here's a proposal for dealing with these devices that have non-BAR
> registers where BARs are supposed to be.  The idea is to:
> 
>   - have an early quirk mark these devices,
>   - disable IO & MEM decoding so the devices don't consume address space
>     we don't know about, and
>   - skip BAR sizing (so the struct resources stay zeroed out)
> 
> This is basically a modification of what Andi originally proposed.  The
> difference here is that we never touch the BAR at all, and we don't have to
> add any struct resource flags, so we don't have to worry about changing any
> consumers of the struct resources.
> 
> Let me know what you think.

I tested the patch on Broadwell and it avoids the Firmware Bug messages.

Tested-by: Andi Kleen <ak@linux.intel.com>

-Andi
