Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8884E485929;
	Mon, 12 Oct 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798973; cv=none; b=WbJ9FDhgU9q1p39L0MT1KnCTs05FziTNTNt7t5MI6Lh734BkARsBUxlN9Md/gCKO7rBydSMcYKAbGb1ogQSBn8fxtby15x88hwvsw6UYeHKEuObE84F1I461NBogpG6A5fEPX9ImzH22ryVuYRXefyBxwpirBTdKfKDUF9PgFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798973; c=relaxed/simple;
	bh=tbvAgt7Rd/DjnZNw9Uj0KdhXn3qgAaBAfIoU8Po2k14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8fUbCA21dBlsmh14UqJn6+SS3n1Pkgtfzdf4DTht9rdFcoRC7Op6H0USedNEaZy3Dm7Cn/53C+jg2z5vubfK0KFGolDoAISfkU8+pqR3ECLHfIdhwaV6BM+9rDsYs90KCd5WvJGx7qtYFJvYofJF08owsEXBKhkPJjh7nuagY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVIHtgRX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVIHtgRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB741F0089C;
	Mon, 12 Oct 2026 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791798964;
	bh=CVHrQuAJ61cQxXtDbuatkxXHw1nLvVEknlTPc5E36UA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FVIHtgRXxZRhYE6maSjehRkWuBF2HH0RayYfx/krs1AI5oe31QO1pDX+lBMY86byq
	 YJjaq/QKQAVJW7RXLCS/vht2HZmd3c10JMx1r96e8YrN5itL+Ua1TBc16aZkEQFmgf
	 2Q/6fDJAjHcscVS1BpvBPrxrTREc/AMpDUXXXZNBLLAxKjKTcKJZpjP2FNTX+Ftb+T
	 B19geR2QBjNTYHqQqyyffgqW0FviJXuqrjWaYmMpqdxUMdOQRwYZErvT22E26fTOBx
	 j3JRi6xV0/xcht6VLYJJ3IgCwWNa46TQyf0NHPGhyIMG6o6EtrWyqiFhVzW8yv9hRh
	 VCjhYDFwXA5OQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 14/16] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
In-Reply-To: <sashiko-outbox-163680@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-15-aneesh.kumar@kernel.org>
 <sashiko-outbox-163680@kernel.org>
Date: Mon, 12 Oct 2026 15:25:59 +0530
Message-ID: <yq5awlrn4500.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] pci/tsm: Use-After-Free of tsm_dev due to missing device reference count
> --
>
> commit 45c3cda47ad9fdb8464c2ba275fcaa5077625b75
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> iommufd/viommu: Allow PCI TSM backends to provide vIOMMU operations
>
> This commit allows a vIOMMU implementation to be provided by a TEE Security
> Manager (TSM) rather than the physical IOMMU driver. It queries the TSM
> associated with the target PCI device and resolves the PCI TSM association
> under pci_tsm_rwsem while pinning the module.
>
>> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
>> index dca9634f8d5eb..c8603867e09df 100644
>> --- a/drivers/pci/tsm.c
>> +++ b/drivers/pci/tsm.c
>
> [ ... ]
>
>> @@ -36,6 +38,25 @@ static const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
>>  	return tsm->tsm_dev->pci_ops;
>>  }
>>  
>> +struct tsm_dev *pci_tsm_get_device(struct pci_dev *pdev)
>> +{
>> +	const struct pci_tsm_ops *ops;
>> +	struct tsm_dev *tsm_dev;
>> +
>> +	guard(rwsem_read)(&pci_tsm_rwsem);
>> +	if (!pdev->tsm)
>> +		return NULL;
>> +
>> +	tsm_dev = pdev->tsm->tsm_dev;
>> +	ops = tsm_dev->pci_ops;
>> +	if (!ops->viommu_get_ops)
>> +		return NULL;
>> +	if (!try_module_get(ops->owner))
>> +		return ERR_PTR(-ENODEV);
>> +	return tsm_dev;
>> +}
>
> [Severity: High]
> Does this code need to take a kobject reference on the device via
> get_device(&tsm_dev->dev)?
>
> The tsm_dev pointer is returned and stored in viommu->tsm_dev for the
> lifetime of the vIOMMU, relying solely on the module pin. 
>
> The doc comment for tsm_get_device() states that backends must not unregister
> their TSM independently of module unload. However, in the Linux device model,
> a module pin only prevents module removal; it does not prevent a PCI device
> from being unbound via sysfs (unbind or remove) or hardware hot-unplug.
>
> If the device is unbound, the driver core forces the driver remove callback
> to run, which calls tsm_unregister().
>

An additional device reference is not strictly needed for the current
CCA backend. arm-cca-host registers the TSM device, and the vIOMMU pins
that module. Sysfs unbind is disabled, and the SMCCC device has no
hot-unplug path, so the TSM remains registered while the vIOMMU exists.


But, taking a device reference makes it explicit that the vIOMMU owns a
reference to the TSM device until it is destroyed. I'll add this in the
next revision.

>
>> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
>> index f791359861020..2fce341ff9231 100644
>> --- a/drivers/virt/coco/tsm-core.c
>> +++ b/drivers/virt/coco/tsm-core.c
>
> [ ... ]
>
>> @@ -16,6 +26,29 @@ static const struct class tsm_class = {
>>  };
>>  static DEFINE_IDA(tsm_ida);
>>  
>> +/**
>> + * tsm_get_device() - Pin the TSM attached to a device
>> + * @dev: device whose TSM is to be pinned
>> + *
>> + * A successful lookup pins the backend module. Backends providing vIOMMU
>> + * operations must not unregister their TSM independently of module unload.
>> + * Return: NULL if no vIOMMU-capable TSM is attached, an error if the module
>> + * cannot be pinned, or the TSM device associated with the pinned backend.
>> + */
>> +struct tsm_dev *tsm_get_device(struct device *dev)
>> +{
>> +	if (!dev_is_pci(dev))
>> +		return NULL;
>> +	return pci_tsm_get_device(to_pci_dev(dev));
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_get_device);
>> +
>> +void tsm_put_device(struct tsm_dev *tsm_dev)
>> +{
>> +	module_put(tsm_dev->pci_ops->owner);
>> +}
>
> [Severity: High]
> Can this dereference freed memory?
>
> When tsm_unregister() is called during an unbind or hot-unplug event, it
> invokes put_device(&tsm_dev->dev). Because no extra reference was held when
> acquiring the device in pci_tsm_get_device(), the reference count drops to zero
> and the tsm_dev object is freed via kfree().
>
> Later, when the vIOMMU is destroyed, iommufd_viommu_destroy() calls
> tsm_put_device(viommu->tsm_dev). This dereferences the freed memory to access
> tsm_dev->pci_ops->owner, resulting in a use-after-free crash.
>

This path is not reachable with the current CCA backend: sysfs unbind is
disabled, the SMCCC device has no hot-unplug path, and the module pin
prevents unload.

-aneesh
