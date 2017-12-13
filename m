Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753215AbdLMV7a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Dec 2017 16:59:30 -0500
Date: Wed, 13 Dec 2017 15:59:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: linux-pci@vger.kernel.org, kishon@ti.com,
        Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Fix find_first_zero_bit() usage
Message-ID: <20171213215925.GJ30595@bhelgaas-glaptop.roam.corp.google.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171212141634.5985-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 12, 2017 at 03:16:31PM +0100, Niklas Cassel wrote:
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> Calling find_first_zero_bit() with the wrong size unit
> will lead to insidious bugs.
> 
> Fix all uses of find_first_zero_bit() called with
> sizeof() as size argument in drivers/pci.
> 
> Also had to fix broken error handling in pci_epc_epf_link()
> in order to do proper error handling for find_first_zero_bit().
> 
> Niklas Cassel (3):
>   PCI: designware-ep: Fix find_first_zero_bit() usage
>   PCI: endpoint: Fix error handling in pci_epc_epf_link()
>   PCI: endpoint: Fix find_first_zero_bit() usage
> 
>  drivers/pci/dwc/pcie-designware-ep.c | 34 ++++++++++++++++++++++++++--------
>  drivers/pci/dwc/pcie-designware.h    |  8 ++++++--
>  drivers/pci/endpoint/pci-ep-cfs.c    | 13 ++++++++-----
>  3 files changed, 40 insertions(+), 15 deletions(-)

In the interest of making forward progress, I applied these to
for-linus for v4.15.

The issues apparently have been there since v4.12-rc1, but I guess
this is proposed for for-linus because (a) it fixes insidious bugs
and (b) the endpoint framework is relatively little-used yet so
low-risk.  Right?

Bjorn
