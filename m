Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1883F44C9
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421737; cv=none; b=cS/LTFIKorxOnVgpHLCI/UHfz5KCDjXCdv1J2f1w6o7rw5uJzzoQbtGlDdQnzIKMZ5C+yoKDDeiFG5Poh/dHn7UKc1WJvPTQxonHGxEVnDhi1uBdGD+ArQJVa8wOeSfZyDSyXIUa25JZhIocP9aiMJdWrlVwekb5qwy+ZISmzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421737; c=relaxed/simple;
	bh=Wg1cGEvf4eUUparaBKFdmSoP05uvZScjagMBX6sVw6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqyhGpw6zQ09phx73ZRRqvlD9sJPeD6K1dPFqaWEEPfjBNuHuGpAI7JtHQb+/ZetOjc1+iQLPzriIT/qCx75SJQ3ElvptBoWJMEH4PZ5zdoK/idmennYvQjMvg/qRKTEhR2FtP8MlcmYbLvX+CYSDIqV2G+J589nZoO/Z+a0aoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bzK53O8X; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bzK53O8X"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652FS9Lx2304028
	for <linux-pci@vger.kernel.org>; Tue, 2 Jun 2026 10:35:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=VfBI5NycCM1cqMEOobD2RppGZmJi32soF0kYJH2gcuU=; b=bzK53O8XujCu
	MBFdW29mz/kF0qikNM+USVwmd8ECo/ryDkIWpwB5MA41Qdkg5AxczQfUI/eKqhDS
	iM+8YTVrGnM/C5ql3dTU9NmKo13jiYM2b0odvntyyQ2a0NGJlukR595Q8/wPsbe1
	Th3DHAph810B/WXMYZfk+pBO3kTfJUA/7BcahWhiKtFh1nnG7f3kyyEmJDYKEFHG
	iufu6oOYnitpV/tI3/xYW/yGc/E7J5P0tvE8WkvDVYo4cCPHoR64RSzGEh/7eIKv
	aSG89ftmXERN5KAq0Irj0fX64YAk+9Fi8DHxol+HdmfUYUSI68fU1dQibfWDytp9
	Y8ZyiDrw9Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ej1uhrwwm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 10:35:33 -0700 (PDT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304f23c55b2so4251392eec.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 10:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780421733; x=1781026533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VfBI5NycCM1cqMEOobD2RppGZmJi32soF0kYJH2gcuU=;
        b=VHM6WPfUEy0L8CebVuuSn4oAx5T3/0sqG+P9P/ND8Lyi2bRC4RAR6j06vzjLtjJGBv
         5/dUpSWBR2VwOiXA8255x45fA02XtFVwzI8qBZM6n3XNmRVWVRtdjaMtPLP+ciuNkisI
         cpM3NIM5fMVziDaOf7GXiXYoKgnp0vJMxN2I5CkAHjwDdqRbRcy1fZEheOrlqTOfZ21j
         9j1rlXENwZnbuycImedIIRLzcEsGy+lJhInCHZGoY/ildhxYClZ0NVFSaBu8e4y4lUvd
         7X9nF3T/WbF6GYRgL6avTGxKm36TGF7uu5fbLKOOOiEqghmSmN+LokYd+Pm/zKVGs98D
         Uz3g==
X-Forwarded-Encrypted: i=1; AFNElJ+VK/3ugzqWwWFuVInYeBN+Kj+S9OOotB03G0sEsqM0huoge3zFf3GIZ+pYv8mWiUplOMBQjy3qbXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6STCN0c22IOctdU4yUN323WBVcN7z7RUpzzZWiCrFR2oeFd6L
	4sHPTr4apx5URGVGeERE2ttOyjJrWbv7WgI3MRhboWJnEZzqobDvtmbyauujjXdBY45XhIivQAF
	V0Yt/CFHjPG7xvQmmi4qjw/0WQbyXuN5V652p7UBmy2RlGyS/palKtaW04CoH
X-Gm-Gg: Acq92OFVd++XMO4TXKJ7q+Q2vUGmTf7yAyxs9FX3KEq8EYRrFg/zpfd2/x6eE1hE40B
	HNOYDB/iN6+x9yvWRI+PI37QosyazFziSq000tHT7/0+UePsdaKxbQgJG20iOIo7HiHQNQr6b3L
	I2RRGbeH1Vqlkc/WgxYLHF81YcZgsrSKeHGRd6VShyrnke39ag4tkiTsM9QweKdt6HeCZfLf4r8
	YC8A4/Ip6BezGbod+XXWb4PJO8jfFa/E34oTkemsjk0raygT+5Ap+nyYOJHX8xcIUCvDoLZD1KC
	mGTgNQnr+j8tX/YWH/GRc7o/qHEtGqhLoHB+BpFiHZxM320xGsNs+yu61hQw7HlEGOtB3JsZdQX
	BMvE/D/8xQfNeaXXZFr58nrliQ3Dm0hvDxq1x3d6r
X-Received: by 2002:a05:7022:ea32:b0:135:578a:cde2 with SMTP id a92af1059eb24-137d425908fmr7340363c88.34.1780421732576;
        Tue, 02 Jun 2026 10:35:32 -0700 (PDT)
X-Received: by 2002:a05:7022:ea32:b0:135:578a:cde2 with SMTP id a92af1059eb24-137d425908fmr7340319c88.34.1780421731546;
        Tue, 02 Jun 2026 10:35:31 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54db05csm298934c88.8.2026.06.02.10.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 10:35:31 -0700 (PDT)
Message-ID: <49c3554f-8ba7-4a00-aa20-a311b173fc0f@meta.com>
Date: Tue, 2 Jun 2026 18:35:25 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] vfio/pci: Support mmap() of a VFIO DMABUF
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Mastro <amastro@fb.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
        Pranjal Shrivastava <praan@google.com>,
        Alistair Popple
 <apopple@nvidia.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-8-mattev@meta.com>
 <20260528171527.46d0c21a@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260528171527.46d0c21a@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SIRDgp1LtiMVv0Sxpy1aBubZzkRRA5I-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfXxLZ2w29E/pVy
 xiCj+byGzsyt8q3/RRJbx6Gf2RMZrINKw70BVbS/lI1TagihQMNV/X+nqARwpWub1ANq/rSMdaz
 kFkV0xqauPTxERZwnEDNd4n4a8rCwOsT1jejOGiBJLB+RuZp5V/Ua6lXvU6QFBNirx/ciX7twJG
 ynSAAlyLfl0dMbblpoji3bYzYfD2CXGn+/6C4a45FgeKUH5qKmFg0LZ/5R8q1nR+w+YL07OQTxI
 Ya4zAMM8chpFlh0PmBdpnml2zJQ8w2y3P7/GXF+dmaOH3hwKjJgVwhDcE0aokTtKsrzrzdtfoxH
 TxbHSnHE9DGOFidXYc/k13vlu/9XtnnNWtXskFMDgsy5ybrYfxAk2ZFIvXwq/sP7jYrjV4SfsLb
 GWJOhWB0rzqe4PDXAMyPmRV6UfiT9P08RXTgucI9PEVOhWp7gExrb4LnqvXPQtvNmVas+4G4KmF
 +ZBkHLccZMWzak9zFoA==
