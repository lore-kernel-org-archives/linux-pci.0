Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC850B428
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909205; cv=none; b=t3KZ1vv9t18nWS42rKjZapOA/iKgYzxwx0QyRS1vYec3S2cJb7+YscTfWbb9smhMrDpLxWvwXHEGdndsAG0lcxioKK1YqPo44rfQPPBQP2nmEwkIpMOHt/HNnYDHWD9rG+3Lch6m+KxQKxJP3q5OytsxiKRj2vqQD5xDOxJYxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909205; c=relaxed/simple;
	bh=DLg8pAZHaVLx9QchK6Hc6I4tM0Vn2PqEvol3XlvJp/8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hhZh9Iti6B0u+LKuRw4RwkHq4HESp5gH+SfFEOhdRV53ac+5mk3o8C6dM1AGTq0D+v2fSa/TfMVglHcT1sf9CPu1zeWC+WESXyAEZloMtG/aEMICWDXib7SaCBalJKKlWhdrqjkGMFuS7iH8CaB86bLDgZ4j+jFYjozo5b8lyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsmUbLBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsmUbLBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3151F000FF;
	Tue, 13 Oct 2026 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909203;
	bh=ZnMQkGjZvfV0sw/bVJGwXFGK/r+xjFxmRuUXfW6+tAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YsmUbLBsRPAZZ1bjbnWYjJun435h9Gyfu+jjvHrzQb+oPAFTFjh8xyY09somAuhEp
	 IMn+2noPgS89RKNuAOCvc6D6yfTt8qHT7hzs4qAc9Rx5qn3GqhbPfIf0HBeOfN+m4y
	 dc0Dn3pktk0QZrcCPfzKh6yoA8Ur1wrohvZSHRp/I3FY2gmypv2iHdCzZ/7ysziymD
	 cBzKq8HRuJLQDSsVJz0M0fk/zNX7LOE43Kqc4VzLV7vZfgs27kvrb3g2WeDXYU97aE
	 /ejwDhwytVItw06JuSsJmh6jWq1Il8h7My3qbA/R/yfJo6ZDkNBd20ml5uv01bTso2
	 umow7x/9XFsmA==
Message-ID: <sashiko-outbox-170118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/13] PCI: liveupdate: Set up FLB handler for the
 PCI core
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261013162529.1928093-2-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:33:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Set up a File-Lifecycle-Bound (FLB) handler so that the PCI core can
> preserve its own state across a Live Update kexec.
>=20
> Preserving a PCI device across kexec requires preserving two independent
> sets of state:
>=20
>  - Driver state, e.g. everything vfio-pci needs so that userspace can
>    keep using the device in the new kernel. The driver preserves this
>    itself and the PCI core is not involved.
>=20
>  - PCI core state, e.g. which devices are preserved, so that the new
>    kernel knows not to disturb them while they are still running and
>    doing DMA. That is what this commit adds, serialized into struct
>    pci_ser.
>=20
> [ ... ]
> key when looking up incoming preserved devices.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D1

