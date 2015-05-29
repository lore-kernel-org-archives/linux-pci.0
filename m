Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35513 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161065AbbE2TYj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2015 15:24:39 -0400
MIME-Version: 1.0
In-Reply-To: <5567FFB6.5050108@ti.com>
References: <1432163293-20965-1-git-send-email-mcgrof@do-not-panic.com>
 <1432163293-20965-2-git-send-email-mcgrof@do-not-panic.com>
 <20150521223321.GG32152@google.com> <20150522002341.GM23057@wotan.suse.de>
 <20150526174008.GN32152@google.com> <20150527200402.GS23057@wotan.suse.de>
 <CAB=NE6Xyd-THK2385W7VfS358PSJfkfHRnjoZRJWP_LFrzOWJA@mail.gmail.com> <5567FFB6.5050108@ti.com>
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Fri, 29 May 2015 12:24:17 -0700
Message-ID: <CAB=NE6X7ewg9TEJz+CWLq_PbxHYER3TEnUQ-nV87wDz6x3QjLA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] pci: add pci_iomap_wc() variants
To: Tomi Valkeinen <tomi.valkeinen@ti.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Juergen Gross <jgross@suse.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Suresh Siddha <sbsiddha@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@elte.hu>,
	X86 ML <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Davidlohr Bueso <dbueso@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Jan Beulich <jbeulich@suse.com>,
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 10:57 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
>
> On 29/05/15 03:36, Luis R. Rodriguez wrote:
>> On Wed, May 27, 2015 at 1:04 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>>> On Tue, May 26, 2015 at 12:40:08PM -0500, Bjorn Helgaas wrote:
>>>> On Fri, May 22, 2015 at 02:23:41AM +0200, Luis R. Rodriguez wrote:
>>>>> On Thu, May 21, 2015 at 05:33:21PM -0500, Bjorn Helgaas wrote:
>>>>>>
>>>>>> I tentatively put this (and the rest of the series) on a pci/resource
>>>>>> branch.  I'm hoping you'll propose some clarification about
>>>>>> EXPORT_SYMBOL_GPL().
>>>>>
>>>>> EXPORT_SYMBOL_GPL() also serves to ensure only GPL modules can
>>>>> only run that code. So for instance although we have "Dual BSD/GPL"
>>>>> tags for modules pure "BSD" tags do not exist for module tags and
>>>>> cannot run EXPORT_SYMBOL_GPL() code [0]. Also there is some folks
>>>>> who do believe tha at run time all kernel modules are GPL [1] [2].
>>>>> And to be precise even though the FSF may claim a list of licenses
>>>>> are GPL-compatible we cannot rely on this list alone for our own
>>>>> goals and if folks want to use our EXPORT_SYMBOL_GPL()s they must
>>>>> discuss this on lkml [2].
>>>>
>>>> By "propose some clarification," I meant that I hoped you would propose a
>>>> patch to Documentation/ that would give maintainers some guidance.
>>>
>>> I *really really* would hate to do so but only because you insist, I'll look
>>> into this...
>>
>> OK done. Please let me know if there is anything else I can do to
>> help. Also as per review with Tomi, the framebuffer maintainer, he
>> would prefer for only the required symbols to go through your tree.
>> We'd then wait for the next merge window for them to perculate to
>> Linus' tree and once there I'd send him a pull request for the
>> framebuffer device driver changes alone. So this does mean we'll have
>> no users of the symbols for a full release, but again, this is as per
>> Tomi's preference. This strategy is also the preference then for the
>> pci_iomap_wc() series as well. With that in mind, perhaps the lib
>> patch can go in as we'd have no users but we do have a few future
>> possible expected users.
>
> I don't have any issue with fbdev changes going through other trees, but
> I'd rather do that only if there are good reasons to go that way.

OK, either way I prefer to go with maintainer's preferences. Most
changes are for framebuffer drivers as that's where MTRR is used most
these days.

