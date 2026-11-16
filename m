Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794803663;
	b=ILTe1APvAF9jpLKEqOs5g38wxIJzvsSb9jP6DggmC18f9xNzW5ljMEGt9emOiAsSMRSn
	 MvoO52Im+Xbi9tL/GX5mV6UZtehFBfJ4Yhh/6a4RqVw1wdAvzF6JcwvwiNaDqWKH5UlP6
	 /lQiQyW06qzHXjEQMhHvVhrgZTs/FmzdH8G95CdrQbNlaebJj3VUkxAD16MgilQs9Suv3
	 yecLQ+kUabqNsaGzMjrY0bCuiW1AMVYviLam6RykjZQNe8clp4q1itTIt3vBCAJFQZPNi
	 yFRU7ByD6eNwU49Y7YnpCEvf2Hlp/u5E9aB4qJSmhhkaVJab9Uxkf4ZV5hi0LefaJeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
	b=16dVLdcKHbDCkk7DSzSA14b1nVhjWCAIHGTRmpZTtcAozzvmUZFW5L2prED6ZEExTqa7
	 7tVrGjlHZuf7F+39FaBHwzVs7D9aKFVCn05ZqasnaGlxCLILm0r6eZrTP99goWEbAOBnR
	 nYVWYJm57Ktbjwwo35hDEOmUgR0mQZOEWGd7dorVvqM64/FqJ9zrYzlKxn+b3pNGr88nN
	 7ty9GfG9cxPVFv6UR07HLav+R6b4kKVCTZiloRx+oQRuGmJpbAUr2fz6FzIX2YFEiMBtm
	 qUDfFDCLiHSNXOmWtBdyPEFU66rqKEN2UVD/gH5jQQeSnAG9dzn9Exu/sAgJOkUT3PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=IvrpsDuj;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14330606A31F
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 04:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14330606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=IvrpsDuj
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-170135e43c7so4781836c88.0
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 20:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794803662; x=1795408462; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
        b=IvrpsDujkb8+xQxkW8bH57B/Njtz9j5nrLpeGfuYrBi6nX1JKFJylBRC6sdQEERIVw
         HtGcx7CHi/CiN1Fk2bHltHeShULSWGB/FJStMTLzNEcxESGvjONp2O5O4N9PClo7TcFu
         4beF6ymkhsh8+wfAWm4UkR+WNqUZfV0HV7UcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803662; x=1795408462;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
        b=VFvUvjq+kB1z+qgiA4+OwJRw85vqpVJTEtgr4k8HwmZYSWDgYIatONPwyMyrwNH0BL
         dnvWL/mqn0+SvdI7nWkasL5n+83m9OwbSWM9zLvIXftoBQHPhnoZFF1zYNUkUjaDNQWq
         i+I6zGPpbOOQIRcIqBI2kuRRy4zJVUQJfP3q2Y8N0V8pMclrF3z+y8eemNx+TL+988wu
         liZmZACtEa0NRSRIlzYwzqvbZCgYWnptiLKjSF/3D96JvhO4EHrzQeclJS6cbePZcTpo
         DabhYf/YsQs9NfZim/ukN3TMUb8Wvmw/+I9xeAMXb6OBUahdXuSx0Bb4k5F7Xg8ZtST6
         8bxA==
X-Forwarded-Encrypted: i=1; AL+hErHt+Ug10k5hHpLCL4RkvJKgcjAWwWHyvtla+dP1O1I4nZHFgI3HG1lLs4XOg0V+eXO0agpAy101aso=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m406jWu6cy9kdFY1rpJQygPUDSDjP4zqaswc0bbjqT7XUNvkL
	LVfzWqABEbQSBOzNaK0Mz8Rwybd822iGNvod3d0iZsQ58wm5oe1h+q+OFOejo0JT0MU=
