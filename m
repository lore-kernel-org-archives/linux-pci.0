Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Mon, 28 Nov 2016 23:38:59 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
Message-ID: <20161128223859.GA4571@wunner.de>
References: <c2b767a782f9a0e1780e5c201d245d1be5b7d78a.1476011255.git.lukas@wunner.de>
 <20161128192530.GO16033@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161128192530.GO16033@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 28, 2016 at 01:25:30PM -0600, Bjorn Helgaas wrote:
> On Sun, Oct 09, 2016 at 01:12:55PM +0200, Lukas Wunner wrote:
> > -.data          56
> > +.data           0
> > -.rodata        32
> > +.rodata        88
> > 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> It'd be nice if this had a changelog.  I'm happy if this goes via the
> x86 tree.

Thanks, I'll resend with your ack.

As for the changelog, to be honest I can't think of much more to write
there.  One important motivation of constifying structs that are never
modified, and particularly structs containing function pointers like
this one, is to prevent their modification and subsequent usage by an
attacker.  However constification patches are submitted all the
time by Julia Lawall and others, and I've never seen this rationale
spelled out in a commit message, so the assumption seems to be that
it's common knowledge.  I could probably add something like

	Size of pci-mid.o ELF sections:

to clarify what the numbers in the changelog refer to.

Best regards,

Lukas

> I can't remember a discussion about having this code in drivers/pci in
> the first place.  Would it make sense to move it to
> arch/x86/platform/intel-mid/?
> 
> 8e522e1d321b ("x86/platform/intel-mid: Add Intel Penwell to ID table")
> fixed a sync issue and added a comment about staying in sync with
> arch/x86/platform/intel-mid/pwr.c.  Maybe moving this code to arch/x86
> would help with that?
> 
> Looks like we'd have to expose pci_platform_pm_ops and
> pci_set_platform_pm(), but setting platform-specific PM ops does seem
> like something that would fit in the arch directories, so maybe that
> wouldn't be a bad thing.
> 
> > ---
> >  drivers/pci/pci-mid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
> > index a8b52dc..566ded1 100644
> > --- a/drivers/pci/pci-mid.c
> > +++ b/drivers/pci/pci-mid.c
> > @@ -54,7 +54,7 @@ static bool mid_pci_need_resume(struct pci_dev *dev)
> >  	return false;
> >  }
> >  
> > -static struct pci_platform_pm_ops mid_pci_platform_pm = {
> > +static const struct pci_platform_pm_ops mid_pci_platform_pm = {
> >  	.is_manageable	= mid_pci_power_manageable,
> >  	.set_state	= mid_pci_set_power_state,
> >  	.get_state	= mid_pci_get_power_state,
> > -- 
> > 2.9.3
