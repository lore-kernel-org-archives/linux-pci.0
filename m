Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932498AbeCKWE0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 11 Mar 2018 18:04:26 -0400
Date: Sun, 11 Mar 2018 17:03:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
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
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
> This patch set brings in error handling support for DPC
> 
> The current implementation of AER and error message broadcasting to the
> EP driver is tightly coupled and limited to AER service driver.
> It is important to factor out broadcasting and other link handling
> callbacks. So that not only when AER gets triggered, but also when DPC get
> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> 
> DPC should enumerate the devices after recovering the link, which is
> achieved by implementing error_resume callback.

The main point of this series is to call the driver error handling
callbacks (error_detected(), mmio_enabled(), slot_reset(), etc.) when
DPC events occur.  We've always called them for AER events, but prior
to this series, we didn't call them for DPC events.

That's a good thing -- we should treat DPC events as much like AER
events as possible.

This series does make it more obvious that there's still a big
difference between AER and DPC handling -- for DPC, we remove and
re-enumerate all the devices, but we don't for AER.  

That difference has been there since the beginning of DPC, so it has
nothing to do with *this* series EXCEPT for the fact that it really
complicates the logic you're adding to reset_link() and
broadcast_error_message().

We ought to be able to simplify that somehow because the only real
difference between AER and DPC should be that DPC automatically
disables the link and AER does it in software.

Bjorn
