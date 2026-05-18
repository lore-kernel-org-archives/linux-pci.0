Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0FB352C4E
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123937; cv=none; b=mp6dbquHJcnpzz03qYx2cKbb9G0x0OcVyMGnRtwDdH+nqn4iADxFpoXTR3QOGrC3rpqfufB+zal7RBITRp+B6uUiKIVc1MxAnfGESdAK1GdewAD5Xdo6B4D2A9RzhLYj0v2MkaQyGXuuFZ2f9xVMK+2+1tCAWBTzqKki+QOPG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123937; c=relaxed/simple;
	bh=iUIsQgZoAK116WxGtlnVkqsIIaIpp2Pf2pmQUPxksdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C3abpn0LTjfkL0nJ3O5IFKqlqBf3DBJ0DPRkMvstA70KmhkaAJ/Rda3j/U0dtDDivVzXZ6ulV7QlLoU31gkyqJHcKgjvMtDVt/WJgc6urEW862vJXeFC8VfoA9EgDNDCQsWIyXaiRM6e+OkNmZANHc9ioWklvRZyHQCesM2utS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTsVclOd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTsVclOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357DDC2BCB7;
	Mon, 18 May 2026 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779123937;
	bh=iUIsQgZoAK116WxGtlnVkqsIIaIpp2Pf2pmQUPxksdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TTsVclOdc66hQHoOXFr5SzIm6LFn8AAPMxF+suHM1Z5DQXlr5rfiporhD1wb4o9KW
	 tBPDWHXHAU4/zWBluFWxDD2H/6mwfwTDFs9OFN6Zw/B1Apwj5Qdyk8QdhBGP1/LdRG
	 CpI7PK8zaWZ4sTyRMtf9yi7IqU/K4HHhgUjOActuq048aArWlE1K4QpsS1z7W5ss3W
	 QhiO+19xv15F42HJVLpwrvEx9xfDGKzkCiY8Wk7F8f1DI8ZLru7I4OWkEvLc+8O5GI
	 eeulN+f1b3wrk+24G54yNjHcZDjIeCvZzURo5zMyXpGP92StbkaSqNgfI8USbo+8uP
	 8RhS+ciG4Y3/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/5] PCI: host-common: Add link down handling for
 Root Ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518-pci-port-reset-v8-3-eb5a7d331dfc@oss.qualcomm.com>
References: <20260518-pci-port-reset-v8-3-eb5a7d331dfc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 17:05:30 +0000
Message-Id: <20260518170537.357DDC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware state desynchronization when CONFIG_PCIEAER is disabled.
- [Medium] Commit message claims error_detected() callback is triggered for=
 the bridge, but the implementation skips it.
--

commit f07cf37e729701c6c67b90c92f65dd76b53b9fec
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: host-common: Add link down handling for Root Ports

This commit introduces a new API, pci_host_handle_link_down(), for host
bridge drivers to recover a specific Root Port when a link down event is
observed. It utilizes pcie_do_recovery() with AER handling if enabled, or
falls back to pci_bus_error_reset() otherwise.

> First, the AER error_detected() callback will be triggered for the bridge=
 and then for the downstream devices.

Is this description accurate regarding the bridge receiving the callback?

Looking at pcie_do_recovery(), it uses pci_walk_bridge() to trigger the
recovery callbacks. However, pci_walk_bridge() handles bridges with
subordinate buses by iterating over devices on the subordinate bus.

Consequently, the Root Port (the bridge itself) appears to be excluded from
the callback walk and might not receive the error_detected() callback.

> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/contr=
oller/pci-host-common.c
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c

[ ... ]

> @@ -106,5 +108,38 @@ void pci_host_common_remove(struct platform_device *=
pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_host_common_remove);
> =20
> +static pci_ers_result_t pci_host_reset_root_port(struct pci_dev *dev)
> +{
> +	int ret;
> +
> +	pci_lock_rescan_remove();
> +	ret =3D pci_bus_error_reset(dev);
> +	pci_unlock_rescan_remove();
> +	if (ret) {
> +		pci_err(dev, "Failed to reset Root Port: %d\n", ret);
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +
> +	pci_info(dev, "Root Port has been reset\n");
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +static void pci_host_recover_root_port(struct pci_dev *port)
> +{
> +#if IS_ENABLED(CONFIG_PCIEAER)
> +	pcie_do_recovery(port, pci_channel_io_frozen, pci_host_reset_root_port);
> +#else
> +	pci_host_reset_root_port(port);

If CONFIG_PCIEAER is disabled, this directly calls pci_host_reset_root_port=
()
which performs a bus reset using PCI_RESET_NO_RESTORE via
pci_bus_error_reset().

Since pcie_do_recovery() is skipped, downstream device drivers are never
notified via their error_detected(), slot_reset(), or resume() callbacks.

Does this leave the hardware configuration space of these devices wiped whi=
le
the bound drivers remain active and unaware?

If subsequent MMIO accesses by these drivers hit unmapped space and DMA
fails, could this lead to device lockups or data corruption? Would it be
safer to hot-remove and rescan the devices instead of blindly resetting the
bus when AER is unavailable?

> +#endif
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-pci-port-r=
eset-v8-0-eb5a7d331dfc@oss.qualcomm.com?part=3D3