> These changes to fbdev drivers look like cleanups, so they are not
> critical, right?

I'll let you make the call, I'll just provide information to you. I
trust your judgement and what you prefer.

This and other series which change use of MTRR to arch_phys enable use
of PAT when available, we want to bury out MTRR from further usage so
all these arch_phys changes will help with that. MTRR, although
supported, should be seen as a first step temporary architectural
evolution to what PAT became. There are known architectural issue with
MTRR, let me list the issues for you to review and consider and
evaluate:

  * MTRR acts on physical addresses and requires power-of-two
alignment, on both the base used and size, this limits the flexibility
of MTRR use
  * MTRR is known to be unreliable, it can at times not work even on
modern systems
  * MTRRs are limited, if using a large number of devices MTRRs will
run out fast, its why Andy ended up adding the arch_phys APIs
  * PAT has been available for quite a long time, since Pentium III
(circa 1999) and newer, but having PAT enabled does not restrict use
of MTRR and because of this some systems may end up then combining
MTRR and PAT. I do not believe this wasn't an original highly expected
wide use situation, it technically should work to combine both but
there might be issues with interactions between both, exactly what
issues can exist or have existed remains quite unclear as MTRR in and
of itself has been known to be unreliable anyway. If possible its best
to just be binary about this and only use MTRR if and only if
necessary because of the other issues known with MTRR.

With all these changes being merged the only use case for MTRR then
would be through the arch_phys APIs, which would just enable use of
MTRR when PAT is not available or a system / driver is known to
require MTRR -- those systems are expected to low numbered, in the end
after all these series Linux will will end up with only two device
drivers which will require MTRR to be enabled always:

  * ipath: this device driver is old, powers the old HTX bus cards
that only work in AMD systems, while the newer IB/qib device driver
powers all PCI-e cards. The ipath device driver is obsolete, hardware
hard to find. In fact the maintainers of this driver have recently
even seriously discussed removing the driver from upstream altogether.
  * ivtv: the hardware is really rare these days, its expected only
some lost souls in some third world country are expected to be using
the feature which requires MTRR. The way this driver uses MTRR is also
quite questionable, but still has been present in the driver for a
long time.

These two device drivers can get PAT disabled by just using the kernel
parameter to disable PAT upon boot. The kernel log will tell them what
to do exactly.

Another use case for still using MTRR are cases where PAT is known to
have errata. We actually want to learn about those users who have
issues with PAT though. Last I heard about this was that the required
errata folks are aware of can be worked around by having PAT entry 0
and entry 4 both map to WB. hpa / andy might be able to elaborate if
needed, but we might even be able to preemptively already deal with
the errata issues for users.

Now let me explain the gains with all these changes being merged:

  * Although there are known PAT errata, we want to learn about those
issues and fix the issues
  * We have a long term goal to change the default behavior of
ioremap_nocache() and pci_mmap_page_range() to use PAT strong UC,
right now we cannot do this, but after all drivers are converted (all
these series I've been posting) we expect to be able to make the
change. Making a change to strong UC on these two calls can only
happen after a period of time of having Linux bake with all these
changes merged and in place. How many kernels we will want Linux baked
with all these transformations to arch_phys before making a change to
ioremap_nocache() and pci_mmap_page_range() is up to x86 folks. There
are other gains possible with this but I welcome others to chime in
here with what gains we can expect from this
  * Xen lacks support for MTRR upstream, but has full PAT support.
These changes will help enable use of the devices which exclusively
used MTRR to work on Xen with write combining moving forward

> Does delaying the fbdev changes until the dependencies are in prevent some other development?

Just the later work on putting the nail on the MTRR coffin, and
delaying the change of default  ioremap_nocache() and
pci_mmap_page_range() from UC- to strong UC. We ideally should want a
few kernel release with all the fbdev changes in place, not sure how
many we'd want, but the sooner we get folks testing kernels with that
the sooner we'd be able to evaluate doing a flip form UC- to strong
UC.

 Luis
