Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752635AbeAMURN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Jan 2018 15:17:13 -0500
Date: Sat, 13 Jan 2018 14:17:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: pci/setup-bus: Delete an error message for a failed memory
 allocation in add_to_list()
Message-ID: <20180113201709.GF205469@bhelgaas-glaptop.roam.corp.google.com>
References: <fd9d212e-e8da-1aa7-be7f-7bf6d8f1e15f@users.sourceforge.net>
 <20180113000839.GD205469@bhelgaas-glaptop.roam.corp.google.com>
 <03f4a55c-3bc3-0f15-bfc4-73049861edc4@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <03f4a55c-3bc3-0f15-bfc4-73049861edc4@users.sourceforge.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 13, 2018 at 07:15:04AM +0100, SF Markus Elfring wrote:
> >> Omit an extra message for a memory allocation failure in this function.
> > 
> > If this is an "extra" message, I assume there's some other message?
> > Can you mention where that is in the changelog?
> 
> * Would you like to get a more detailed commit description?

Your commit message says "omit an extra message", which suggests that
there are currently two messages about the memory allocation failure,
and that your patch removes one of them.

If that's the case, it would be nice to know where the other message
is.

If your patch removes the *only* message about the memory allocation
failure, that might be worth doing, but the changelog should be clear
about that and say "I don't think the error message is worthwhile
because the function already returns failure" or something similar.

> * Are you looking for a reminder on the Linux allocation failure report?

I don't know what the "Linux allocation failure report" is.

> > Also, please squash all the drivers/pci patches into one.
> 
> To which other change possibilities do you refer here?

You posted two patches that remove error messages about memory
allocation failures:

  http://lkml.kernel.org/r/dc3922b4-50f6-e7fa-482f-18e6ff5d905f@users.sourceforge.net
  http://lkml.kernel.org/r/fd9d212e-e8da-1aa7-be7f-7bf6d8f1e15f@users.sourceforge.net

These are doing the same thing and could be combined into one patch.

Bjorn
