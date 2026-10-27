Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122429;
	b=XbySQmXrfWLmGurhagWVywq2uTeSRP2/AuK3vxUR6o4WTsBdv7txkd7dUGFHjzd6EaJS
	 mtLxOYZldE87/jWsToIGcwwlnES66WeansBad6j1uUl6yX/SPVkTL5eQqCW7IgZDud0ME
	 Xi9sFQndJPsrLixUNpFBAprvkrIa9gMlkRKZn5+CYxZmq/+aXDGadwGBTN+fy6GaIXOsr
	 hOyVTWgnkl5XLcuC6vuxSgfWIN1mLzJ63+0tiTG50cuJfKoYCPNhAbnxtrTixopLMxIOi
	 v1fEcqCagNeZF8yIcTgUF1z3Mi5nYe1WXcgShm2WjJZXmcgYB5IftIrP2P7xY3oVhoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Glhm1d7B/bXe7XSf6a+44KZYpto2vUedcbuSuK5V4mM=;
	b=pqq/nc4Yqtn/pIzsuFisd78C1mo7lxjqc6HPYNoHyt33JFgJm/MhioBdnJADilWib1IN
	 oF+yTys4A3k6byPLHZzv1jE9dHLUsFQHW+sZWk5/exXIVLT7kIgXeaNQT3mvTtbvNF6g0
	 mDekVIpqlOzsalBDnRLN6Un1IsJFOpOmhpLaiPYUtOfXqiKk1gVqHip265f1sjswtMHRC
	 fYrKB+qoxoZcsdKzpaW1KPUP49SJmfQ9I+cqkzhK4znwusLudIybd8SVRg+aynxe1SkPH
	 Vew4EldyySJgJprJrN/CqUT0fHVgxM539chghjsd8kR7jMIl2CcgjSrRkLxZJH8LYbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lRoyxfdN;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDE1606A322
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 17:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCDE1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lRoyxfdN
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ea759cc9b6so150285ad.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122428; x=1793727228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Glhm1d7B/bXe7XSf6a+44KZYpto2vUedcbuSuK5V4mM=;
        b=lRoyxfdNn7TBbP5x6TkgUA1F7eeRXPKnXT1QlAmfv319FSidtbjLhWioxe8BN35NPv
         5CSrJlJ93V1JDi5SBSg9vII16gE5atOuOaJp/X1n8PzfJRT4rX09Hu03abW16KTq2Tso
         LOX18fnGf1mUsiRbGH76ZxdSiOjX7qvx2t0MZ4H8lVLi8X1xHIIZKPsEdnDKUqP0eRld
         bY84x9/GyfLKtsTV5dSA4qUST2NjSALnJWHYGNGQnIWfj1c+cknq3N39Ow554X0OB4Hh
         Crmdst4DaE0kvergmO7udhiKzur5U8aL6zagImA1qVJCOLmfPD8cmcjxmm2w+eXd4Eax
         Q89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122428; x=1793727228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Glhm1d7B/bXe7XSf6a+44KZYpto2vUedcbuSuK5V4mM=;
        b=WHYK8f03egCcBK6xunMfuJ6+2PoqMTcoG12lrSjdjrIX4HiP2VMkqQwvqZvUkyx22r
         6NB6Tuyf6FicD1zjPI6SnEmCbqJBXxaMEyslz677C2yLQjCT9n1WfubV/PPjGmV1ScfE
         lzkgR3MWLuT/l8PmZ+F4YBm5xraaBa2U6PL+kGl1QYizke5RpbOW90tB2U1oFISZISma
         8Ad+4rfrC27a2ombMPqB6S5ZnM5+SqvMf0aZiiO50LKVA/ykTIrKvgANDd5iJjpRdq1v
         pHqJ/UAmeERaJ1Z9xFE8vCIxUyDZRpZaO+k2PKFIrpOzXSkdxxUzI2Nixf3MDopVyWlx
         hkjQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3R4tB0dWCH+IC3mdyhsiEZ3sBg5jikbSVC1UJXRGK+kgJwcpS61bsxz9QXmrXZA6V8D5vDqMQdP4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmntiMA/gAhT1yHCIbpQ88P30hcmJXteOhWiHMlRGHN4ReqX3S
	Yg933DmVjgvqy+IiNEd7cW7g3InpUAxml/qwIAexu2sqr1i1Gqd2E+3Py6mK+ecVTQ==
