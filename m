Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48769 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbaFXQPh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jun 2014 12:15:37 -0400
Message-ID: <1403626435.4230.17.camel@weser.hi.pengutronix.de>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhu <r65037@freescale.com>, kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Date: Tue, 24 Jun 2014 18:13:55 +0200
In-Reply-To: <20140624153559.GA5741@dragon>
References: <20140624153559.GA5741@dragon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

Am Dienstag, den 24.06.2014, 23:36 +0800 schrieb Shawn Guo:
> Hi Lucas,
> 
> I found that imx6q suspend/resume is broken on 3.16-rc, and it works
> just fine if PCIe support is built out.  However the issue was not
> exposed on 3.15, so I suspect the PCIe driver change merged in 3.16
> is part of the cause.
> 
I don't yet see why any of the changes to the designware/imx6 host
driver would cause such failures.

Which board are you doing your testing on? What devices are connected to
the PCIe bus? In what way does it break system resume, complete hang?

Regards,
Lucas

> $ echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.002 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> sd 0:0:0:0: [sda] Stopping disk
> PM: suspend of devices complete after 85.695 msecs
> PM: suspend devices took 0.100 seconds
> PM: late suspend of devices complete after 6.786 msecs
> PM: noirq suspend of devices complete after 6.228 msecs
> Disabling non-boot CPUs ...
> CPU1: shutdown
> CPU2: shutdown
> CPU3: shutdown
> Enabling non-boot CPUs ...
> CPU1: Booted secondary processor
> CPU1 is up
> CPU2: Booted secondary processor
> CPU2 is up
> CPU3: Booted secondary processor
> CPU3 is up
> 
> The issue is actually with resume procedure.  I noticed that Richard
> added the following change in FSL kernel tree, which seems to fix the
> issue.
> 
> @@ -229,6 +232,22 @@ static int imx6_suspend_finish(unsigned long val)
> 
>  static int imx6_pm_enter(suspend_state_t state)
>  {
> +       struct regmap *gpr;
> +
> +       /*
> +        * L2 can exit by 'reset' or Inband beacon (from remote EP)
> +        * toggling phy_powerdown has same effect as 'inband beacon'
> +        * So, toggle bit18 of GPR1, to fix errata
> +        * "PCIe PCIe does not support L2 Power Down"
> +        */
> +       gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +       if (IS_ERR(gpr)) {
> +               pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
> +               return PTR_ERR(gpr);
> +       }
> +       regmap_update_bits(gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD,
> +                       IMX6Q_GPR1_PCIE_TEST_PD);
> +
>         switch (state) {
>         case PM_SUSPEND_STANDBY:
>                 imx6_set_lpm(STOP_POWER_ON);
> @@ -258,6 +277,15 @@ static int imx6_pm_enter(suspend_state_t state)
>                 return -EINVAL;
>         }
> 
> +       /*
> +        * L2 can exit by 'reset' or Inband beacon (from remote EP)
> +        * toggling phy_powerdown has same effect as 'inband beacon'
> +        * So, toggle bit18 of GPR1, to fix errata
> +        * "PCIe PCIe does not support L2 Power Down"
> +        */
> +       regmap_update_bits(gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD,
> +                       !IMX6Q_GPR1_PCIE_TEST_PD);
> +
>         return 0;
>  }
>  
> And I copied the details of the errata as below.
> 
> ERR005723 PCIe: PCIe does not support L2 power down
> 
> Description:
> When PCIe works as Root Complex, it can exit L2 mode only through reset.
> Since PCIe does not have a dedicated reset control bit, it cannot exit
> L2 mode.
> 
> Projected Impact:
> PCIe does not support L2 power down.
> 
> Workarounds:
> The PCIe can be put into PDDQ mode to save PCIe PHY power and wake up
> only by the OOB (Out of Band) wakeup signal (since wakeup by a beacon
> from link partner is not supported) driven from the link partner (End
> Point). This signal could be used as a GPIO interrupt to exit this mode.
> The limitation of this workaround is that the link partner cannot be put
> into L2 mode.
> 
> As I have no knowledge of how PCIe works, I provided all the info I
> found here to kick the discussion.  Hopefully, we can find a proper fix
> to get suspend/resume back to work.
> 
> Shawn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

