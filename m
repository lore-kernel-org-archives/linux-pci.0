Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Jul 2015 10:52:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>, bhelgaas@google.com
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, bp@suse.de,
	arnd@arndb.de, bhelgaas@google.com, luto@amacapital.net,
	akpm@linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com,
	mst@redhat.com, toshi.kani@hp.com, linux-fbdev@vger.kernel.org,
	xen-devel@lists.xensource.com, benh@kernel.crashing.org
Subject: Re: [PATCH v9 0/8] pci: add pci_iomap_wc() and pci_ioremap_wc_bar()
Message-ID: <20150721085252.GA15861@gmail.com>
References: <1436406859-1280-1-git-send-email-mcgrof@do-not-panic.com>
 <20150717202923.GC30479@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717202923.GC30479@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Luis R. Rodriguez <mcgrof@suse.com> wrote:

> On Wed, Jul 08, 2015 at 06:54:11PM -0700, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > Ingo,
> > 
> > Boris is on vacation, he picked up these patches on his bp#tip-mm tree [0]
> > and they have baked there for a while now. That tree receives 0-day
> > bot testing, but other than that its not clear what other tests were
> > run on these patches. Boris modified the commit logs a bit, and made one
> > optimizaiton to bail early on an PCI ioremap call when it should. These
> > patches have no modifications from what is on Boris' tree and tip-mm branch.
> > 
> > The 0 day build bot did find issues on Boris' tree but those are related
> > to ioremap_uc() (already upstream) and its first use on atyfb (not
> > upstream) -- I will be addressing a fix for that ioremap_uc() issue through
> > another patch series prior to posting the final set for atyfb which makes
> > use of ioremap_uc().
> > 
> > No issues have been found with this series. Benh did note some possible issues
> > with expectations with what is done for write-combining for PowerPC [1] but
> > the issue is a rather general long standing issue with semantics of ioremap --
> > in the case for ioremap_wc() on PowerPC benh notes that writel() will never
> > write-combine as it uses too heavy barriers. Benh notes that although
> > writel_relaxed() today is identical to writel() this can be changed. There are
> > other general semantics issues with ioremap() variant calls -- we seem to have
> > all gotten together to discuss all these issues on a thread where Dan Williams
> > is proposing to "unify ioremap prototypes and macro aliases" [1], folks
> > intersted on these issues or semantic concerns can drop in and chime there.
> > 
> > Let me know if these are OK or if there are any questions.
> > 
> > [0] http://lkml.kernel.org/r/20150625204703.GC4898@pd.tnic
> > [1] http://lkml.kernel.org/r/20150707095012.GQ7021@wotan.suse.de
> 
> Ingo,
> 
> Just a friendly reminder. Let me know if there are any issues or questions.

It would be nice to get an Acked-by from Bjorn for the PCI API bits.

Thanks,

	Ingo
