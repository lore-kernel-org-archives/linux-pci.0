Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2737E307;
	Mon, 29 Jun 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750761; cv=none; b=pVV/utaa/VKpwMhvnLiTeq79w4on72LeW2u2Ib7oM5KwgfOSZ8rzrTe74zgmqC4CDFH1KsBFu1F5joH3v6LnfOdDWOJbiqW20np7PnYGscemdRfzcgzCoj+FbSXDMyStUaJzpDyqqrzcWjk54iHOUkssUjZ2pzpfE/yh3airN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750761; c=relaxed/simple;
	bh=WIdkcAohK7LeGO5ya6PB5DsiIrkffvVoD27wmvkjpgU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TqjelhlFGnq+U0spdFZSBleTAAaiiyohPCi4QocIsRKd5TTVR/4bG6BqTjQoAxA3IxOgNKbgYfBEbJ7yLsvxORZa/MLezVnBYy1KVavlSxHUbyoJ76E000kELWXVONWNQN6UIeJc541vPc4pnVi3QEeoDbUxOdmhxqfdeS+EiCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=qh88UNuk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="qh88UNuk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1782750749;
	bh=lEyeCapBsVXYSpplIUA0PN6OvGWLHmv5pdfFL1Phu/8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=qh88UNukwFc6dT9j/eKGL1AmHTkKB4THBoN2h8ulr24M43yQI7H2a3DniuYI4YQU/
	 y+sEySwE1m/Yf7Z4VFExs88su0MVH5q9LvDDgm3FgbSwSerHA0qE+99HtFGQuSq59g
	 FxbGAdDGAJa0us+28P1h8SwZbStEfY16odXIDBqOwMFsZRmzUmX3G24DLlJPC9HqMt
	 AlrhiIGH2v4UHN+lsmYX4xgJg8hyB5WUMln6lluFMWJe2rYqxANowUQAhfaoHNwZ4s
	 g1DEDbhTRfl1prBKA0d/k+37/uM3L3gfGP5wgLmM81glk8mKfiDysdxeSh8Nd0lNCJ
	 lz5QMzOgdFabA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4gpsJ43jdmz4x1q;
	Tue, 30 Jun 2026 02:32:20 +1000 (AEST)
Message-ID: <57055684-2008-4ba3-bfa8-674317be1a71@ozlabs.org>
Date: Mon, 29 Jun 2026 17:32:14 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] vfio/pci: Permanently revoke a DMABUF on request
Content-Language: en-GB
From: Matt Evans <matt@ozlabs.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-9-matt@ozlabs.org>
 <DM6PR11MB3690886693898AD755FB246F8CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
 <31d1265b-e264-4dc6-a8c3-1b64dc9867a1@ozlabs.org>
In-Reply-To: <31d1265b-e264-4dc6-a8c3-1b64dc9867a1@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kevin,


Digging this one up again,

On 17/06/2026 17:08, Matt Evans wrote:
> Hi Kevin,
> 
> On 16/06/2026 10:26, Tian, Kevin wrote:
>>> From: Matt Evans <matt@ozlabs.org>
>>> Sent: Wednesday, June 10, 2026 11:43 PM
>>>
>>> Expand the VFIO DMABUF revocation state to three states:
>>> Not revoked, temporarily revoked, and permanently revoked.
>>>
>>> The first two are for existing transient revocation, e.g. across a
>>> function reset, and the DMABUF is put into the last in response to a
>>> new VFIO feature VFIO_DEVICE_FEATURE_DMA_BUF.
>>
>> VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE
>>
>>>
>>> VFIO_DEVICE_FEATURE_DMA_BUF passes a DMABUF by fd and requests that
>>> the DMABUF is permanently revoked.  On success, it's guaranteed that
>>
>> ditto
> 
> Argh, thanks for catching these.  Fixed.
> 
>>> the buffer can never be imported/attached/mmap()ed in future, that
>>> dynamic imports have been cleanly detached, and that all mappings have
>>> been made inaccessible/PTEs zapped.
>>>
>>> This is useful for lifecycle management, to reclaim VFIO PCI BAR
>>> ranges previously delegated to a subordinate client process: The
>>> driver process can ensure that the loaned resources are revoked when
>>> the client is deemed "done", and exported ranges can be safely re-used
>>> elsewhere.
>>
>> probably clarify that re-use by creating a new dmabuf fd as the original
>> one is essentially zombie now.
> 
> Reworded this, plus added a note re the change below.
> 
>>>
>>> +/* Set the DMABUF's revocation status (OK or temporarily/permanently
>>> revoked) */
>>> +static void vfio_pci_dma_buf_set_status(struct vfio_pci_dma_buf *priv,
>>> +					enum vfio_pci_dma_buf_status
>>> new_status)
>>> +{
>>> +	bool was_revoked;
>>> +
>>> +	lockdep_assert_held_write(&priv->vdev->memory_lock);
>>> +
>>> +	if (priv->status == VFIO_PCI_DMABUF_PERM_REVOKED ||
>>> +	    priv->status == new_status) {
>>> +		return;
>>> +	}
>>
>> the only interface to request PERM_REVOKED is via the new ioctl.
>>
>> vfio_pci_core_feature_dma_buf_revoke() returns -EBADFD if
>> it's already in PERM_REVOKED.
>>
>> so this check shouldn't be reached, suggesting a warning.
> 
> Good point, both any change to PERM_REVOKED or a double-set of the same
> state indicate some caller has gone wrong.  Added a warning.

Well, after the D0/D3 reset thread, I noticed while testing that a
double-revoke will naturally happen when cleaning up a buffer that was
already revoked by a device having previously transitioned to D3.

Similarly, cleaning up a buffer that was explicitly (permanently)
revoked leads to an attempt to set TEMP whilst PERM, and this is OK too.

So the only "surprising" case is a buffer already in the PERM_REVOKED
state getting a second PERM_REVOKED (which is weeded out in the caller
as you point out).  Any new caller asking for PERM_REVOKED repeatedly is
odd, but still gets what it wants.  I really don't think a warning is
warranted just for that (it's safe either way).  Sending this
explanation separately, so you are not too disappointed if v4 reverts to
this existing condition above...  :)


Thanks,


Matt


> 
>>> +
>>> +	dma_buf_invalidate_mappings(priv->dmabuf);
>>> +	dma_resv_wait_timeout(priv->dmabuf->resv,
>>> +			      DMA_RESV_USAGE_BOOKKEEP, false,
>>> +			      MAX_SCHEDULE_TIMEOUT);
>>> +	dma_resv_unlock(priv->dmabuf->resv);
>>
>> It's existing code but while at it let's make above conditional to
>> the actual revoke path. for unrevoked it's not required given the
>> previous revoke already cleans up everything.
> 
> I noticed this too though I was consciously trying to keep the diff as
> small as possible.  But with this feedback from both you and Praan, I'll
> move this.  It's still pretty readable before/after.
> 
>> otherwise,
>>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> 
> Thank you.
> 
> 
> Matt
> 

