Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbeD3WkF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Apr 2018 18:40:05 -0400
Date: Mon, 30 Apr 2018 17:40:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v14 0/9] Address error and recovery for AER and DPC
Message-ID: <20180430224002.GI95643@bhelgaas-glaptop.roam.corp.google.com>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
 <f97676e307fe7a02f1f2059a140a5e32@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f97676e307fe7a02f1f2059a140a5e32@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 26, 2018 at 11:00:52AM +0530, poza@codeaurora.org wrote:
> On 2018-04-23 20:53, Oza Pawandeep wrote:
> > This patch set brings in error handling support for DPC
> > 
> > The current implementation of AER and error message broadcasting to the
> > EP driver is tightly coupled and limited to AER service driver.
> > It is important to factor out broadcasting and other link handling
> > callbacks. So that not only when AER gets triggered, but also when DPC
> > get
> > triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> > 
> > The goal of the patch-set is:
> > DPC should handle the error handling and recovery similar to AER,
> > because
> > finally both are attempting recovery in some or the other way,
> > and for that error handling and recovery framework has to be loosely
> > coupled.
> > ...

> Hi Bjorn,
> 
> I know I need to rebase this whole patch-set to 4.17 now.
> 
> But before I do that, can you please help to comment.

My overall comment is that I think the series will be simpler and read
better if you first change AER to do remove/re-enumerate, before doing
anything with DPC.

This could be done by extracting just the AER part of "PCI/AER/DPC:
Align FATAL error handling for AER and DPC" (i.e., adding
pcie_do_fatal_recovery()) and moving that to be the very first patch.

It's a small change in terms of code size, but significant to drivers,
and it's really the core of the series, so it would be good to clearly
establish the policy of:

  ERR_NONFATAL => call driver recovery entry points
  ERR_FATAL    => remove and re-enumerate

before bringing DPC into the picture.

Then the subsequent patches would all be more or less mechanical
changes to make DPC follow the same model.

Bjorn
