Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 2 Oct 2017 18:19:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: bhelgaas@google.com, jonathan.derrick@intel.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: don't call recovery process for correctable
 errors
Message-ID: <20171002231903.GE5407@bhelgaas-glaptop.roam.corp.google.com>
References: <1503940184-29423-1-git-send-email-tbaicar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503940184-29423-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 28, 2017 at 11:09:44AM -0600, Tyler Baicar wrote:
> Correctable errors do not need any software intervention, so
> avoid calling into the software recovery process for correctable
> errors.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/pci/pcie/aer/aerdrv_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index b1303b3..4765c11 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -626,7 +626,8 @@ static void aer_recover_work_func(struct work_struct *work)
>  			continue;
>  		}
>  		cper_print_aer(pdev, entry.severity, entry.regs);
> -		do_recovery(pdev, entry.severity);
> +		if (entry.severity != AER_CORRECTABLE)
> +			do_recovery(pdev, entry.severity);

I think this is fine, and it mirrors what is done in
handle_error_source().

But I want to converge the APEI path and the "native" AER path, so as
one tiny step in that direction, can you look into doing this test
once, e.g., move the test from handle_error_source() into
do_recovery(), where one test will handle both paths?

>  		pci_dev_put(pdev);
>  	}
>  }
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 
