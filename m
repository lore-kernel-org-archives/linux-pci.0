Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:12197 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeAPBaC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jan 2018 20:30:02 -0500
Date: Mon, 15 Jan 2018 18:33:15 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Maik Broemme <mbroemme@libmpq.org>
Subject: Re: [PATCH 3/4] PCI/DPC: Enable DPC in conjuction with AER
Message-ID: <20180116013315.GC32369@localhost.localdomain>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20171219210643.24615-3-keith.busch@intel.com>
 <0fb4494a-bd74-8ff9-f4d6-04409965cf58@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0fb4494a-bd74-8ff9-f4d6-04409965cf58@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 15, 2018 at 09:43:22AM -0500, Sinan Kaya wrote:
> On 12/19/2017 4:06 PM, Keith Busch wrote:
> > @@ -289,6 +290,9 @@ static int dpc_probe(struct pcie_device *dev)
> >  	int status;
> >  	u16 ctl, cap;
> >  
> > +	if (pcie_aer_get_firmware_first(pdev))
> > +		return -ENOTSUPP;
> > +
> 
> There are two ways to support firmware first handling along with DPC.
> 
> The first one is to tie DPC handling to the firmware first enable.
> 
> The second one is to enable DPC ERR_COR signalling so that firmware
> gets notified on each DPC event occurrence.
> 
> While the first one gives more control to the firmware, I think it beats
> the purpose of the DPC. The first approach requires firmware to do some
> "pre-processing" before notifying operating system of a failure.
> 
> The goal of the DPC is to put hardware into safe state when a PCIe error
> happens. The best software recovery following this is to notify endpoint
> drivers of failures and shutdown threads/processes accessing the hardware
> as quick as possible.
> 
> The firmware-first event notification is through ACPI GHES and firmware injects
> an artifical uncorrected AER error to the operating system. Once OS gets
> notified, it tries to recover drivers through AER fatal error recovery mechanism.
> 
> While the semantics of this path is clearly defined in ACPI, it is also known
> to be slow as well. During the time firmware does its business, operating
> system still could be trying to access the endpoint address space.
> 
> My suggestion is to enable ERR_COR signalling so firmware gets a notification
> on each DPC event for logging purposes. 
> 
> OS handles DPC natively and tries to recover hardware without any external
> influence.

I see what you're saying, but if a device has a firmware first policy,
doesn't that mean firmware owns the DPC Control register? The OS shouldn't
be mucking with it in that case, right?