X-Proofpoint-ORIG-GUID: SIRDgp1LtiMVv0Sxpy1aBubZzkRRA5I-
X-Authority-Analysis: v=2.4 cv=UshT8ewB c=1 sm=1 tr=0 ts=6a1f1465 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8
 a=oquhCkXgnwb2tx7nsGQA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01

Hi Alex,

On 29/05/2026 00:15, Alex Williamson wrote:
> 
> On Wed, 27 May 2026 03:23:10 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
>> support for mmap() of this fd.  This provides another route for a
>> process to map BARs, except one where the process can only map a specific
>> subset of a BAR represented by the exported DMABUF.
>>
>> mmap() support enables userspace driver designs that safely delegate
>> access to BAR sub-ranges to other client processes by sharing a DMABUF
>> fd, without having to share the (omnipotent) VFIO device fd with them.
>>
>> Since the main VFIO BAR mmap() is now DMABUF-aware, this path reuses
>> the existing vm_ops.  But, since the lifecycle of an exported DMABUF
>> is still decoupled from that of the device fd it came from, the device
>> fd might now be closed concurrent with a VMA fault.
>>
>> Extra synchronisation is added to deal with the possibility of a fault
>> racing with the DMABUF cleanup path.  (Note that this differs to a
>> DMABUF implicitly created on the mmap() path, which holds ownership of
>> the device fd and so prevents close-during-fault scenarios in order to
>> maintain the same user-facing behaviour on close.)  It does this by
>> temporarily taking a VFIO device registration to ensure vdev remains
>> valid, then vdev->memory_lock can be taken.
> 
> Suggest some general rewording of the commit log here, quite confusing.

OK!

