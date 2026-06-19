Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D6A2F8E98
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859849; cv=none; b=CVyVmaaqMHMC2QApPA7gl3FOg0NhnNRu75pXYmwXYZ38f82+paf9gmoJQETzqtdDRV8xa/jY3l/kg8UpOx6+XRL/l5aL60CTqXoSU3Ne5IQ/LybmSnDbwEGjRsD6y8LhYqhpDPXXOISVxQoTtIRBeq5Z3YvtdVVkBc16U635VfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859849; c=relaxed/simple;
	bh=xOMQnWRV4ESCCxeYpblEb6lKw6rx3ZjF9e3NeqXfuKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q9ENiji2fMWZtPKy2i2jWdaH5knckpHVqePksQdZpI1ZfnJmr0r/NS+XiirMSLNveZfAC8P2bv82jMasUVydEhq8DGzjLTWis74ldhMNXvNiFg8Orxmy0ETkO7OApeYluxvfUoSdMxTYczjj9Q4lVgbtX15G2+tcIntmSjARE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhulajw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhulajw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B461F000E9;
	Fri, 19 Jun 2026 09:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859847;
	bh=zgDyKBndIxOFYN5ji5jD9XeSFLeyGFfD/BSvuwqCMW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fhulajw8eKc/Lt13E/5Tl8tZ+QVJ37usuiyGcpzd4wwpCPid2QKCpfSTtUEHwNUef
	 9bt2MtwrGK8K/CRU2+gNq/B0gxlTSxYhLjrN6E0zl6xkw6ISptT/Nwufg2MAyZnGwl
	 uiVsacxKJI0o704Ew4ID2mlx9jbEupAdY4tdBaqCbRti0aQ0B2kciMj5Ot03ABi/tC
	 VhCwEHxyYDfH2F1p2+jZin5CDx10inY78yvxGeL9SkLiPKbyOj0ZbNutLVMi+qkD7s
	 TjqvdVDZGax2x6nCt6WDSvj7nCOGoigrY5kT6cr93ME9QyPswHVHvomYZUfgG2cktl
	 /dx2zDBn78UeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 16/25] alpha/PCI: Add static PCI resource attribute
 macros
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-17-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-17-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:04:07 +0000
Message-Id: <20260619090407.A4B461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add macros for declaring static binary attributes for Alpha's PCI
> resource files:
>=20
>   - pci_dev_resource_attr(),        for dense/BWX systems (mmap dense)
>   - pci_dev_resource_sparse_attr(), for sparse systems (mmap sparse)
>   - pci_dev_resource_dense_attr(),  for dense companion files (mmap dense)
>=20
> Each macro creates a const bin_attribute with the BAR index stored in
> the .private property and the appropriate .mmap callback.
>=20
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D16

