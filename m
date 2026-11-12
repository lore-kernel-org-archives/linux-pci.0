Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518161;
	b=tpaEVn1/iKqmnXCwaizQG09whpK5nnsnTnmxAb9MxNYQdovb1iiwi/T6ljGS0XF8rAds
	 MYaX75DrWne8P2HTZbRc98foFQTwl2YsC1UhdecB2Br5nNCnpjIh03z4RJjz8xVqs5re3
	 ddE8NjO7ojsiccF+6KZhmFXNF6gy2JUIGM+urhM24sWQtkehW+UhQvTeZVcIg0vBQjOzu
	 fdEi1wPNr0+QYWgFhYSwb+vY4o2zt0nfS5Irs3AxCT/uN2DlcZr246BVyYmPSocJ9KxYT
	 Q3yKhye+yRm5y6+du7MlbfKK0ZdjVwx+eawDqSJ+6rafhwCnTAK8St+4e55h00wJ3AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518161;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OAbQKWrixu0wQSE6vk14hxuTjczqzGi6Jtfww5IhWVQ=;
	b=C55yIrNKUwZeiOZcbXOU0H+3ywluYZqVzkyKK5jHdC89HyvH1qvBogExqUjtkgjIKehZ
	 2z7a7nkQSPmJtjxlcZ9jd+zPJSiH0Gfe1D8fdeNf6eecNL08cYeL41WhZpf8MqyJtMvDz
	 rEXxssuj8N7jUu3aS/vXbh5uHjQlNBrbsAcVvruQ+9AhpIwQTV/Ao9F9EYPLeI3kT8EPe
	 cenef+grrY3WESrySKMV0csvfU1xUP+u+yFkFu+HAREGZnkjAFo5hvwIZESfTyWZoysiA
	 BD9FB6GPQyfxxj5Tryxr1QzVNQntt1299LJaT4aQ5N1g0VW9Gli6YFCtMaiI2MbOAoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHlCWz54;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45C606A31C;
	Thu, 12 Nov 2026 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHlCWz54
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BB61F000C4;
	Thu, 12 Nov 2026 21:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794518161;
	bh=OAbQKWrixu0wQSE6vk14hxuTjczqzGi6Jtfww5IhWVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hHlCWz542xxydIzT2yuDqQ8U75V99Cn3AM80pImqgll47hifHTKLM8ZyYW81rlwS2
	 hOPDyZkp7rzc5uhivFw03m/eCZ4eS3ZE6pDZnL5KZWzrX08mJBidrsZJrgK7e5A8kl
	 PoLc66CEQr4vPVZSkt8c5A0EmV0TRG3seCxCBgMBQo3Ax3jAk6bUU4W+AtCCoSle+x
	 WNhlfbFBBBlxtwJ13VlGLTzoysCKenhqb1Ldb2CBxH/OdisHDsFzhIawdOlKEApb6s
	 W6/0uwvtVNCa94XjyYRwvm/FNX5v7NwPMgYWZ65xQaUIxfNFZWUEWKW/8rrPSP0VTP
	 1NxJEoomjUk4Q==
Date: Thu, 12 Nov 2026 15:16:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex@shazbot.org, jgg@ziepe.ca,
	kevin.tian@intel.com, kbusch@meta.com, michal.winiarski@intel.com,
	satyanarayana.k.v.p@intel.com, sonangp@nvidia.com,
	ankita@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com
Subject: Re: [RFC PATCH v3 02/20] PCI/PM: Add a power-state helper that tries
 the bus lock
Message-ID: <20261112211600.GA904814@bhelgaas>
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
In-Reply-To: <20261112141632.918954-3-skolothumtho@nvidia.com>

On Thu, Nov 12, 2026 at 02:16:14PM +0000, Shameer Kolothum wrote:
> PCI error recovery can hold pci_bus_sem for reading while waiting for a
> lock held by a driver. If that driver also needs the bus read lock to
> bring a device to D0, a queued writer can block it. Recovery, the driver
> and the writer then all wait for each other.
> 
> Add pci_try_set_power_state(), which returns -EAGAIN if it cannot take
> the bus lock immediately. The caller can then release its locks. Once
> the bus lock is held, use pci_set_power_state_locked() for the transition.
> Keep the existing cases that need no power-state change. The transition
> itself can still sleep.
> 
> Callers that already hold the bus read lock must use the locked helper
> instead.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h |  3 +++
>  drivers/pci/pci.c   | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96..542fa4af0a43 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1535,6 +1535,7 @@ int pci_load_and_free_saved_state(struct pci_dev *dev,
>  int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state);
>  int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
>  int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state);
> +int pci_try_set_power_state(struct pci_dev *dev, pci_power_t state);
>  pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
>  bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
>  void pci_pme_active(struct pci_dev *dev, bool enable);
> @@ -2216,6 +2217,8 @@ static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  { return 0; }
>  static inline int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
>  { return 0; }
> +static inline int pci_try_set_power_state(struct pci_dev *dev, pci_power_t state)
> +{ return 0; }
>  static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
>  { return 0; }
>  static inline pci_power_t pci_choose_state(struct pci_dev *dev,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..f2ebd19204aa 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1655,6 +1655,43 @@ int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
>  }
>  EXPORT_SYMBOL(pci_set_power_state_locked);
>  
> +/**
> + * pci_try_set_power_state - Set power state without waiting for the bus lock
> + * @dev: PCI device to handle
> + * @state: Target PCI power state
> + *
> + * Like pci_set_power_state(), but return -EAGAIN without changing the power
> + * state if the bus lock cannot be acquired immediately. The transition
> + * itself can sleep.
> + *
> + * Callers already holding the bus read lock must use
> + * pci_set_power_state_locked().
> + */
> +int pci_try_set_power_state(struct pci_dev *dev, pci_power_t state)
> +{
> +	int ret;
> +
> +	if (state > PCI_D3cold)
> +		state = PCI_D3cold;
> +	else if (state < PCI_D0)
> +		state = PCI_D0;
> +	else if ((state == PCI_D1 || state == PCI_D2) && pci_no_d1d2(dev))
> +		return 0;
> +
> +	if (dev->current_state == state)
> +		return 0;
> +	if (state >= PCI_D3hot && (dev->dev_flags & PCI_DEV_FLAGS_NO_D3))
> +		return 0;
> +
> +	if (!down_read_trylock(&pci_bus_sem))
> +		return -EAGAIN;
> +	ret = pci_set_power_state_locked(dev, state);
> +	up_read(&pci_bus_sem);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(pci_try_set_power_state);
> +
>  #define PCI_EXP_SAVE_REGS	7
>  
>  static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
> -- 
> 2.43.0
> 