>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c   | 79 ++++++++++++++++++++++++++----
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 27 ++++++++++
>>   drivers/vfio/pci/vfio_pci_priv.h   |  2 +
>>   3 files changed, 99 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index cfea59806a4f..41e049fa9a8a 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -12,6 +12,8 @@
>>   
>>   #include <linux/aperture.h>
>>   #include <linux/device.h>
>> +#include <linux/dma-buf.h>
>> +#include <linux/dma-resv.h>
>>   #include <linux/eventfd.h>
>>   #include <linux/file.h>
>>   #include <linux/interrupt.h>
>> @@ -1742,19 +1744,77 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>>   	vm_fault_t ret = VM_FAULT_SIGBUS;
>>   
>>   	/*
>> -	 * We can rely on the existence of both a DMABUF (priv) and
>> -	 * the VFIO device it was exported from (vdev).  This fault's
>> -	 * VMA was established using vfio_pci_core_mmap_prep_dmabuf()
>> -	 * which transfers ownership of the VFIO device fd to the
>> -	 * DMABUF, and so the VFIO device is held open because the
>> -	 * VMA's vm_file (DMABUF) is open.
>> +	 * The only thing this can rely on is that the DMABUF relating
>> +	 * to the VMA's vm_file exists (priv).
>>   	 *
>> -	 * Since vfio_pci_dma_buf_cleanup() cannot have happened,
>> -	 * vdev must be valid; we can take memory_lock.
>> +	 * A DMABUF for a VFIO device fd mmap() holds a reference to
>> +	 * the original VFIO device fd, but an explicitly-exported
>> +	 * DMABUF does not.  The original fd might have closed,
>> +	 * meaning this fault can race with
>> +	 * vfio_pci_dma_buf_cleanup(), meaning priv->vdev might be
>> +	 * NULL, and the VFIO device registration might have been
>> +	 * dropped.
>> +	 *
>> +	 * With the goal of taking vdev->memory_lock in a world where
>> +	 * vdev might not still exist:
>> +	 *
>> +	 * 1. Take the resv lock on the DMABUF:
>> +	 *  - If racing cleanup got in first, the buffer is revoked;
>> +	 *    stop/exit if so.
>> +	 *  - If we got in first, the buffer is not revoked so vdev is
>> +	 *    non-NULL, accessible, and cleanup _has not yet put the
>> +	 *    VFIO device registration_.  So, the device refcount must
>> +	 *    be >0.
>> +	 *
>> +	 * 2. Take vfio_device registration (refcount guaranteed >0
>> +	 *    hereafter).
>> +	 *
>> +	 * 3. Unlock the DMABUF's resv lock:
>> +	 *  - A racing cleanup can now complete.
>> +	 *  - But, the device refcount >0, meaning the vfio_device
>> +	 *    (and vfio_pcie_core device vdev) have not yet been
>> +	 *    freed.  vdev is accessible, even if the DMABUF has been
>> +	 *    revoked or cleanup has happened, because
>> +	 *    vfio_unregister_group_dev() can't complete.
>> +	 *
>> +	 * 4. Take the vdev->memory_lock
>> +	 *  - Either the DMABUF is usable, or has been cleaned up.
>> +	 *    Whichever, it can no longer change under us.
>> +	 *  - Test the DMABUF revocation status again: if it was
>> +	 *    revoked between 1 and 4 return a SIGBUS. Otherwise,
>> +	 *    return a PFN.
>> +	 *  - It's not necessary to also take the resv lock, because
>> +	 *    the status/vdev can't change while memory_lock is held.
>> +	 *
>> +	 * 5. Unlock, done.
>>   	 */
>> +
>> +	dma_resv_lock(priv->dmabuf->resv, NULL);
>>   	vdev = READ_ONCE(priv->vdev);
> 
> I think you've again avoided the need for the READ_ONCE() by getting it
> under dma_resv_lock(), so it's still unnecessary.

Reviewed, you're right ofc.  This originally went in when I was using a 
different approach to resolve the race.  I've tweaked the comment and 
actually it can be further simplified as this !vdev test can be removed:

