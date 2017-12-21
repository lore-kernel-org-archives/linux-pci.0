Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31615 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbdLUFJd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Dec 2017 00:09:33 -0500
Date: Wed, 20 Dec 2017 22:12:56 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>
Subject: Re: [PATCH 4/4] PCI/DPC: Print AER status in DPC event handling
Message-ID: <20171221051256.GA15276@localhost.localdomain>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20171219210643.24615-4-keith.busch@intel.com>
 <35445e86-e7b6-3fed-f26a-954a0f8d5e8a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35445e86-e7b6-3fed-f26a-954a0f8d5e8a@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 20, 2017 at 11:43:07PM -0500, Sinan Kaya wrote:
> +Oza
> 
> On 12/19/2017 4:06 PM, Keith Busch wrote:
> > A DPC enabled device will suppress sending ERR_FATAL and ERR_NONFATAL,
> > which prevents the AER handler from reporting the details of the
> > error. This patch will have the DPC driver get the AER status registers
> > from the downstream port that detected the uncorrectable error, and
> > print out additional information.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> 
> Oza is doing some restructuring to unify DPC and AER error handling path per
> feedback from Bjorn. It is almost done. He is testing it. 
> 
> Can this patch wait until you review his version? I'm thinking this could
> be something that can be added to his series instead.

No problem.
 
> Coming back to this patch. The interrupt number for DPC and AER could be the
> same or different. 

Only if you're talking about root ports. DPC is also a feature of
switch downstream ports, which don't generate interrupts on AER events
(they don't have a Root Error Command register).

> According to the spec, AER errors are always reported
> regardless of DPC driver presence (see the famous flow chart).

> If the interrupt IDs are the same for AER and DPC, your patch would introduce
> double printing for AER errors.

The AER Uncorrectable Status Register of the detecting port would
indeed be set with the appropriate status if that's the type of error
that occured, but when DPC is enabled, the root port never observes an
ERR_FATAL/ERR_NONFATAL message required for it to get set the Root Error
Status Register. The Linux AER handler requires the Root Error Status
be set in order for it to print anything, so I don't think we're at risk
of double printing with this patch even if the root port is DPC capable.
