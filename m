Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323545;
	b=Zqugf+iJG294ZU80cUQB1C1+hHcCbvVAUw0MbWYyQlOsSs5bDUNcODarTHx14sq7+wca
	 0qwPTxE865J7HSA+Sc9MvfgtsIGRNBhs2J24nFPektXSv7QuNb8FWa24EcfM2wIHPsPFJ
	 F89tmlNc70BVFGPjCNucZ+kh80f6A9Rh6BZDsznnggfkR5yFhKBITwlCuqzgMelICa1UE
	 jEFyblbcejm3nTyZKge3oGZox1dOlum4moKroXt6QP6tlv/okE3mhXAFnhB+4JUfp+tuR
	 XKpvmN9jdet5cidbbPG8IVeVn4e9Xj4ZZVIRDPzYp1UPHdqMkIIJt85olaIc9xx+Huw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
	b=qMpcirzQ6hYgOveIZUvmX8jNu9kJ3znhCPG7/WMSylQpSQt5rV/20sukYoDwpLP40jd2
	 T+N4VIPKrETEXWgHjl47ZZn93JQL7AwvkOw7z+CjH9wgcPWcpd6DZUAo8bNyEeqbP05KJ
	 KVmajAq1h0FpioPOjNuQvBkuNqWQnsoMOhHVpyDN5KoZvfFiXgdgzyfb0rj1Y9YzfSwG8
	 6lPAYNtIRxbUE9VQ6I0vIMLfwUe1D3sb45nV5bZrlf23h+joa6DRoEt8axMB6VDxHIOVq
	 9eHdUi+PN4cEvOmTvDb5tPezz0s2uJOM1pXPaMCJOaZDz60PTTAJ3+8TKzmnxjYBZFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="YOUBG/UJ";
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB860A2607
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 15:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EDB860A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YOUBG/UJ
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so673003e0c.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794323544; x=1794928344; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
        b=YOUBG/UJDUN4UyxvkhIoLhefkcKvcqtCc43YY9icyFLipWGwJr4yRhoF61ai04yb3G
         /3oA/YdYUik8WvsHFnI3gFCqTxtjsY0R+rgJT3k6h2A7QoXojCu8iohoASLyE0xrRsG6
         r77coPHPIo9sHj3xb1YOG5IhOJKV9qF8R6gyeeM54RzrM2UnL6uNga7Md3t05uiI9v6o
         5KldDRCzbIk9P4MYLEtb+lU5m6ZqVMMuwQ4336EDEh3PepvHzOcgNGzJe9mzOCIKRb4w
         P2iFaU19sefu/7GQ+UIx4MnWmqodZKnGvXovtykItH/b2HiCw11TEk6EiCg3vu0DA4qv
         p42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323544; x=1794928344;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
        b=RKYxv3p+fywthvi3ck3B/WicJLa2fdvBA4Nr528XikFElkyZsBJMWlcigiZqfj9feT
         XcS3bVTuuuxwyP6RAciXxzJy4cmtXoNuAAU/dHOoYmmPmAscqu74wUAR65VcTH6+eM+e
         W/ELbeYrl0kbshaJ3Mxw+CxPVprLvYWVmKghy5GH0tR5gxmYFmLOUn3j062t7GGl8e8Z
         zje8W9Pn0ACHFXMUazXzf0qYYvY22Ru+od+hjId6xtkcrJ27esNy7GGIMPevExCpQ64J
         Vv+SGCIiB4phDvBJJFiWZN+cqWldnDnBUc5zNRyVyAHRE3l4bUxHDLn1seAdjLTfdG+G
         RzNA==
X-Forwarded-Encrypted: i=1; AL+hErFcHLNQNwUSiF6KCdGMWRtsfY3rl9thHAuMTBrjbmiLOfSqAjMNEG/bSqoGM9Y90+HR0VVt2rSySUY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hvLnNut9mvfPOdcav5q1ltWKLt+TZGDCFKCZ01jUn1zaSBG2x
	P26by37HWUR0q4TDpZyeRJ9qX97Syd5w86fCVJb5JnJ7iYSUzLBvuORnQtyeysoAu7E=
