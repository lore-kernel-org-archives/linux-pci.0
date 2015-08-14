Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35236 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbbHNUR5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2015 16:17:57 -0400
Received: by igbjg10 with SMTP id jg10so19660207igb.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2015 13:17:56 -0700 (PDT)
Date: Fri, 14 Aug 2015 15:17:52 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Zhang Rui <rui.zhang@intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	chuansheng.liu@intel.com, Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>, MyMailClone@t-online.de,
	mister.freeman@laposte.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
Message-ID: <20150814201752.GG26431@google.com>
References: <1438047747.1856.12.camel@rzhang1-mobl4>
 <20150728175848.GI5322@mtj.duckdns.org>
 <1438133951.1856.23.camel@rzhang1-mobl4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438133951.1856.23.camel@rzhang1-mobl4>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Zhang,

On Wed, Jul 29, 2015 at 09:39:11AM +0800, Zhang Rui wrote:
> From c6b063b2874b62466362a10b53097216b16e400d Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Sun, 26 Jul 2015 14:15:36 +0800
> Subject: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
> 
> In https://bugzilla.kernel.org/show_bug.cgi?id=81551,
> we found that Jmicron chip 361/363 is broken after resume if async noirq
> (76569faa62 (PM / sleep: Asynchronous threads for resume_noirq)) is supported,
> thus commit e6b7e41cdd (ata: Disabling the async PM for JMicron chip 363/361)
> is introduced to fix this problem.
> But then, we found that Jmicron chip 368 also has this problem, and it is decided
> to disable the pm async feature for all the Jmicron chips.
> 
> But how to fix this was discussed in the mailing list for some time.
> After some investigation, we believe that a proper fix is to disable
> the async PM in PCI instead of ata driver, because, on this platform,
> pci_resume_noirq() of IDE controller must happen after pci_resume_noirq()
> of AHCI controller. But as .resume_noirq() of the pata_jmicron driver is
> no-op, this suggests that it is the PCI common actions, aka,
> pci_pm_default_resume_early(), have the dependency.
> To fix this, using device_pm_wait_for_dev() in pata_jmicron driver can not
> solve the dependency because pci_pm_default_resume_early() is invoked before
> driver callback being invoked, plus, as it is the PCI common actions that
> have the dependency, it is reasonable to fix it in PCI bus code,
> rather than driver code.
> 
> This patch is made based on the patch from Liu Chuansheng at
> https://lkml.org/lkml/2014/12/5/74
> it reverts commit e6b7e41cdd ("ata: Disabling the async PM for JMicron
> chip 363/361"), and introduces a PCI quirk to disable async PM for Jmicron
> chips.

This changelog has a lot of text, but doesn't tell me what I really
want to know.

We need to know what the problem is from the *device* point of view,
not in terms of kernel function names.  Function names are only
meaningful to a handful of experts, but a concrete problem description
may be useful to hardware designers and firmware writers who can
potentially fix the root issue.

In this case, I think the problem is something like: "on these
multi-function JMicron devices, the PATA controller at function 1
doesn't work if it is powered on before the SATA controller at
function 0."

It's also helpful to include a symptom to help people connect a
problem with the solution.  For example, the 81551 bug reports says
these are symptoms:

  pata_jmicron 0000:02:00.1: Refused to change power state, currently in D3
  irq 17: nobody cared (try booting with the "irqpoll" option)

This patch doesn't change the workaround: we still use
device_disable_async_suspend() on these devices.  This patch merely:

  1) Changes the workaround so instead of doing this only for 361 and
  363 devices, we turn off async suspend on *all* JMicron devices, and

  2) Moves the workaround from the AHCI and PATA drivers to the PCI
  core.

For 1), I think it is probably overkill to penalize all JMicron
devices.  There's no reason to think NICs and SD/MMC/etc controllers
have the same issue.  Or if there *is* reason to think that, you
should give evidence for it.

For 2), you have not made a convincing argument for why the workaround
needs to be in the PCI core.  Such an argument would be of the form
"we need this quirk even if the driver hasn't been loaded yet
because ..."

