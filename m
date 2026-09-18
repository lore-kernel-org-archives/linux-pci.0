Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007F51DB01;
	Fri, 18 Sep 2026 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762468; cv=none; b=tH2R5Q0U1xmvNkwZei1MoTETWyN11EM22ZCr0YJDJSB+PLe9U4SYvdb5d8tYSgcDmUnDURnDYbi3nuKg4R25yMOHUaNBaA6gEW9WFkZvgbBE2wO6PAOjtQTmE0tyPJKuufQW1yZwl1QAQuBtWqcZjTJi+rX8DvbAIk1AeJqvbec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762468; c=relaxed/simple;
	bh=fUX1CMYSfd1cCzY+rZLKpCj1B/a7Nm8BOcFnIwzacKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n5R9iWCtTUse5SvyVPYivJK4Cggszv6VixFGN45xOERZTFKEiIB2/KyJb5uXYWKw2E/IRox48RbpZnY7ORpBHtVcukHyZDpMKv1vo6dNZNSZ5XVAOTtEWMwxMsxaQ5ktc1mneRLVdvVFRi/R2cHSO/PNLCbpTUAywjgIYerG73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1K9Juxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1K9Juxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EBD1F00898;
	Fri, 18 Sep 2026 20:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762465;
	bh=fUX1CMYSfd1cCzY+rZLKpCj1B/a7Nm8BOcFnIwzacKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c1K9JuxoIpd0ybPcfa6kWD3z1AEnt7uah5WM781MT65U7w3mGH1TkBNhFdNZ9WXOh
	 u/uCw2YcDD7rWhPfRaPzF1f+7/RHUmkx8mpTbHwUEjxXqM81pAvR8O2S2gOvqywOQO
	 FWvY2hCiZcx1j0t1FQU4VF9shWKsBGbF/DNyGxLVjy6e9E6Wmo69vBFEijiO1lE8J6
	 V2oxC45PLi9hOwYS1uVguivaABUjbrNvSZ84D3HlEADtZgW8CA8HbniVzsALfWIYBE
	 wzbiLZAU4WpZa6wwdHt+L3f4lsoucD79w3I5cmeKiF/xx+9pU6VLVlBAPJL/gIn0Zv
	 SLB4jTZYVNvyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/13] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, "David
 Matlack" <dmatlack@google.com>
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, kexec@lists.infradead.org, "Alex
 Williamson" <alex@shazbot.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Yi
 Liu" <yi.l.liu@intel.com>, "Jason Gunthorpe" <jgg@nvidia.com>, "Alexander
 Graf" <graf@amazon.com>, "David Rientjes" <rientjes@google.com>, "Chris Li" <chrisl@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, "William Tu" <witu@nvidia.com>, "Vipin
 Sharma" <vipinsh@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Mike Rapoport" <rppt@kernel.org>, "Parav
 Pandit" <parav@nvidia.com>, linux-pci@vger.kernel.org, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Leon Romanovsky" <leonro@nvidia.com>
In-Reply-To: <20260918200640.887030-6-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:14:24 +0000
Message-Id: <20260918201424.82EBD1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
>=20
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
>=20
> To preserve bridges, the PCI core tracks the number of downstream
> devices preserved under each bridge using a reference count in struct
> pci_dev_ser. This allows a bridge to remain preserved until all its
> downstream preserved devices are unpreserved or finish their
> participation in the Live Update.
>=20
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D5

