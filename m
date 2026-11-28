Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795870828;
	b=ysas/mBJNaKWepJfst0VtH9GSRR1mVkrNjhBsb9X7t9oTxx7klNXqfUqllHtjm7Xo815
	 6+Z5iO1yc6L3BAwAVx1fJRk1Eft7s35RzTyt2IkgaFT8WUrjcLpabfgqe2xgT3AGLmm4r
	 5hJCmX4lEpO5t8RXdsOQbW1fLA2HGazs5FCNSZ3iYSLIxrzo2wfFyng9weFV/bWiyXA39
	 wVz0Vx0ZJLE5uA/3YhOgr5gwwoJSq5Lfxf/dbgYshY+2+bef2/OSeE2gOotyLNtkGsAno
	 YlQXKspqpq93XALDmu+23cJFMEG2f6Gx9jwPSGegL6ovv3Rpk76lk+nlRssp6c7tP3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795870828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=d6BkAp7ECdk7km8IXzswx291+eDVbqVT1bK4nfJre9c=;
	b=FqW5wEQlgOdKWT651ovy+S1m6NIaDYlkUZrS5P2f4Vc4fJviaOCvEcQDErDS7OzaU+9H
	 KF5wGelb9pSurTkufeknSlBWt1Z2WSA/DmG9vu1kEyRv/DUotw2PRbvtFt/pjJhKUUcbq
	 HPivVZqkKKxqG4k3Or3X6n7vK91q/i/cI8eOuiZM6uUUvU7BQH3RzsQZGTBcBjkAlPr1X
	 N74t7ljF7HXbuqVDrSRazaQEUovOeIvn3muIB27AJj7f0z40vcsOcuhUWsyUJybW3J21c
	 wGsu/ui8be4ibMLxmrElHnmnxkjHRUPiK2wJYgWQEvfMz0eK1jaahrhYJFWa/7pJ0qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CiK14xPr;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03C606A31F
	for <linux-pci@vger.kernel.org>; Sat, 28 Nov 2026 13:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E03C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CiK14xPr
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c40aa03ded8so847759066b.2
        for <linux-pci@vger.kernel.org>; Sat, 28 Nov 2026 05:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795870826; x=1796475626; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6BkAp7ECdk7km8IXzswx291+eDVbqVT1bK4nfJre9c=;
        b=CiK14xPrrxHAZcwKgPYEry9+8DB6qjeyuPWTq4AOlSVBmohXvdN4g7RiDUUIXGWP4p
         1JLJPdNM1KahxhvxRDlR5yzyG/cKY2PmiAyPQCGDNSfCO7Aq4vuHTneXz+O+lHn2O1sc
         aacTiStOd/Tjxgy8E+neiHJjfDoIAj87Iceg2tSkzteWsgc5HryrdqU3QtswvgtHyCaT
         iVfB1J6NV4MkUAgzkS6Ka9jB6ZMKFSaHki8xW4WHrEch7/skS6RFRYGpUCUi4zDaXQMd
         sjxqXzPk+sSwfqw4lkErvjgRg+nPbfR+hNo8mMTFKsvYFrxuuaCh1TbpC2c8vla+9MRq
         0u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795870826; x=1796475626;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6BkAp7ECdk7km8IXzswx291+eDVbqVT1bK4nfJre9c=;
        b=1lTYNLnqpVX8huGGJ/z+eKbvn6I63+yBKbn8OioLjfmTwlEs6I7bMrxvnitV6fXS6A
         AqiqIR/1Gbwi310Qw3HW97l2yspZXud8ymTYVzHuqqoWFkNVO4JopA3FpB80gbd27fHG
         rY21aOUqvBp6rtLfAXBSX9quFTXX4jwpi1tazzrdRZuGVWusJyo3UAANZXBVuVS5xmoi
         WZ0eb2lzUV38XYcFo2M2lgzXnNDIQSt+VGJdVn9ZEuwPMKm5DYMYV8YtdodkMtJ6otTz
         lvWuStyKLawvqyG+foQcU2ZHryUp76J3FrJ7i/YYlN1LEOLcHfw8lfuaVyh/1F71J3p6
         ZcKg==
