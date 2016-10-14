Return-Path: <linus971@gmail.com>
Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFxxsn1kBZDtjbvgnaDQe7LJuHg2WL049dCxRxwWnncoFg@mail.gmail.com>
References: <20161013140746.GA14174@localhost> <CA+55aFxxsn1kBZDtjbvgnaDQe7LJuHg2WL049dCxRxwWnncoFg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Oct 2016 17:21:40 -0700
Message-ID: <CA+55aFw2pJ71SxFZXCKix8uVOJcZUu4YeMq+aubGa9+Op_yRXA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.9
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Dan Carpenter <dan.carpenter@oracle.com>, Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 13, 2016 at 4:48 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ugh:
>
> Your "summary" is actually less legible than the shortlog, and looks
> entirely auto-generated.
>
> That's against the whole point of having a summary for a pull request.
>
> Please tell me what changed, don't auto-generate pointless unreadable crud. Ok?

I wrote some kind of summary based on actually (hopefully) intelligent
culling of relevant information instead of just bunching up together
automated data.

It may not be complete, but it's the kind of "what does this merge
actually _merge_" information that is useful. Please do something like
this in the future rather than the automated illegible mush:

 "Summary:

   - use local struct device pointers in many host bridge drivers for
     clarity

   - remove unused platform data

   - use generic DesignWare accessors

   - misc cleanups: remove redundant structure entries and re-order
     structure members to put comon generic fields first etc"

See? Humans can read that and get an idea of what is going on. It
would be even better if it had a few more lines about why those things
matter, but as is, it's much better than that that tag contained.

But the reason I want the maintainer to write this is that I'm lazy.

No, wait, it's really because you are supposed to know the high-level
detail and be able to really notice what is relevant. I just went by
looking for patterns in the shortlog, doing silly things like

   git shortlog ..FETCH_HEAD --no-merges | cut -d: -f3- | sort | uniq
-c | sort -n

to get a feel for what you had done. But because I don't know the
code, maybe I missed some really important change, or
mis-characterized it somehow, or whatever.

Which is why I want the pull requests to contain the kind of relevant
information on what the hell is going on. Not just a "this is all that
happened" munged shortlog in a slightly different format.

                Linus
