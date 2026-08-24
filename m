Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7D361DA8;
	Mon, 24 Aug 2026 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603403; cv=none; b=uL+3QutDTgZ2EQEEraGxDhD5fmpMXIN+K01HEir4XVKek16tZhb4XkaN6Ltrvs18lLQZUOCO0qNPhb4UxwD1juONnqLjr+Se/3vHqgAQGfSzkJBwvCEB2JSC5Y9zvFUsAUZ5WpC+pvd9XrgpOBhh76NlURLIg0xrr2a/o/HRYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603403; c=relaxed/simple;
	bh=nfy1kAgZM25iOXAp95QNMPx7GbJYyCFTsLS93VWg9B4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=V9AQXqE5y9OM6IyfmukPoiBgY2UWqAs9Wp2AVR5+39bU81NjihF6URmO2g+8YbNHEPSon4VW3fP6wNjOznd7j/YrNlKnZ9XE7cHeH/USzDs4NsTeuvzni7ZicqT5nOJsnCsUVqK0H+HcYHqiVPpBwvt1n4MFCc0IIPXTiICDoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=n9WT5Hfe; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="n9WT5Hfe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=ttrN7yudHYdE+P6Y7Hk+L4cL67VsRPH1HuuP89qulVk=; b=n9WT5HfeDEh5VKNVwJ+kveNnkY
	3aZPomnCEOJ/kPb6Ox8sFtVvHmZTs7RLBxihuIB7SoVvEmsLnj+8TCVMiUllBkSRNa7zzwimaazMQ
	QEViQHHDoq22NajHMNV8FuJcAY5p7oe+axyQ0v2AWjD3aSLZBdwZb95NhPa6PkwlUxQmCiaYwhxqx
	M3grSKey4/ZHqmqwd0d981oZmYybDkB6bc+O+F9P9R3lckZSwo7rkFQTnldQJwfUrdDfaEdV3iJ2Z
	mXpRQyKIXb7bIu/7thaiSoQAtDMw5+t8CPQRUfDoVScKunXqieE8VPq5f43/X3NUiSbDgAp8y37VD
	QOeH3JPg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wybIl-00000005ZN8-0MU4;
	Mon, 24 Aug 2026 14:29:51 -0600
