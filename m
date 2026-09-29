Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE952842D;
	Tue, 29 Sep 2026 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691157; cv=none; b=cPTeCEeYp9Fu/G1ShGpqY3qvToGR5hmxhAwHWNMivyk0bWsMsCogM3W03x3V02GUQ4psNjtfqHDD1DQ3AdJiJpyM2OS+Nrtdu0Mh3jNCgJT59Pvs22ZBWZLVOzQXHxnMDE2jRa1dmC4lmXMq4H4r9YL26RarqO6KrKIgKe4wbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691157; c=relaxed/simple;
	bh=KxYUde1/KEXNJejqTrFp4SUYsnBB9mXRBQ/AuHK+DCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hi8kkU8uVEzTiTWF6/jkOh79Dw7kP53HJuPaEtp3l8X55SrRjUnlNQzj3xYOW2cc2X/8XtGDHeqNWDUYiESySMaZLX8438JbtCPAMQZJTSC5KGXZq+v6uXFuLk44Ti8nTRkUyPcTf0fi+LH1AYQP/GbAlcPxn0B97f2k6So1yw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=WNfyQU9c; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="WNfyQU9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790691123;
	bh=Aw7Hjrk1sBkpUcXdU7XN6UKj9w+0U2HAjIBfpJZKRPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WNfyQU9cFo10yl6/oCL5McnApoxTM1lNPigavhilb6ac/iMqQbs2+CTZNV71NdtyQ
	 1Pyk2z/R7Cp2x/CWk2KXrJ1DFXPYrx9AJa5ZLzKWjhX7sZnDAPLbObovErSYy3u0r1
	 DaUJ24j/AX7JR/CJ6ow7MG1GMd+v0qhH/Dg2k+V/aLD88bXkTEjU7UVjug/1koKAsV
	 l7/F4EKw/FflF5aeqzk7An1xdxtr5SG/JCL4ECbh/YXmJ0xhteB93OXzBx3IfDcPI/
	 8yTPHO/qGHhTFJJS+ROhm/wqKlCQaM4lkalfAsRnUr8++IZj4xrs2zwv2UM/F8HhqJ
	 J6f2It0H3NHyQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hvKqh2QQ3z4wDw;
	Wed, 30 Sep 2026 00:11:59 +1000 (AEST)
Message-ID: <cfc03c25-2900-48fa-bba0-01e3283232a5@ozlabs.org>
Date: Tue, 29 Sep 2026 15:12:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/9] vfio/pci: Remove DMABUF export dependency on
 vdev->memory_lock
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, media-ci@linuxtv.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-2-matt@ozlabs.org>
 <20260924153737.951E71F000FF@smtp.kernel.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260924153737.951E71F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Robot,

On 24/09/2026 16:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] vfio: incorrect initial DMABUF revoked state allows DMA to disabled BARs
> --
> 
> commit fb51fe9e3cab37471d1c4237de83fcf89aad79f5
> Author: Matt Evans <matt@ozlabs.org>
> 
> vfio/pci: Remove DMABUF export dependency on vdev->memory_lock
> 
> This commit introduces a new dmabuf_lock to protect the list of exported
> DMABUFs and a new bars_revoked flag for tracking BAR revocation state. This
> removes the dependency on vdev->memory_lock during DMABUF export in
> preparation for future mmap refactoring.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 6757054e9d875..1f60661078313 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -663,6 +663,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>>   		vdev->has_vga = true;
>>   
>>   	vfio_pci_core_map_bars(vdev);
>> +	vdev->bars_revoked = false;
> 
> [Severity: High]
> Is this hardcoded initialization safe?

I believe so -- this report seems to be incorrect.

> Earlier in vfio_pci_core_enable(), pci_try_reset_function() is called,
> which performs a fundamental reset that clears the device's
> PCI_COMMAND_MEMORY bit in the physical hardware.

First, on entering any driver probe, the PCIe function is enabled (MSE=1).

The HW FLR does indeed clear MSE, but pci_try_reset_function() 
saves/restores config space either side of the reset:  since it starts 
out enabled, the pci_dev_restore(dev) in there means that 
PCI_COMMAND_MEMORY is re-enabled after the reset.

And for a device that doesn't have a reset method, MSE is never cleared 
so is also enabled through vfio_pci_core_enable().

> Then vfio_config_init() populates the virtual config space by reading from
> the hardware, capturing PCI_COMMAND_MEMORY == 0. Does initializing
> bars_revoked to false here fail to match that initial virtual config state?

vfio_config_init() runs after the above has restored/left MSE=1, so the 
vconfig captures memory enabled.

So, vdev->bars_revoked = false is correct here.  (I had considered 
initialising it based on the read value of MSE, but I can't see a way 
for MSE to be 0 here.)

>>   
>>   	return 0;
>>   
> 
> [ ... ]
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index c16f460c01d68..847ee5cc78e7f 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> 
> [ ... ]
> 
>> @@ -305,12 +305,27 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   
>>   	/* dma_buf_put() now frees priv */
>>   	INIT_LIST_HEAD(&priv->dmabufs_elm);
>> -	down_write(&vdev->memory_lock);
>> +
>> +	/*
>> +	 * dmabuf_lock synchronises access (R) or updates (W) to the
>> +	 * vdev->dmabufs list and to bars_revoked (see below).  The
>> +	 * revocation state of DMABUF elements in the list is written
>> +	 * holding both dmabuf_lock(W) and resv, and tested with
>> +	 * either.
>> +	 *
>> +	 * dmabuf_lock -> resv
>> +	 *
>> +	 * vdev->bars_revoked tracks the BAR revocation status updated
>> +	 * via vfio_pci_dma_buf_move(), so the initial DMABUF state
>> +	 * follows the same criteria that later update the DMABUF
>> +	 * state (BAR zap, etc.).
>> +	 */
>> +	down_write(&vdev->dmabuf_lock);
>>   	dma_resv_lock(priv->dmabuf->resv, NULL);
>> -	priv->revoked = !__vfio_pci_memory_enabled(vdev);
>> +	priv->revoked = vdev->bars_revoked;
> 
> [Severity: High]
> Can this incorrect initial state allow P2P DMA to disabled BARs?

Nope.

> If userspace exports a DMABUF at this point,

Above, the flag value is correct, but also one can't export a DMABUF 
from a VFIO device that hasn't completed initialisation.


Matt

> the DMABUF inherits the
> un-revoked state from vdev->bars_revoked (false), bypassing the correct
> state evaluation.
> 
> Could this permit P2P DMA to this DMABUF to be allowed by the kernel but
> dropped by the endpoint since memory decoding is disabled? This would trigger
> PCIe Unsupported Request (UR) errors, which could potentially be weaponized
> by unprivileged users controlling the VFIO device to trigger AER and crash
> the host.
> 
>>   	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
>>   	dma_resv_unlock(priv->dmabuf->resv);
>> -	up_write(&vdev->memory_lock);
>> +	up_write(&vdev->dmabuf_lock);
>>
> 

