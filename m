Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36324 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553AbbFSVGn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 17:06:43 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo4sHA-f83X1nW2QdLT9GdubFXCQ7UEJmSfFc5GBjj8FSA@mail.gmail.com>
References: <1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com>
 <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com>
 <20150521223321.GG32152@google.com> <20150522002341.GM23057@wotan.suse.de>
 <20150526174008.GN32152@google.com> <20150527200402.GS23057@wotan.suse.de>
 <CAB=NE6Xyd-THK2385W7VfS358PSJfkfHRnjoZRJWP_LFrzOWJA@mail.gmail.com>
 <CAB=NE6Ut4QNmumYJku=At9QC==kAMzFZP-ANHWd3EWKY-tKHBA@mail.gmail.com> <CAErSpo4sHA-f83X1nW2QdLT9GdubFXCQ7UEJmSfFc5GBjj8FSA@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 19 Jun 2015 14:06:22 -0700
Message-ID: <CAB=NE6Vx97T2PhYnqANopvqn1Qptv4DO8deb9=Lqe9iQQx04Kg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] pci: add pci_iomap_wc() variants
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@elte.hu>, Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@infradead.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Dave Airlie <airlied@linux.ie>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	venkatesh.pallipadi@intel.com,
	Stefan Bader <stefan.bader@canonical.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Andi Kleen <andi@firstfloor.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 16, 2015 at 3:20 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Jun 16, 2015 at 2:16 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> On Thu, May 28, 2015 at 5:36 PM, Luis R. Rodriguez
>> <mcgrof@do-not-panic.com> wrote:
>>> On Wed, May 27, 2015 at 1:04 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>>>> On Tue, May 26, 2015 at 12:40:08PM -0500, Bjorn Helgaas wrote:
>>>>> On Fri, May 22, 2015 at 02:23:41AM +0200, Luis R. Rodriguez wrote:
>>>>> > On Thu, May 21, 2015 at 05:33:21PM -0500, Bjorn Helgaas wrote:
>>>>> > >
>>>>> > > I tentatively put this (and the rest of the series) on a pci/resource
>>>>> > > branch.  I'm hoping you'll propose some clarification about
>>>>> > > EXPORT_SYMBOL_GPL().
>>>>> >
>>>>> > EXPORT_SYMBOL_GPL() also serves to ensure only GPL modules can
>>>>> > only run that code. So for instance although we have "Dual BSD/GPL"
>>>>> > tags for modules pure "BSD" tags do not exist for module tags and
>>>>> > cannot run EXPORT_SYMBOL_GPL() code [0]. Also there is some folks
>>>>> > who do believe tha at run time all kernel modules are GPL [1] [2].
>>>>> > And to be precise even though the FSF may claim a list of licenses
>>>>> > are GPL-compatible we cannot rely on this list alone for our own
>>>>> > goals and if folks want to use our EXPORT_SYMBOL_GPL()s they must
>>>>> > discuss this on lkml [2].
>>>>>
>>>>> By "propose some clarification," I meant that I hoped you would propose a
>>>>> patch to Documentation/ that would give maintainers some guidance.
>>>>
>>>> I *really really* would hate to do so but only because you insist, I'll look
>>>> into this...
>>>
>>> OK done.
>>
>> Bjorn,
>>
>> This is now on Jonathan Corbet's tree and visible on linux-next:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=582ed8d51e2b6cb8a168c94852bca482685c2509
>
> Sorry, I'm just not comfortable with using EXPORT_SYMBOL_GPL() this
> way.  I'm happy to use it when it has a technical justification, e.g.,
> for internal interfaces where users of the interface are clearly
> derived works.

I believe it is completely fair for some maintainers to take the
position of what the documentation used to say prior to the new
documentation patch on queue for v4.2, but note that that is an old
position and I seriously caution against it. A few reasons I caution
against it:

1)  It used to be believed that EXPORT_SYMBOL_GPL() was pretty
pointless by many maintainers and developers -- in particular for all
those who have always written even EXPORT_SYMBOL() code with the same
intent as EXPORT_SYMBOL_GPL(). Experience and comments with attorneys
even on Linus' part reflects that there is a huge legal value to
EXPORT_SYMBOL_GPL() [0].

The skinny: Intent matters a lot and "circumventing a GPL-only export
requires an explicit action, making it clear that the resulting
copyright infringement was a deliberate act".

Naturally lax positions on the matter over use of EXPORT_SYMBOL_GPL()
have evolved over time then, not only about its value but also then as
a consequence about where its used in practice today by maintainers
and developers in different trees.

[0] https://lwn.net/Articles/154602/

