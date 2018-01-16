Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31215 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbeAPCo2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jan 2018 21:44:28 -0500
Date: Mon, 15 Jan 2018 19:47:41 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>
Subject: Re: [PATCH 4/4] PCI/DPC: Print AER status in DPC event handling
Message-ID: <20180116024740.GA32639@localhost.localdomain>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20171219210643.24615-4-keith.busch@intel.com>
 <35445e86-e7b6-3fed-f26a-954a0f8d5e8a@codeaurora.org>
 <20171221051256.GA15276@localhost.localdomain>
 <ea609f8a-1d79-c2fe-e9e5-5993e418f9cc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ea609f8a-1d79-c2fe-e9e5-5993e418f9cc@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 10, 2018 at 10:52:23AM -0500, Sinan Kaya wrote:
> Since the AER status is set when we observe DPC event and nobody is clearing these
> we won't observe another DPC event until somebody clears these. We can say that
> we are resetting the endpoints as part of the DPC but we are not touching the
> switch downstream port or the root port registers.
> 
> Somebody still needs to clear these in addition to printing whatever information
> is available in the AER registers.
> 
> Do you agree?

We should clear the downstream port's AER uncorrectable status register if
the trigger reason is of that type, but DPC definitely does not require
we clear it in order to observe a new event.
