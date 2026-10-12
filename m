Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621137F320
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842213; cv=none; b=ba3SkBNzUIIlhxgj8GMZdi+/SleWZHkdYiaLt9+DwbmobDNfpJv8bvELzYIO2rM2rfR0uJWiGVf+0B1yNXrU6SIa7nSljgmPbWBe6OCKs79ngIhfAT4Flw78sixNdeKhEiajqrtoNQ/7gP4ghIV5zLiV4sS/UCCKv+MzqdLu2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842213; c=relaxed/simple;
	bh=kBJpnpOPhbnX7HfdiuLOGxw0Gt7/kMXGZvFNKtsDM0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fTyGc5YLguBwGJYTBfykiEzzG7cZ99xbA6jsZG5WFKvb5hRbVzEO97JkxUOp87aKxQ+5g6MvEbClcuUhP/+RbxdbKrYFrSoOJ3YGMqnG54oVmMVeSS0lQw76x8kckh4ZgCDx+MToFOlbIiYNdZMZGKSiFhEr4tmYWVPX1hYRMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBi1Q1eT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBi1Q1eT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96C01F0089B;
	Mon, 12 Oct 2026 21:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791842210;
	bh=h+gWx/IABU3vfuF4WLNZB9HmpNOUI9aLl9gcRzQY+ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NBi1Q1eTZ7MbGFGki1+4M8JBGZNAJnH4suS99EIigC2wNZE5oDgGtKsCev8hKl2W1
	 EL7FAZhjEYY8bENAp0UlZGxJQNJBAfutVc25w+L1VL9gmnT5gZ28ltTg+DhCrS6yNY
	 wDI5IwB7kyOXR0F9BjbHx5Nu4dldkGC39Nd0XwC+Wr4a8gCYXbbGzQIBS2ZosJb5Gc
	 x+U+4mJnfPEWsFrwPJZpj1ajy3DCsdNi+8M/DHPD7Lwz1IkQvyN7hGZ51IF7VqTK92
	 7nd68s9r4PsMcW3uwKN9jIJphjiN7qJK9GnzVz63GslJU2rick0UgD+obnczda6IpR
	 5kbEkHnHDuqpw==
Date: Mon, 12 Oct 2026 16:56:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: Update saved Max Payload Size in pcie_set_mps()
Message-ID: <20261012215648.GA1404779@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005124154.2190628-2-cassel@kernel.org>

On Mon, Oct 05, 2026 at 02:41:55PM +0200, Niklas Cassel wrote:
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
> Fixes: 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root Ports in a platform-specific way")
> Assisted-by: LLM
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Applied to pci/mps for v7.4, thanks!

> ---
> This fix was originally sent out as part of my RFC series:
> https://lore.kernel.org/linux-pci/20260930145017.1356088-6-cassel@kernel.org/
> 
> But sending this fix as a separate patch, as the fix is really unrelated
> to the rest of the series, so it could be picked up independently.
> 
>  drivers/pci/pci.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8cc6a89130b5..f3b82eb7bfaf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1736,6 +1736,24 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
>  }
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
>  static int pci_save_pcix_state(struct pci_dev *dev)
>  {
>  	int pos;
> @@ -5983,8 +6001,12 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>  
>  	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>  						  PCI_EXP_DEVCTL_PAYLOAD, v);
> +	if (ret)
> +		return pcibios_err_to_errno(ret);
>  
> -	return pcibios_err_to_errno(ret);
> +	pcie_update_saved_devctl(dev, PCI_EXP_DEVCTL_PAYLOAD, v);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(pcie_set_mps);
>  
> -- 
> 2.55.0
> 
