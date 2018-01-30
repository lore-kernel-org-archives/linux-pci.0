Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41753 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeA3SN4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:13:56 -0500
Date: Tue, 30 Jan 2018 11:17:38 -0700
From: Keith Busch <keith.busch@intel.com>
To: "poza@codeaurora.org" <poza@codeaurora.org>
Cc: Oza Pawandeep <oza.pawandeep@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>
Subject: Re: [PATCH 2/6] PCI/DPC: Leave interrupts enabled while handling
 event
Message-ID: <20180130181738.GB27205@localhost.localdomain>
References: <20180129213145.26068-1-keith.busch@intel.com>
 <20180129213145.26068-2-keith.busch@intel.com>
 <56d77093-b630-148d-52ab-14dcb7714e6b@codeaurora.org>
 <CAK1A=4w-uDm+gau6WdwM=ZrgO=bWDtDKqwabxWxm2EZZb+YoKw@mail.gmail.com>
 <f0afb7badc99dcfc3b6818cc2356250d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f0afb7badc99dcfc3b6818cc2356250d@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 29, 2018 at 10:34:44PM -0800, poza@codeaurora.org wrote:
> On 2018-01-30 11:59, Oza Pawandeep wrote:
> > + Oza
> > 
> > On Tue, Jan 30, 2018 at 7:41 AM, Sinan Kaya <okaya@codeaurora.org> 
> > wrote:
> >> On 1/29/2018 4:31 PM, Keith Busch wrote:
> >>> +     if (!work_busy(&dpc->work))
> >>> +             schedule_work(&dpc->work);
> >> 
> >> Isn't there a race condition between the time that dpc_work() clears 
> >> PCI_EXP_DPC_STATUS
> >> register and when work actually completes by returning from 
> >> dpc_work()?
> >> 
> >> If the interrupt arrives just in this window, this code will not 
> >> schedule the work.
> >> 
> >> --
> >> Sinan Kaya
> >> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
> >> Technologies, Inc.
> >> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
> >> Linux Foundation Collaborative Project.
> 
> besides, there is one more problem which I was debugging:
> if RP doesnt support MSI, then legacy interrupts are not well handled 
> and we get interrupt storm.
> this is because;
> PCI_EXP_DPC_STATUS_INTERRUPT is being cleared in deferred work.
> which should get cleared in dpc_irq interrupt handler.

Okay, thanks for that information. I haven't got a DPC capable device that
supports INTx, so that's a gap in my current testing capabilities.

It looks like as you're suggesting, we should clear DPC Interrupt Status
in the top-half IRQ handler, and we should not see another DPC interrupt
raised until after we clear DPC Trigger Status in the bottom-half.
