Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834522;
	b=qYHWbcj4z8WImWhy53t+R3uRL9JesMam8zp4slv6kPuSDFtS4xtHNwUR0JeJO22D2eLa
	 O6qPgJhGfpTk9D+BkNNAdv1fGlizhHDiQiQzG0tKsQlP87hfPFMzAsn6C+VI+0FpCnAJB
	 BHOQwawzgNX4lqyfHdwaOTLoagWAnlm3qzjM8xV2FHLE+SxW8W9Z1N0AgJjMad3MHDelG
	 j85Ti+rNvG0MyfHZLT7vLTjKu1J7eXwTVB928Wab4aXlssViIQ0bUgP/es2Oy7E3NVkCp
	 xVaotvife7iQJquxfVsGN1I84Ws64Mr994TNZwNcpHL0k//Ev7Hhf0fhhwu6ZmMbN5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834522;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=FwoCPPpdO8j0QQzLogIM9E8IgkHPKoUE54w1Plha5dw=;
	b=g5T2LIQhBkTcsMozvcwrUyP+MygohRJqOAd5/pHxuV6GYHgVaX9agEodLoUFvRvJD145
	 32F+rkLvBLHeJAtKAejr/AycEFr63qb9YQKot8lcsnXAyRJeKyHcpOE2XooxbblIiYkDb
	 y8KgUrus4Y2xq+bYmtcB4hx/8+4dGSUZehDBmwgNCyRezRg0E3f5CHFwVoggdpLnxKG7Y
	 ujQmZzq29Q6MsLnIz/CZMUiaPvY1Z4JJInTPaK00F080DNEcVacjQXG4dRKDd8k7lJFmq
	 zHynIvoMJJwx1BHPvZXPcu+A2fzfd4vs1tMNrI3MF+6wELsvxIcxUnguDXvcIDUJF7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIc5lPy1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D07606A33B;
	Mon, 16 Nov 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIc5lPy1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612A41F000C5;
	Mon, 16 Nov 2026 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794834522;
	bh=FwoCPPpdO8j0QQzLogIM9E8IgkHPKoUE54w1Plha5dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LIc5lPy1D71RQN2xAbDw2oXaH5IV6pJ32H0KUZEqe8L249TmRi2WTJNQxKcuU1wEO
	 oLm11Z/jqifv9rpcqf6oDFERa929d+JDfwRjC64Lnedd+EABh/BlgjMO2vcuLflph1
	 8ElRVqEMjm7Be2V+wkEQvCuB9EDMcj/MMyH7AM8kqurVjgwf5jK5SAvnQJxVfCyPce
	 WrnayG/saturD08cn49YyfcaDZzfKPuzx0jRt56/DImYkW4CmT1Kyp50jL+nYJU21v
	 MsNp1ZjKlC00n397AZiiTcJm11MwJ1MeO9np8vdTOwAxjjQ4K/7vmluasP5XB0SeNC
	 zhGRJWHaUOOpw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
In-Reply-To: <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
Date: Mon, 16 Nov 2026 18:38:25 +0530
Message-ID: <yq5amrr8yldi.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Leon Romanovsky <leon@kernel.org> writes:

> From: Leon Romanovsky <leonro@nvidia.com>
>
> Convert the PCI specific untrusted to use the common device trust
> level. Adversarial means the same thing untrusted does.
>
> PCI discovery keeps the logic that set untrusted: it looks for removable
> PCI devices with arch_pci_dev_is_removable() and defaults them to an
> adversarial policy. Treat a disabled policy the same way when choosing
> the IOMMU domain. Do not record the ATS capability of such a device, as
> pci_ats_supported() rejected untrusted ones. Let the Intel write-buffer
> quirk apply, as it only adds flushing.
>

 [ ... 28 lines skipped ... ] 

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 78742aeba932d..a48fb511bfe6f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -589,16 +589,11 @@ static int iova_reserve_iommu_regions(struct device *dev,
>  	return ret;
>  }
>  
> -static bool dev_is_untrusted(struct device *dev)
> -{
> -	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> -}
> -

 [ ... 244 lines skipped ... ] 

> diff --git a/include/linux/device.h b/include/linux/device.h
> index 65ea07c9ac35b..870ce14924905 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -934,6 +934,11 @@ static inline bool device_iommu_mapped(struct device *dev)
>  	return (dev->iommu_group != NULL);
>  }
>  
> +static inline bool device_policy_is_adversarial(const struct device *dev)
> +{
> +	return READ_ONCE(dev->trust_policy) == DEVICE_TRUST_POLICY_ADVERSARY;
> +}
> +
>  /* Get the wakeup routines, which depend on struct device */
>  #include <linux/pm_wakeup.h>
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96c..087c63b177c85 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -490,14 +490,6 @@ struct pci_dev {
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
>  	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
> -	/*
> -	 * Devices marked being untrusted are the ones that can potentially
> -	 * execute DMA attacks and similar. They are typically connected
> -	 * through external ports such as Thunderbolt but not limited to
> -	 * that. When an IOMMU is enabled they should be getting full
> -	 * mappings to make sure they cannot access arbitrary memory.
> -	 */
> -	unsigned int	untrusted:1;
>  	/*
>  	 * Info from the platform, e.g., ACPI or device tree, may mark a
>  	 * device as "external-facing".  An external-facing device is
> @@ -616,6 +608,28 @@ static inline struct pci_dev *to_pci_dev(const struct device *dev)
>  {
>  	return container_of(dev, struct pci_dev, dev);
>  }
> +
> +static inline bool
> +pci_dev_default_is_restricted(const struct pci_dev *pdev)
> +{
> +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> +
> +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
> +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
> +}
> +

Could you clarify how this series will work alongside device acceptance
and private-memory access?

In particular, what should callers of device_cc_accepted() use under
this model? My understanding is that trust describes the operating
policy, not TDISP acceptance or DMA access to private memory. Therefore,
neither FULL nor ADVERSARY alone indicates whether a device can access
private memory?

You also mention that once a trust level other than DISABLED is set, it
cannot be changed during the device's lifetime. If a device initially
operates in ADVERSARY mode and later attestation justifies FULL
operation, is that transition intentionally unsupported for the existing
device object? As documented, unbind/rebind and reset preserve the
committed level.

Some of these details are discussed in this thread:
https://lore.kernel.org/all/20260708143153.GH118978@ziepe.ca/

It would help to describe how the trust framework fits together with
those separate mechanisms, including which pieces are left for follow-up
series.

-aneesh
