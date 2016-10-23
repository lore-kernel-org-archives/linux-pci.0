Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:42307 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755028AbcJWO5Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Oct 2016 10:57:24 -0400
Date: Sun, 23 Oct 2016 16:57:57 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_state hook
Message-ID: <20161023145757.GA4909@wunner.de>
References: <cover.1477221514.git.lukas@wunner.de>
 <7c1567d4c49303a4aada94ba16275cbf56b8976b.1477221514.git.lukas@wunner.de>
 <1477226275.2932.54.camel@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1477226275.2932.54.camel@nexus-software.ie>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 23, 2016 at 01:37:55PM +0100, Bryan O'Donoghue wrote:
> On Sun, 2016-10-23 at 13:55 +0200, Lukas Wunner wrote:
> > Commit cc7cc02bada8 ("PCI: Query platform firmware for device power
> > state") augmented struct pci_platform_pm_ops with a ->get_state hook
> > and
> > implemented it for acpi_pci_platform_pm, the only pci_platform_pm_ops
> > existing till v4.7.
> > 
> > However v4.8 introduced another pci_platform_pm_ops for Intel Mobile
> > Internet Devices with commit 5823d0893ec2 ("x86/platform/intel-mid:
> > Add
> > Power Management Unit driver").  It is missing the ->get_state hook,
> > which is fatal since pci_set_platform_pm() enforces its
> > presence.  Andy
> > Shevchenko reports that without the present commit, such a device
> > "crashes without even a character printed out on serial console and
> > reboots (since watchdog)".
> > 
> > Retrofit mid_pci_platform_pm with the missing callback to fix the
> > breakage.
> > 
> > Fixes: cc7cc02bada8 ("PCI: Query platform firmware for device power
> > state")
> > Cc: x86@kernel.org
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Acked-and-tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.c
> > om>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> > Changes v1 -> v2:
> > - Cast return value of intel_mid_pci_get_power_state() to
> >   (__force pci_power_t) to avoid "sparse -D__CHECK_ENDIAN__" warning.
> > - Add ack by Andy Shevchenko.
> > 
> > Changes v2 -> v3:
> > - Amend commit message to explain the user-visible failure mode as
> >   reported by Andy.
> > - Add ack by Bjorn Helgaas and Fixes tag.
> > 
> >  arch/x86/include/asm/intel-mid.h  |  1 +
> >  arch/x86/platform/intel-mid/pwr.c | 19 +++++++++++++++++++
> >  drivers/pci/pci-mid.c             |  6 ++++++
> >  3 files changed, 26 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/intel-mid.h
> > b/arch/x86/include/asm/intel-mid.h
> > index 5b6753d..49da9f4 100644
> > --- a/arch/x86/include/asm/intel-mid.h
> > +++ b/arch/x86/include/asm/intel-mid.h
> > @@ -17,6 +17,7 @@
> >  
> >  extern int intel_mid_pci_init(void);
> >  extern int intel_mid_pci_set_power_state(struct pci_dev *pdev,
> > pci_power_t state);
> > +extern pci_power_t intel_mid_pci_get_power_state(struct pci_dev
> > *pdev);
> >  
> >  extern void intel_mid_pwr_power_off(void);
> >  
> > diff --git a/arch/x86/platform/intel-mid/pwr.c
> > b/arch/x86/platform/intel-mid/pwr.c
> > index 5d3b45a..67375dd 100644
> > --- a/arch/x86/platform/intel-mid/pwr.c
> > +++ b/arch/x86/platform/intel-mid/pwr.c
> > @@ -272,6 +272,25 @@ int intel_mid_pci_set_power_state(struct pci_dev
> > *pdev, pci_power_t state)
> >  }
> >  EXPORT_SYMBOL_GPL(intel_mid_pci_set_power_state);
> >  
> > +pci_power_t intel_mid_pci_get_power_state(struct pci_dev *pdev)
> > +{
> > +	struct mid_pwr *pwr = midpwr;
> > +	int id, reg, bit;
> > +	u32 power;
> > +
> > +	if (!pwr || !pwr->available)
> > +		return PCI_UNKNOWN;
> > +
> > +	id = intel_mid_pwr_get_lss_id(pdev);
> > +	if (id < 0)
> > +		return PCI_UNKNOWN;
> > +
> > +	reg = (id * LSS_PWS_BITS) / 32;
> > +	bit = (id * LSS_PWS_BITS) % 32;
> > +	power = mid_pwr_get_state(pwr, reg);
> > +	return (__force pci_power_t)((power >> bit) & 3);
> > +}
> > +
> >  void intel_mid_pwr_power_off(void)
> >  {
> >  	struct mid_pwr *pwr = midpwr;
> > diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
> > index 55f453d..c7f3408 100644
> > --- a/drivers/pci/pci-mid.c
> > +++ b/drivers/pci/pci-mid.c
> > @@ -29,6 +29,11 @@ static int mid_pci_set_power_state(struct pci_dev
> > *pdev, pci_power_t state)
> >  	return intel_mid_pci_set_power_state(pdev, state);
> >  }
> >  
> > +static pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
> > +{
> > +	return intel_mid_pci_get_power_state(pdev);
> > +}
> > +
> >  static pci_power_t mid_pci_choose_state(struct pci_dev *pdev)
> >  {
> >  	return PCI_D3hot;
> > @@ -52,6 +57,7 @@ static bool mid_pci_need_resume(struct pci_dev
> > *dev)
> >  static struct pci_platform_pm_ops mid_pci_platform_pm = {
> >  	.is_manageable	= mid_pci_power_manageable,
> >  	.set_state	= mid_pci_set_power_state,
> > +	.get_state	= mid_pci_get_power_state,
> >  	.choose_state	= mid_pci_choose_state,
> >  	.sleep_wake	= mid_pci_sleep_wake,
> >  	.run_wake	= mid_pci_run_wake,
> 
> Shouldn't this serialize like this
> 
>       might_sleep();
> 
> 	reg = (id * LSS_PWS_BITS) / 32;
> 	bit = (id * LSS_PWS_BITS) % 32;
> 
>       mutex_lock(&pwr->lock);
>       power = mid_pwr_get_state(pwr, reg);
>       mutex_lock(&pwr->lock);
> 
> 	return (__force pci_power_t)((power >> bit) & 3);
> 
> there's a corresponding flow in mid_pwr_set_power_state() that operates
> in exactly that way.

mid_pwr_set_power_state() uses a series of steps (set the power state,
wait for completion) so presumably Andy thought this needs to be done
under a lock to prevent concurrent execution.

mid_pwr_get_state() on the other hand is just a register read, which
I assume is atomic.  The other stuff (calling intel_mid_pwr_get_lss_id(),
calculation of reg and bit) seems to be static, it never changes across
invocations.  Hence there doesn't seem to be a necessity to acquire
the mutex and call might_sleep().

That said I'm not really familiar with these devices and rely on Andy's
ack for correctness.  Andy if I'm mistaken please shout, otherwise I
assume the patch is correct.

The usage of a mutex in mid_pwr_set_power_state() actually seems
questionable since this is called with interrupts disabled:

pci_pm_resume_noirq
  pci_pm_default_resume_early
    pci_power_up
      platform_pci_set_power_state
        mid_pci_set_power_state
          intel_mid_pci_set_power_state
            mid_pwr_set_power_state

Thanks,

Lukas
