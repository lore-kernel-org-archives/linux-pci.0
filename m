Received: from mail-m11871.qiye.163.com (mail-m11871.qiye.163.com [115.236.118.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3821F192E
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313009; cv=none; b=g3Cwtexmd1f907sTQRCCKxTzRzQ5+Txxux71AF6L0LaaUMAHcRnN7wCyKf3djV0cKt2n1g4xn7rqP10Fcp3w6iNInwg2Hcv0VnFm+TpSX4fcG7EFS6GZNgGWeX5T3G4cDdpOy6dJqh3Y/SRe78kV7muiC42BOD/Tal5rO8z0U6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313009; c=relaxed/simple;
	bh=/YiSad4sfCW39PgNQ2ZutBxZYUpW/RzN2n7CPe8E9oQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=blUyVJmpMU9W5e7VHsZGuzqBeZqdU1eVBQ6EGPU5HRw5tpajCcmWY9CP2CHZKDLGEBWZyTiTQMLs2bbIdAsmXQ1F08UJiKLuev38JM7uxQ/qoCKse6PxdeENIgTS52uDywanK73d2soge1PP5oBIfkQPrz3Blszytbi40awaI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VP8/HEUq; arc=none smtp.client-ip=115.236.118.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VP8/HEUq"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 50150b1f5;
	Tue, 6 Oct 2026 20:06:49 +0800 (GMT+08:00)
Message-ID: <8dc2f33d-6c1e-4f5e-9f78-1f74405925a6@rock-chips.com>
Date: Tue, 6 Oct 2026 20:06:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: Update saved Max Payload Size in pcie_set_mps()
To: Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Frank Li <Frank.Li@nxp.com>
References: <20261005124154.2190628-2-cassel@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261005124154.2190628-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1111bfc5503a4kunm971a00f5c37249
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZT01IVkhPTx1JQkgZSRlDGFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VP8/HEUqOtHBWrLrpK7O/mHzeRtOuXHwK5HPZDWDRTF6/sHhOH66ytHkco/0RYMYC8SLs5lFPhXvLSVridSALej40TD1llEbEyNG1iOj3Pjl3f34bdIQvzRrUOY4j8krCKeMm3jJgSCUbD81+rYvXGRBktbGjKchWdgao9MuKII=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=lgWbEUgSz0YKuspgKjuMWLzlYWgwmePe2UooMv1UNow=;
	h=date:mime-version:subject:message-id:from;

Hi Niklas,

在 2026/10/05 星期一 20:41, Niklas Cassel 写道:
> pcie_set_mps() changes the Max Payload Size (MPS) in the Device Control
> register but leaves the copy saved by pci_save_state() alone, so the next
> pci_restore_state() puts back the old value.
> 
> The PCI core does change the MPS of devices whose state has already been
> saved: pci_configure_mps() reduces a Root Port's MPS when a device with a
> smaller MPS Supported is hot-added directly below it (commit 9f0e89359775
> ("PCI: Match Root Port's MPS to endpoint's MPSS as necessary")), and with
> "pci=pcie_bus_safe", pcie_bus_configure_settings() can do the same when
> pciehp calls it after a hot-add.  The Root Port's state was saved when it
> was added and again when portdrv probed it.
> 
> Since commit 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root
> Ports in a platform-specific way"), pcibios_reset_secondary_bus() restores
> that saved state, without saving it first, after host->reset_root_port()
> has reset the Root Port, e.g. during AER recovery or on Link Down with the
> qcom and Rockchip DWC drivers.  The Root Port then goes back to the old,
> larger MPS while the device below it is restored to the smaller one, so
> the Root Port may send TLPs that the device treats as Malformed.
> 
> Update the saved copy of Device Control when pcie_set_mps() changes the
> MPS, like commit 909f7bf9b080 ("PCI: Update saved_config_space upon
> resource assignment") does for BARs.
> 

LGTM,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Note that I saw pcie_set_readrq() also changes Device Control register 
without updating the saved copy, so the reset-restore path reverts it
too.  Since you added pcie_update_saved_devctl(), mind fixing that here
as well?



> Fixes: 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root Ports in a platform-specific way")
> Assisted-by: LLM
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> This fix was originally sent out as part of my RFC series:
> https://lore.kernel.org/linux-pci/20260930145017.1356088-6-cassel@kernel.org/
> 
> But sending this fix as a separate patch, as the fix is really unrelated
> to the rest of the series, so it could be picked up independently.
> 
>   drivers/pci/pci.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8cc6a89130b5..f3b82eb7bfaf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1736,6 +1736,24 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>   	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
>   }
>   
> +/*
> + * Update the saved copy of the Device Control register after changing it, so
> + * that pci_restore_state() doesn't put back a stale value.  Device Control is
> + * the first register saved by pci_save_pcie_state().
> + */
> +static void pcie_update_saved_devctl(struct pci_dev *dev, u16 clear, u16 set)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u16 *devctl;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		return;
> +
> +	devctl = (u16 *)&save_state->cap.data[0];
> +	*devctl = (*devctl & ~clear) | set;
> +}
> +
>   static int pci_save_pcix_state(struct pci_dev *dev)
>   {
>   	int pos;
> @@ -5983,8 +6001,12 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>   
>   	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>   						  PCI_EXP_DEVCTL_PAYLOAD, v);
> +	if (ret)
> +		return pcibios_err_to_errno(ret);
>   
> -	return pcibios_err_to_errno(ret);
> +	pcie_update_saved_devctl(dev, PCI_EXP_DEVCTL_PAYLOAD, v);
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL(pcie_set_mps);
>   

