Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285647;
	b=5Oz8vw6VqQQvVrjccsw4DUu5z7bHhB+2c1rtcCi2HDTRCtD7xS1Uw7O+zv0puN5EBnYZ
	 mWVkBc0qwdO3ZmIM/DHcljN+Z0ZwnCIFAfiWOH1TxsXIt5kKgbCImZIvLcpPUSjlKuzws
	 cOlxG6vPItBbog127xqXLqng+1SDcRCxwDePYEXYtyAEHYcvFSy5yebEI2cMfETai1A0V
	 d/WAo/xc3xG1G9wGrXCxKrFzH4pdNW6Kzna3w2aZb2KWLSoG0GCWpgeqC95h0Aa5yAG2M
	 OFz+7JFpFUWtM5Qmg6gWY1EIBpoRVYgFeLE6OomsyJK9Ew91+HguuH7BHZ2oWLdE0hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IPQyeaEr+5+wGRzASAEvP7T9y7n3r4QpcHhUe0wul5A=;
	b=fbN/BCbGshIM+fY59yvnrsmRYf0BjzAax8R89aXDWmQ5NpG7Bhwj4jhoCFQoSC7+7j/5
	 lJ/d+yeQV18xim5uqvlgt+QuhYhTy54xTScTvX6/pRc1ZhWYANStySjct2y/FHvcCK/D+
	 FnLPmZoIpHryXWOf7zb99ARe5GR2h0ve9lVXvp8BSf9F2AE6lYT/XXpFec2NWF9DMD/p1
	 Q4ozJ5qDGrogradHy55qC1U+xYPcuYMD3UyzdrULJjwN7jbUWGbZF9RbfrO6+wWP9kwdA
	 0NbQNWqMQFKvwZUgWArg9GHj8e+n9yalwM1+gcnlYqwolkJDWiWo1DbcUcdLpXNkLqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkAm4joL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D75606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkAm4joL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508091F0089F;
	Tue, 10 Nov 2026 04:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285646;
	bh=IPQyeaEr+5+wGRzASAEvP7T9y7n3r4QpcHhUe0wul5A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HkAm4joL11GEpPPdQ+lwGgHKrqbL1ku37vRvsjMC9W9ovuZGlqnT4V2SZEo0wTUll
	 yi+BAR+l7XF5Fm4KUMxTTMRNluRqmOgtD/FsbatgjEYnrXw39zeaGxcvS7FVb+dsu8
	 oalFpK6GT3LlUsWj9po8X4fu9Cee2j4vtCz0/RRRoe0nFqrGpSxSKu5lTEWb3kLFVi
	 8McnIIoVtWqO0+yyV4oYagdqRrcIpShQMAdhNIcX36cjzpKKXryi10abDWH9EnfMYa
	 GLajKew7XQB9G44mTtQgaRA3xfLuoeeNuilaPF/aN0OX63PquicwV5HGhaaWrhOVNl
	 k8Q3/bqu3bjTA==
Message-ID: <sashiko-outbox-206224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/25] PCI/CMA: Validate Subject Alternative Name in
 certificates
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-14-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-14-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:40:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Lukas Wunner <lukas@wunner.de>
>=20
> PCIe r6.1 sec 6.31.3 stipulates requirements for Leaf Certificates
> presented by devices, in particular the presence of a Subject Alternative
> Name which encodes the Vendor ID, Device ID, Device Serial Number, etc.
>=20
> This prevents a mismatch between the device identity in Config Space and
> the certificate.  A device cannot misappropriate a certificate from a
> different device without also spoofing Config Space.  As a corollary,
> it cannot dupe an arbitrary driver into binding to it.  Only drivers
> which bind to the device identity in the Subject Alternative Name work
> (PCIe r6.1 sec 6.31 "Implementation Note: Overview of Threat Model").
>=20
> The Subject Alternative Name is signed, hence constitutes a signed copy
> of a Config Space portion.  It's the same concept as web certificates
> [ ... ]
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # except ASN.1
> [ Changed by AF:
>  - Fixup a few issues caught by Sashiko
> ]
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D13

