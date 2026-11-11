Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375422;
	b=Vpgy8WBwHs/qAr14rewAkVvafG2yPzwTWQcePFOyjygbW2egax96/Z3qZblmOpLwswsC
	 Fa/exDeP/XXYctAu5xRhAvex1fsqBneVjqj/vJAwmwtgtWglcDcwH/jffXUDmnUUdl2sq
	 39XsueU65qqC1GmFk5Nnb2xxSqPCq/dogAgjGSJ5rpKaaUr9Pnd2U6/aY+YZSoAddwHyA
	 Q1Pe4kqpLIMd3x5MAQPwk/L38i5rY1/nCVcmFsDwuF597sidTFhKY+tDA918UFu5JM60M
	 WG/GJEU2lUZT1O+9zusDQ2/qErQWinLiS5UnOKNR3HXaDl1snnI42GATP4smO7aY4kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eLmVTYOfswJ+cGfMoCZUFy1VK5TCu4veYLS+0REM4CM=;
	b=Atg1G/hzq+YbaNlZHrGvfxdSR2xEDwecTZm8qhK8rwc0nUjpzU9TY77APX+KOj6euZsF
	 dzIb7fiQ6dmItt9IuErGkLRO0NfAOOqhyJvdjaNrsyWF/nqcJtaXRWQDo6g9J0KST+nB6
	 a/Y5L86wkisRT0Ajf+0mtFh5F6U2qortv7wq5dLTpqAAzLRsEh7hbL0hZL4dVD3huXfiZ
	 L/N+GZY3LGtueGWdGPr8l4LAV40BBlei03yzoCG52UTLnpvC2eMF7u9Ow01wCmIZm221G
	 UgEUM1q2r80txjVJt8mPAtM5uVGEHBKcHe77rE8iCyhpa0SUvAA2xcfXEUlxa90AcIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j0h7t6W2;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A650606A32A
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 05:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A650606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=j0h7t6W2
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so20822385e9.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 21:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794375420; x=1794980220; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLmVTYOfswJ+cGfMoCZUFy1VK5TCu4veYLS+0REM4CM=;
        b=j0h7t6W2DhVdMUK6Ake7JqZjqrnTvHtViAvJAdnP83aR3NfgvIHJywMNNZw2qDFFYJ
         pZVHUlmqFSM0KTJ6KVSrk78AmbGhzrjkNyJThYbaCbowANuc6lSdDGXt5hINeyqJspkW
         6+9+aP/K6t57zRXMZvIa1sdCqATbWCBs0Af0GV+w/9ssx/kDyne1QjMnI7LNbeKsR2nY
         z2sf5dPvG4eOvKvELtfHTr97/MUcE9vGfDqwxg7s9FgiDgwLaLfE15EIe132P5/hGL2M
         iHhvk0FcES6c9vCnyFTpsE2akeQay/L41FGbDg0wZPy0W0HZvzH2GkJkEQUovdYlXLBz
         EZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794375420; x=1794980220;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLmVTYOfswJ+cGfMoCZUFy1VK5TCu4veYLS+0REM4CM=;
        b=0RIdegewI6Ep0by3GERiyl/va2+UqtrzFwo8dgpkkJFadtRvMdZwlnzhfdm2JhErVd
         eY2BykBkWrbDrMxySiaSa40cM6lz3HDbSDTgsP7kcKAfi3tHt3Ol/K7CGppFUAlVpGwb
         2+2KPd9ewV5bA4csos+cE2BfnO4TFyGkaUsJFEXGTbNN+0xyZcNhu0BQU18AZHiG1nVA
         mAavItR0ix9meuu7PStctXQnBK7GsI+EWVELdztHjh0Cj9lBHUZb+pqewGUV6IIvx11P
         N1J3BEcquuiyHOJV1Ju7jTY8C3rglwzSbZstJl7JgQXO3HLrIsBqqpN1vPjJHgnqpkgR
         fleA==
X-Forwarded-Encrypted: i=1; AL+hErGdTAvWIk/qfIEg+fwFiVbjI6/P1Mw3HVOJ9OR9SMTBapUitUJyvpYkPM3iUaUw1sEbC4YtNu/JGiA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BWjisN8MhEjdsYENPWZnIaVLDSnT1hkNQpGfTX0+Q1V58K+QF
	q9QmTvIco5CbhOmOu9vsWoC9JXDTRqy0lL0l7DqoABh0ZN6/fXGZzz1qlsP0yrXLkpLnM29JDLN
	v81U31bzmLwmvJcs2Jg==