X-Gm-Gg: AYBFou2NXR9qweoXkb3meoCfuWL7jXpFYz4pcEMDRIvLNmedJWIXx1QEfijxK//AhBN
	yRug9KER3St1/XPsLFElwpnEFck30AcCinBdP31WXU/gx33CZi1dz/s2Tmowio0Sv/lnE1GpkWX
	f7pRkpbtFjj8jE91b5pB40DW24nMhlcsZz4963481U9gNJsgIYC1ESHBWw23Klg4shQVcd5NU5H
	Phd/GUt4grelfBKWtwCz+AUOYXNREPZCJPXACTSm1xyfodOXApf55GzSWJLg0LJhg1jf4ev24/7
	cNJiVCNcKVYkA+oQCQ+sYo6MJIWblrKkqaT0b0m/xadmcPNsAyRqdWzhZ/vRBexRw2AgeU6xjqx
	R0ERVpQHw02mkEFspoWLOhVVO6Z0tPD8h0vZiYMDfgCcoQqxRXeqh++TxH806dA+ti+SRom/40w
	nKn+mtE18PV6PMswmDeCiW++fmznha2vwVMwI4qIa496VNnbQzhscTfSAXX7tA4YjmarfV9JyG/
	L5+0RAiZHCZuwqwBq/VjpPDkw9lhEVR7SLn2BK2rXMzSVGqqgXXe0hK/K2KRlIq5TmYGxF8o0Lj
	P3sy2Ah448//jIBOgImlazTJhFeFzN6V8U0yBgSIqM2TbwUC1FiAEF5xAfmWE1gw54IPAJTV9fX
	N/kzdUA0PBot3d4kx8iK2jZzatRQAMN9Tmjbkg5LxnsaMdcklMuv2T+ag0N7kEHuPkrd2uO8IHZ
	/qZ9I71B+AA2bYM+qdO940loOxMJlnWtkUvKwbjvMeOcuBkw+4Qmc5aNyXPRLviux9
X-Received: by 2002:a05:701b:4508:20b0:194:9e7a:3ba2 with SMTP id a92af1059eb24-1b50306c4d3mr9813315c88.2.1794803662025;
        Sun, 15 Nov 2026 20:34:22 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5329ec87bsm2576204c88.0.2026.11.15.20.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:34:21 -0800 (PST)
Date: Sun, 15 Nov 2026 20:34:13 -0800
From: Chris Down <chris@chrisdown.name>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org,
	will@kernel.org, David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com,
	loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com,
	joro@8bytes.org, kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/19] liveupdate: Add feature header to struct
	luo_flb_ser
In-Reply-To: <20261110050202.529473-15-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-15-tarunsahu@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261115203413.eaa54fcba43adc22@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Tarun,

Tarun Sahu writes:
>+	for (u64 i = 0; i < fh->header_ser->count;
>+	     i++, fhdr = (void *)fhdr + fhdr->size) {
>+		struct luo_flb_ser *ser;
>+
>+		err = kho_ser_validate(fhdr, luo_flb_ser);
>+		if (err)
>+			return err;

I think there's a problem with returning this error as it is. For an
unknown required feature kho_ser_validate() returns -EOPNOTSUPP, but
callers of liveupdate_flb_get_incoming() already take -EOPNOTSUPP to mean
that live update is disabled. pci_liveupdate_flb_get_incoming() returns
NULL for it, so instead of panicking, PCI carries on as if nothing was
preserved, even though those devices may still be doing DMA.

 From a quick test with an outgoing kernel hacked to set an unknown
required bit on its luo_flb_ser entries, that is what happens after the
kexec, in that the PCI FLB is never retrieved and boot carries on.

Could you validate the entries once in luo_flb_setup_incoming() instead?
They are all written with the same header by luo_flb_serialize(), so
there's no need to check them on every lookup. Going by the code, a
failure there would panic through luo_restore_fail(), like a bad
luo_flb_header_ser already does. If the per-entry headers end up going
away as David suggested, then this check goes away with them, of course.

Thanks!

Chris
