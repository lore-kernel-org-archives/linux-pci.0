Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44369 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbcFNN6J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jun 2016 09:58:09 -0400
Message-ID: <1465912766.30123.55.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/1] x86/platform/intel-mid: Add Power Management
 Unit driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	David Cohen <david.a.cohen@linux.intel.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 14 Jun 2016 16:59:26 +0300
In-Reply-To: <20160614104355.GC13439@gmail.com>
References: <1465849087-54528-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160614104355.GC13439@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-06-14 at 12:43 +0200, Ingo Molnar wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Add Power Management Unit driver to handle power states of South
> > Complex
> > devices on Intel Tangier. In the future it might be expanded to
> > cover North
> > Complex devices as well.
> > 
> > With this driver the power state of the host controllers such as
> > SPI, I2C,
> > UART, eMMC, and DMA would be managed.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/include/asm/intel-mid.h     |   8 +
> >  arch/x86/pci/intel_mid_pci.c         |  35 +++-
> >  arch/x86/platform/intel-mid/Makefile |   2 +-
> >  arch/x86/platform/intel-mid/pmu.c    | 392
> > +++++++++++++++++++++++++++++++++++
> >  drivers/pci/Makefile                 |   3 +
> >  drivers/pci/pci-mid.c                |  77 +++++++
> >  6 files changed, 515 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/x86/platform/intel-mid/pmu.c
> >  create mode 100644 drivers/pci/pci-mid.c
> 
> So this collides with perf's 'PMU' naming massively. Can we pick
> another name 
> before hillarious kernel-wide confusion spreads?
> 
> how about intel/mid/pm.c plus renaming all the pmu* internal names to
> pm*?
> 
> We could call it 'power management interface', and in a single line
> mention that 
> this is also a 'Power Management Unit' in Intel-speak?

In the TRM it's called Power Management Unit, though once or twice in
some documents as Power Management Controller. I actually woudn't like
to use PMC abbreviation to not be confused with pmc_atom.c and many
other variation of existing PMC drivers of other Intel platforms.

PM* as a prefix might be too short to conflict with Power Management
framework in the kernel. P-Unit (punit*) is existing part in SoC which
will have its own driver in the future, so, can't use it either.

pwr*, pwrmu*, scpmu* (as of South Complex Power Management Unit) — one
of them?

> 
> >  extern int intel_mid_pci_init(void);
> > +int intel_mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t
> > state);
> > +
> > +#define INTEL_MID_PMU_LSS_OFFSET	4
> > +#define INTEL_MID_PMU_LSS_TYPE		(1 << 7)
> > +
> > +int intel_mid_pmu_get_lss_id(struct pci_dev *pdev);
> 
> Yeah, so please be consistent about 'extern'.

Ok.

> 
> Also, I had a look at the resulting arch/x86/include/asm/intel-mid.h
> and the 
> vertical alignments are all over the map.
> 
> Here is how it looks like:
> 
> #define FSB_FREQ_83SKU  83200
> #define FSB_FREQ_100SKU 99840
> #define FSB_FREQ_133SKU 133000
> 
> #define FSB_FREQ_167SKU 167000
> #define FSB_FREQ_200SKU 200000
> #define FSB_FREQ_267SKU 267000
> #define FSB_FREQ_333SKU 333000
> #define FSB_FREQ_400SKU 400000
> 
> /* Bus Select SoC Fuse value */
> #define BSEL_SOC_FUSE_MASK      0x7
> #define BSEL_SOC_FUSE_001       0x1 /* FSB 133MHz */
> #define BSEL_SOC_FUSE_101       0x5 /* FSB 100MHz */
> #define BSEL_SOC_FUSE_111       0x7 /* FSB 83MHz */
> 
> #define SFI_MTMR_MAX_NUM 8
> #define SFI_MRTC_MAX    8
> 
> Can we please improve that?

Sure, I can cook a separate patch.

> 
> > +
> > +static void mrst_power_off_unused_dev(struct pci_dev *dev)
> > +{
> > +	mid_power_off_dev(dev);
> > +}
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0801,
> > mrst_power_off_unused_dev);
> 
> So we add mrst_power_off_unused_dev() just to make it to
> mid_power_off_dev()?

For now. Perhaps I can just rename and extend current function. What do
you prefer?

> 
> Also, newlines ran out when the above bit was written.

Got it.