Message-ID: <d559d41c-5cba-4a95-bc8b-b1f78a49a18c@deltatee.com>
Date: Mon, 24 Aug 2026 14:29:34 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, Matt Evans <matt@ozlabs.org>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-5-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-5-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com, matt@ozlabs.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: I
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> pdev->p2pdma has two lifetime models. Provider-based entry points are
> quiesced by their driver before remove completes. pci_p2pmem_find_many()
> and the p2pmem sysfs attributes can race with unbind and therefore rely
> on the teardown grace period.
> 
> Document publication, teardown, and how the grace period protects both
> the struct pci_p2pdma object and its optional gen_pool.
> 
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Matt Evans <matt@ozlabs.org>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/p2pdma.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index a77ef9deb3c6..49bc8cf06240 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -21,6 +21,39 @@
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
>  
> +/*
> + * Lifetime and RCU usage
> + *
> + * Within one driver bind, pdev->p2pdma is published exactly once, by

Is published the right verb here? Seems like we use published for
different purposes in p2pdma and calling pcim_p2pdma_init() publishing
reads strangely.

> + * pcim_p2pdma_init(), and cleared exactly once, by the pci_p2pdma_release()
> + * devres action that the same function installs. It is never re-pointed at a

"It is never re-pointed at" is some strange wording. I had to read it a
few times to understand what it is saying.

> + * second struct pci_p2pdma, so a reader that observes a non-NULL pointer
> + * always observes the same, fully initialised object. That object is devres
> + * memory allocated before the action is installed, so devres frees it only
> + * after pci_p2pdma_release() has returned.

I don't quite follow the point of this paragraph. It's like it's
building to some kind of gotcha, but all it seems to be saying is is the
life cycle of pdev->p2pdma is the same as the lifecycle of pdev.

> + * Most exported entry points reach pdev->p2pdma through a struct pci_dev or a
> + * struct p2pdma_provider owned by the provider driver, and
> + * pcim_p2pdma_provider() requires callers to drop those references before the
> + * driver's remove() completes. Those cannot run concurrently with
> + * pci_p2pdma_release(), and their rcu_dereference() calls are simply how an
> + * __rcu pointer is read.
> + *
> + * pci_p2pmem_find_many() and the p2pmem sysfs attributes are the exceptions.
> + * The first walks every PCI device, so it can reach a provider whose driver is
> + * unbinding: pci_get_device() pins the struct pci_dev, not the driver. The
> + * second is reachable from userspace until sysfs_remove_group() runs at the end
> + * of the release. pci_has_p2pmem() must dereference the object to determine
> + * whether it owns a gen_pool, so even a poolless object must remain alive until

Maybe a hyphen with pool-less or maybe better to use plain language: "so
even a device without a pool must remain alive..."

> + * that RCU reader exits. The sysfs group is created with the pool.
> + *
> + * The grace period in pci_p2pdma_release() first protects the struct
> + * pci_p2pdma itself from being freed while pci_has_p2pmem() is using it. For a
> + * pool-backed provider it also fences the gen_pool: gen_pool_alloc_owner()
> + * walks pool->chunks under RCU and gen_pool_destroy() frees those chunks
> + * without waiting for a grace period of its own, so pci_alloc_p2pmem() and
> + * p2pmem_alloc_mmap() hold rcu_read_lock() across the allocation.
> + */
>  struct pci_p2pdma {
>  	struct gen_pool *pool;
>  	bool p2pmem_published;
> @@ -235,9 +268,19 @@ static void pci_p2pdma_release(void *data)
>  	if (!p2pdma)
>  		return;
>  
> -	/* Flush and disable pci_alloc_p2p_mem() */
> +	/*
> +	 * Stop new RCU readers and wait for readers that observed p2pdma before
> +	 * allowing devres to free it. This is required even without a pool,
> +	 * because pci_has_p2pmem() dereferences every non-NULL p2pdma it finds.
> +	 * For a pool-backed provider this also fences gen_pool_destroy().
> +	 */
>  	RCU_INIT_POINTER(pdev->p2pdma, NULL);
>  	synchronize_rcu();
> +
> +	/*
> +	 * The grace period also ensures no RCU reader can still be accessing
> +	 * map_types here.
> +	 */
>  	xa_destroy(&p2pdma->map_types);
>  
>  	if (!p2pdma->pool)
> @@ -255,6 +298,9 @@ static void pci_p2pdma_release(void *data)
>   * for a PCI device. It allocates and sets up the necessary data
>   * structures to support P2PDMA operations, including mapping type
>   * tracking.
> + *
> + * The state is published once per driver bind and torn down by a devres

I still find the use of "published" here a bit odd and I'm not sure what
"state" it is referring to.

> + * action on unbind. Repeated calls for the same device are a no-op.
>   */
>  int pcim_p2pdma_init(struct pci_dev *pdev)
>  {
> @@ -786,6 +832,12 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
>  	}
>  done:
> +	/*
> +	 * pci_p2pmem_find_many() reaches this with a provider whose driver may
> +	 * be unbinding, so the store runs under RCU: pci_p2pdma_release()
> +	 * clears the pointer and waits for readers before destroying
> +	 * map_types. See "Lifetime and RCU usage" above.
> +	 */

I don't know, but this seems like we're just describing basic RCU usage
here. I'm not sure I personally find much value in the comment.

>  	rcu_read_lock();
>  	p2pdma = rcu_dereference(provider->p2pdma);
>  	if (p2pdma)
> 

Thanks,

Logan
