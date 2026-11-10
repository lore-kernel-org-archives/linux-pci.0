Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335150;
	b=nfnWNmMfcGAu6W1FSsMxHAbjk4Bm9m/TgfbbYTHB/4+2zoGMCNEHK3HIFO5CQsdZZ2qK
	 OvoTn4RTgTG1zU48cy+OSm3nF8RTsfwGb4pbRHECt6T5+diVGSTX5BsHWRDbFUDRku5LR
	 eSeRehOvtoRfm++c7LIPro0TWdkujO9wvOag//QNWKIRuyGNrHvwB+BER3eNwEvavEu5a
	 esPk4pGQIL0RY82LJAHjkJNWPtcQc4JDKYr47q8XwSyFZ8n3wuKmckvM2zbtYNRl+Uphw
	 3tk1AIhRr5gpis8jg/iTPb3Hb2dQwN0po2L/T3iHFMINlQA+w2WgrOF8HtVH6CeZAtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
	b=ZtHKaDFPcB/ybHEZspSPtl30XprIfs4tVeLIFTQQOrBr7LQhA2zimqNCbPiN2yBk0Zd7
	 rnuhlAuSEA2IzTlvPt7R7wVChf/mzvkRhDGnhGMuIGshJO/YYsYlEisupmbzdfu57eMlK
	 NeCg6tz2uVsCFLVBQ4FG9xq6auaD4FPtwlutacHcSzKW4RtJTO/PV4Zm3CdGKEG9VJb0y
	 f8CnThJVrDrAh4uAJWP+Du/M5Bey2mdvdUWqN7jIfui/3KZB0Ft7MQJkgNBhVBMh6oVc+
	 zCc9UeeeVmXlsiheGyJThMkpKBoVyG6xssxH0bvphwSmy4fLoCTdoszkYXpnhPJ127g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ss2sAv1Z;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66FF606A331
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 18:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B66FF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ss2sAv1Z
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c429d9d05f0so247613866b.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794335148; x=1794939948; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
        b=Ss2sAv1Z44xGCzrouTTSNStulPTKhVCnUO+g4V7Ttgr82dioG8oDl/aa9BFjmSvCYi
         euurrMXPzpvjVfF2ZfKzD82qUQBBtXAN9f+MJkGikK45Tj4cAehpSd8POZHmWpeSUTNa
         ee90SX5pk+PyA8l2gVtwImvYurJFi/PPJudDUyeLNd3LrsGsvH6KnVfocewpXHvIiLKq
         VjnnbVpNS7FQdGG2Lc5//B4NgFsI+lF/Az+FjkxpMpXT6wrqHKPZtvcjAcfxV7sSEMxX
         WSc7JvmUyi5mGyRJmJ514aI1wQP2Xz8QRVxCIv+4tiJbD3usEEvyGPpAG5S96WBYg/hM
         99Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335148; x=1794939948;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
        b=L6oIKXF2RPim2VeLoGhaE6b4u4ubwOzp/asA6Nr81KB7/uutWOP0F6Pp6gvoYvDWXz
         9pnQjiZYiCdpFevHs3jf+nf1tqgsv3eYU/7uDjC4jlYp3qlC/gxtsrQDerWFn7Hc2JtX
         k7hL2R3hUroSyISB5C0lFxyfbNZvM9s0LDMbQ3wm8ctE87F1i18rpQDX9455j4e4S3b3
         RWUg2twMhC6XPj0dohxMjRPfsZRQ5EhGhpBprFjw7fQPPHCK08zkhwzXSyfHVCktA5+A
         lUfviaj6fkwfA5HaKMBTWH0jqMmHAlWvg5Z8KkzUE0jVtKOCvXxTfcc83oTRA5Wx8b9f
         JYjg==
X-Forwarded-Encrypted: i=1; AL+hErGXoBUNwBi0ph4eeEwOBDlI3ZgADqqO0E4L2G7wX4SCiNpv08IHMqlP9JBTB5Me2P8KrmhUrt4/xHU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GKQYVUfkPbaZXnfxzbL+DFWyEz3WbUvNtX1YLQTPjtm1B2ZP8
	MPUbZMZr4yOu6n7fyBsBo6QewlCAkBmKi8Q10MtZ6o4B4QJ1tJPed5eNjAJuuEo1NjSzMD0PBMe
	H7WSj6wR//vP/mgBKng==
X-Received: from edfg4-n2.prod.google.com ([2002:a05:6402:a244:20b0:6b5:813f:c569])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:13c5:b0:6b5:76be:be54 with SMTP id 4fb4d7f45d1cf-6b777829b2fmr85425a12.35.1794335147866;
 Tue, 10 Nov 2026 10:25:47 -0800 (PST)
Date: Tue, 10 Nov 2026 18:25:47 +0000
In-Reply-To: <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-6-tarunsahu@google.com>
 <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
Message-ID: <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI compatibility
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
>
>> +/**
>> + * DECLARE_KHO_SER - Register a serialized payload structure with KHO.
>> + * @name:         Structure tag name (e.g. luo_ser).
>> + * @payload_size: Compile-time expected size of struct @name in bytes.
>> + * @nr_required:  Total number of defined required features.
>> + * @nr_optional:  Total number of defined optional features.
>> + *
>> + * Size and 8-byte alignment are asserted under CONFIG_64BIT: KHO and LUO are
>> + * 64-bit only, while !CONFIG_KEXEC_HANDOVER stubs pull ABI headers into
>> + * 32-bit builds where u64 has 4-byte or 2-byte alignment.
>> + */
>> +#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)	\
>> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
>> +		      sizeof(struct name) == (payload_size),		\
>> +		      "struct " #name " size mismatch");		\
>> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
>> +		      __alignof__(struct name) == 8,			\
>> +		      "struct " #name " must be 8-byte aligned");	\
>> +	extern struct kho_ser_hdr __kho_ser_hdr_##name;			\
>
> Remove this extern.
>
>> +	enum {								\
>> +		__KHO_SER_SIZE_##name = (payload_size),			\
>> +		__KHO_SER_NR_REQUIRED_##name = (nr_required),		\
>> +		__KHO_SER_NR_OPTIONAL_##name = (nr_optional),		\
>> +	}
>> +
>> +/**
>> + * DECLARE_KHO_SER_HDR - Declare a feature header variable, field, or parameter.
>> + * @name: Structure tag name registered with DECLARE_KHO_SER().
>> + * @decl: Declarator (e.g. *fhdr, **out_fhdr, or * inside DECLARE_KHOSER_PTR).
>> + *
>> + * Declares @decl with type struct kho_ser_hdr while checking at compile time
>> + * that @name was registered with DECLARE_KHO_SER(), documenting which
>> + * serialized payload structure a feature header pointer belongs to.
>> + */
>> +#define DECLARE_KHO_SER_HDR(name, decl)	typeof(__kho_ser_hdr_##name) decl
>
> Remove DECLARE_KHO_SER_HDR, use kho_ser_hdr directly.


I added this, because wherever in the kernel a serialized struture is
preceded with kho_ser_hdr, it will only be called `struct kho_ser_hdr
fhdr` which does not display (to readers) that this declaration of
header variable is not alone, it also holds the serialized structure
after this variable.

Using this macro, it clearly explain, that "Hey, I am header to this
serialized struct and I am compiled time initalized using
DECLARE_KHO_SER for this serialized structure and my pointer holds
location to both feature header followed by serialized structure."

Techinically this is just for readability.

WDYT?

~Tarun

>
> -- 
> Pasha