X-Received: from wmsl10.prod.google.com ([2002:a05:600c:1d0a:b0:4a3:5d5b:9ad9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:810c:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4ba09379cc1mr15865455e9.7.1794375419814;
 Tue, 10 Nov 2026 21:36:59 -0800 (PST)
Date: Wed, 11 Nov 2026 05:36:58 +0000
In-Reply-To: <DMRJJX2ZSYQT.2U1TTBGE7R4RA@soleen.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <DMRJJX2ZSYQT.2U1TTBGE7R4RA@soleen.com>
Message-ID: <9huz5wy4q685.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 00/19] kho, liveupdate: Add feature header for
 fine-grained ABI compatibility
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
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

"Pasha Tatashin" <pasha.tatashin@soleen.com> writes:

> On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
>> This v4 of feature flags support for LUO and KHO is no longer an RFC.
...skip
>>
>> Each serialized structure is preceded in memory by struct kho_ser_hdr
>> and registered via DECLARE_KHO_SER(name, payload_size, nr_required,
>> nr_optional). Both struct kho_kexec_metadata and struct pci_dev_ser are
>> explicitly marked with __aligned(8) because their largest member is a
>> 32-bit integer, and 8-byte alignment is required by DECLARE_KHO_SER() so
>
> I do not believe we need __aligned(8), because the struct immediately 
> follows the newly introduced kho_ser_hdr, which is 8-byte aligned. 
> However, we should verify that the combined size (header + payload) 
> is 8-byte aligned.

Yes, we can check total size alignment and remove the __aligned(8). I
will update it.

~Tarun

>
>> trailing feature payloads remain 8-byte aligned across 32-bit and 64-bit
>> kernels.
>>
>> Also, Introduce DECLARE_KHO_SER_HDR(ser_name, fhdr) which is just the
>> wrapper for struct kho_ser_hdr fhdr, This makes it clear
>> To which ser_name, this fhdr belongs to.
>>
>>
>> Series structure:
>>   - Patch 1 removes __packed from KHO, LUO, and memfd ABI structures and
>>     asserts their natural size and 8-byte alignment under CONFIG_64BIT.
>>   - Patch 2 records entry_size in struct kho_block_header_ser so the
>>     incoming kernel derives the entry stride from the block header.
>>   - Patch 3 converts callers that embedded struct kho_vmalloc by value
>>     (memfd_luo and test_kho) to reference it via DECLARE_KHOSER_PTR so
>>     struct kho_vmalloc can grow independently.
>>   - Patch 4 converts struct luo_session_ser to reference
>>     struct luo_file_set_ser via DECLARE_KHOSER_PTR instead of embedding
>>     it by value so both structures can grow independently.
>>   - Patch 5 introduces struct kho_ser_hdr, DECLARE_KHO_SER(),
>>     DECLARE_KHO_SER_HDR(), and the serialization/validation helpers in
>>     include/linux/kho/abi/feature.h.
>>   - Patches 6-18 add the feature header to each of the 13 KHO, LUO, PCI,
>>     and memfd serialized structures in independent patches.
>>   - Patch 19 adds a KUnit test suite (kho_feature) covering the feature
>>     header helpers.
>>
>> [1] https://lore.kernel.org/all/20260903023452.721732-1-loganodell@google.com/
>> [2] https://lore.kernel.org/all/20261021152527.375070-1-tarunsahu@google.com/
>> [3] https://lore.kernel.org/all/20261026174217.603114-1-tarunsahu@google.com/
>>
>> Tarun Sahu (19):
>>   liveupdate, kho: Remove __packed from KHO, LUO and memfd ABI
>>     structures
>>   kho: block: Record the entry size in the block header
>>   kho, memfd_luo: Reference struct kho_vmalloc via serialized pointer
>>   liveupdate: Reference struct luo_file_set_ser via serialized pointer
>>   kho: Add feature header for fine-grained ABI compatibility
>>   kho: kexec_metadata: Add the feature header
>>   kho: vmalloc: Add the feature header
>>   kho: block: Add the feature header to blocks
>>   liveupdate: Add feature header to struct luo_ser
>>   liveupdate: Add feature header to struct luo_session_ser
>>   liveupdate: Add feature header to struct luo_file_set_ser
>>   liveupdate: Add feature header to struct luo_file_ser
>>   liveupdate: Add feature header to struct luo_flb_header_ser
>>   liveupdate: Add feature header to struct luo_flb_ser
>>   PCI: liveupdate: Add feature header to struct pci_ser
>>   PCI: liveupdate: Add feature header to struct pci_dev_ser
>>   mm: memfd_luo: Add feature header to struct memfd_luo_ser
>>   mm: memfd_luo: Add feature header to struct memfd_luo_folio_ser
>>   kho: Add KUnit test for the feature header helpers
>>
>>  MAINTAINERS                            |   1 +
>>  drivers/pci/liveupdate.c               |  99 +++----
>>  include/linux/kexec_handover.h         |  15 +-
>>  include/linux/kho/abi/block.h          |  21 +-
>>  include/linux/kho/abi/feature.h        | 372 +++++++++++++++++++++++++
>>  include/linux/kho/abi/kexec_handover.h |  11 +-
>>  include/linux/kho/abi/kexec_metadata.h |  17 +-
>>  include/linux/kho/abi/luo.h            | 102 ++++---
>>  include/linux/kho/abi/memfd.h          |  27 +-
>>  include/linux/kho/abi/pci.h            |  66 ++---
>>  include/linux/kho_block.h              |   8 +-
>>  kernel/liveupdate/kexec_handover.c     |  98 ++++---
>>  kernel/liveupdate/kho_block.c          | 172 +++++++++---
>>  kernel/liveupdate/luo_core.c           |  43 +--
>>  kernel/liveupdate/luo_file.c           |  58 ++--
>>  kernel/liveupdate/luo_flb.c            |  69 +++--
>>  kernel/liveupdate/luo_internal.h       |   9 +-
>>  kernel/liveupdate/luo_session.c        |  55 +++-
>>  lib/Kconfig.debug                      |  13 +
>>  lib/test_kho.c                         |  38 ++-
>>  lib/tests/Makefile                     |   1 +
>>  lib/tests/kho_feature_kunit.c          | 184 ++++++++++++
>>  mm/memfd_luo.c                         | 183 ++++++++----
>>  23 files changed, 1271 insertions(+), 391 deletions(-)
>>  create mode 100644 include/linux/kho/abi/feature.h
>>  create mode 100644 lib/tests/kho_feature_kunit.c
>
> -- 
> Pasha
