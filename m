Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E5C344D9D
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859706; cv=none; b=ammMPoiWKzo3d96m9HW1mA23j0uYkXNRSUZrpDiWSkr5PO5NmT8vO7++pKSCVqTAMnVZA5AXPeLEtNDlZCnL6CBVfenChPXCFdUjmuSW+5YMs0XtvNIwHD9BzYQPWC31tbg6nqqm+fONLA2tpS/Chlm8kfKuorzB6DDhY0ZRLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859706; c=relaxed/simple;
	bh=kv8Ofm1rx64jQY5S5Sdozu/PU1jY/UB6/rTTX9w6DTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U6SgXLB8v64Ib/h0E81LgaSEfoW4IXLolVCP1Sh0hiOZWTzXQVFSE2XW6MrmFIMvFyzss/HhSEQFTI6UWWmbrvtCKzSuXIwLnfW7msGr3kICJ299fxIZwYjAdHKzLzHT/Fz0ytKZJZ49GbzEGLtSUZnki3Lt9TUOiQLJwnx9zVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNBU/4iZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNBU/4iZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DB61F00A3A;
	Fri, 19 Jun 2026 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859704;
	bh=vD7UAdHL30Jq6rq5dDyuU3Fs2LtyAZybOpvjKPWkZKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNBU/4iZBkEI2D4VMVfQTT825WMeAnN3o3X60nzdwrT1p6yZ92eX5BcFeanu07008
	 SDZc6Y5PyKJ0a2aawbjIcjv1dtH+VQyrFRMlNUeh0D4DEQnu3q28yeW70PRF1AxpF7
	 ku6jpEB4VyV6cczOaDBqQXS5YFSu42qmuThrTv72dz7fOOJLDlEONmEMzEpEZYq5uB
	 AD7whxCLwcn3Up7UFflaa+O9x4W6gbGaEUnfVZAepxacg4zFdeBtRq7mjY0Gi5YxOC
	 pPJzNObP7BppX2Q1ZGVVDp1qV5KObzBABEp1U5tZ7jtN0Xja2VMX34qUmuToroz4ST
	 75XS3x8EjBk5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/25] PCI/sysfs: Only allow supported resource types
 in I/O and MMIO helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-4-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-4-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:01:44 +0000
Message-Id: <20260619090144.A3DB61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, when the sysfs attributes for PCI resources are added
> dynamically, the resource access callbacks are only set when the
> underlying BAR type matches, using .read and .write for IORESOURCE_IO,
> and .mmap for IORESOURCE_MEM or IORESOURCE_IO with arch_can_pci_mmap_io()
> support.  As such, when the callback is not set, the operation inherently
> fails.
>=20
> After the conversion to static attributes, visibility callbacks will
> control which resource files appear for each BAR, but the callbacks
> themselves will always be set.
>=20
> Thus, add a type check to pci_resource_io() and pci_mmap_resource()
> to return -EIO for an unsupported resource type.
>=20
> Use the new pci_resource_is_io() and pci_resource_is_mem() helpers
> for the type checks, replacing the open-coded bitwise flag tests and
> also drop the local struct resource pointer in pci_mmap_resource().
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D3

