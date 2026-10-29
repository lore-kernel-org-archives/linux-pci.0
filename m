Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256990;
	b=fvyVLiyPmhVPCerN9MM1u+QjMWv1g6lZt23OWBGgeQEdigvzNAHbhSHp4ahJMpxpNRuk
	 k1Z4jSoCP1MYlRdys6YgG5LDE8yAGcyvWnYQVzHG5QNCsGXMzQixxt5zEf8sfPmFBfAOb
	 ZxFucIs5596BqYZ8WIJfZt/a3xNnyNAwN9/hbUWG8s9ObPYgq5R7cKQmE3KoiqWJ8tMsy
	 HNF+RAQ9ZCQMBbb3m1kVOy6LbgYUpA+B9y3Rfbplwq+LnfUDUcG+h4Zvm4/hBPC5hhlk1
	 TooIJUrNtZY4pFB0qCYi/24KUAWRFbrjZ5JUJjYTv2TYkHlAu6coD/PH5GLflFQmIsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256990;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=xm/82lb0vdE7UE3lfCTgpLvIz8gxwRlNqpIHYX74QDw=;
	b=tpneloS6o9r/ytRfCtaa0DjjrzZjGB3GcICM+kj8tjoZA9PztuRv4ZoJW6CV+L2ZPgjJ
	 eSVujhm/cjdpYywo5M756nMrmjLMnYTQEYIXY6S3aKXK+DyPCRmtmxEub33lnE98tDfNg
	 Id8JyYlTGyqrx0MZQXRGxZL3PBNzsKBkjMspb/DYKJrtHM+n0EohmdAe/iVJlvn/l6KJp
	 sStg/LP66siC2Mw5hvrCsXDwMww7P91vGTzLrCKHOi8xGaBjX7BKPZHYilErZsLCc9R8M
	 xJN9aRT7BWE5HnA/VjPwCG7qqI5+lnJW4vDk1Lk1oS8U843pa3ibhDQEDlJu6pEs2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G2/AnfBb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A50606A31A;
	Thu, 29 Oct 2026 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2/AnfBb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6283E1F01828;
	Thu, 29 Oct 2026 06:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793256989;
	bh=xm/82lb0vdE7UE3lfCTgpLvIz8gxwRlNqpIHYX74QDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=G2/AnfBbNO0zt72CeeVhNXL+8QKSwpiUw2d2rwFl8G/YCRD/OBkWfpRV5O5cQWu7s
	 3MvWhAeryn2J3r0LyEzJ2ys0PLv4CImqow6yugeYzfPhpPwhu9ARflIlrlZwo8xNqP
	 eW18BVZ3W4tXZpE8e0MBKdd5cU6ADvGfDmYp3nwG8NV4XMaZgGKRuz5PA6DOe5e873
	 5Nyv75DXTI8lAWMWHynNwRtnHZl+wQht+ZAwyWWlgoPHdhCMBZ7H4tJRA2/m2a7r/z
	 OjBvGLMs1WERnExaZMc/hhgstmCojzyA/PUO7Kw4pycWBzbM3inTRQ8z8PL7aDRNOs
	 n2R3XweWme1Aw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 09/16] tsm: Remove the device from lookup before PCI
 teardown
In-Reply-To: <179321444108.2412245.9613928294789740313.b4-review@b4>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-10-aneesh.kumar@kernel.org>
 <179321444108.2412245.9613928294789740313.b4-review@b4>
Date: Thu, 29 Oct 2026 12:26:17 +0530
Message-ID: <yq5abj8datbi.fsf@kernel.org>
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

Jason Gunthorpe <jgg@nvidia.com> writes:

>> [ ... 22 lines skipped ... ]
>> -static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
>> -						 struct pci_tsm_ops *pci_ops)
>> +static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)
>>  {
>>  	int rc;
>>  
>>  	if (!pci_ops)
>> -		return tsm_dev;
>> +		return 0;
>
> Aside unrelated to this series: Do we need this NULL pci_ops stuff? I
> don't know what it was imagined to do, but now that we have split
> things up attestation subsystem I wonder if it would ever be useful?
>
> It is quite a maze of unused layers in here..
>


Agreed. I'll remove it; we can always add it back if a use case arises.

>
>>  
>>  	tsm_dev->pci_ops = pci_ops;
>>  	rc = pci_tsm_register(tsm_dev);
>>  	if (rc) {
>> +		tsm_dev->pci_ops = NULL;
>  [Severity: Medium]
>  Does this unprotected write to tsm_dev->pci_ops introduce a race condition?
>
> And of course sashiko finds races in all this unused complexity...
>
>> [ ... 14 lines skipped ... ]
>> @@ -96,15 +95,22 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
>>  	if (rc)
>>  		return ERR_PTR(rc);
>>  
>> -	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
>> +	rc = tsm_register_pci(tsm_dev, pci_ops);
>> +	if (rc) {
>> +		device_del(dev);
>  [Severity: Medium]
>  Can this error path lead to a use-after-free if PCI registration fails?
>
>  Since device_add() is called prior to tsm_register_pci() in tsm_register(), 
>  the device is already exposed via class_find_device(). If a concurrent 
>  connect_store() finds the device and proceeds to pci_tsm_connect() before 
>  this error path cleans it up, it will attach the PCI context to tsm_dev.
>
> Fun. Usually device_add should be the last thing in any driver flow,
> not the first.  There should not be any device_del on error paths.
>
> Because of races like this...
>

I now have:

struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
{
	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
	struct device *dev;
	int rc;

	if (IS_ERR(tsm_dev))
		return tsm_dev;

	dev = &tsm_dev->dev;
	rc = dev_set_name(dev, "tsm%d", tsm_dev->id);
	if (rc)
		return ERR_PTR(rc);

	/* Complete PCI registration before exposing the TSM to class lookup. */
	rc = tsm_register_pci(tsm_dev, pci_ops);
	if (rc)
		return ERR_PTR(rc);

	rc = device_add(dev);
	if (rc) {
		if (pci_ops)
			pci_tsm_unregister(tsm_dev);
		return ERR_PTR(rc);
	}

	/* Notify TSM userspace that PCI/TSM operations are now possible. */
	if (pci_ops)
		kobject_uevent(&dev->kobj, KOBJ_CHANGE);

	return no_free_ptr(tsm_dev);
}

-aneesh

