Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328775;
	b=v05OLhd0XYYNpy7gITHgU09gi+2LcX4ixcEJTNMV0g9jt/Froeo9Ht/ckY4P5whcP25L
	 o4aqJPXrgfOg4IDe1h3JNEeoSH03BoqpIx+RWqWKvuWXcRP2cXlPQYPVD8OsexSiVtUSr
	 5lbGRCAzXIh6Lp7cBXm3fzxtc2Yg23M6j2toKIftXUQwclmbQCi/EfSeLwXc2005SWiCX
	 r8GYE0ItY9pZ2MJNcvs3cb5grUBwSIK6bUCspLKiW8i5zC5ha399BQuTob1oxsB8sBf0T
	 RU71riw51ftOVUmYI9JCCMAeEjUhwtPxYJPRwm8Fari8t2tDUiOUpsnhCmgBjvPuM8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
	b=3zMjsX7GTciVzDcGERiym8tpgqXeKkZvxhfQu6VJlbIhTQdIrjK32T+wYnHju8c7wFeU
	 yq6Utmw9Z7Luuf4FPQ4FQBY85smZB/O/aF73lwqtdU1ibgBWqC1wLyQH+n3G9xiBG3EHt
	 o6HaMlukeQH2RqN+eoNF19dntyyoEjyQvzNOWpu1EdnMvbp09r3g4mhMKGyahuW50FDUp
	 k4SzcOnD1xQKPABld9aTXV6EkwSuSXetlXSTmemcRWwDGiTGx0Ali2ufiQabSB9kp+CgY
	 tt8KgsM9DtOkLyZIi0nmXoh3Njosuacxx99GKAQFZgQDL0iPzU/zE4fhEN7oXGq+Cgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Af3onASr;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739660A3801
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 16:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9739660A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Af3onASr
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b1535be329so1180574a91.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794328774; x=1794933574; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
        b=Af3onASrXSp7ZkNpgiwe/Q2+oXpI2XjcCAiLbtB+390MxJDRDjSFaW1jd9q05Yg8tN
         JlwAwdyX7S+G/Tn5f64UiFDiRZlle3R5xR0Jw9PSv3k3c3Mh6pWQZ1CGzhvf+hw38y5X
         dU8RoU0RUVyNKFjWhU9rF0Vf1Z6e73VWXTGSSlYsDn9yMfJsKqoBa9utqC0AN7pUvUvn
         iHzNcnQeTol0BMW07/jYQ/6NveZ+1XR51qNPvL0SG7sBtMz0KYYFVBgzvWx1EUDw7Jym
         huQ7iDW1WlGdR43JlVdcrlnpjIjyp5m2PtmwMdYy5JhTpS5krOGamd/BQhmEp5dJQ1Oi
         hSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328774; x=1794933574;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KprtAoIZUPQy03e7SCEXrO4BhVdW6Lml6VdK8wkVG2w=;
        b=IXNAewX8snoxZKFa4/mf/7HEfY7GosopCSy8Cqv79epoGudasDR8RBsRdi2abVkLmK
         yZshn5jT6WO5ALNh3ZWiAdI6KcqDeXT6hdPoh0QWraPqcQwaPXjzl4ZxsFKXhiBBCUYE
         IE6VJtL1j2GyIjMJS6o0PbDrM68rd8uXUfGgAWB50/8Fp7B3qyPuCyP61SlGUtQwhrd4
         SDZhtqhoDlYfOppNGuXZrIaO9thEe2LbN4Y0FL68pe8pAy1vQNzhEMfbo8qig6lCa8K3
         E3MGHFZsAAj/L/h6MSEF5Ge1CyEDmaZO76UDqg5TO1sdpiVJEeWO89CmQdXbBvAM5VNx
         V+UA==
X-Forwarded-Encrypted: i=1; AL+hErEUH3cxCW/gywx+em5atY/Uh2kSZpTMtini2YqtEp40DKPATZD3zdDwl0xq6lmcGvM7kEy92Wi15Ds=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LicaBf5O7pdIrsI9EK1mdVDZM73gyJi8CBQbnuKvwnCcR4yp0
	ltaDYOGzn85hKyujN5bh/cZPfvsSODdrPAPJLYKv36XnxpHa2gbPhpntP9UnV0fmuQ==
