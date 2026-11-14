Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794648885;
	b=Zsub38ZD0TZmR26VYVZreTSDGLePAagzCCJTCs9Qf4ZOcL7lrxUgDhiKM8yRN44YpxHJ
	 n8ofc6PxBhSTEDXD1uvl1NctdHF6hrKuoh4SG/FkzC4rLVmeSkgIDJKhUZvdm4BsDqzDV
	 Jw2Y6/myxlfKXBaqUC3Qt9iyCqUQhmAFVDpBpCj5cihI+mHuHgzHHuzPRjWCJC/p2v0om
	 y3ZA5XSBruQj8E/5jstOA05Go3YX0md8kKc9UfYtcXRXOxAgwgQ4HIn+vGAvR0P6/mFrl
	 bN8oq0IGl6eTBfPkyGkgBWwVDT+77dmj65S5OhnghhL6Fhp5bNIDnAou0/MoVi6bNoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794648885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=cYfB8ZYjzkbZTu8PkWr5VdyVYonCx+ZsO65KHqfQojE=;
	b=wIU+pqgh7orvRKlkh+Oqn3EWh71u+iyfgtrUJC5pm1Z3l6vklbjrJp4u0HNsPX9TRwAA
	 piYsKmZ0p0b4+CnMcJ+gMAnVubW7UIi6A9SJgZsVNociivZXeoQFm9tT/PJAbbAC8jWb7
	 qN4GsWsz1M4apEFrL3bqDq3eg/DlRAeLbS+Cce6FX0mVwOn3j0EfjY6Eavovyk4mhvg0L
	 XzqbwNJlPV9HVd6JcGUG9FQmd4tA9ajjAbiqjnlkqCanKzyCB9IM3j3OjYtzvNFAQGmaT
	 GzG8ZSvGjmymZvnxwGUrjx2yv+WtBSeB1RY/i/b6tWg8iunVwf73Vn4pnEp7K+pxcPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ITg0WODf;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C27E606A333
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 09:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C27E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ITg0WODf
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c504b52eed3so197467366b.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794648884; x=1795253684; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYfB8ZYjzkbZTu8PkWr5VdyVYonCx+ZsO65KHqfQojE=;
        b=ITg0WODfjiev4CXog2b9Top27p9acyqI1Fkp+RPBD6r7sYJZqI/EMHl8i8nfvu28O9
         dUCQop6o6E2Gr/87u/0UbmggSi5NCyfqhTIrHZZ9kj0eQQToCTyvBNp/d27vac0bvCPD
         r2WpWq4ODLLc1IpIs9MpZYNM4XyaHWGT+Pjf0nuE0ptmYbcQQ24ghSHFaFmasMm7blpJ
         5PbfVkj5ydyYPDI0PxPy9Mx5/COg2jf4RAruRKhBDxV3osGEsZ2RwtiEbtey1x5Jcctb
         XByyygKualSG+W9eCuD217I4RzkoA04BH4G0/h+C3EmObIc6kiVaAU213gFCHU6Ch4R1
         Grzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794648884; x=1795253684;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYfB8ZYjzkbZTu8PkWr5VdyVYonCx+ZsO65KHqfQojE=;
        b=o2j01Ynhu35PCXAImRWE/DP71dhO5i7GaT/CjXjr4mh4DINLgvugltDfMzzeDXQeFy
         vhE5brWfJyVdmjv1huNhabHUUlL+TBrMN7izD3dvoiN5oSRQIFSv6O8Ie7OoVgCiunv+
         e35obhy5eycrU7CTiGewJsMtbEVwjiez4AJFS8DJ/H1xQkmeIJmvb8M5F3W55Xbc70sW
         cKh/fijwOZ9Bpw7Mo/JFuTcpSCN1gWp97eebaj/9UdlrCO+7vor0JaJhyZETJYKFZVNg
         Rw3VY54ZOLXPbNbOG+SIk+GejcI2kTg2MRHN4W1HDiAm9gu/y7jGsdZncCNsuDk6aMOg
         qKpQ==
X-Forwarded-Encrypted: i=1; AL+hErFoiFXx5Pw8li1E6BSFGUftYAAD0jkI2vIYZxRzvDxizYUmQ6kLF1jnyB7qKGZEPqTFYVRAtsHAz7o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/h7mLtUyWurt4fZHOitCmJC7Iez6RLTkjmUSJFgAX+9PAY4WN4
	JXNuOk4IHoak6RY07OjCVtJV15p8u8FI+/rgsP1GS+1nJlMjlyYGB0zHeQ24skaTMV7J5weYBzG
	0BMw51XmYJQFyn17xng==
X-Received: from ejbgl17.prod.google.com ([2002:a17:906:e0d1:b0:c50:537a:6835])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7b83:b0:c41:b4e4:7958 with SMTP id a640c23a62f3a-c5095dd7931mr418395066b.0.1794648883281;
 Sat, 14 Nov 2026 01:34:43 -0800 (PST)
Date: Sat, 14 Nov 2026 09:34:41 +0000
In-Reply-To: <DMRP21FATCC0.ARAURXWV85JP@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-9-tarunsahu@google.com>
 <DMRP21FATCC0.ARAURXWV85JP@google.com>
Message-ID: <9huzse13pxhq.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 08/19] kho: block: Add the feature header to blocks
From: tarunsahu@google.com
To: David Matlack <dmatlack@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"David Matlack" <dmatlack@google.com> writes:

> On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
>> Precede struct kho_block_header_ser with struct kho_ser_hdr using
>> DECLARE_KHO_SER. Each block in a block set starts with struct
>> kho_ser_hdr followed by struct kho_block_header_ser. Serialized entries
>> start immediately after the header payload at offset fhdr->size.
>
> This adds a feature header to every block in the set, but the layout it
> describes is a property of the whole set: all blocks are written by the
> same kernel with the same header.
>
> Blocks are only ever added and removed at the tail, so the head block
> is stable for the lifetime of the set. I'd put a single set-wide
> header in the first block only, e.g. a struct kho_block_set_ser with
> its own feature header, and keep the per-block header to next and
> count.
>
> entry_size (added in patch 2) is another set-wide property that belongs
> there. All blocks in a set have the same entry size, so recording it in
> every block is redundant, and restore has to check that the copies
> agree.
>

Yes, adding a ser_hdr to each block_header is unnecessary and also cause
8 bytes to get added to every block. This can be solved like you said by
adding it only to the first block. But this will make number of entries
in block[0] to be less than blocks 1..N. I am not sure if that is
acceptable but if it can be then we can avoid adding ser_hdr to each
block. Same for entry_size which can be moved to the first block only
like you suggested part of struct kho_block_set_ser.

> [...]
>
>>  		entry_size = ser->entry_size;
>>  		bs->entry_size = entry_size;
>> -		capacity = (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
>> +		capacity = (KHO_BLOCK_SIZE - fhdr->size) / bs->entry_size;
>>  		bs->count_per_block = capacity;
>
> Nothing checks that the blocks agree. Each block's entries start at its
> own fhdr->size, and count_per_block ends up being whatever the last
> block implies. With a single set-wide header this can't happen.

yes.

~Tarun
