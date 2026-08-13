Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41B3955F9;
	Thu, 13 Aug 2026 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636223; cv=none; b=ABgq6j1MaGL0RZ5CxD5rv6FZMiiPyq9QKVTVVtjqbdsThQRkeEGe3ZWxv62avn5BDlQa5Q9DLgyENc119aQg/ppLT6TLf9Wjx9IDtm1qzppLpXCfwPKk20sJdkZ1C7fz8RuswcjfPH1wV/w6VH1KtXAgjW7eHfeQWlfq3YhEZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636223; c=relaxed/simple;
	bh=r4fAFmUDrtddKraDNS8TmzAzDA8Z1bk/cbz11RoC7dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXnXcftWAjt0eM64liW7H5Brh5Fsa8wMTLTVr7znw1THeNCW4kdDa4+zion0waLrW9xFZanQSuBq43GdmIdfbvDQdtj4CtlsZD1rbdXKPpU6AAPO5nqntabFWkjQoukk8M1IwNG6DRGgyDfjyR1UT3+Zkp9+BagSnGMd0erQGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=HksqieLv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="HksqieLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1786636209;
	bh=XIhu+nqQzjz2LR4uuSfg1nS0R2BhHb+M3dJJmBjOuH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HksqieLv+7l3go3qji728AvWDA/KOIJMhP8NA/h/2+sy+kKQunlYCHfEKDxNClQPF
	 2D+lUyQofOGCJVyhHzI5v3ELDfMKl3kpqVhDP3ogL5IJH3aOoKdsrlF7u3JZrLzOGy
	 ZGu9k5dFmblugyvQNVlLvLpkCIoz0pa9PBSxtiVGqQVeB3fQg85ECFqBaCv8vrKUt4
	 +wJ3G00wsquFBfzpJJNV72lRDJWGxD8tzO0ohmJmot+a8+DWMPNEhwLskicyzMR4ja
	 g7zeN2f8qpeqfmHY3gxZ8WkX/zrkWO/QkFI5gp6aLodJtQ+w2/En3WS01z1nuBvVCv
	 73KeJrw3kUHmw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hLVDR6fLRz4wDm;
	Fri, 14 Aug 2026 01:49:59 +1000 (AEST)
Message-ID: <2ba56abd-797c-4051-b345-e025a5ed0421@ozlabs.org>
Date: Thu, 13 Aug 2026 16:49:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-8-matt@ozlabs.org>
 <20260729115204.2a9a50b2@shazbot.org>
 <6a964960-722c-44b5-837d-9d582aeb0a3c@ozlabs.org>
 <20260804141022.71b6429d@shazbot.org>
 <291625a2-f281-4c05-b51f-553018a34b08@ozlabs.org>
 <20260812140657.247b9fa3@shazbot.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260812140657.247b9fa3@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hola Alex,

On 12/08/2026 21:06, Alex Williamson wrote:
> On Tue, 11 Aug 2026 16:58:43 +0100
> Matt Evans <matt@ozlabs.org> wrote:
> 
>> Hi Alex,
>>
>> [snip]
>> Isn't the init-time 'event horizon' for writing the bitfield the
>> vfio_register_group_dev() in vfio_pci_core_register_device(), after
>> which synchronisation is needed?
>>
>> The hisi_acc_vfio_pci driver's .probe calls
>> vfio_pci_core_register_device() and _after that_ sets
>> zap_bars_on_revoke, and that's now in the "needs synchronisation to
>> write the bitfield" phase.
>>
>> (Re-reading my comment in vfio_pci_core_register_device() I'd noted
>> this, "Drivers can opt out after registration".  Has to be done after by
>> definition as the default's set in vfio_pci_core_register_device().)
>>
>> The concern is just blatting neighbours in the bitfield, not the window
>> of time before the flag's set.  The flag's an opt-out of a safe but (for
>> this driver) unnecessary zap, so having it unset for a short time is OK.
>>
>> I still think this really should be a standalone bool, not a bit in the
>> bitfield.  It has to be set after registration and having to take a lock
>> to do that has downsides.
> 
> You're right on the ordering, the device is live after
> vfio_pci_core_register_device().  However, I think that's evidence that
> vfio-pci-core is setting the default polarity, inferred from the mmap
> op, in the wrong place.  It should happen in init, not register_device.
> 
> The same mmap op pointer is available in vfio_pci_core_init_dev(), which

Ahaa, they're passed into vfio_alloc_device()!

> is used by all vfio-pci variant drivers in their init callback.  The
> proposed vfio_pci_core_register_device() change just needs to be lifted
> into vfio_pci_core_init_dev().  hisi_acc is then modified to fix the
> flag after vfio_pci_core_init_dev(), something like below.
> 
> I think that's better than anticipating it being dynamic when we don't
> have a use case that requires it.  Thanks,

Yes, that works nicely.  Done.  As ever, thanks for the suggestion.


Matt


PS: Series v6 has several improvements/review fixes ready, but I'm 
holding off posting it.  It'd depend on resolving the awful deadlock I 
posted about on patch [4/9].




> 
> Alex
> 
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1564,6 +1564,7 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
>          struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>          struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
>          struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
> +       int ret;
>   
>          hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
>          hisi_acc_vdev->pf_qm = pf_qm;
> @@ -1575,7 +1576,9 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
>          core_vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_PRE_COPY;
>          core_vdev->mig_ops = &hisi_acc_vfio_pci_migrn_state_ops;
>   
> -       return vfio_pci_core_init_dev(core_vdev);
> +       ret = vfio_pci_core_init_dev(core_vdev);
> +       hisi_acc_vdev->core_device.zap_bars_on_revoke = false;
> +       return ret;
>   }
>   
>   static const struct vfio_device_ops hisi_acc_vfio_pci_migrn_ops = {