X-Gm-Gg: AYBFou21yI2bvs+fn1FXww8M3uBcWsXYL3Wcayv0b2gNbUMdAaN9jT4RnX8wZ2Aai1c
	+zcM6gcUFqQCouo4kBmfkR3iB9dxW/1BNNb/SBG1a/zfSkIMVCUVe26jPSZus+zg3yctv2jTAeY
	OwsfkgfUnTEVV2Ezh5C+63NnR1UFIuxOq271VGybbgSRoICukdTpqyEih+ZpF/rdLlOKk6y9MtM
	MiyhXjd4ntS3AP+2hN2vrp4TLKAAY6lgo0LQ3wD7uTC4xdIOEs7Vz/kJKxvAIupY2tLE/qfVqob
	jF5dCb/GDE8aXhZJ/0+c6372flBOPJJ38WLP26BWcwwNZ9y8cqjA2j9mr2aMSU1SNnDlkehKJSm
	PJnlG91MqOfzOSxMMi14ptC863PAgFVtekQE3JbyJUmCGfSX7FBjWwmqD2eUAlgL3XqxXhc35XY
	3vVCdLyOAC8fZ+0sXBFIou3xH9UNN/57DfLaTKQK3yUUhUI2f0FcGo9IKiAQkoco4HMXfXxJEo4
	Qyuyu5IGvG57uUmqKDEwZxxP+O8ZsURFbbQvUzHoIGp8nHjSvy+jDayPZ4malN/3DLXl3aE9KgK
	/vJbEtrX2SgbOi7J3LaGf/uHbGqcxNu/dH0W8FEAmjB55iYRWpc4faf4JMBjEull
X-Received: by 2002:a17:90a:d444:b0:3ac:9d83:8861 with SMTP id 98e67ed59e1d1-3b166e3c924mr3152630a91.67.1794328773194;
        Tue, 10 Nov 2026 08:39:33 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168a8de09sm2418499a91.0.2026.11.10.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:39:31 -0800 (PST)
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
Date: Tue, 10 Nov 2026 16:39:31 +0000
Message-Id: <DMROGPTP93G4.13PA42UFKZJNJ@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 15/19] PCI: liveupdate: Add feature header to struct
 pci_ser
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-16-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-16-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> PCI_SER_REQUIRED_FLAGS_SUPPORTED. Remove dev_ser_size and
> PCI_DEV_SER_MIN_SIZE so restoration derives the struct pci_dev_ser stride
> from the KHO block header entry_size. Drop __packed from struct pci_ser

Taking the stride from the block header is good, but dropping
PCI_DEV_SER_MIN_SIZE removes the only check that incoming entries are
large enough to hold the fields this kernel reads.
kho_block_set_restore() only rejects an entry_size of 0, so
pci_flb_retrieve() will now read past the end of entries smaller than
offsetofend(struct pci_dev_ser, refcount) instead of panicking. Please
keep an equivalent check against the incoming entry size.

> from the KHO block header entry_size. Drop __packed from struct pci_ser
> and struct pci_dev_ser, adding an explicit u32 reserved field to struct
> pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to

Please move this to patch 1, which drops __packed from the other ABI
structs.

> pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to
> pci-v2.

The PCI Live Update ABI hasn't been in a release yet, so maybe we don't
need a version bump?

[...]

> - *  * The size of each struct pci_dev_ser is recorded in
> - *    ``pci_ser.dev_ser_size`` and is never smaller than
> - *    ``PCI_DEV_SER_MIN_SIZE``. The next kernel ignores any fields beyon=
d the
> - *    ones it knows about, and must handle entries that are smaller than=
 its
> - *    own struct pci_dev_ser.
> + * Preserved devices are serialized as struct pci_dev_ser entries stored=
 in
> + * a KHO block set. The block header records the entry size, allowing th=
e
> + * next kernel to step through entries using the source kernel's stride
> + * even if fields are added in later versions.

Please keep the rules for extending struct pci_dev_ser. I'd say
something like: fields appended to struct pci_dev_ser must be gated by
a feature in struct pci_ser's header, entries are never smaller than
PCI_DEV_SER_MIN_SIZE, and the next kernel must not read fields beyond
the incoming entry size.

[...]

>  struct pci_flb_outgoing {
> -	struct pci_ser *ser;
> +	DECLARE_KHO_SER_HDR(pci_ser, *fhdr);
>  	struct kho_block_set block_set;
>  };

I'd keep the ser pointer here (and in struct pci_flb_incoming) and add
the header pointer alongside it. The header is only needed to free the
allocation and for args->data, and keeping ser avoids sprinkling
kho_ser_payload(outgoing->fhdr, pci_ser)-> throughout the file.

Also, please call it header rather than fhdr, here and throughout the
series. fhdr isn't obvious to someone reading this code for the first
time, whereas header is very obvious and clear.

[...]

> + * @reserved: Reserved for alignment.

Please document that this must be zero, so it can be used by a future
feature.