X-Forwarded-Encrypted: i=1; AL+hErGQtb3VDP3yue2xPEUwA6uWW9xDDjPPiUbmGOVpap7G5Q0+fViv/ypV3LsBSJP4Dsh/KrDhqNbwz68=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Comuu8oLbdOoTZ7mhqq0Yn8I/kCmP6dp3flWmMVTReGOJClbO
	uku8wKhkKZJCpHCfTwpoLPfeue1MCgSZ8Zn+tYc7nMG2CoYC0UnxOpwloJLibpmmF+rgd/h5OyG
	tvlrGMA/wDFoNeyBIng==
X-Received: from ejtf9.prod.google.com ([2002:a17:906:4949:b0:c31:8840:5c0c])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:3d21:b0:c51:24a4:1dfb with SMTP id a640c23a62f3a-c513ac7edecmr1624478866b.40.1795870826056;
 Sat, 28 Nov 2026 05:00:26 -0800 (PST)
Date: Sat, 28 Nov 2026 13:00:25 +0000
In-Reply-To: <avnuP7SWE2BdBFBL@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-3-tarunsahu@google.com>
 <avnuP7SWE2BdBFBL@kernel.org>
Message-ID: <9huzpkvpglg6.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block header
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, robin.murphy@arm.com, maz@kernel.org, 
	will@kernel.org, David Matlack <dmatlack@google.com>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org, 
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Mike Rapoport <rppt@kernel.org> writes:

> On Tue, Nov 10, 2026 at 05:01:45AM +0000, Tarun Sahu wrote:
>> Subsystems using the KHO Serialization Blocks framework currently do
>> not record the serialized entry size in the block header. The entry size
>> is only known to individual callers, which must track and store it in an
>> owning serialized data structure. If a newer source kernel adds fields
>> to an entry, the changed entry size breaks the stride when an older
>> target kernel iterates over blocks.
>> 
>> Add an entry_size field to struct kho_block_header_ser. On the outgoing
>> side, record bs->entry_size into every block header during allocation.
>> During restoration, derive the entry stride directly from the block
>> header instead of relying on caller-supplied dimensions. The
>> kho_block_set_init() interface remains unchanged. A zero entry size,
>> or one that differs between blocks of a set, is rejected during
>> restoration.
>> 
>> This change modifies the serialized layout of struct kho_block_header_ser
>
> Imperative voice please.


Okay, Will take care of that everywhere. Thanks
>
>> and shifts the offset of serialized entries within preserved blocks.
>> Bump KHO_FDT_COMPATIBLE from kho-v4 to kho-v5 so that pre-v5 and post-v5
>> kernels cleanly reject mismatched handover state during boot. Also
>> update the stale compatible string example in the documentation.
>> 
>> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  include/linux/kho/abi/block.h          | 10 ++++----
>>  include/linux/kho/abi/kexec_handover.h |  6 ++---
>>  kernel/liveupdate/kho_block.c          | 32 +++++++++++++++++++++++---
>>  3 files changed, 38 insertions(+), 10 deletions(-)
>> 
>> @@ -264,8 +274,21 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
>>  	}
>>  
>>  	while (next_pa) {
>> +		u64 capacity;
>> +
>>  		ser = phys_to_virt(next_pa);
>> -		if (!ser->count || ser->count > bs->count_per_block) {
>> +		if (!ser->entry_size || (entry_size && ser->entry_size != entry_size)) {
>> +			pr_warn("Block contains invalid entry size: %llu\n",
>> +				ser->entry_size);
>> +			err = -EINVAL;
>> +			goto err_destroy;
>> +		}
>> +		entry_size = ser->entry_size;
>> +		bs->entry_size = entry_size;
>> +		capacity = (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
>> +		bs->count_per_block = capacity;
>
> Nit: can't we just initialize bs->count_per_block directly and drop
> 'capacity' and the change of the following line?
>
> We are not very strict with 80-chars limit in kho/luo anyway.
>
Sounds good. I will update it.

~Tarun
>> +
>> +		if (!ser->count || ser->count > capacity) {
>>  			pr_warn("Block contains invalid entry count: %llu\n",
>>  				ser->count);
>>  			err = -EINVAL;
>
> -- 
> Sincerely yours,
> Mike.