> 
> > +++ b/arch/x86/platform/intel-mid/pmu.c
> > @@ -0,0 +1,392 @@
> > +/*
> > + * Intel MID Power Management Unit device driver
> 
> Could we please write a bit longer description about what this driver
> does, what 
> interfaces/capabilities it enables, etc.? People like the warm fuzzy
> feeling 
> associated with knowing what's going on.

I will add a few lines to describe it.

> 
> > +#include <linux/delay.h>
> > +#include <linux/errno.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pci.h>
> > +#include <linux/types.h>
> 
> Was that types.h include really needed?

I played with bitmaps earlier, looks like leftover.

> 
> > +/* Registers */
> > +#define PM_STS		0x00
> > +#define PM_CMD		0x04
> > +#define PM_ICS		0x08
> > +#define PM_WKC(x)	(0x10 + (x) * 4)
> > +#define PM_WKS(x)	(0x18 + (x) * 4)
> > +#define PM_SSC(x)	(0x20 + (x) * 4)
> > +#define PM_SSS(x)	(0x30 + (x) * 4)
> > +
> > +/* Bits in PM_STS */
> > +#define PM_STS_BUSY		(1 << 8)
> > +
> > +/* Bits in PM_CMD */
> > +#define PM_CMD_CMD(x)		((x) << 0)
> > +#define PM_CMD_IOC		(1 << 8)
> > +#define PM_CMD_D3cold		(1 << 21)
> > +
> > +/* List of commands */
> > +#define CMD_SET_CFG		0x01
> > +
> > +/* Bits in PM_ICS */
> > +#define PM_ICS_INT_STATUS(x)	((x) & 0xff)
> > +#define PM_ICS_IE		(1 << 8)
> > +#define PM_ICS_IP		(1 << 9)
> > +#define PM_ICS_SW_INT_STS	(1 << 10)
> > +
> > +/* List of interrupts */
> > +#define INT_INVALID		0
> > +#define INT_CMD_COMPLETE	1
> > +#define INT_CMD_ERR		2
> > +#define INT_WAKE_EVENT		3
> > +#define INT_LSS_POWER_ERR	4
> > +#define INT_S0iX_MSG_ERR	5
> > +#define INT_NO_C6		6
> > +#define INT_TRIGGER_ERR		7
> > +#define INT_INACTIVITY		8
> > +
> > +/* South Complex devices */
> > +#define LSS_MAX_SHARED_DEVS		4
> > +#define LSS_MAX_DEVS			64
> > +
> > +#define LSS_WS_BITS			1	/* wake state
> > width */
> > +#define LSS_PWS_BITS			2	/* power state
> > width */
> > +
> > +/* Supported device IDs */
> > +#define PCI_DEVICE_ID_TANGIER		0x11a1
> 
> Again essentially randomized vertical alignment. Is anyone supposed to
> read this 
> code?

Anyone who wants to read it.

> 
> > +	/* Find device in cache or first free cell */
> > +	for (j = 0; j < LSS_MAX_SHARED_DEVS; j++)
> > +		if (lss[j].pdev == pdev || !lss[j].pdev)
> > +			break;
> 
> ... missing curly braces. That's a problem in other places as well,
> please fix all 
> of them.

Will do.

> 
> > +static int tng_set_initial_state(struct mid_pmu *pmu)
> > +{
> > +	unsigned int i, j;
> > +	int ret;
> > +
> > +	/* Enable wake events */
> > +	mid_pmu_set_wake(pmu, 0, 0xffffffff);
> > +	mid_pmu_set_wake(pmu, 1, 0xffffffff);
> > +
> > +	/* Power off unused devices */
> > +	mid_pmu_set_state(pmu, 0, 0xffffffff);
> > +	mid_pmu_set_state(pmu, 1, 0xffffffff);
> > +	mid_pmu_set_state(pmu, 2, 0xffffffff);
> > +	mid_pmu_set_state(pmu, 3, 0xffffffff);
> 
> What are these magic numbers of 0/1/2/3?

This is a map of 64 devices with 2 bits per each on 32-bit HW registers.
The mapping itself is provided by platform using vendor capability of
PCI configuration space. So, here is just a counter variable. No magic.
And I can't do more than already done in the register definition.

Should I put a comment here and at the top of the file about these bits
/ registers? 

> 
> > +static struct pci_driver mid_pmu_pci_driver = {
> > +	.name		= "intel_mid_pmu",
> > +	.probe		= mid_pmu_probe,
> > +	.id_table	= mid_pmu_pci_ids,
> > +};
> 
> This structure initialization has a nice vertical layout.
> 
> > +static struct pci_platform_pm_ops mid_pci_platform_pm = {
> > +	.is_manageable = mid_pci_power_manageable,
> > +	.set_state = mid_pci_set_power_state,
> > +	.choose_state = mid_pci_choose_state,
> > +	.sleep_wake = mid_pci_sleep_wake,
> > +	.run_wake = mid_pci_run_wake,
> > +	.need_resume = mid_pci_need_resume,
> > +};
> 
> This one, not so much.

Will fix this one.

Thank you for review!

-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
