Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36548 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbbAOX4E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jan 2015 18:56:04 -0500
Received: by mail-oi0-f51.google.com with SMTP id h136so14981060oig.10
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2015 15:56:02 -0800 (PST)
Date: Thu, 15 Jan 2015 17:55:59 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Wilmer van der Gaast <kernel@wilmer.gaast.net>,
	Zhang Rui <rui.zhang@intel.com>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI: keep enable status consistent for device without
 driver
Message-ID: <20150115235559.GC29776@google.com>
References: <1421300208-7087-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421300208-7087-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, Pavel, linux-pm]

On Wed, Jan 14, 2015 at 09:36:48PM -0800, Yinghai Lu wrote:
> Wilmer reported continuous suspend/resume does not work after
> commit 928bea964827 ("PCI: Delay enabling bridges until they're needed").
> 
> For pci bridge without driver, FW enable it already.
> In pci_pm_resume/pci_pm_reenable_device after first resume
> will not reenable the device, aka the status is not the same
> as that before first suspend.
> 
> Try to update enable status according to register value before
> calling pci_reenable_device, so we will not miss those pm
> operation calling for next suspend/resume.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=86421
> Fixes: 928bea964827 ("PCI: Delay enabling bridges until they're needed")
> Reported-by: Wilmer van der Gaast <kernel@wilmer.gaast.net>
> Bisected-by: Wilmer van der Gaast <kernel@wilmer.gaast.net>
> Tested-by: Wilmer van der Gaast <kernel@wilmer.gaast.net>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> CC: stable@vger.kernel.org  # v3.10+

928bea964827 appeared in v3.12.  Did you mean v3.12+ instead of v3.10+?

I'd really like to get Rafael and Pavel to take a look at this.

> ---
>  drivers/pci/pci-driver.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Index: linux-2.6/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci-driver.c
> +++ linux-2.6/drivers/pci/pci-driver.c
> @@ -519,8 +519,17 @@ static void pci_pm_set_unknown_state(str
>   */
>  static int pci_pm_reenable_device(struct pci_dev *pci_dev)
>  {
> +	u16 cmd;
>  	int retval;
>  
> +	/* update enable_cnt according to cmd register */
> +	pci_read_config_word(pci_dev, PCI_COMMAND, &cmd);
> +	if (!pci_dev->is_busmaster && (cmd & PCI_COMMAND_MASTER))
> +		pci_dev->is_busmaster = true;


> +	if (!pci_is_enabled(pci_dev) &&
> +	    (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)))
> +		atomic_inc(&pci_dev->enable_cnt);

This doesn't feel right because we're handling enable_cnt differently here
than we do on initial boot.

On initial boot, I don't think we set enable_cnt based on whether firmware
left the IO or MEMORY bits set in the command register.  Why should we
modify enable_cnt based on the command register during resume?

I could certainly believe we should do something during initial boot, too.
It just seems like we should look at the command register in both places or
neither place.

I have the same question about is_busmaster above.

> +
>  	/* if the device was enabled before suspend, reenable */
>  	retval = pci_reenable_device(pci_dev);
>  	/*