X-Gm-Gg: AYBFou0CSF/6tHVS7C2odAwe+AP/ounD+Dwo9AFs35QQUZD2ZKVcxgTOy3t2+dz116f
	lgg5SRZJ2Gg7Uk+SI8M158ers6/TKWgZB1rYv4Do6KYZNNsUf5zAnSdHhz/UdyWjYQhn+fwy/it
	q/utdZBlgHw4LkhXjhESkMrubIup3ROg0O3Lnb3ufQ9gc2BUgm8S59jmfbm+Irz0KcWYrck8EY4
	Rz8FzOdVk1RQmrRx0Tj2XWhfJsarHcJe3Dh1SnuhuNzY+1hJ7F3e4SIjtMK1iHe74Gftk/Ccy3A
	Qy/3DAQpwWa1j/zIrQ3gv+XFLy+i/SmL7xEKMFLbHBDXDj8spYnaVZCqNZCaX+eW5L4QkMELcUK
	+sM0IbSWyNHC+mMKk/7vihcoZ5bU8SVB5uawYlVD1H5uRLhkRJUrsbpCorH5xBmQrDaV6K8Ck3l
	n7u9mWrnI65NYb0SEUU6FtW7aQMSku3npA60qF9GlJEFkPcWM4EOFDOHknkv07JzsPE8gTpTRqv
	PUbKEt+QNHtk8N4nmNY4Ru1hH4o9T9PLWyI4Tg/vsB48Y+llNW6TlT2mISw+sSploS7RVRjWyKn
	ydZaFMPW3PaA/NXKAg8dJVmR5Q958GQND4AfsHeE3AF9sZLWWlGokRv6HHHMv1d0Dg==
X-Received: by 2002:a17:903:3d0d:b0:2e9:5507:b52e with SMTP id d9443c01a7336-2eb005a6905mr454945ad.50.1793122427469;
        Tue, 27 Oct 2026 10:33:47 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm12585675ad.35.2026.10.27.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:33:44 -0700 (PDT)
Date: Tue, 27 Oct 2026 17:33:41 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auDgdUb3y_ricEq9@google.com>
References: <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
 <auDPd6tjzACQVszf@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auDPd6tjzACQVszf@google.com>

On 2026-10-27 12:21 PM, Pasha Tatashin wrote:

> My main requirement is that DECLARE_KHO_SER() in include/linux/kho/abi/ 
> must be enforced by the compiler rather than being just a bare 
> static_assert() that someone could forget to add. Since kho/abi/ headers 
> contain both versioned structs and unversioned sub-structs, it must be 
> mandatory to declare versioned structs in kho/abi/ with their 
> static_assert size check before the kho_ser_*() helpers can be used on 
> them.
> 
> So, how about adding enum names like this, that are going to be required 
> in accessor functions later:
> 
> #define DECLARE_KHO_SER(name, payload_size, nr_feats)             \
>     static_assert(sizeof(struct name) == (payload_size),          \
>                   "struct " #name " size mismatch");              \
>     enum {                                                        \
>         __KHO_SER_SIZE_##name = (payload_size),                   \
>         __KHO_SER_NR_FEATS_##name = (nr_feats),                   \
>     }

Sounds good. Since you're also on board with splitting required
and optional features [1], this would take both counts:

#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional) \
    static_assert(sizeof(struct name) == (payload_size),              \
                  "struct " #name " size mismatch");                  \
    enum {                                                            \
        __KHO_SER_SIZE_##name = (payload_size),                       \
        __KHO_SER_NR_REQUIRED_##name = (nr_required),                 \
        __KHO_SER_NR_OPTIONAL_##name = (nr_optional),                 \
    }

  DECLARE_KHO_SER(memfd_luo_ser, 16, MEMFD_LUO_NR_REQUIRED, MEMFD_LUO_NR_OPTIONAL);

The incoming path can also use __KHO_SER_NR_OPTIONAL_##name to validate
the incoming header only contains required features that it knows how to
handle:

#define kho_ser_validate(hdr, name) \
    __kho_ser_validate(hdr, __KHO_SER_NR_REQUIRED_##name)

> > Plus helpers that allocate and initialize the header and return the
> > payload as a typed pointer. Both the outgoing and incoming paths find
> > the payload the same way, by computing its offset from the header,
> > rather than through a struct with a fixed payload offset:
> > 
> >   /* outgoing */
> >   hdr = kho_ser_alloc(luo_memfd_ser, LUO_MEMFD_NR_FEATS);
> >   ser = kho_ser_payload(hdr, luo_memfd_ser);
> > 
> >   /* incoming */
> >   hdr = phys_to_virt(args->serialized_data);
> >   ser = kho_ser_payload(hdr, luo_memfd_ser);
> 
> These would become, where without enum, the init would fail:
> 
> #define kho_ser_init(buf, name)                                     \
>       __kho_ser_init(buf, __KHO_SER_SIZE_##name,                    \
>                           __KHO_SER_NR_FEATS_##name)
> 
> And payload can also check the existance of DECLARE_KHO_SER, using 
> (expr1, expr2):
> 
> #define kho_ser_payload(hdr, name)                                  \
>       ((void)__KHO_SER_SIZE_##name,                                 \
>        (struct name *)__kho_ser_payload(hdr))
> 
> We can also add an optional kho_ser_alloc(name) to allocate, init, and 
> preserve.

+1
