Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Mon, 28 Nov 2016 12:29:14 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
Message-ID: <20161128112914.GA4194@wunner.de>
References: <c2b767a782f9a0e1780e5c201d245d1be5b7d78a.1476011255.git.lukas@wunner.de>
 <1476021678.11323.352.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1476021678.11323.352.camel@linux.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 09, 2016 at 05:01:18PM +0300, Andy Shevchenko wrote:
> On Sun, 2016-10-09 at 13:12 +0200, Lukas Wunner wrote:
> > -.data          56
> > +.data           0
> > -.rodata        32
> > +.rodata        88
> > 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Bjorn,

it seems this patch wasn't applied to one of your branches.
Would you prefer this to go in via tip.git, like we did
with the other two intel-mid patches I submitted?  If so,
could you ack this patch?  I'd then resend with your ack
and cc: the x86 maintainers.

Thanks,

Lukas

> 
> > ---
> >  drivers/pci/pci-mid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
> > index a8b52dc..566ded1 100644
> > --- a/drivers/pci/pci-mid.c
> > +++ b/drivers/pci/pci-mid.c
> > @@ -54,7 +54,7 @@ static bool mid_pci_need_resume(struct pci_dev *dev)
> >  	return false;
> >  }
> >  
> > -static struct pci_platform_pm_ops mid_pci_platform_pm = {
> > +static const struct pci_platform_pm_ops mid_pci_platform_pm = {
> >  	.is_manageable	= mid_pci_power_manageable,
> >  	.set_state	= mid_pci_set_power_state,
> >  	.get_state	= mid_pci_get_power_state,
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
