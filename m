Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0BD45D921;
	Mon, 12 Oct 2026 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796504; cv=none; b=REjcrLSEZ5ts++oqoQisSGkM7wgmwsXpZcoti32foEKAGdMx6GanCJxZDTyGWQSWwcmElxl3cibs4UiPoq8EcYVfOel87ySGFhsCiqOUBQExSiq2iNDER45nSiRuqVMTAORyC99WAE/7B+WPTO9VwDay89wwtMGZvUQ4Jja/61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796504; c=relaxed/simple;
	bh=wa/y7uAKyiAHBNtIYD1dmzBcK/WRQvA5lG8dWR2sAmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YKqxHWeilr/KxcOFS91fmpReDZUnObzyagg5EQCqE5bDGA2+goFxgm7g5ABx/paWmTP71cgMijbk0kKN0K+5oNjKWXh/Bw2Tikt7d/+U7KJeKlRjWYNWeR8W+vJSNa3YdGT5h90M/3xpBNF6MPMaNa6tvFhyyq1M3m4JFfknn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIcx3XSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIcx3XSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BFA1F0089C;
	Mon, 12 Oct 2026 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791796503;
	bh=dJfud/jMsdkOXHAbu78ikuLmB6vnTo/8gDUfonWvO84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=UIcx3XSK40mYNy5nI/NyJ98yCPrLiu1xI/Ss2K7xZBBsrO53Ou001C3KtsENUp53y
	 Dx9Q7NT+qraEAT/j2uYG/7Ex98D8Zfi6CsWiaklCSHoGrA9eTlDafiJrTzo9mZ5moS
	 KVyNPdez6g2ePXwZ2OhudbLrrWgcPvuaCPXJN1duWnWm+alUdbAHHODq3f0WPnBwzl
	 juC4B9vjrvN7lWHykshR1GQXtJsm5fxLhkHqrmx5fPJULQXnKe8lkie7E83UfsUC5W
	 rmhddJZ2eKjkv3ZD8Kdg2J++psYi5pz/b8OLUq4YlYmAqn/sPLpCqW/5R6O9KaOKCI
	 RTW5U/lLDfDbQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: sashiko-reviews@lists.linux.dev, linux-coco@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 09/16] tsm: Remove the device from lookup before PCI
 teardown
In-Reply-To: <sashiko-outbox-163673@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-10-aneesh.kumar@kernel.org>
 <sashiko-outbox-163673@kernel.org>
Date: Mon, 12 Oct 2026 14:44:58 +0530
Message-ID: <yq5a33ub5lgt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] tsm: race in tsm_register() error path leads to UAF and NULL pointer deref
> --
>
> commit f9b77b7469552ae6078c3a47333908a88eec2474
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>
> tsm: Remove the device from lookup before PCI teardown
>
> This commit modifies the teardown flow to remove the TSM device from
> lookup before tearing down the PCI state. It also adjusts the setup
> flow in tsm_register() to handle PCI registration failures differently.
>
>> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
>> --- a/drivers/virt/coco/tsm-core.c
>> +++ b/drivers/virt/coco/tsm-core.c
>> @@ -56,26 +56,25 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
> [ ... ]
>> -static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
>> -						 struct pci_tsm_ops *pci_ops)
>> +static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)
>>  {
> [ ... ]
>>  	tsm_dev->pci_ops = pci_ops;
>>  	rc = pci_tsm_register(tsm_dev);
>>  	if (rc) {
>> +		tsm_dev->pci_ops = NULL;
>
> [Severity: Medium]
> Does this unprotected write to tsm_dev->pci_ops introduce a race condition?
>
> If pci_tsm_register() returns an error early (e.g. if a driver incorrectly 
> provides both link_ops and devsec_ops, returning -EINVAL before acquiring 
> pci_tsm_rwsem), a concurrent userspace write to the connect sysfs attribute 
> might trigger connect_store().
>
> If connect_store() evaluates is_link_tsm() concurrently, this lockless 
> assignment to NULL on the error path could cause the compiler to reload the 
> pointer after the NULL check. Could this lead to a NULL pointer dereference 
> when accessing ->link_ops.probe?
>
>>  		dev_err(tsm_dev->dev.parent,
>>  			"PCI/TSM registration failure: %d\n", rc);
>> -		device_unregister(&tsm_dev->dev);
>> -		return ERR_PTR(rc);
>> +		return rc;
>>  	}
> [ ... ]
>> @@ -96,15 +95,22 @@ struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
>>  	if (rc)
>>  		return ERR_PTR(rc);
>>  
>> -	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
>> +	rc = tsm_register_pci(tsm_dev, pci_ops);
>> +	if (rc) {
>> +		device_del(dev);
>
> [Severity: Medium]
> Can this error path lead to a use-after-free if PCI registration fails?
>
> Since device_add() is called prior to tsm_register_pci() in tsm_register(), 
> the device is already exposed via class_find_device(). If a concurrent 
> connect_store() finds the device and proceeds to pci_tsm_connect() before 
> this error path cleans it up, it will attach the PCI context to tsm_dev.
>
> When this error path calls device_del() and returns, the __free(put_tsm_dev) 
> guard at the top of tsm_register() will drop the primary reference to 
> tsm_dev, freeing its memory.
>
> Because the attached PCI context stores the pointer without taking an 
> additional device reference, wouldn't this leave a dangling pointer in the 
> PCI context, resulting in a use-after-free on subsequent accesses?
>
>> +		return ERR_PTR(rc);
>> +	}
>> +	return no_free_ptr(tsm_dev);
>>  }


I think this problem already exists upstream. We should delay
device_add() until PCI/TSM registration succeeds. The kobject event
should also be emitted after device_add(). I will add the fix as a
separate patch.

-aneesh