>> +	if (priv->revoked || !vdev) {
>> +		pr_debug_ratelimited("%s VA 0x%lx, pgoff 0x%lx: DMABUF revoked/cleaned up\n",
>> +				     __func__, vmf->address, vma->vm_pgoff);
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +	/* vdev is usable */

...and (plain) vdev read moved here.  If (holding the dma_resv_lock()) 
it's not revoked then vdev is usable/valid.

>> +
>> +	if (!vfio_device_try_get_registration(&vdev->vdev)) {
>> +		/*
>> +		 * If vdev != NULL (above), the registration should
>> +		 * already be >0 and so this try_get should never
>> +		 * fail.
>> +		 */
>> +		dev_warn(&vdev->pdev->dev, "%s: Unexpected registration failure\n",
>> +			 __func__);
>> +		dma_resv_unlock(priv->dmabuf->resv);
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +	dma_resv_unlock(priv->dmabuf->resv);
>> +
>>   	scoped_guard(rwsem_read, &vdev->memory_lock) {
>> +		/* Revocation status must be re-read, under memory_lock */
>>   		if (!priv->revoked) {
>>   			int pres = vfio_pci_dma_buf_find_pfn(priv, vma,
>>   							     vmf->address,
>> @@ -1773,6 +1833,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>>   				    vma->vm_pgoff, (unsigned int)ret);
>>   	}
>>   
>> +	vfio_device_put_registration(&vdev->vdev);
>>   	return ret;
>>   }
>>   
>> @@ -1781,7 +1842,7 @@ static vm_fault_t vfio_pci_mmap_page_fault(struct vm_fault *vmf)
>>   	return vfio_pci_mmap_huge_fault(vmf, 0);
>>   }
>>   
>> -static const struct vm_operations_struct vfio_pci_mmap_ops = {
>> +const struct vm_operations_struct vfio_pci_mmap_ops = {
>>   	.fault = vfio_pci_mmap_page_fault,
>>   #ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
>>   	.huge_fault = vfio_pci_mmap_huge_fault,
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 733607371082..4b3b15655f1d 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -27,6 +27,32 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>>   
>>   	return 0;
>>   }
>> +
>> +static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
>> +{
>> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
>> +
>> +	if (priv->revoked)
>> +		return -ENODEV;
> 
> Questionable validity to testing revoked without a lock, but doesn't
> this also fail to follow the "map regardless, sort it out on fault"
> paradigm used elsewhere in vfio-pci?  Thanks,

Kind of, though this was intentional.  (I had removed a crappy comment 
here from the RFC, but should re-add something better...)

You're right that, if we don't test this here, the fault handler ensures 
safety.

In the revoke ioctl^Wfeature header UAPI comment I'd suggested a 
revocation prevents a new map (in addition to prevents access to an 
existing map) with the intention of making userspace easier to debug:

  - I'd rather trace an mmap() failure than a SIGBUS (eg. if another
    process has revoked my DMABUF and I didn't get the memo).  For a
    prior revoke this is a reliable & useful test.

  - Even if there's an active race such as userspace doing an
    ioctl(RESET) at the same time as an mmap() (!) then obviously this
    check won't always catch it, but when it does then that's useful.

I'd prefer to keep this belt-and-braces check to early-fail (with 
comment), if you don't mind much.  It _is_ testing revoked outside of 
any synchronisation as anything we can lock against here doesn't have a 
useful effect AFAICT.  (Taking the example of a concurrent ioctl(RESET), 
a revoke still manifests "before" (caught here) or "after" (caught in 
fault handler).)  Maybe READ_ONCE() wouldn't hurt, if only to indicate this.


With thanks,


Matt


> 
> Alex
> 
>> +	if ((vma->vm_flags & VM_SHARED) == 0)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * dma_buf_mmap_internal() has asserted that the VMA is
>> +	 * contained within the DMABUF size before calling this.
>> +	 */
>> +
>> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>> +
>> +	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
>> +	vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
>> +		     VM_DONTEXPAND | VM_DONTDUMP);
>> +	vma->vm_private_data = priv;
>> +	vma->vm_ops = &vfio_pci_mmap_ops;
>> +
>> +	return 0;
>> +}
>>   #endif /* CONFIG_VFIO_PCI_DMABUF */
>>   
>>   static void vfio_pci_dma_buf_done(struct kref *kref)
>> @@ -94,6 +120,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>>   static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>>   #ifdef CONFIG_VFIO_PCI_DMABUF
>>   	.attach = vfio_pci_dma_buf_attach,
>> +	.mmap = vfio_pci_dma_buf_mmap,
>>   #endif
>>   	.map_dma_buf = vfio_pci_dma_buf_map,
>>   	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index 10833aabd7fb..db2e2aeae88f 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -38,6 +38,8 @@ struct vfio_pci_dma_buf {
>>   	u8 revoked : 1;
>>   };
>>   
>> +extern const struct vm_operations_struct vfio_pci_mmap_ops;
>> +
>>   bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
>>   void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
>>   
> 

