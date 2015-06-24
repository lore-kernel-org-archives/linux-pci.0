Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1435183509.3790.14.camel@kernel.crashing.org>
References: <1434751712-24333-1-git-send-email-mcgrof@do-not-panic.com>
 <1434751712-24333-6-git-send-email-mcgrof@do-not-panic.com>
 <1435099343.3996.13.camel@kernel.crashing.org> <20150624163821.GF11147@wotan.suse.de>
 <1435183509.3790.14.camel@kernel.crashing.org>
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 24 Jun 2015 15:29:22 -0700
Message-ID: <CAB=NE6X0ySW=1udE3LCbo_eCjMfdrOMrceGsPvBZbDW+N-pLTw@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] PCI: Add pci_iomap_wc() variants
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Juergen Gross <jgross@suse.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 3:05 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2015-06-24 at 18:38 +0200, Luis R. Rodriguez wrote:
>> On Wed, Jun 24, 2015 at 08:42:23AM +1000, Benjamin Herrenschmidt wrote:
>> > On Fri, 2015-06-19 at 15:08 -0700, Luis R. Rodriguez wrote:
>> > > From: "Luis R. Rodriguez" <mcgrof@suse.com>
>> > >
>> > > PCI BARs tell us whether prefetching is safe, but they don't say anything
>> > > about write combining (WC).  WC changes ordering rules and allows writes to
>> > > be collapsed, so it's not safe in general to use it on a prefetchable
>> > > region.
>> >
>> > Well, the PCIe spec at least specifies that a prefetchable BAR also
>> > tolerates write merging...
>>
>> How can that be determined and can that be used as a full bullet proof hint
>> to enable wc ? And are you sure? :)
>
> Well, I"m sure the spec says that ;-) But it could be new to PCIe, I
> haven't checked legacy PCI.

OK cool so to be clear from what I gather you are suggesting (or not
and letting me make it) is that we might be able to enforce
write-merging on prefetchable areas, and if we can *ensure* we do this
then automatically enable write-combining behind the scenes?

>> Reason all this was stated was to be
>> apologetic over why we can't automate this behind the scenes. Otherwise
>> we could amend what you stated into the commit log to elaborate on our
>> technical apology. Let me know!
>
> At least on powerpc, for mmap of resource to userspace, we take off the
> garded bit in the PTE for prefetchable BARs. This has the effect
> architecturally of enabling both prefetch and write combine (ie. side
> effect)

That's pretty darn sexy.

> though afaik, the implementations probably don't actually
> prefetch. We've done that for years.

Neat!

> In fact we don't have a way to split the notions, it's either G or no G,
> which carries both meanings.

Interesting.

> Do you have example/case of a device having problems ?

Nope but at least what made me squint at this being a possible
"feature" was that in practice when reviewing all of the kernels
pending device drivers using MTRR (potential write-combine candidates)
I encountered a slew of them which had the architectural unfortunate
practice of combining PCI bars for MMIO and their respective
write-combined desirable area (framebuffer for video, PIO buffers for
infiniband, etc). Now, to me that read more as a practice for old
school devices when such things were likely still being evaluated,
more modern devices seem to adhere to sticking a full PCI bar with
write-combining or not. Did you not encounter such mismatch splits on
powerpc ? Was such possibility addressed?

If what you are implying here is applicable to the x86 world I'm all
for enabling this as we'd have less code to maintain but I'll note
that getting a clarification alone on that prefetchable !=
write-combining was in and of itself hard, I'd be surprised if we
could get full architectural buy-in to this as an immediate automatic
feature. Because of this and because PAT did have some errata as well,
I would not be surprised if some PCI bridges / devices would end up
finding corner cases, as such if we can really do what you're saying
and unless we can get some super sane certainty over it across the
board, I'd be inclined to leave such things as a part of a new API.
Maybe have some folks test using the new API for all calls and after
some sanity of testing / releases consider a full switch.

That is, unless of course you're sure all this is sane and would wager
all-in on it from the get-go.

 Luis
