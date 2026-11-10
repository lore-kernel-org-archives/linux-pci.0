Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320637;
	b=uYejzhlX7+qU+bWCsXEUmNuIlb3V/XVGDQqXBS3IWYGEWrpJVWuXNxP6B7lK8InzX3Nd
	 P7pdHgj0XfooZclt/RLpf3q3rRoJPsXdsHzPZGdIQGiPaPwXyNGyuo/z8WF5DvmW8EDBp
	 BC1ZApLrRMZh06KrE5lHmlyn9dK+KTeHqzM4RIFEt07xtI4dftHT5NqtbxhbdQv5Ja9zQ
	 bVZqi2nukzRllnR7d+hx3s1TY+C8qENPWOF6suJZ3j4pYLVSSib7mPLJXje0H7Bj4d6km
	 4hWe9XNnnhpI/ozS8F1XY0Sp3xRXTrh8xUK6Fy5G1f6TVX1OvxJChYPhw7FZ+gac+Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Kh3fWHtVs9ElLDXrVfG1M2iBA/DoCWf9txtZMpxB3YI=;
	b=jHaD5OyBRSrzRTLlIg3j0SBGD2lkoQ8iMcVhbyM6Bm7yz687fntiqX/i9MFbKFXHHkNj
	 XLFTORQ3pI+LYDxENnuvkf0cJH3edC+oZNn2acVbzni7aT2Da0l/UIlbS4hQ6c2FyOJEc
	 D9dRM7EAIbKHv9E8dPfsktn1vTf7DEKV1/E+8el5eghhMDCXVGgbX/HQfZ2hJwvx/+vRN
	 KBR8gFut7Q8yOTrPVWqzW2nLAuRUbfK7BE8jyyOscUWnx2Vi7a8E3AQrKHVcIrDUW3oRq
	 jTxmsOwmu+03YI/aeYRtR02eWY1W7Ya+DEFumAtuDnNxDPHry2Q4iNunItc/tsRa1cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=ZexUOhQC;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42292606A332
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 14:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42292606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=ZexUOhQC
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc91ddf447so837878137.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794320635; x=1794925435; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kh3fWHtVs9ElLDXrVfG1M2iBA/DoCWf9txtZMpxB3YI=;
        b=ZexUOhQClOg9kYHkYXePsvaxuBh9ANjvAR6c3zVvKUpVHJw8arzcFu2Bq+OnBPjj7H
         XGCmAuBlXWKBZ8J/9w/5AdY+4GqkP15JIqY+fPpSJ6w9314mWlXeghw80vMJdCxtobO4
         xVgR0SPdqA6pvHx1163WBt/25tqbumeA/m6ZvMRCDIQecBL5owcOc/4bG+Kc+TDrwFPs
         PDutCn61V+GsDgSoQxI5l5OG2EkSQA65i7FmxKjhglIoMYGALHzCW6tNMMvxIxA/J6/u
         9LkL6q0cVIrDtE0BBJH3Fs9RfopzsAt6DYzi0BD8lCB2c2jg0kc2RXqy3cJ9ChdGa6KR
         2hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320635; x=1794925435;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kh3fWHtVs9ElLDXrVfG1M2iBA/DoCWf9txtZMpxB3YI=;
        b=1ItA00VRTdjxU3Y5pntjyJLqZMy1TxZqbo46R6v+XthteKRUqG/tIxiAs8EfwoOgJP
         HM16uK4gIdOm5xwzw85k1TeDhCO4Yj9tgbtdr593g39T63a7yJjW5Cfr2WF1wb+G6c2w
         CttyA4/cgboJeB+5gHWfM+FKVKgnwoZflFcpQnlxJF74z5m8kl9BIj/RE4q8WBGbQ+iK
         Xc00OwF+F6uEm4Rmsg5jUm/zcVBFbQQ5uI/RsFC+7e7qaeAl8CH3KzHiN6I77GGkRGAT
         3wImE+0MxhhbheYZt7G39nNuXGDRErLQB1/DAXmmI5IQKvkCcSQDOkjpnXxAeoplbTmB
         r5+g==
X-Forwarded-Encrypted: i=1; AL+hErGqdLk7TLt/BxBBSRwuUpGsjB6c7NkexNt56KMBXkymSY5zEheZ5yM3N1AvZokYveKtEAI9XUHsUq8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uOzW2E25PMHOk8k7oQExKkZMV0hST8mNSfdFgbDlF8LBt8FpD
	Hq5R9sFPNbkTEJEK+rLuctYe3tKxrYunqGR2lOS3rjYsIesFm2Wepcsc0BbWOqRwttw=
