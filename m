Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C0344D9D
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859807; cv=none; b=Z4mb+8MAhhuf38k8eDBEDdHy2CymUKNexLwUaO324o8xybRH1p0o1KYyGLJN2P1oFGThiJrKH44BfqM+FKatAHse7+LLlEHCpFh4AmiYlA3yeim9PJIRN7CoCT6q20C/m+kRny0jFniXrvMjpTWPvOMSMHzRzuYErBh1Z7G8rcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859807; c=relaxed/simple;
	bh=pj0UACJ3937iepnn6QfY7Ce/6kv+aKf0RR/XMMjVww8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EKvpjLum87RmakAsMj9k7GsxhKY71zguu2s87dd0nwKvEsXPH4u6n5n1X2n5eCNDrryzWWJeL2s9bpJWU0QvcQydArXaJsR6g0SbyL5C1kmVTrnfwqDHhPwz8ELgQB8XF40crjAzjL/1KpLP+n48U9/Fq41l6HCirsdDkUv7PoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDkMkvre; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDkMkvre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7691F000E9;
	Fri, 19 Jun 2026 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859805;
	bh=1SL2uTpVLWgz6lgddQQVTmQppaRy7wjR6VlP2Kqm7mA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SDkMkvreA4xTetkwlDBhHBH7fC4h9o2Am+iYryLkdWg3hsRz3XzvTHX7SiPhXZpS/
	 tn8LzesJ59hNhVHZftIu1XZeamXbgdeykT84njgDHoy5eQeWtvYGFE/x9LhKRRM22s
	 KPJV/b8byK6EgotspBcUkTVqEKp7XY8BDuwHIoAiZBrqVFAS7sfpGiMknmx7Q0hnQr
	 iA2uNj7eEQFANUYGSeGK0QNw40XC8dCb71Jnkbjn//YwFySPSbsW9ofYHVUe9LhsPl
	 Pnd8mC0thXOYkW7FEjtJu8iO5tapT6CacVd9qvZOj5k+eCQ6xmihE6+O1J9hw+eMrI
	 E7Ld9r34yTBLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/25] PCI/sysfs: Split pci_llseek_resource() for
 device and legacy attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-5-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-5-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:03:25 +0000
Message-Id: <20260619090325.BF7691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Both legacy and resource attributes set .f_mapping =3D iomem_get_mapping,
> so the default generic_file_llseek() would consult iomem_inode for the
> file size, which knows nothing about the attribute.  That is why custom
> llseek callbacks exist.
>=20
> Currently, the legacy and resource attributes have .size set at creation
> time, as such, using the attr->size is sufficient.  However, the upcoming
> static resource attributes will have .size =3D=3D 0 set, since they are c=
onst,
> and the .bin_size callback will be used to provide the real size to kernfs
> instead.
>=20
> The legacy attributes operate on a struct pci_bus, not struct pci_dev,
> so calling to_pci_dev() on them would be invalid.
>=20
> Thus, split pci_llseek_resource() into two functions:
>=20
>   - pci_llseek_resource(), which derives the file size from the BAR
>     using pci_resource_len().
>=20
>   - pci_llseek_resource_legacy(), which uses attr->size directly.
>=20
> Update the dynamic legacy attribute creation to use the new
> pci_llseek_resource_legacy() callback.
>=20
> The original pci_llseek_resource() was added in commit 24de09c16f97
> ("PCI: Implement custom llseek for sysfs resource entries").
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D4

