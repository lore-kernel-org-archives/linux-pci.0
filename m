Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:35630 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205AbbFPWUv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jun 2015 18:20:51 -0400
Received: by yhak3 with SMTP id k3so21559087yha.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2015 15:20:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6Ut4QNmumYJku=At9QC==kAMzFZP-ANHWd3EWKY-tKHBA@mail.gmail.com>
References: <1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com>
 <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com>
 <20150521223321.GG32152@google.com> <20150522002341.GM23057@wotan.suse.de>
 <20150526174008.GN32152@google.com> <20150527200402.GS23057@wotan.suse.de>
 <CAB=NE6Xyd-THK2385W7VfS358PSJfkfHRnjoZRJWP_LFrzOWJA@mail.gmail.com> <CAB=NE6Ut4QNmumYJku=At9QC==kAMzFZP-ANHWd3EWKY-tKHBA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 16 Jun 2015 17:20:31 -0500
Message-ID: <CAErSpo4sHA-f83X1nW2QdLT9GdubFXCQ7UEJmSfFc5GBjj8FSA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] pci: add pci_iomap_wc() variants
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Dave Airlie <airlied@linux.ie>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
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
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 16, 2015 at 2:16 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Thu, May 28, 2015 at 5:36 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> On Wed, May 27, 2015 at 1:04 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>>> On Tue, May 26, 2015 at 12:40:08PM -0500, Bjorn Helgaas wrote:
>>>> On Fri, May 22, 2015 at 02:23:41AM +0200, Luis R. Rodriguez wrote:
>>>> > On Thu, May 21, 2015 at 05:33:21PM -0500, Bjorn Helgaas wrote:
>>>> > >
>>>> > > I tentatively put this (and the rest of the series) on a pci/resource
>>>> > > branch.  I'm hoping you'll propose some clarification about
>>>> > > EXPORT_SYMBOL_GPL().
>>>> >
>>>> > EXPORT_SYMBOL_GPL() also serves to ensure only GPL modules can
>>>> > only run that code. So for instance although we have "Dual BSD/GPL"
>>>> > tags for modules pure "BSD" tags do not exist for module tags and
>>>> > cannot run EXPORT_SYMBOL_GPL() code [0]. Also there is some folks
>>>> > who do believe tha at run time all kernel modules are GPL [1] [2].
>>>> > And to be precise even though the FSF may claim a list of licenses
>>>> > are GPL-compatible we cannot rely on this list alone for our own
>>>> > goals and if folks want to use our EXPORT_SYMBOL_GPL()s they must
>>>> > discuss this on lkml [2].
>>>>
>>>> By "propose some clarification," I meant that I hoped you would propose a
>>>> patch to Documentation/ that would give maintainers some guidance.
>>>
>>> I *really really* would hate to do so but only because you insist, I'll look
>>> into this...
>>
>> OK done.
>
> Bjorn,
>
> This is now on Jonathan Corbet's tree and visible on linux-next:
>
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=582ed8d51e2b6cb8a168c94852bca482685c2509

Sorry, I'm just not comfortable with using EXPORT_SYMBOL_GPL() this
way.  I'm happy to use it when it has a technical justification, e.g.,
for internal interfaces where users of the interface are clearly
derived works.  But pci_iomap_wc() is not in that category, and I
think it should be symmetric with similar interfaces like pci_iomap()
and ioremap_wc().

I don't want to use EXPORT_SYMBOL_GPL() for a random collection of
things depending on the whim of the author.  That makes for a messy
environment to work in, and it's messy enough already.  If we wanted
to remove the EXPORT_SYMBOL/EXPORT_SYMBOL_GPL distinction completely,
that'd be fine with me, too.  But as long as we keep it, I think it
should mean something more than the preference of the author.

I know I did already ack this, and I even said I would merge it, but a
month of thinking about this hasn't made me more comfortable with it,
so I've changed my mind.  I said before that I wouldn't try to stop
you if you want to merge it some other way, but I don't want to ack
it, and I don't want to merge it via my tree.

Bjorn
