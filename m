Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003619;
	b=ZWajfcAw0baPGdwpIZGHlNsRxFolW50FeKeNNlb12Ya6AU4QJ1ndD5tRWtryaXb6Yhdu
	 /Hrb4U7hUIH3eQi7Wm5gUmOEYnooA7d9SvpfPr0kon8SZsb/6ifQF4VUfwtCCX9CgOj5Y
	 t8YbDLS4M6XR1Q0iLZsHSvYWK7GbVfp2PO9Q1wM3zWR5JwXQgaMtILCBCjcfFt1880YO2
	 W0a/F6L71wU1/d8oaJRfdE7TRA3NZ7oOFm7L7jJWIBwgsv+/84W5dmBN9nKvA4qDo5d82
	 GfBudqRqayeiLqesg84WxrtFb/5qefMG6EIGzs+GcvcK+gnYWGhvk9+vAmjEUMpVajA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=YdrvcTfiK/07Nw/kCOuL7er8KrOXBZTHNtdfHcqY3yc=;
	b=Qe8k2nbZGy4kSNh9tg6WViDap6TKnLtajA3nyIwkV4hoTD7c12hJazSmuYJTNGWUAyST
	 iOhKUAzk9rknG9Md/hjOdR0fA+cEXOBc7ZSlt68/QrtOkwLkHI6HxYwfhWn534T44TbFG
	 Vfkm+jXAgDJy8gqhv5WEd/QrXhWyKUu4vSmOohdP8nqQMSj9pLEe0Xa2p0n5VWUpGp+kW
	 qwKILqvc2CiBQaMWLWE7MznhDuafARj2cMnN5mZqJfcYa1p1yX3AvPvS1WER1b7n3dpGM
	 Gq1vXJO3fc8LEAfO/xSrDMm+zo8TwojyKWaOdxngPQApIfaJU6B/ZpMk6oYkWw3x9eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LXEDKNDB;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B034606A32C
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 22:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B034606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LXEDKNDB
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso552610a91.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794003613; x=1794608413; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YdrvcTfiK/07Nw/kCOuL7er8KrOXBZTHNtdfHcqY3yc=;
        b=LXEDKNDBLRIJbYbtObAwr4pGaCKvFWMV99QdmyNI1LdRkb0kyu8RPs5U/rQq4a6M0h
         5ASlz3BmDk3LbCaPAyYM+ml0fpr0LBMu3Q0UZRphZODpbT5qLOGmsnp2iuyMGrmWopeo
         0rfHxzgGItR2A3RsjfMqH1RMIqnPHk/DKQcOT7SxsJPifbZx3trsUOLshBP/kzfGPp40
         jwfo6kRiQl0dxVV33yemWrOK969JVlnLk1sX53xxNvUOyU2suRXcmx/I4zRoch0SsKrQ
         gy23ukO+EfJuK2oVUR2elXb03hZSdEx1PEMUCYg04OuYdXw6vsu9TD7Y/3wa6Yuenl32
         VwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794003613; x=1794608413;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdrvcTfiK/07Nw/kCOuL7er8KrOXBZTHNtdfHcqY3yc=;
        b=sr79iUUcr3aw7XiqgL1sNADh3uPMMfEihR8HM08Sr65u0mstbtGtT7WihnEch2rGMJ
         BB4tTOIHGG3TD5PiLsL5owWANE5xbI3F89eSOr2/+RCQo5zL+Htgonj+04GFbNHc2a9k
         +MM3xjFDUayGfrT/kBKyi+ubX9eVNbNrAeiWYAvhNKBSk7URf1Dkkn5tMj9OseLes9gI
         BucCuv0SWrmrqCDwkoYJiY6FarNXPCM/G8KOvtU1pOpXmJ3NKJBSkg20NTOytiwzpscg
         4hnH8G+MVbWuByNpl6wkj20tDNpieO+1and0IibT71LQVryUNowJZIYbgCQP1QttZGap
         Dc7Q==
X-Forwarded-Encrypted: i=1; AL+hErEi6LR3LuUGKQ54Oom3U78Dy+k9Kj2+T0kj8Ze6RASo0gMcl17+H1WABly7PzfgElR4eEQXhGMUYzk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9P/EMPAeZH61LIuttS5efE0HSyZVDWxz5P3UzY1G/PCObwEele
	bLNjrE7m2dxYXTSabsQ/aX3f0W8etbTYqJKuXRo27CWYhxRVx7iNA7yIsXue3cIpUw==
