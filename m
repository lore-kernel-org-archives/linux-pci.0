Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815596;
	b=W03jX6R64JVtsoJIaXbj8ZVfkhpzaE4y0VK22wt6xy/SGMUFVwOq66kEZBnH8zDEeFV1
	 VzJmXlmj3Lue0eA4aaQawyLdSnsjrn4tUh8JyhJP3eTvSb3PYuw/pas0TcDld3o0xJ247
	 EEEBoiSe6KIRWup9w4x6pQeFWwyYJLkHge1iysvWES6ZhsbspI1l7hLkcdEiiz9AVoWSG
	 ye3tXNRRQPDFIL0zP4NRAV2UwtTyHGUMKzJeYcp0hka4IJ/EA5V/9PJVtL7fwajtL4Ry+
	 KMpNK4oPhSK6iXjwOgMFJbrvbh5uWP1l3bFUrKSihdUJiLRzRy5sW0nZL5upgNbyinA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GRG5s9Ykm6gdotG16z6YfBmoncjsZwUpCfdfDleiz1Q=;
	b=LMJruyUWnUQPQPBBVkZIoAx+zgB3qj2RlJ+5jbEYlLRplNV3fcwigCUhD1LOx/CmZXBE
	 765+MJ3eEJkmLZ84cMtIj5Eh1Al/uB+e6pL1+51EvBjTW29M6oK37JYhpJ6O2IMvCrNBE
	 z0o+TWw3A3fDCzR7f7pYko37/2PekHrPluaCy7gWFCHNSsMtPg+sNjL0gZO314A5ysUZN
	 sFDpr2Cu5p3oGb4950YkobMSawZ1CMuaTvG1vZNZUeeS/KrXU51EQxtdM7fmtQuk8SmGO
	 tHcY7nSEEliryCAfBzk6dB3XTEcPs3iRacSFkUP5m0zgBsZ9oowdHD76P6KsLZOu5Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WliIYQRY;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A33606D80E
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 18:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A33606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WliIYQRY
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso610730a91.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 10:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793815590; x=1794420390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GRG5s9Ykm6gdotG16z6YfBmoncjsZwUpCfdfDleiz1Q=;
        b=WliIYQRYHNdchsLq7SQIkvo/eS23FuBDujIvZwfiAhbl1fJdFHV3CQ3WnIHjP0/A8X
         RC+UZxPyOIZJwQi8Q1/saKu1y5dPGuUmaxotbeWEjNu+dZGDNJYHzYIf1c4SCLBP/BhQ
         C/k6PeRYrCFEMtB6+YicL2zlEPPWKalYa/voigHvz9GObPPZei1JLW1Jos3kRtmRe4Jy
         IQqXUYnJ37WC+ljY9DquIcjkKt7VD6xGb0Z5UzdaZr0vy2jkaqwbvP9EM0kBLl04JHK4
         lhCi4WxBcwkiLLvTqKtokv9DoGjU+IIvUPHJSDnco6EMxQjmST+K+yaVMjlLPxA5uvWb
         jF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815590; x=1794420390;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GRG5s9Ykm6gdotG16z6YfBmoncjsZwUpCfdfDleiz1Q=;
        b=ljG/cL1eJIIuc21/3aJirmOcXkmiM1s1064sMZAJOvTdG2yaFlZ3zEKdWq9TlIsRNl
         97K2/PH3x8c8ef9iOWnwT0aVQa8rQBh/S9E2cGnHv3NodfdA5s+AWdrmpcuREfHk8chT
         y3l2CoxVDuwvQoofI62P3hzHzahbfjHbBCq0UsXN5fFfIQpd6Zakdf3EGOE5D45fa40c
         9+UDhKI2Ahs+/LYv+kBbRt0TcFgPWm7xooO0j960QHaSaRJXI1imd2sOvvUMfhk/PyYU
         tloxXKDF4K1JYgAjNOzRN0jqbKcGCPS8LFB6nMjC6+9jA+w8amF0rNjlolkwlJ0daSmY
         JtyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwyvyc7rK5E3+nOkb+/adJm2be08TObU5MTI09XAc7M37mTaMjnWNcz5SbRL8w5RWc4lwk/qgwbuwc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9O0ouHKKHP80hACRoo1kt8D8qOu6YqX2FPl6tZ2hXeoxh9n4kp
	mdvx7N8t2qDPa25hoMmQRKAfu3G2mURCi5V98nmGIuR4OsN76ZzVHUo/w6W1C5TVDg==
