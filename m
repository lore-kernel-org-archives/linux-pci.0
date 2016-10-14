Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932196AbcJNNZx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Oct 2016 09:25:53 -0400
Date: Fri, 14 Oct 2016 08:25:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL] PCI changes for v4.9
Message-ID: <20161014132548.GA10744@localhost>
References: <20161013140746.GA14174@localhost>
 <CA+55aFxxsn1kBZDtjbvgnaDQe7LJuHg2WL049dCxRxwWnncoFg@mail.gmail.com>
 <CA+55aFw2pJ71SxFZXCKix8uVOJcZUu4YeMq+aubGa9+Op_yRXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFw2pJ71SxFZXCKix8uVOJcZUu4YeMq+aubGa9+Op_yRXA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 13, 2016 at 05:21:40PM -0700, Linus Torvalds wrote:
> On Thu, Oct 13, 2016 at 4:48 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ugh:
> >
> > Your "summary" is actually less legible than the shortlog, and looks
> > entirely auto-generated.
> >
> > That's against the whole point of having a summary for a pull request.
> >
> > Please tell me what changed, don't auto-generate pointless unreadable crud. Ok?
> 
> I wrote some kind of summary based on actually (hopefully) intelligent
> culling of relevant information instead of just bunching up together
> automated data.
> 
> It may not be complete, but it's the kind of "what does this merge
> actually _merge_" information that is useful. Please do something like
> this in the future rather than the automated illegible mush:
> 
>  "Summary:
> 
>    - use local struct device pointers in many host bridge drivers for
>      clarity
> 
>    - remove unused platform data
> 
>    - use generic DesignWare accessors
> 
>    - misc cleanups: remove redundant structure entries and re-order
>      structure members to put comon generic fields first etc"

That's accurate, thank you, and sorry for not providing it myself.

I guess I've always been a little confused on what to put in the email
vs. what should be in the tag message itself.  I'm glad you pointed
this out because it's just dawning on me that the tag message does not
become part of your tree when you pull the tag, while the summary from
the email pull request normally does.  I've been focusing on the tag
message, not the email summary, which was completely backwards.

Bjorn
