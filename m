Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1477239952.25812.11.camel@nexus-software.ie>
Subject: Re: [PATCH v3 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_state hook
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
To: Lukas Wunner <lukas@wunner.de>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Sun, 23 Oct 2016 17:25:52 +0100
In-Reply-To: <20161023145757.GA4909@wunner.de>
References: <cover.1477221514.git.lukas@wunner.de>
         <7c1567d4c49303a4aada94ba16275cbf56b8976b.1477221514.git.lukas@wunner.de>
         <1477226275.2932.54.camel@nexus-software.ie>
         <20161023145757.GA4909@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2016-10-23 at 16:57 +0200, Lukas Wunner wrote:
> On Sun, Oct 23, 2016 at 01:37:55PM +0100, Bryan O'Donoghue wrote:
> > 
> The usage of a mutex in mid_pwr_set_power_state() actually seems
> questionable since this is called with interrupts disabled:

> pci_pm_resume_noirq
>   pci_pm_default_resume_early
>     pci_power_up
>       platform_pci_set_power_state
>         mid_pci_set_power_state
>           intel_mid_pci_set_power_state
>             mid_pwr_set_power_state


That was my other question then - though I assume the mutex is put in
place to future-proof the code.

I'm just wondering out loud - considering we have the case where we update a register and then spin waiting for a command completion - is it in fact logically valid to have a concurrent reader read out the power state - when another writer is executing mid_pwr_wait() - for example.

/* Wait 500ms that the latest PWRMU command finished */
static int mid_pwr_wait(struct mid_pwr *pwr)
{
        unsigned int count = 500000;
        bool busy;

        do {
                busy = mid_pwr_is_busy(pwr);
                if (!busy)
                        return 0;
                udelay(1);
        } while (--count);

        return -EBUSY;
}

static int mid_pwr_wait_for_cmd(struct mid_pwr *pwr, u8 cmd)
{
        writel(PM_CMD_CMD(cmd) | PM_CMD_CM_IMMEDIATE, pwr->regs +
PM_CMD);
        return mid_pwr_wait(pwr);
}

static int __update_power_state(struct mid_pwr *pwr, int reg, int bit,
int new)
{

<snip>
        /* Update the power state */
        mid_pwr_set_state(pwr, reg, (power & ~(3 << bit)) | (new <<
bit));

        /* Send command to SCU */
        ret = mid_pwr_wait_for_cmd(pwr, CMD_SET_CFG);
        if (ret)
                return ret;
<snip>
}

anyway...

I've tested your patch and it looks good. We can otherwise defer to
andy on the usage of the mutex.

Tested-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>

---
bod
