Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42921 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756334AbbFPTFH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 16 Jun 2015 15:05:07 -0400
Date: Tue, 16 Jun 2015 21:05:04 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Borislav Petkov <bp@suse.de>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	Andy Lutomirski <luto@amacapital.net>,
	linux-pci@vger.kernel.org
Subject: Re: [Cocci] [PATCH v3 0/4] pci: add and use pci_ioremap_wc_bar()
Message-ID: <20150616190504.GH11147@wotan.suse.de>
References: <1429647634-17169-1-git-send-email-mcgrof@do-not-panic.com>
 <CAB=NE6VYvd-Au58QRJprCquuvJkY9NYe1x8FmbW7qAhVrVE=QQ@mail.gmail.com>
 <20150519175310.GH23057@wotan.suse.de>
 <CAB=NE6UsMMoPhkKof+VN7ZUCd81VxrwP9nqHDUj5Lr3DJLm3bA@mail.gmail.com>
 <CAB=NE6UdW2d6zO1hYbTnPcoZWt8+Yg5KdWE_bdqAuR_ysey_+A@mail.gmail.com>
 <557FCD1A.4020105@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <557FCD1A.4020105@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 16, 2015 at 10:15:38AM +0300, Tomi Valkeinen wrote:
> On 22/05/15 00:23, Luis R. Rodriguez wrote:
> > On Wed, May 20, 2015 at 1:54 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> >> On Tue, May 19, 2015 at 10:53 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> >>> On Wed, Apr 29, 2015 at 02:08:47PM -0700, Luis R. Rodriguez wrote:
> >>>> On Tue, Apr 21, 2015 at 1:20 PM, Luis R. Rodriguez
> >>>> <mcgrof@do-not-panic.com> wrote:
> >>>>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >>>>>
> >>>>> This series adds pci_ioremap_wc_bar() and makes use of it
> >>>>> on a few framebuffer device drivers.
> >>>>>
> >>>>> Luis R. Rodriguez (4):
> >>>>>   pci: add pci_ioremap_wc_bar()
> >>>>>   video: fbdev: i740fb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
> >>>>>   video: fbdev: kyrofb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
> >>>>>   video: fbdev: gxt4500: use pci_ioremap_wc_bar() for framebuffer
> >>>>
> >>>> Bjorn,
> >>>>
> >>>> any feedback on this series?
> >>>
> >>> Hey Bjorn, any feedback on this series ?
> >>
> >> I meant this series. Also Tomi, do I get your Acks for these as well?
> >> Since they depend on pci parts do you mind if we route them through
> >> the PCI tree? I'll poke you soon about another similar type of patch
> >> which has dependencies on another development tree.
> > 
> > Bjorn, Tomi, please let me know if this series is OK, if so I'll
> > resubmit rebased onto Bjorn's pci tree.
> 
> For the fbdev patches:
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks Tomi,

there are two fbdev series that depend on PCI symbols I am introducing, this
series and the pci_iomap_wc() series [0]. You've now provided Acks for the fbdev
part of both series.

Can the fbdev parts go through Bjorn's tree? We last discussed if the series
was important to be fully merged or not by v4.2 and I recentlty provided a
long winded review of the entire series to help maintainers pick and choose
and decide [1].

Based on this can the fbdev patches from both of these series go through Bjorn's tree?
Another alternative that seems to be practiced for situations like this is for
most of the merge window to trickle in and then towards the end send dependent
API changes such as this one, but I think that would then have to go through
your tree and since I realize you are busy I am not sure if this would work
well to get this in, in time for v4.2.

[0] http://lkml.kernel.org/r/1430415364-19679-1-git-send-email-mcgrof@do-not-panic.com
[1] http://lkml.kernel.org/r/CAB=NE6UgtdSoBsA=8+ueYRAZHDnWUSmQAoHhAaefqudBrSY7Zw@mail.gmail.com

 Luis
