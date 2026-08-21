Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DA39A4AA;
	Fri, 21 Aug 2026 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353724; cv=none; b=ZA38b+akFqSynmEyzQsvC6cOLpnzzKSzjM+JcvMNuQG0ifZI1HxeFcFnWHEeepzBjkOvEgQ82WmNm5RW8s7XaL6G2axt5KA98I7Tpki2hvu1NoCOzScfCeSZ4NHzDFqKKMCOGCQScVvYn4fqWJdv2K3N9vyNYLqHbsRTp/g6E90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353724; c=relaxed/simple;
	bh=W1EihAFKCMrMO8clCMq/OCfA6XR2zjlEvpw5pDjweVw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=aYKU2uzBqlMZ/lZ2pcbHOU+v6W02FK3n31sFd2iIlYozzJ+j5yi8a/10BWYZ+vg/6eZ6TgylTGHHiGZmlktaYM37+TU9sR+7sG9X4CAi9KYN9jX7Vr+pb0G303W0NUrfCU1426fIE7bcN2Dsmh6kM6bqCaoR6r8HyG28IXYQQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=HNLahndZ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="HNLahndZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=fkfMaoeV36jnbnNkOff/Nn2sVnubQwHY5bjslIAzUlM=; b=HNLahndZDsC6m/ontpRX49oXxx
	E45i6V1tIhktwdOacGtGyfvlh59IY74piVaieBCf+UO1UsB3w3LSgIstj8YUhlPvkxgv95HvBKetr
	Tl/lowRkSWqr+cekthZgT8CYmVyiBSKFQ5GsBSd6VvyAAuKJ2axyAhUAh8jtLQQTcfbt3TYkqCRu2
	cyU9C6IklpJbk0TQn5WEVh3N4x2EmZt8NCo2USL4p39pgfX0h5CmzVEMOsvlcdKwz64Qez2jtnuW5
	p9U4WydoXj2j849TP7I9NexLgEl0FgoC0vYncdyRXauwcoTMmHpjCg+LD+VOZr1dGRn/y+5J2B5+/
	I0m1fk2w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wxYLf-00000003EQt-3smV;
	Fri, 21 Aug 2026 17:08:32 -0600
Message-ID: <f1237857-1318-48e4-adcc-b2ff1924433b@deltatee.com>
Date: Fri, 21 Aug 2026 17:08:19 -0600
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
 Tushar Dave <tdave@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-1-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-1-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 01/18] PCI/P2PDMA: Do not tear down the allocate
 attribute on registration failure
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> pci_p2pdma_add_resource() installs pci_p2pdma_unmap_mappings() as a devres
> action with the devres allocated p2p_pgmap as its data, and only then adds
> the range to the pool:
> 
> 	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
> 					 p2p_pgmap);
> 	if (error)
> 		goto pages_free;
> 
> 	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> 	error = gen_pool_add_owner(p2pdma->pool, ...);
> 	if (error)
> 		goto pages_free;
> 
> The action removes the allocate attribute for the whole device, which
> tears down existing userspace mappings of every BAR already registered on
> it. Both failures here get that wrong, in opposite ways.
> 
> devm_add_action_or_reset() runs the action when it cannot allocate its
> devres node, so an -ENOMEM while registering a second BAR unmaps the
> first one. Use devm_add_action() and let the error path unwind only what
> this call created.
> 
> gen_pool_add_owner() allocates a chunk and can also fail with -ENOMEM.
> There the action is registered, and the error path frees p2p_pgmap with
> devm_kfree() while leaving the action pointing at it. On unbind devres
> runs the action and pci_p2pdma_unmap_mappings() dereferences
> p2p_pgmap->mem->owner->kobj, which is freed memory. Give that failure its
> own label and drop the action with devm_remove_action(), which removes it
> without running it.
> 
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
> Fixes: f58ef9d1d135 ("PCI/P2PDMA: Separate the mmap() support from the core logic")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Makes sense to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
