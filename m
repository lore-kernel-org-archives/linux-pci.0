Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA95A79B
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666101; cv=none; b=rQM6ui8+TC/1EQlIL8GWbeG3/k4uwfzq/VBy40lh9iKaMumdmAQiR3NpduT844GatNTGKW1ydT9Aycfv86/Bt6i8FO7+qOc9KVRF7bKTl9zbdlhoBfl+NapnIi5/O40pTsOzRo+8X6clGYAm0BXxpfZDTrYAp3lB0WdDQdc0KWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666101; c=relaxed/simple;
	bh=AqKhpmgs5lBLabnoVkzlUB24jXTuzgU80NjNYCjT2cw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FsdhpHIpix2ngtYfcvec6tVt3gGB4+XwQvtbURZZSXXSdfI8BEETaL4L4dT3zd7XpkuUAEPfzfthg9cERtWIE+wdKbawGEUgbDq8JCR90VN19LJWzXh5qZWRj7YlGX3ekXM5BFoQBr8hEe6zsEcrGnXEFP3XIbzVSlJ2U5bUq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELyB7hXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELyB7hXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A827F1F000E9;
	Fri, 14 Aug 2026 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786666099;
	bh=suIL0YK4qticq3gtAJ56WYW1LgPwSuNnfPf3MYUGZn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ELyB7hXKm/Nh5dAyRBQ3jPCuAbIIJhKTRCoVYyWCxy72Uw7PnzcnKkl5MyriEtS3R
	 hTHJoN2O0KJXoIzpmbA3ucYyILfBF2L1BFeY5gJGjs59kzQWEV29VlvThIPD4lWDsF
	 lvzkwmjKV4KSi5+U1dB4Zn7b2/fZWi6nZgrBmJR/J8AAR0OxSLHg4rZnRv4FwPGDBe
	 Af79uU8pfRYXCxxND9oQkq4XmXXwfLwwwIdpX2rMVg3Z5wBAksEUR5y0LCIXg5kXn4
	 dNmYg25PriLu8KWGmPUobskMdljw7lD1yD+l5XiALoej8+52jKDbe0KSy76ABDFYmA
	 /w/enKNvu6lfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/24] PCI/sysfs: Use BAR length in
 pci_llseek_resource() when attr->size is zero
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260411080148.471335-5-kwilczynski@kernel.org>
References: <20260411080148.471335-5-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 00:08:19 +0000
Message-Id: <20260814000819.A827F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Both legacy and resource attributes set .f_mapping =3D iomem_get_mapping,
> so the default generic_file_llseek() would consult iomem_inode for the
> file size, which knows nothing about the attribute.  That is why this
> custom llseek callback exists.
>=20
> Currently, the legacy and resource attributes have .size set at creation
> time, as such, using the attr->size is sufficient.  However, the upcoming
> static resource attributes will have .size =3D=3D 0 set, since they are c=
onst,
> and the .bin_size callback will be used to provide the real size to kernfs
> instead.
>=20
> Thus, update pci_llseek_resource() to derive the file size from the
> BAR using pci_resource_len() instead of reading the attr->size directly.
>=20
> The custom pci_llseek_resource() helper has been added in commit
> 24de09c16f97 ("PCI: Implement custom llseek for sysfs resource
> entries").
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411080148.4713=
35-1-kwilczynski@kernel.org?part=3D4