X-Gm-Gg: AYBFou0aPpx1oJa40G9nDJ1ADpj1xMeYNqOplK7LBCi1kTR9xfXJfW97to6mOpZcPw9
	i79/G94mzxbm9OWTuA9l76W/BiBc4BcR1wKVObJfQqJebzy86k1Srbi2pR4yDhBmG6Vtz5fNPUp
	+vTe+USVkHCzO92TFczuGvdchpDkPQabdRdfZD0kjX4sQPCZ+Cw46rtUJOihmt9AgFb2yeywX4e
	XkwVfVVicxRRE9oKf0v9Koy47/+WXgjspB7tiLdlrT1uN8d971sbub9AHn0Girqgox550iGEwky
	V+XkcS9INjISu0IG/GC9/MWXFzaLjLhmrxhjPeZRNxXEmjAZ2y2i04UfuZWm+uygKIYoJzCds0z
	vF3WdUdt5I1tPXz2RLXJu85I7lHU+XHCChD2D0Bp5dHyoEX58VWsH3+cRHyza4v2X0fzOxXHEZo
	jaTOG7IlViIlvBMXUlUaF8er9DQBoBkUbUqoZnrC92m2dHjqy+wLMM/I3Hj4TPXZ/jcRl89Ua/a
	1jwM3vqFGvq2osiGdZL4g5sTnkS7QEFVbVBuvUSqcEZqtano3tmdfn5JjP2K6JteSZ2EIaz2YwH
	R5f6FzHQwlqfGnkFSZ0YA4/9mbNYaL2uhaevGWJngrGqtGyxEKHD53Nnvkr4RBJT4tQTHSrxCNE
	NG/xK3/vzPIyFBWl2pmS64Z5m1RCgBZpaO4DS51vWp9ElR44=
X-Received: by 2002:a05:6102:6050:b0:7cc:2cef:b341 with SMTP id ada2fe7eead31-7d301ac2767mr622566137.4.1794320634935;
        Tue, 10 Nov 2026 06:23:54 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200838f0sm1837111241.9.2026.11.10.06.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:23:54 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, 
 will@kernel.org, David Matlack <dmatlack@google.com>, 
 Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, 
 loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, 
 baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
 oupton@kernel.org, alex@shazbot.org, gle.com@google.com, 
 pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, 
 kevin.tian@intel.com, joro@8bytes.org, kvmarm@lists.linux.dev, 
 linux-pci@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
 kexec@lists.infradead.org, kvm@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261110050202.529473-4-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
Date: Tue, 10 Nov 2026 09:23:48 -0500
Message-Id: <179432062803.2329176.7220119921541924936.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7477;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=3MeQeXkemHu+Wr0/oMRB7Xn+2Je8r4E7OMIYcRodeqI=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8yj5YKX9YmXwBRUiJpQxd2lEuERo2IgfqwM0l
 IVRH3L/L9qJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavMo+QAKCRC7dyhM23N6
 3qK5D/9g7VLq2y8fSOMG0PAMp3BX67/XRkPN7ey3PFRx5aKMUM07RMgQmzWBgUvl2Q6gNiQzkn6
 PzGX64l/U3Obis7LYoXZVjFyU/Y1E3VsLm3pidkNnIIr4W6pd8fWOLQ1uNuf7+Y+ZNq3oJq7nS1
 4k2nRqLY7pzJAH9m8n6ub9XYCpLh3WeltCRtRINtCyceucFzMTRCUUdV2RUap7fL6Wumu3QX5eS
 8i1d0l/SPxERlsryDD5cCykkv2QXhHkfilL/BhVrMdy39RdMo4gj/FfTT94+11QgULuudAtccqO
 U5L/QQpjwNg9nTNZkz1PQTXGK0J2aU/renYZpknMh5BplqfPCYnmTetLfrBpsDzfgey8RLF8V/Y
 Eoh+ESh7BADOSLIg69tXGp+wnSKKHwkjEOC7OQCOwY9QDGPzUzCgkpdGdmzDoNKre2SpcvdIZAR
 CcygD2hatCPKtp7iIAcav0qx3mKfHiW2V//Tu09m5IEQ7l7pd0mWhE4svcffc3miVXPGWhYrqmd
 PVunIgq+xYFl+QWB7LvoZyaTxHcY3mbTkzsfJUXKDzZ/cqAhA8jR6w9agPlhIgaeGMrDR2m2MQg
 C6Ovc0HMEbvS0tj7Rg3+WW5boGrxb4k26c6jkEz95OlytA/VPaKEpi+/upamWNVJg+P9KkVBlDM
 /j4Qa87px1Kor9Q==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

