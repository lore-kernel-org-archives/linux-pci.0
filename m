Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377818;
	b=snmOb5GlmrJukwkHjouMrzW23tsUvDpAVu8YO5HiKYD2UnLq0tsiJZVAbawSPAGKokaR
	 pTkCsrhSWomwk2N2psPIgMGRxAz40z4oh96fBiJJskwMkPgroIN6TkvB4UCeD7ZkVy10c
	 ZqbHuxKvUWDMQZkchWg/qvwXsM1S8UGazH859AN+jYBWzXnM5fzEr6IHDWrBab6zCH/wd
	 s609wHkDOtzykYMVhJci8X/zqZ+UFXpeT/PMl4Qd2WN9Impjc3qG26MM8mxQk/7Hl++4E
	 PsKJ5QVZKM/c8Z7bepAZjCnpLD3Ro3a8adoh6P9ork1gz2YCdHXjKS9aQxuxzUkuevw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377818;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+dRu/ieWpcjsSh7FVYBbeFZj4sROfKx0KyOovHmm1RY=;
	b=4coJ9yVk+K3zM1BByVMV9jn/b2djRs2mGHZJm/IcDZZHM8754GBGUxVo5BYQbj+fFxTB
	 +EbEu7YXqC/sRuISzWNPI5KoU9e3SYyQdG/C6HGnUhA3m6MKj9cJRvBhUUknu3uacVy+N
	 xMmHYEei/8+3nDa7aVerVXPVc4sDHMaKqrkinQsl+v5NdlkNaYyU6fjrVDd6XxDeZeU/F
	 SO6R/X2KaF+k344jSo3ogElJyfB54TA+MEU9cciKJOLGuC9dX+RmMMOIzxlVF7X7s7kYe
	 28OvRzA1wdGwRryGpWE+KcWkfGBoYWzL2TXYQ8pUqZaUgGQSVeGx8pS1ZMfnxJUhPFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwqIIlxM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9B606A330
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwqIIlxM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C58B1F00A08;
	Wed, 11 Nov 2026 06:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377817;
	bh=+dRu/ieWpcjsSh7FVYBbeFZj4sROfKx0KyOovHmm1RY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lwqIIlxMXrhYYv9u6rn6/R+m3BQWilpswuTnNNzR7yp3/ItMy1nrzysFsVVxY2uaR
	 pF/iZKJvXjVwtdWWHhd+HL4g9wRnXHBxIc7ngZZjy5tFvlE5lbnjYcuzgiEmr1vcjW
	 BC4iN5Grj6nuG9Cn/enM1yoxbz+v8vEnhZmf6XuWN63tgRG/4i5kvRev9cp3GIN4jp
	 lQuxV8OCqzaAw8jzGfcu+IaFEXDd6SpvZYqvdkv+DpmT8XOIpzJJ1ibGX3T+jYndGg
	 LoNeYtSZiPSwXfZti8k86fBtODSfaWUd4e51aH1CiWZFClJAelnbqxBZ3ScFu2N/Nj
	 wbYWMC0757c+w==
Message-ID: <sashiko-outbox-208420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/19] mm: memfd_luo: Add feature header to struct
 memfd_luo_ser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-18-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-18-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Precede struct memfd_luo_ser with struct kho_ser_hdr using
> DECLARE_KHO_SER. Later memfd features can be appended under new
> feature indices without breaking compatibility between adjacent kernels.
>=20
> Allocate both the memfd_luo_ser feature header and the kho_vmalloc
> feature header in the same preserved folio. On restore and retrieve,
> validate incoming required features before accessing payload fields.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D17