X-Gm-Gg: AYBFou1uMfDfO1U/HESj48bcihmCgJQbhJhpsZ8hU+gWP3OAViUCVHiw0y1LV7fcAff
	EHx3QND4ChOGNkU6K5mgU7UtCJ5Ac5f1bQXBMT3hbkpuwLz5LrvTvHSlrcI26MZzLGO+A3sx0EK
	0bumbSb2h80amQkLAWps6djGyxB+Ji2F956kiNK5tOy10JfeUjoJ56XZs7/mO0glZDS53ZP2CcC
	8cnwC+qEAfiW2kX6WHaOVEMItfmTrFwY9+PCRQ8hp85ZImNa99mIkOiiRWsHGYPJWFb33zx2Ngo
	Hkj3MNn/9hLaGYV3gjLfOayw+dSjwaJ8wIqWZuQe/WXTZ20tTgBCHUDS0c68kF8vEaOjZMR5v7X
	0FZMTO9izJXjq7d1fNhoVX26j0VWp8/4x+NKpz2Ucnzzo8/ds5L0Izm5W+WQNgMHj1airJdurqp
	BqislpsgpfoPSZMXM5GtIl3ZjfU+d7VpoP496wcZDxF+zbpVJZw1iTVFVnrROiUB2CwiRAuWnPx
	aI04Tv6I3Tqfk7jbiAzMzGTvvbIFxIXsQu38mtXYmf8r/gWXpJMUSWLAW0ALfCKiEXrrCqx7c+K
	GWIaHhxrmqgmDvB2ZLJI73nMm17lmWSIN+7S0jkY2gxRgbXGo3iTDIMlH163aRP/6MLbSA==
X-Received: by 2002:a17:90b:3ec8:b0:3a4:e735:b39d with SMTP id 98e67ed59e1d1-3b0db726100mr3762406a91.64.1794003612758;
        Fri, 06 Nov 2026 14:20:12 -0800 (PST)
Received: from localhost (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057b1fa8sm528979a91.2.2026.11.06.14.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 14:20:11 -0800 (PST)
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
Date: Fri, 06 Nov 2026 22:20:10 +0000
Message-Id: <DMOH7D1PZUM4.1X82LVQK7E54Q@google.com>
Cc: <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <dmatlack@google.com>, <graf@amazon.com>, <jacob.pan@linux.microsoft.com>,
 <jgg@nvidia.com>, <jgg@ziepe.ca>, <jrhilke@google.com>,
 <julianr@linux.ibm.com>, <kees@kernel.org>, <kevin.tian@intel.com>,
 <leon@kernel.org>, <leonro@nvidia.com>, <lukas@wunner.de>,
 <mattev@meta.com>, <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 00/27] VFIO PCI Live Update (noiommu mode)
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>

On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:

> David Matlack (4):
>   vfio: Enforce preserved devices are retrieved via
>     LIVEUPDATE_SESSION_RETRIEVE_FD
>   docs: liveupdate: Add documentation for VFIO PCI
>   vfio: selftests: Add vfio_pci_liveupdate_uapi_test
>   vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
>
> Vipin Sharma (23):
>   vfio/pci: Factor out the reset logic in VFIO PCI device close path
>   vfio: Export various helpers from VFIO
>   liveupdate: Export symbols needed by modules
>   vfio/pci: Register a file handler with Live Update Orchestrator
>   PCI: liveupdate: Add helpers to preserve struct pci_saved_state
>   vfio: Add helpers to identify device files that can be preserved
>   vfio/pci: Preserve vfio-pci device files across Live Update
>   vfio: Introduce vfio_find_device() helper
>   vfio: Refactor vfio_device_fops_cdev_open()
>   vfio: Add API to open cdev device for Live Update restore
>   vfio/pci: Retrieve preserved device files after Live Update
>   vfio/pci: Protect incoming preserved devices until they finish Live
>     Update
>   vfio/pci: Take over preserved devices without resetting them
>   vfio: selftests: Build liveupdate library in VFIO selftests
>   vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
>   vfio: selftests: Add iommufd noiommu mode
>   vfio: selftests: Add helpers to map DMA memory at IOVA =3D=3D PA in
>     noiommu mode
>   vfio: selftests: Add helpers for Live Update DMA memory and sysfs
>     state
>   vfio: selftests: Add an attach() driver op
>   vfio: selftests: Test preserving noiommu devices in
>     vfio_pci_liveupdate_uapi_test
>   vfio: selftests: Add vfio_pci_liveupdate_kexec_test
>   vfio: selftests: Verify that opening VFIO device fails during Live
>     Update
>   vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

This series is getting quite long. I would consider splitting out the
selftests into its own series and we can iterate on each separately.
