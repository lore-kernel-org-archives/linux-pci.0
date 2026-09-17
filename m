Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1FF4E9C38;
	Thu, 17 Sep 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676400; cv=none; b=hSQZNEKM9xOtddG5mLGHeYgB2SfhyRt3aTVgwTXIwTRDa6vHSKmadS81GNlKjlUI1e1A/hBvS03tYzXzSbt4SZhwfFbe2UxTApdVkrdef0R4UU5futfZW/Qdubze0XBU7g5qDZx4u3p1a+YnP0Gb6X0kczSqICO/v7Czsr1TVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676400; c=relaxed/simple;
	bh=hfDey7uBPVMLPx6e2rFfuHQOiUnPZrKrwDq/n2xZ/vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LlxvETr6CMDQjVX92kTOyq0qmrwPQ1jQcfs4Kz/TnyrY39v6PxoW3eTaKfi8yep/0qwqIYobv8ozBuOnRiYEALPNL9eR//afsSABpfrYoWDHgedJeJupDDZ6AUIDch87cvJHModiFUTdLIMan3q/Q5CBJG784dFXLa/FAnMAU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPn5Yy6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPn5Yy6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177331F000FF;
	Thu, 17 Sep 2026 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789676393;
	bh=FVPFyILB0p9mKi052GhepayT1vMbxqjB1Nhk/upvblM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fPn5Yy6FfiqKTmfjU5oYceM12GCmiYpT11w/2EyEPdKZGB9CPcBNkVv2+BwFLzu6X
	 xSgkGQj5+WhLzGvcmRurhfvuOQGHvSLSKl4teDAJZ6QR/QG7VnV959jPcTz+HVEaZK
	 CuD8XS5L28gUkvAbrICdalmnnCwxmYFcPuyhzJDJRcJ2dL8dpzKDBT7Z38/9T65arE
	 LY8nGXBX//YUlL/TndeGkCuR1dbAH8rbGwzFuTEWxVYd14ZqNgn+y/iXdiTaJOcVDu
	 NcVTytHagvF9lKoqQdw5+GoOIioEKAtSHIhUTx/SJFFATlpqz1u3d3zNwsKQDDY+v+
	 SECBXMxIYkoGg==
Date: Thu, 17 Sep 2026 15:19:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 11/12] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Message-ID: <20260917201952.GA1049400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-12-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:10:05PM +0000, David Matlack wrote:
> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
> 
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to ensure continuous operation.  Clearing the bus
> mastering bit would prevent these devices from issuing any memory
> requests while the new kernel boots.
> 
> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. This is critical because clearing bus mastering on an upstream
> bridge prevents the bridge from forwarding memory requests upstream (i.e.
> it would prevent the endpoint device from accessing system RAM and doing
> peer-to-peer transactions with devices not downstream of the bridge).
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/liveupdate.c | 11 +++++++++++
>  drivers/pci/liveupdate.h |  6 ++++++
>  drivers/pci/pci-driver.c |  7 +++++--
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 65bcecb1b64e..32b73ebf71f7 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -132,6 +132,10 @@
>   *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
>   *    preserved devices to ensure that all preserved devices on the bridge's
>   *    secondary bus are addressable after the Live Update.
> + *
> + *  * The PCI core does not disable bus mastering on outgoing preserved devices
> + *    during kexec. This allows preserved devices to issue memory transactions
> + *    throughout the Live Update.
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt
> @@ -879,6 +883,13 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
> +{
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +	pci_WARN_ONCE(dev, !dev->liveupdate.frozen, "Preservation status is unstable!\n");
> +	return dev->liveupdate.outgoing;
> +}
> +
>  /**
>   * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
>   * @dev: The PCI device to check
> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index 49d07fd02132..9c31fb60207d 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
> @@ -20,6 +20,7 @@ void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
>  void pci_liveupdate_cache_adopted_acs_controls(struct pci_dev *dev);
>  int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev);
>  int pci_liveupdate_adopt_ari(struct pci_dev *dev);
> +bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
>  #else
>  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
>  {
> @@ -55,6 +56,11 @@ static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +
> +static inline bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
> +{
> +	return false;
> +}
>  #endif
>  
>  #endif /* DRIVERS_PCI_LIVEUPDATE_H */
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 51616e4327d3..47cb3dcaa927 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -546,11 +546,14 @@ static void pci_device_shutdown(struct device *dev)
>  	/*
>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>  	 * device to tell it to not continue to do DMA. Don't touch
> -	 * devices in D3cold or unknown states.
> +	 * devices being preserved for Live Update or in D3cold or
> +	 * unknown states.
> +	 *
>  	 * If it is not a kexec reboot, firmware will hit the PCI
>  	 * devices with big hammer and stop their DMA any way.
>  	 */
> -	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> +	if (kexec_in_progress && !pci_liveupdate_is_outgoing(pci_dev) &&
> +	    pci_dev->current_state <= PCI_D3hot)
>  		pci_clear_master(pci_dev);
>  }
>  
> -- 
> 2.55.0.487.gaf234c4eb3-goog
> 
