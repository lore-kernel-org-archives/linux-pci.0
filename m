Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795147224;
	b=4aqqaWZi1yeHXdodDGVnyi/kfneT6KaIClKwlQwF8g+N4EGG5HXcE7rOA39H7SxX88k8
	 8xI4+ozmxbmdohofIQ2hVXRdlPr/KcJzFrBEE9lruK1ZxtPQk3/YZG2EkOgJjMCtRZ4RB
	 R7xRhRqk5JXgUyFvFLppxwNfUaxlBJ/b5Fepkl0y0CXAnamXenE/ST16kwcvYN++koqHQ
	 e3apyk6SFM6UsJBSM2RdA/X7RVd7XmEUNQ9NFYOsnU70g6nsQhTyib5p8nF9aZ7BC82Lr
	 eBp9ANeCy/WHFzQMhhyfruKxilzkSxpgXE1QpR9AXxeodG2WXL6192CdQPN/57tz2aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795147224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
	b=th69Q4CGn6qYCctYrw0kxP6U1DOyIp0l31luJhbAB+jdBL/F8C7ggyRKo1pYy8Gwm2Oi
	 YuA4Fwpn81fyeQ1n6z5Y1hTLbuFYYnt5e+vm5+5j+TjA0efANbJD1fyZ/kZ5vY+peTIwL
	 PEqiffck+q2rA9DZzxqKM4sbBbxPygM1s/5THKaRL3J3QmjWfKLpIPvwRoHIKjPCdpoJy
	 LEZyZoU2y2547olZ+aVliKPwZJ3JLFfhFS+LTaBKxL8s1ys5EZEuZZeI3L+jxUG3GrsRj
	 8+RufQ+fWwl+PFka9DOrxBQ1qsWce/Es0tPp0LwKTxvLKK0MG/UFf0TdjKdY7DcvDkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B5criCdm;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F6606A330
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F4F6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B5criCdm
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c40bbd26f74so37819766b.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 20:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795147223; x=1795752023; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
        b=B5criCdmTHpf648AOYOoTrsp7d3NtGQaXhm0wMw1FXI3k3qw+457SKF80eC5qUcEr9
         R5Jarg3tinhS/KE9BrIkFy3cbmSnVIChYpPMlyDW9+lZKO0ID9Z2fsL+JRhl6dfnl5wS
         u/0lzw3QyLg0SUhXq9kg7PJNK37zkAVLcXZFEgnPtuPAnpD+fadgjVq1GtCPSrfhUFiY
         BIgOo1wmzaloGacQItCbAPgBfbEoVgkdAr0aWujuWDehTSM49+mnRV62CDO+hXm9kMUQ
         YSTirgHtY4c5Xa8FG4gJ7p1jPWSue5VrdAxaaoO89BsEeROyX55jHwuC8zlqUq2NyrgT
         HlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147223; x=1795752023;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
        b=h8YFfNZ6gSKLyhh2LQbzCIzju2dU/FBWKMxhY+8o7gImPM7jvS2FP8Ix/5iwucCeYh
         0yZH/01+YfESNPw4CXSXWPXjol15f/GeuOohW3lM7i/dk7/H2GodNXm2+39q0UABhtSZ
         o8jKppVs5VKyDCfu5L1TdE6Ai4P5SmsEtAeiDgtQT81uOM/XLUWOTZBJrEJHjxBnxZV2
         gq470mcgJ0lF3FWpIficQ+xD7BQm2nzox+ulpRrdy2l0QMmH26EB+buT4K7FpFBVE/Dk
         utn72DiA7rmuPOCWhPSPXqd+bnB/3v69Q/9g44oPCntjbSt0fKq3/T3+cRZzHXCCySKy
         ukYA==
X-Forwarded-Encrypted: i=1; AL+hErGpXV8uft/9v9ECuz+dl4bJZ0FkHwG1jp9Wis1EM256WFfA6TexEa1hcf2QPYmp/y2Ufa0OZDaD0t0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PvpaHNw+FpBbw1p+KkEjdAyC+0837iHqgwU+AAZCm+7dmgaX/
	s19RGOlXZEo1ZS30MQT9puLEf4agGDrN+dGZXtHfDma5FZ4hzg6dUViAY+BQxMi4Gf9hMYEyXn2
	GIFby9lyXiplJrDaqTA==
X-Received: from edeg3.prod.google.com ([2002:a05:6402:5643:b0:6b8:a08a:8bad])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:501c:b0:6b8:afbd:64e6 with SMTP id 4fb4d7f45d1cf-6ba37edaf1cmr1021371a12.42.1795147222675;
 Thu, 19 Nov 2026 20:00:22 -0800 (PST)
Date: Fri, 20 Nov 2026 04:00:21 +0000
In-Reply-To: <20261115203421.38c206b35f5b12e6@chrisdown.name>
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
 <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com> <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
 <20261115203421.38c206b35f5b12e6@chrisdown.name>
Message-ID: <9huzmrr4f8yy.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI compatibility
From: tarunsahu@google.com
To: Chris Down <chris@chrisdown.name>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org, 
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Chris Down <chris@chrisdown.name> writes:

> Hi Tarun,
>
> tarunsahu@google.com writes:
>>Techinically this is just for readability.
>>
>>WDYT?
>
> It doesn't help readability in the generated docs, though. kernel-doc
> splits the parameter list on the comma inside the macro, so
> kho_preserve_vmalloc() comes out as
>
>      int kho_preserve_vmalloc (void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc# *fhdr))
>
> and the struct memfd_luo_ser and struct luo_session_ser definitions in the
> ABI docs end up with a member like
>
>      DECLARE_KHO_SER_HDR(kho_vmalloc folios_fhdr;
>
> I'd go with Pasha's suggestion and use struct kho_ser_hdr directly. The
> pointer can then say which payload follows it with a comment.

Okay that works. Thanks Chris, I will update it.

~Tarun

>
> Chris
