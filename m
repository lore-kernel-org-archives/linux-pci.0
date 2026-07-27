Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157A3FADE5;
	Mon, 27 Jul 2026 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159966; cv=none; b=VV2N+nguONrlH0uvlvLUv0EG9Bc0a0qn8Osk18ubBL2WX3frdx6oHZBhuWhkqywzdxUPea8LEHLEp+ZYNRtTsu9qVenmvHcTK8uaSgNk5Im0eVsFDM4ywatlUZ/bqUI1CXI4Ce7ccoLa4mO7tR4ThSlF3XpxW5iIEhVcYpnARtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159966; c=relaxed/simple;
	bh=uZR06OsYX7bLFAlwTYUUY5e2nSFlRtrdQ76TYNgR/LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klleg3ZW60BNMxQPFmOAJTI2leqEMQaT/+/WUZYwl771i/u6Zc0L00exF8Cv4xOz5W1Yl8gznTGcjLqIRYiDnvAlIpBbFHqn1xXxXgNwW2iVxWO282tzl4M8laKypekXf3PB105481GDXD3W1GSnwTR0fyJouyiwyRRcWZlm860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=aKBlSe1B; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="aKBlSe1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1785159963;
	bh=DztvKC6RI7e0C3xqh2KV+oSshUYJibZtujJTSmc47ck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aKBlSe1Bxj7jRHnppBdIVn1S94JHLAWklNDbJKJqbNhcznvuvyIh61hNLjYHHH1HL
	 TXsDdRzKR5ocZhjXQ5bEgkvqJVEO1qw0NP1yzFg35S5n48NWnaIZwxYbjIw1HvhFV8
	 iRCf9TjBanTlueDKuYRGwh30Y6Iudyp7WoJ4Zh9HM1GUx8BXjG++KBt6PKjRywRNH0
	 C9K3oTmr3nPX08PgCT7WLndFHfvE6vwy7b+Bwt2SlVaLHss28BWvhVikc3v1DaQVa8
	 eXuUlXHEC+m/3z0nTbCENC97h6mSvzZJdzQ5BW/yjUVSEJwJoTre0B7HDXVd2o+vwH
	 jvpvGZB1I09hw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h80HG2jTtz4w1j;
	Mon, 27 Jul 2026 23:46:02 +1000 (AEST)
Message-ID: <2b8961fb-efab-4d0d-a577-32ccf87e4a9e@ozlabs.org>
Date: Mon, 27 Jul 2026 14:45:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] vfio/pci: Permanently revoke a DMABUF on request
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-10-matt@ozlabs.org>
 <20260715181131.12E0A1F000E9@smtp.kernel.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260715181131.12E0A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear robot,

On 15/07/2026 19:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The function `vfio_pci_core_feature_dma_buf_revoke` mixes `goto`-based error handling with scope-based cleanup helpers (`scoped_guard`).
> --
> 
> --- Patch [9]: [PATCH v5 9/9] vfio/pci: Permanently revoke a DMABUF on request ---
> commit 668793566cfbdb5cee2b0a69188ebbada38dd4d5
> Author: Matt Evans <matt@ozlabs.org>
> 
> vfio/pci: Permanently revoke a DMABUF on request
> 
> This commit expands the VFIO DMABUF revocation state to allow permanent
> revocation via a new VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE feature request.
> It refactors the revocation logic into a common function used by both
> the move path and the new feature request path.
> 
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index ccfe861f88b66..36bf07530840d 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> [ ... ]
>> @@ -671,9 +696,72 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
> [ ... ]
>> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops ||
>> +	    READ_ONCE(priv->vdev) != vdev) {
>> +		ret = -ENODEV;
>> +		goto out_put_buf;
>> +	}
>> +
>> +	scoped_guard(rwsem_write, &vdev->memory_lock) {
> 
> [Severity: Low]
> Is it intentional to mix goto-based error handling and scope-based cleanup
> helpers in the same function?

Yes.

> The subsystem guidelines for cleanup helpers recommend against mixing goto
> labels with scoped_guard in the same routine, to avoid confusing ownership
> semantics and potential resource leaks during future refactoring.
> 
> Could the dma_buf_put cleanup at the out_put_buf label be converted to use a
> scope-based helper, or could the scoped_guard be replaced with traditional
> locking, to keep the error handling style consistent throughout
> vfio_pci_core_feature_dma_buf_revoke?

Those guidelines are good, and exist for clarity.  It's a good idea to
avoid jumping into or out of scoped_guard blocks.  In the case of this
function, it is clear what is going on regarding the scoped_guard, and
the pattern is:

- Verify input values; exit if unpalatable, else:
- Do the scoped_guard block to perform action

There is, IMO, very low scope for confusion from mixing one goto +
scoped_guard here.

(Mixing goto-out and return is worse, and this function is guilty of
that.  However, converting four if()s to ret = -EFOO; goto out; would
make the function longer and actually a little harder to read.

IOW I think it's fine as is.


Matt


> 
>> +		if (priv->status == VFIO_PCI_DMABUF_PERM_REVOKED) {
>> +			ret = -EBADFD;
>> +		} else {
>> +			vfio_pci_dma_buf_set_status(priv,
>> +						    VFIO_PCI_DMABUF_PERM_REVOKED);
>> +			ret = 0;
>> +		}
>> +	}
>> +
>> +out_put_buf:
>> +	dma_buf_put(dmabuf);
>> +
>> +	return ret;
>> +}
>> +#endif /* CONFIG_VFIO_PCI_DMABUF */
> 