X-Gm-Gg: AYBFou1DvFD1dxB5IVUGZS/hjwGvhjS/as2VNhHk49sD1Qm7KOMB1VclOEmPol7STdB
	V/tGlQpC4xYRMGnOE3V22OfZOoRxmvkFx5Fkd0bZFppqu8WIr0Z1yiZExhXxQH2Hy/z5LSNmg+v
	XfrGgn43T/rjRc5UTHcDW6grGHEI4L8WYQXeeVc8tIjwfQOaPyufCdlsKvKGWg0CsY8JI/SEwRE
	5ZkoNGrafT9ZreM6OFMx2qYpqKAaHSpKHdg8zePzpUoZ91FT5huHSfSmEjxnptB5BUlBJqYqYKr
	VLq07AsXa45fTa8kuf2mT02suCdoIstZEpb8xGq0fMctcRy9ekDG+kYicaLgLuQPZW+WYenB7Ji
	22IhvigyfYGw/njqWyd4xuLWcEXqNoLRvprf4+I+OwSb/dN4ZVrvX2b7qT/1IpphqHRxkUy640l
	l+OmRz8GETq7gCLpSJx/TE7qckna/6RPPvThTT9BoAqcLswNVUly9LAM1iaUyEm5kAWwnYEs5V3
	+rQoha0fn5UdO/kyWdRXrbY0uybkXiljnkumCo6EgeR0+MQqrvWmbBEEPmklViMbHYLjLSt6OtM
	AOuKDrHuXNl09aqmGX/WPn4nPs+YE0Go08mvaDtO4vPjkcDv6mWfrIKdsrzfw+aQ2IGMsEgronA
	0IMf2UOJHdsIxFZywUbFP3gBj2ZYb
X-Received: by 2002:a05:6122:5313:b0:5ea:a0f0:192f with SMTP id 71dfb90a1353d-5ee0d0cd07bmr947867e0c.10.1794323544266;
        Tue, 10 Nov 2026 07:12:24 -0800 (PST)
Received: from localhost (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c45a110sm2039560e0c.2.2026.11.10.07.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:12:23 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 10:12:22 -0500
Message-Id: <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-6-tarunsahu@google.com>

On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:

> +/**
> + * DECLARE_KHO_SER - Register a serialized payload structure with KHO.
> + * @name:         Structure tag name (e.g. luo_ser).
> + * @payload_size: Compile-time expected size of struct @name in bytes.
> + * @nr_required:  Total number of defined required features.
> + * @nr_optional:  Total number of defined optional features.
> + *
> + * Size and 8-byte alignment are asserted under CONFIG_64BIT: KHO and LU=
O are
> + * 64-bit only, while !CONFIG_KEXEC_HANDOVER stubs pull ABI headers into
> + * 32-bit builds where u64 has 4-byte or 2-byte alignment.
> + */
> +#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)	\
> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
> +		      sizeof(struct name) =3D=3D (payload_size),		\
> +		      "struct " #name " size mismatch");		\
> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
> +		      __alignof__(struct name) =3D=3D 8,			\
> +		      "struct " #name " must be 8-byte aligned");	\
> +	extern struct kho_ser_hdr __kho_ser_hdr_##name;			\

Remove this extern.

> +	enum {								\
> +		__KHO_SER_SIZE_##name =3D (payload_size),			\
> +		__KHO_SER_NR_REQUIRED_##name =3D (nr_required),		\
> +		__KHO_SER_NR_OPTIONAL_##name =3D (nr_optional),		\
> +	}
> +
> +/**
> + * DECLARE_KHO_SER_HDR - Declare a feature header variable, field, or pa=
rameter.
> + * @name: Structure tag name registered with DECLARE_KHO_SER().
> + * @decl: Declarator (e.g. *fhdr, **out_fhdr, or * inside DECLARE_KHOSER=
_PTR).
> + *
> + * Declares @decl with type struct kho_ser_hdr while checking at compile=
 time
> + * that @name was registered with DECLARE_KHO_SER(), documenting which
> + * serialized payload structure a feature header pointer belongs to.
> + */
> +#define DECLARE_KHO_SER_HDR(name, decl)	typeof(__kho_ser_hdr_##name) dec=
l

Remove DECLARE_KHO_SER_HDR, use kho_ser_hdr directly.

--=20
Pasha