2) The old position of use of EXPORT_SYMBOL_GPL() about the
derivatives work punts onto the maintainer the onus over the question
of derivatives work -- such question really should not be taken
lightly and this responsibility should really not fall onto the
developer, it requires attorney involvement and should not be taken
lightly by any means.

3) Most drivers are upstream these days, we want to avoid bug reports
from crappy proprietary drivers, specially as we add new features. We
don't have to be begging vendors to work upstream these days, that's
rather the norm. The landscape has changed dramatically. Even Linus
has told Nvidia to go fuck themselves lately, bravo.

> But pci_iomap_wc() is not in that category, and I
> think it should be symmetric with similar interfaces like pci_iomap()
> and ioremap_wc().

Those are two old APIs, and quite the contrary, as I noted we have a
series of new PAT APIs that old modules did not use that are now being
added and spread into the kernel onto which upstream maintainers have
been insisting on using EXPORT_SYMBOL_GPL() even though older similar
APIs only used EXPORT_SYMBOL(). As a recent example the family of APIs
set_pages_array_xx() are all EXPORT_SYMBOL() but Toshi's new
set_pages_array_wt() was asked to be changed to EXPORT_SYMBOL_GPL()
because as noted by Ingo:

--------------
By default we make new APIs EXPORT_SYMBOL_GPL():
we don't want proprietary modules mucking around with new code
PAT interfaces, we only want modules we can analyze and fix
in detail.
--------------

http://article.gmane.org/gmane.linux.kernel.mm/129104

> I don't want to use EXPORT_SYMBOL_GPL() for a random collection of
> things depending on the whim of the author.

Its not just me as I note above, and the new APIs I'm introducing are
also to help with PAT usage.

> That makes for a messy environment to work in, and it's messy enough already.

You're right about the mismatch over the kernel and even on a set of
family of APIs, that's a fair argument, but *that* is a very different
problem. Also the "messy environment" you describe is for proprietary
drivers and it always has been a messy environment for them, that's on
them and they should be talking to attorneys! The issue is already
super messy for them considering tons of folks using EXPORT_SYMBOL()
with the same intent as EXPORT_SYMBOL_GPL(), and refusing to use
EXPORT_SYMBOL_GPL() because of this.

> If we wanted  to remove the EXPORT_SYMBOL/EXPORT_SYMBOL_GPL distinction
> completely,  that'd be fine with me, too.

You're not the only one who has argued over this and the misfortune
over the naming used for EXPORT_SYMBOL_GPL(). Christoph made a similar
argument recently and provided some technical ideas on how to improve
the situation with symbol groups to reflect more of what was intended.
I also followed up with some further possibilities of how to do that
work [1]. If we really care about this so much perhaps we should talk
about this as a separate topic and address it but I would strongly
prefer to avoid this discussion at this point on this thread. If we
really want to we can talk about it over beers at Plumbers perhaps.

[1] http://lkml.kernel.org/r/20150529174051.GC23057@wotan.suse.de

>  But as long as we keep it, I think it  should mean something more than the preference of the author.

We extend the documentation as things become relevant and as you noted
to help with guidance, we did just that recently upon your request and
I provided basis for why things have changed over time now, as well as
reasoning by other maintainers on PAT interfaces, I hope this helps
clarify things.

> I know I did already ack this, and I even said I would merge it, but a
> month of thinking about this hasn't made me more comfortable with it,
> so I've changed my mind.  I said before that I wouldn't try to stop
> you if you want to merge it some other way, but I don't want to ack
> it, and I don't want to merge it via my tree.

I appreciate your thoroughness over this matter and patience. I hope I
have provided new information to help you reconsider. Contrary to the
old days where we needed more of technical reason to use
EXPORT_SYMBOL_GPL() since its use has proven to have huge value, I
personally will always prefer to *always* use EXPORT_SYMBOL_GPL() for
all *new* exported symbols, unless explicitly told by the maintainer,
and even if they do ask for me to  use EXPORT_SYMBOL_GPL() obviously
my intent remains the same, and no one can change that. These days
maintainer's don't ask me to change EXPORT_SYMBPOL_GPL() to
EXPORT_SYMBOL() though, and if they do they are of the position that
EXPORT_SYBOL() means the same thing as EXPORT_SYMBOL_GPL(), you're the
first to question this but it seems it was for the lack of guidance we
had to reflect new best practices.

I hope to have provided a bit of new information to help you
reconsider this series to go through you but since you seem to be fine
for this to go through another tree and since I failed to notice that
I should also get Arnd's Ack I am in hopes this might be able to go
through Arnd's tree if not through you. Please let me know, in case I
have to resubmit to Arnd.

 Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
