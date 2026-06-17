Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE23815FA;
	Wed, 17 Jun 2026 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687034; cv=none; b=HuUTh7mpORWyzqBEgVirGPeapF85frPKu5nUIwiRGKGO0LgrQVOOqWZgr1Sye2JX+fhl/4B8n7G8oJGDOjzeuLmAsp4m6BCo9GUvpt4ZaLnHJdGRxzCqOcVM9/MaSl09s+u7z9uPQM1QGs3RWrKTCRlEBXNSUsLJzVK4HW8rIY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687034; c=relaxed/simple;
	bh=LqvCQ4E+c+XM1goJ1rMnLbImX6Ucb0K+bDzdn/DW1/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ughpdTqotdHXpNYb9Fr/6EdPD5sX7zFdG14StCNdnD4+dVfDSV+QZVouG9NRNsla1CVXcKf+5IaAJOUEhgwDdGIDVwqT7bbjbm99j9l7l7Z19HyGKmThBt1OZoROkxy7GU8uWtFb1438vt9JunwnSN2KTvx/+mve2/IQMZuz27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CB1D64C2C37F03;
	Wed, 17 Jun 2026 11:03:26 +0200 (CEST)
Message-ID: <bd5ab9e3-ab93-43ad-a2ce-03d56e2d2ecf@molgen.mpg.de>
Date: Wed, 17 Jun 2026 11:03:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: Implement PCI reset
 handler
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20260617084329.199110-1-sergey.temerkhanov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260617084329.199110-1-sergey.temerkhanov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +Aleksandr (as in Reviewed-by:), +PCI subsystem]

Dear Sergey,


Thank you for your patch.

Am 17.06.26 um 10:43 schrieb Sergey Temerkhanov:
> Implement PCI device reset handler to allow the network device to
> get re-initialized and function after a PCI-level reset.

Please describe the problem in more detail. When does PCI-level reset 
occur, and what is the current problematic situation?

Also, what is ixgbe specific compared to a general PCIe implementation?

Please share details how to test it, and how you tested it.

> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 72 +++++++++++++++++++
>   2 files changed, 73 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 594ccb28da20..c4b0c5bb89c6 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -912,6 +912,7 @@ enum ixgbe_state_t {
>   	__IXGBE_PTP_TX_IN_PROGRESS,
>   	__IXGBE_RESET_REQUESTED,
>   	__IXGBE_PHY_INIT_COMPLETE,
> +	__IXGBE_PCIE_RESET_IN_PROGRESS,
>   };
>   
>   struct ixgbe_cb {
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 2ac274c73d61..a61ee5fff7be 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -12352,6 +12352,76 @@ static pci_ers_result_t ixgbe_io_slot_reset(struct pci_dev *pdev)
>   	return result;
>   }
>   
> +#define IXGBE_PCIE_RESET_RETRIES 1000

Why 1000? Isn’t there a generic PCIe macro? Please extend the commit 
message.

> +
> +/**
> + * ixgbe_reset_prep - called before the pci bus is reset.
> + * @pdev: Pointer to PCI device
> + *
> + * Prepare the card for a reset, preventing the service task from running.
> + */
> +static void ixgbe_reset_prep(struct pci_dev *pdev)
> +{
> +	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
> +	unsigned int timeout = IXGBE_PCIE_RESET_RETRIES;
> +
> +	if (!adapter)
> +		return;
> +
> +	/* Prevent the service task from being requeued in the timer callback
> +	 * while we're resetting.
> +	 */
> +	if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state)) {
> +		timer_delete_sync(&adapter->service_timer);
> +		/* Prevent the service task from running while we're resetting. */

One of the two comments seems redundant.

> +		cancel_work_sync(&adapter->service_task);
> +	}
> +
> +	pci_clear_master(pdev);
> +
> +	while (test_and_set_bit(__IXGBE_RESETTING, &adapter->state) && --timeout)
> +		usleep_range(1000, 2000);
> +
> +	if (!timeout) {
> +		e_err(drv, "Timed out waiting for __IXGBE_RESETTING to be released. Reset is needed\n");
> +		pci_set_master(pdev);
> +		return;
> +	}
> +
> +	set_bit(__IXGBE_PCIE_RESET_IN_PROGRESS, &adapter->state);
> +	smp_mb__after_atomic();
> +}
> +
> +/**
> + * ixgbe_reset_done - called after the pci bus has been reset.
> + * @pdev: Pointer to PCI device
> + *
> + * Allow the service task to run and schedule re-initialization.
> + */
> +static void ixgbe_reset_done(struct pci_dev *pdev)
> +{
> +	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
> +
> +	smp_mb__before_atomic();
> +	if (!test_and_clear_bit(__IXGBE_PCIE_RESET_IN_PROGRESS, &adapter->state)) {
> +		e_err(drv, "Reset done called without PCIe reset in progress\n");

How can this happen? What should the user reading this error do?

> +		return;
> +	}
> +
> +	/* Allow the service task to run */
> +	if (!test_bit(__IXGBE_REMOVING, &adapter->state)) {
> +		clear_bit(__IXGBE_RESETTING, &adapter->state);
> +		smp_mb__after_atomic();
> +	}
> +
> +	/* Schedule re-initialization */
> +	if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
> +		set_bit(__IXGBE_RESET_REQUESTED, &adapter->state);
> +		if (test_bit(__IXGBE_SERVICE_INITED, &adapter->state))
> +			mod_timer(&adapter->service_timer, jiffies + 1);
> +	}
> +}
> +
>   /**
>    * ixgbe_io_resume - called when traffic can start flowing again.
>    * @pdev: Pointer to PCI device
> @@ -12384,6 +12454,8 @@ static const struct pci_error_handlers ixgbe_err_handler = {
>   	.error_detected = ixgbe_io_error_detected,
>   	.slot_reset = ixgbe_io_slot_reset,
>   	.resume = ixgbe_io_resume,
> +	.reset_prepare = ixgbe_reset_prep,
> +	.reset_done = ixgbe_reset_done,
>   };
>   
>   static DEFINE_SIMPLE_DEV_PM_OPS(ixgbe_pm_ops, ixgbe_suspend, ixgbe_resume);

Kind regards,

Paul