> Subsystems preserving vmalloc allocations currently embed struct
> kho_vmalloc directly by value in their serialized structures or device
> tree properties. For example, struct memfd_luo_ser embeds struct
> kho_vmalloc folios, and test_kho writes the structure directly into the
> folios_info FDT property.
> 
> Embedding struct kho_vmalloc directly couples the containing layout's
> field offsets and size to struct kho_vmalloc. Any modification to struct
> kho_vmalloc shifts subsequent fields in the containing structure and
> breaks the handover ABI across kexec.
> 
> Convert callers to hold a DECLARE_KHOSER_PTR pointer to struct
> kho_vmalloc instead of embedding it by value. In memfd_luo, allocate the
> main structure and struct kho_vmalloc in the same preserved folio, placing
> struct kho_vmalloc in the remaining 8-byte-aligned space, and bump the
> compatibility string to memfd-v3. In test_kho, place struct kho_vmalloc
> in the remaining space of the FDT folio, store the serialized pointer in
> the folios_info property, and bump the compatibility string to
> kho-test-v2.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> index 6f12f5037ea5..bee75a7006e8 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -11,6 +11,8 @@
>  #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
>  
>  #include <linux/bits.h>
> +#include <linux/build_bug.h>
> +#include <linux/kconfig.h>
>  #include <linux/log2.h>
>  #include <linux/math.h>
>  #include <linux/types.h>
> @@ -177,6 +179,10 @@ struct kho_vmalloc {
>  	unsigned short order;
>  };
>  
> +static_assert(sizeof(struct kho_vmalloc) == 16);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct kho_vmalloc) == 8);
> +
>  /**
>   * DOC: KHO persistent memory tracker
>   *
> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
> index 376a724a1d8c..7b49dd6d7e2a 100644
> --- a/include/linux/kho/abi/memfd.h
> +++ b/include/linux/kho/abi/memfd.h
> @@ -81,7 +81,7 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>   *             to directly use them in the ABI.
>   * @flags:     Flags for the file. Unused flag bits must be set to 0.
>   * @nr_folios: Number of folios in the folios array.
> - * @folios:    KHO vmalloc descriptor pointing to the array of
> + * @folios:    Pointer to KHO vmalloc descriptor for the array of
>   *             struct memfd_luo_folio_ser.
>   */
>  struct memfd_luo_ser {
> @@ -90,14 +90,14 @@ struct memfd_luo_ser {
>  	u32 seals;
>  	u32 flags;
>  	u64 nr_folios;
> -	struct kho_vmalloc folios;
> +	DECLARE_KHOSER_PTR(folios, struct kho_vmalloc *);
>  };
>  
> -static_assert(sizeof(struct memfd_luo_ser) == 48);
> +static_assert(sizeof(struct memfd_luo_ser) == 40);
>  static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>  	      __alignof__(struct memfd_luo_ser) == 8);
>  
>  /* The compatibility string for memfd file handler */
> -#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
> +#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v3"
>  
>  #endif /* _LINUX_KHO_ABI_MEMFD_H */
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index aa6a0956bb8b..cd0f183ff68e 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -25,7 +25,7 @@
>  
>  #define KHO_TEST_MAGIC	0x4b484f21	/* KHO! */
>  #define KHO_TEST_FDT	"kho_test"
> -#define KHO_TEST_COMPAT "kho-test-v1"
> +#define KHO_TEST_COMPAT "kho-test-v2"
>  
>  static long max_mem = (PAGE_SIZE << MAX_PAGE_ORDER) * 2;
>  module_param(max_mem, long, 0644);
> @@ -34,7 +34,7 @@ struct kho_test_state {
>  	unsigned int nr_folios;
>  	struct folio **folios;
>  	phys_addr_t *folios_info;
> -	struct kho_vmalloc folios_info_phys;
> +	DECLARE_KHOSER_PTR(folios_info_phys, struct kho_vmalloc *);
>  	int nr_folios_preserved;
>  	struct folio *fdt;
>  	__wsum csum;
> @@ -47,13 +47,13 @@ static void kho_test_unpreserve_data(struct kho_test_state *state)
>  	for (int i = 0; i < state->nr_folios_preserved; i++)
>  		kho_unpreserve_folio(state->folios[i]);
>  
> -	kho_unpreserve_vmalloc(&state->folios_info_phys);
> +	if (KHOSER_LOAD_PTR(state->folios_info_phys))
> +		kho_unpreserve_vmalloc(KHOSER_LOAD_PTR(state->folios_info_phys));
>  	vfree(state->folios_info);
>  }
>  
>  static int kho_test_preserve_data(struct kho_test_state *state)
>  {
> -	struct kho_vmalloc folios_info_phys;
>  	phys_addr_t *folios_info;
>  	int err;
>  
> @@ -61,11 +61,10 @@ static int kho_test_preserve_data(struct kho_test_state *state)
>  	if (!folios_info)
>  		return -ENOMEM;
>  
> -	err = kho_preserve_vmalloc(folios_info, &folios_info_phys);
> +	err = kho_preserve_vmalloc(folios_info, KHOSER_LOAD_PTR(state->folios_info_phys));
>  	if (err)
>  		goto err_free_info;
>  
> -	state->folios_info_phys = folios_info_phys;
>  	state->folios_info = folios_info;
>  
>  	for (int i = 0; i < state->nr_folios; i++) {
> @@ -123,14 +122,19 @@ static int kho_test_prepare_fdt(struct kho_test_state *state, ssize_t fdt_size)
>  
>  static int kho_test_preserve(struct kho_test_state *state)
>  {
> -	ssize_t fdt_size;
> +	struct kho_vmalloc *folios_vmalloc;
> +	ssize_t fdt_size, alloc_size;
>  	int err;
>  
>  	fdt_size = state->nr_folios * sizeof(phys_addr_t) + PAGE_SIZE;
> -	state->fdt = folio_alloc(GFP_KERNEL, get_order(fdt_size));
> +	alloc_size = fdt_size + sizeof(struct kho_vmalloc);
> +	state->fdt = folio_alloc(GFP_KERNEL, get_order(alloc_size));
>  	if (!state->fdt)
>  		return -ENOMEM;
>  
> +	folios_vmalloc = folio_address(state->fdt) + fdt_size;
> +	KHOSER_STORE_PTR(state->folios_info_phys, folios_vmalloc);
> +
>  	err = kho_preserve_folio(state->fdt);
>  	if (err)
>  		goto err_free_fdt;
> @@ -234,7 +238,8 @@ static int kho_test_save(void)
>  
>  static int kho_test_restore_data(const void *fdt, int node)
>  {
> -	const struct kho_vmalloc *folios_info_phys;
> +	const DECLARE_KHOSER_PTR(*folios_info_phys, struct kho_vmalloc *);
> +	const struct kho_vmalloc *folios_vmalloc;
>  	const unsigned int *nr_folios;
>  	phys_addr_t *folios_info;
>  	const __wsum *old_csum;
> @@ -255,7 +260,11 @@ static int kho_test_restore_data(const void *fdt, int node)
>  	if (!folios_info_phys || len != sizeof(*folios_info_phys))
>  		return -EINVAL;
>  
> -	folios_info = kho_restore_vmalloc(folios_info_phys);
> +	folios_vmalloc = KHOSER_LOAD_PTR(*folios_info_phys);
> +	if (!folios_vmalloc)
> +		return -EINVAL;
> +
> +	folios_info = kho_restore_vmalloc(folios_vmalloc);
>  	if (!folios_info)
>  		return -EINVAL;

Why do we need DECLARE_KHOSER_PTR() in test_kho.c at all?

DECLARE_KHOSER_PTR() makes sense in shared ABI structs like struct 
memfd_luo_ser where both kernels reference the same struct field and get 
type checking between KHOSER_STORE_PTR() and KHOSER_LOAD_PTR().

Here, struct kho_test_state is purely local to the saving kernel and the 
handover ABI is just the "folios_info" FDT property carrying a u64 
physical address. Having two unrelated DECLARE_KHOSER_PTR() declarations 
doesn't buy any cross-kernel type safety

Can we drop DECLARE_KHOSER_PTR() here, keep a plain pointer in struct 
kho_test_state, serialize a u64 phys addr into the "folios_info" FDT 
property, and read it back as const u64 * + phys_to_virt() like the rest 
of the KHO FDT code?

-- 
Pasha

