Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729778;
	b=ppctmFWJlqnocJlPZXTRJKrRAituJqtzTROzhLLx83yP1acT+gPm/P55r1GdKvFOztRP
	 kUQiz9e5bEvOBmTX4qeyfbXkYBY/j1uWcE5GoOGcVJibH5BN/CKaqk4hc9480r77OCCYI
	 GFZz1sO3iVEINOzk6iaEEJtb7Z+/7lQ47NlebKsQGdD3/gHpzGObI8JS3klXD69zvkY4B
	 6tkoINzZm1vIVPmCEF/9iUczdk+dmfjMrj/0VymY9ydoUbLkFuGBxeOrKvQFspbDkPWUM
	 6Z6gA9ZDnkCOjbXRx7rWqmFoayFpsBCKtPqb/toFqiqG/O4lyTc5az/tAv7pNbppRiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729778;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5vC3ikaO9+ZyD8Tz22boGp6vyq/vVZm31u070B3Xfh0=;
	b=w0aUE+7/LZTTeFRK8RjjzXdKy2Vpzbzxopo1T2mvN9baXLEdAqE6wooFT1rN9d6xZkdg
	 L+hCLxt2Rl+dcQmVCHBU0yzSHcg0cQX+7QgX608NtZo/imRL8CnXTwEuQlJxK+5qBy5Wn
	 ac4OGyiNcQDZmTqIE2uSNl41Hppc+MzA8l7n1zDwr2i7cpJNHpC2Id73nspwAX4sXVtSH
	 t6COv2g0vD/EmYwGD5pYxl6EpX5vLGcHT9fgt2BMJ7ozhfNeZwFnJICaCFA3iDzizc3MK
	 a7ipVzIldVgbuqTdsckKlWY3VuSBUpx4WShz5KrUMSZAkziTZPBYnQkEuwwzJEBebvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHLCteEH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F67606A324;
	Tue,  3 Nov 2026 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHLCteEH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59DC1F000C1;
	Tue,  3 Nov 2026 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793729778;
	bh=5vC3ikaO9+ZyD8Tz22boGp6vyq/vVZm31u070B3Xfh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BHLCteEHNmkcGv5xcNwAkB1ixymniwNBQIhly3z1aJKdS8n2yPy82+x8ALpR4WbrZ
	 4ryjUQgOpR85zTl3PeIj+W1SdzfHj7aDuHQ9dNYoMXpUg50+9IPt0ZQR0YGVZQhsxa
	 Jz4yVwJXWL6isDkqKRqQOLYwUsO43G6oOBMdLb2yDtq7MKD3qotIADc5SGbgupBT+z
	 VoncmTAvffRHh42n3bbWcS8SxECpEr54+A4Poj+SW7xDHqmMkB6jaY1rTxmJ9Wa9aC
	 nL3XcADPOI+5mO0osKf9jjosLS2pAltzjqeNZykX+RHZdobj1TW48E92KGzqIKQRGG
	 o4+9rQjHdRGjQ==
Date: Tue, 3 Nov 2026 12:16:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danny Gonzalez <digonzal@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Decotigny <decot@google.com>,
	Sheena Mohan <sheenamo@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2] PCI/ATS: Disable ATS when ACS TB is set upstream
Message-ID: <20261103181616.GA1080116@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028233651.960835-1-digonzal@google.com>

[+cc other folks interested in ATS]

On Wed, Oct 28, 2026 at 11:36:51PM +0000, Danny Gonzalez wrote:
> Enabling ATS allows an endpoint to cache translations and initiate DMA
> requests with Translated addresses, which an upstream bridge with ACS
> Translation Blocking (PCI_ACS_TB) set will block as ACS Violations.
> Because pci_enable_acs() preserves existing PCI_ACS_CTRL bits (e.g., from
> firmware, a kexec kernel, or "pci=config_acs=") without relaxing them,
> PCI_ACS_TB may remain set on upstream bridges.
> 
> Add pci_ats_check_acs() and call it from pci_dma_configure() after
> pci_enable_acs() to walk upstream bridges and clear dev->ats_cap if any
> bridge has PCI_ACS_TB enabled, leaving the endpoint to use Untranslated
> addresses.

> Tested by booting a machine with an endpoint advertising the ATS Capability
> behind a Root Port with PCI_ACS_TB set; verified ATS is disabled and the
> system boots cleanly.
> 
> Signed-off-by: Danny Gonzalez <digonzal@google.com>
> ---
> 
> v2 (based on sashiko review):
>  - Move the upstream ACS TB check from pci_ats_supported() into
>    pci_ats_check_acs() called after pci_enable_acs()
>  - Use pci_acs_enabled() instead of reading PCI_ACS_CTRL directly
> 
>  drivers/pci/ats.c        | 20 ++++++++++++++++++++
>  drivers/pci/pci-driver.c |  1 +
>  drivers/pci/pci.h        |  2 ++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 9cb23780093d..0395612f3987 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -31,6 +31,26 @@ void pci_ats_init(struct pci_dev *dev)
>  	dev->ats_cap = pos;
>  }
>  
> +void pci_ats_check_acs(struct pci_dev *dev)
> +{
> +	struct pci_dev *bridge;
> +
> +	if (!dev->ats_cap || dev->is_virtfn || dev->ats_stu)
> +		return;
> +
> +	/* Do not allow ATS if any upstream bridge blocks translation */
> +	for (bridge = pci_upstream_bridge(dev); bridge;
> +	     bridge = pci_upstream_bridge(bridge)) {
> +		if ((bridge->acs_capabilities & PCI_ACS_TB) &&
> +		    pci_acs_enabled(bridge, PCI_ACS_TB)) {
> +			pci_warn_once(dev, "ATS disabled: upstream bridge %s has ACS Translation Blocking enabled\n",
> +				 pci_name(bridge));
> +			dev->ats_cap = 0;
> +			return;
> +		}
> +	}

This works by making pci_ats_supported() return "false".  Can we do
this checking inside pci_ats_supported() instead?  Then we wouldn't
need a new function, and I think it would be easier to understand the
control flow that way.

> +}
> +
>  /**
>   * pci_ats_supported - check if the device can use ATS
>   * @dev: the PCI device
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index e16aa59dd7ac..9a1856def5bd 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1713,6 +1713,7 @@ static int pci_dma_configure(struct device *dev)
>  	 * quirks.
>  	 */
>  	pci_enable_acs(to_pci_dev(dev));
> +	pci_ats_check_acs(to_pci_dev(dev));
>  	pci_put_host_bridge_device(bridge);
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..cf2c93761d81 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -961,9 +961,11 @@ static inline void pcie_walk_rcec(struct pci_dev *rcec,
>  #ifdef CONFIG_PCI_ATS
>  /* Address Translation Service */
>  void pci_ats_init(struct pci_dev *dev);
> +void pci_ats_check_acs(struct pci_dev *dev);
>  void pci_restore_ats_state(struct pci_dev *dev);
>  #else
>  static inline void pci_ats_init(struct pci_dev *d) { }
> +static inline void pci_ats_check_acs(struct pci_dev *d) { }
>  static inline void pci_restore_ats_state(struct pci_dev *dev) { }
>  #endif /* CONFIG_PCI_ATS */
>  
> -- 
> 2.56.0.313.g2479322e68-goog
> 
