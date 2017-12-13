Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752908AbdLMTZC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Dec 2017 14:25:02 -0500
Date: Wed, 13 Dec 2017 13:24:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: update AER status string print to match other
 AER logs
Message-ID: <20171213192457.GG30595@bhelgaas-glaptop.roam.corp.google.com>
References: <1508254922-30925-1-git-send-email-tbaicar@codeaurora.org>
 <6d5b3747-ceb7-d47f-9d5f-47aa69ec33cf@codeaurora.org>
 <20171115175636.GA1794@bhelgaas-glaptop.roam.corp.google.com>
 <9ff7829c-02b7-ba51-3609-08fd9468106a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9ff7829c-02b7-ba51-3609-08fd9468106a@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 13, 2017 at 11:50:56AM -0500, Tyler Baicar wrote:
> On 11/15/2017 12:56 PM, Bjorn Helgaas wrote:
> >Hi Tyler,
> >
> >On Wed, Nov 15, 2017 at 09:47:41AM -0500, Tyler Baicar wrote:
> >>On 10/17/2017 11:42 AM, Tyler Baicar wrote:
> >>>Currently the AER driver uses cper_print_bits() to print the AER status
> >>>string. This causes the status string to not include the proper PCI device
> >>>name prefix that the other AER prints include. Also, it has a different
> >>>print level than all the other AER prints.
> >>>
> >>>Update the AER driver to print the AER status string with the proper string
> >>>prefix and proper print level.
> >>Hello,
> >>
> >>Will this patch be pulled into 4.15?
> >Sorry, I am preparing the 4.15 pull request right now, and it doesn't
> >include this change.
> >
> >I do like the dev_err() change, but would prefer fewer lines of
> >output.  I could have applied just the dev_err() change, but to
> >minimize pain for people who parse the logs, I'd rather make one
> >change in the output instead of making one change now and another
> >later.
> Hello Bjorn,
> 
> Are there existing abbreviations for these AER status strings that I
> cannot find? Or do you want
> me to abbreviate them similar to the style used with prints in lspci -vv?

I think the terms used by lspci -vv would be a good start.

> Once they are abbreviated, you'd prefer to have all errors that have
> occurred to be printed on
> the same line, correct?

Yes.  Multiple lines suggests an ordering that really isn't there, so
if we can print them all at once, it both improves atomicity and
removes the erroneous suggestion that "this error occurred before this
other one".

Bjorn