X-Gm-Gg: AYBFou03a2hYHwrhepImCUA8wTvVuGNAiKA9qT4Pt2SOMifO5FbVV2Cju95wPFt8aIp
	JugIU3pyuvEelhrziV0fh2ntkbiszYF7Titw2yPDj7g2w2XpshLaMDI7XfJMe2N8Q9BsWcelxXS
	dRfwoCLfhiBkEDJWiBlchQlVdeEw4A+LqGyT1HVCOmdl4UDhTOhtTuJLU2s9wwq1NpxqVJGWzkL
	HJPshHH2MDJyHBwRnzpxtos5ebSpassLM+PMf5SEgXlXs2R8C/n8vGz9DpUuAyAdO1VRnjld9zZ
	GO3o0jpXAV/30HDOuU+FxlG1bO/fQIy5w9eR9lwLrMxdRMP0bQZpcGkrWFEBkN/DsIwFTdetl9J
	5ywIoziMAhMtlLOdqnRIsycAJjI0lWzquUi05v10C3RBLNejhcWGUSNoON5HTIH3l7UTN/SyryK
	1Ko2vjwUwZYF/F6IK3uZDU64LuBA4sWQjTMaHqxfLh3U+yu+yq/nZntGP+6NeoPV+bYWWCuuab0
	HXieXSQa//KraFHyK+rW4BZc8pCJeoWatKiFlKovwVvcWlnomazvYPXOhxN0Q1sP++QUMqQZ1L7
	97pxg0UaqV8N96/gBoQsF4GFCbdYVSZIhn2J6KC8UupyN63sEMC30WOxzSaukwkx
X-Received: by 2002:a17:90b:180d:b0:3a4:8c41:fab6 with SMTP id 98e67ed59e1d1-3ae8983f058mr13975312a91.46.1793815589132;
        Wed, 04 Nov 2026 10:06:29 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4694a0e0sm1481545a12.20.2026.11.04.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:06:27 -0800 (PST)
Date: Wed, 4 Nov 2026 18:06:23 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <aut0H65XKAHUqPR9@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <autxCZPJ9yiE2ucq@google.com>
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
In-Reply-To: <autxCZPJ9yiE2ucq@google.com>

On 2026-11-04 01:00 PM, Pasha Tatashin wrote:
> On 10-13 16:25, David Matlack wrote:
> > v10:
> >  - Save and restore the ACS Egress Control Vector along with the ACS
> >    Control register, sizing the save buffer from the HwInit Egress
> >    Control Vector Size field (Alex) and drop Bjorn's R-b tag
> >  - Make CONFIG_PCI_LIVEUPDATE depend on 64BIT from the first patch
> >    rather than adding the dependency later in the series (Pratyush,
> >    Mike)
> >  - Reword kernel-doc comments to read better in the HTML docs and
> >    spell out "reference count" (Mike)
> >  - Replace the version number at the start of struct pci_ser with
> >    required_flags and optional_flags, and record the size of struct
> >    pci_dev_ser, so that the PCI FLB ABI can be extended (LPC BoF)
> 
> Hi Bjorn,
> 
> I am planning to target this series for the 7.5 merge window through the 
> liveupdate tree, as we previously agreed. However, there are still 6 
> patches that lack an Acked-by from you. I believe you might have 
> reviewed some of them before, but the tags were lost during subsequent 
> refactoring. Could you please take another look at the following to make 
> sure everything is in order for us to merge the series:
> 
> PCI: liveupdate: Set up FLB handler for the PCI core
> PCI: liveupdate: Track incoming preserved PCI devices
> PCI: liveupdate: Document driver binding responsibilities
> PCI: liveupdate: Auto-preserve upstream bridges across Live Update
> PCI: Save and restore the ACS Control register and Egress Control Vector
> PCI: liveupdate: Adopt ACS controls in incoming preserved devices

Thanks Pasha. One more for Bjorn's list:

  [06/13] PCI: liveupdate: Preserve bus numbers during Live Update
          https://lore.kernel.org/linux-pci/20261013162529.1928093-7-dmatlack@google.com/

Bjorn's Reviewed-by on it was dropped in v9 when it changed materially
(albeit based on his feedback).

Alex, could you also take a look at the two ACS patches? 08 includes the
Egress Control Vector save/restore you asked for in v9.

  [08/13] PCI: Save and restore the ACS Control register and Egress Control Vector
          https://lore.kernel.org/linux-pci/20261013162529.1928093-9-dmatlack@google.com/
  [09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved devices
          https://lore.kernel.org/linux-pci/20261013162529.1928093-10-dmatlack@google.com/
