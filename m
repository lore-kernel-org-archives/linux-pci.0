Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 3 Dec 2015 10:40:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Josef Bacik <jbacik@fb.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, bhelgaas@google.com, shli@fb.com,
	kernel-team@fb.com
Subject: Re: [PATCH] pci: completely disable aspm if it's unsupported
Message-ID: <20151203164007.GA16669@localhost>
References: <1447856703-2566-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447856703-2566-1-git-send-email-jbacik@fb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 18, 2015 at 09:25:03AM -0500, Josef Bacik wrote:
> We have some hardware that takes about 30 seconds to setup common clocks for
> ASPM, but our bios'es don't actually allow ASPM.  It seems we had this thing in
> place where we would disable ASPM after the pci bus probe so that we would make
> sure that pre pcie 1.1 devices would be properly skipped during initialization.
> This is because the mechanism to disable ASPM doesn't actually disable the
> setting up of the link state stuff, it just keeps us from changing the link
> state after the fact.  So instead make it so that when we call pcie_no_aspm()
> that we disable ASPM completley, that is we skip setting up the link state and
> everything.  This way we avoid the costly setup for a feature we cannot support
> in the first place and we also make sure we are safe from future tampering with
> the ASPM link state.  Thanks,

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 317e355..5f84af2 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -954,6 +954,7 @@ void pcie_no_aspm(void)
>  	if (!aspm_force) {
>  		aspm_policy = POLICY_DEFAULT;
>  		aspm_disabled = 1;
> +		aspm_support_enabled = false;

After this patch, I think aspm_disabled and aspm_support_enabled are
equivalent.  If that's the case, we should get rid of one of them.

>  	}
>  }
>  
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