Since you didn't say anything like that, I assume the patch in comment
#72 of bug #81551 (https://bugzilla.kernel.org/attachment.cgi?id=156301)
would work as well.  That has the advantage that it wouldn't penalize
non-storage controllers.

Other minor nits:

- The function "pci_resume_noirq()" does not exist.  I assume you meant
  pci_pm_resume_noirq().  And as I mentioned earlier, I don't think the
  name is relevant in the changelog anyway.

- You have a mix of SHA1 lengths and summary quoting above.  Please use
  the conventional commit reference style (with 12-char SHA-1)
  consistently, e.g.,

    76569faa62c4 ("PM / sleep: Asynchronous threads for resume_noirq")

- Please use http://lkml.kernel.org/r/... references when possible,
  not https://lkml.org/....

> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=81511
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=81551
> Reviewed-by: Aaron Lu <aaron.lu@intel.com>
> Acked-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/ata/ahci.c         | 12 ------------
>  drivers/ata/pata_jmicron.c | 12 ------------
>  drivers/pci/quirks.c       | 17 +++++++++++++++++
>  3 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 7e62751..26bb40d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1451,18 +1451,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	else if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
>  		ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
>  
> -	/*
> -	 * The JMicron chip 361/363 contains one SATA controller and one
> -	 * PATA controller,for powering on these both controllers, we must
> -	 * follow the sequence one by one, otherwise one of them can not be
> -	 * powered on successfully, so here we disable the async suspend
> -	 * method for these chips.
> -	 */
> -	if (pdev->vendor == PCI_VENDOR_ID_JMICRON &&
> -		(pdev->device == PCI_DEVICE_ID_JMICRON_JMB363 ||
> -		pdev->device == PCI_DEVICE_ID_JMICRON_JMB361))
> -		device_disable_async_suspend(&pdev->dev);
> -
>  	/* acquire resources */
>  	rc = pcim_enable_device(pdev);
>  	if (rc)
> diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
> index 47e418b..4d1a5d2 100644
> --- a/drivers/ata/pata_jmicron.c
> +++ b/drivers/ata/pata_jmicron.c
> @@ -143,18 +143,6 @@ static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *i
>  	};
>  	const struct ata_port_info *ppi[] = { &info, NULL };
>  
> -	/*
> -	 * The JMicron chip 361/363 contains one SATA controller and one
> -	 * PATA controller,for powering on these both controllers, we must
> -	 * follow the sequence one by one, otherwise one of them can not be
> -	 * powered on successfully, so here we disable the async suspend
> -	 * method for these chips.
> -	 */
> -	if (pdev->vendor == PCI_VENDOR_ID_JMICRON &&
> -		(pdev->device == PCI_DEVICE_ID_JMICRON_JMB363 ||
> -		pdev->device == PCI_DEVICE_ID_JMICRON_JMB361))
> -		device_disable_async_suspend(&pdev->dev);
> -
>  	return ata_pci_bmdma_init_one(pdev, ppi, &jmicron_sht, NULL, 0);
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e9fd0e9..02803f8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -29,6 +29,23 @@
>  #include "pci.h"
>  
>  /*
> + * For JMicron chips, we need to disable the async_suspend method, otherwise
> + * they will hit the power-on issue when doing device resume, add one quick
> + * solution to disable the async_suspend method.
> + *
> + * https://bugzilla.kernel.org/show_bug.cgi?id=81551
> + */
> +static void pci_async_suspend_fixup(struct pci_dev *pdev)
> +{
> +	/*
> +	 * disabling the async_suspend method for JMicron chips to
> +	 * avoid device resuming issue.
> +	 */
> +	device_disable_async_suspend(&pdev->dev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, pci_async_suspend_fixup);
> +
> +/*
>   * Decoding should be disabled for a PCI device during BAR sizing to avoid
>   * conflict. But doing so may cause problems on host bridge and perhaps other
>   * key system devices. For devices that need to have mmio decoding always-on,
> -- 
> 1.9.1
> 
> 
> 
