Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A31B6D08;
	Tue,  1 Sep 2026 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225140; cv=none; b=mB9ibgbY7rmNdI8TDgj+dXfocOqOSWRnbG08S/f2IjHi6GD6f/rqu0/uELMXqp9+JO/p0hhQf3JjUJ+JZoYanF8w/sZs4vD4cAjTneWEuNJ69YnnvmHINlhTp2bQESlVFOylN+xHgvACbBa2ht97qiaurOh+YJT4cUnH4L3xOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225140; c=relaxed/simple;
	bh=MznvPOe5105tLp3TuFKwn0eOMlPGxLAXtLXjT9UhKAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n5CNPe/D6toNsOw3dF5+tRcuqNlhqsDImdIkVearYFO+ppYSmIIkQcvgwQJySwQQretPoCEZ8KVqv/4VnXe9lktv3DkLtj0yqhSMw3MGMNeWjEjDFEuuSo7JAbtQd9lzePFgQHErKjW6F8olXXI1a+qGM2sCbxTba0NQvxf/E9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF9AQS+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF9AQS+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBBD1F000E9;
	Tue,  1 Sep 2026 01:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225139;
	bh=MznvPOe5105tLp3TuFKwn0eOMlPGxLAXtLXjT9UhKAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fF9AQS+w9ghgaiQnux45qeMDHg7+OwMW8+r33tPvC1R/hE0g59E0FWhJilol4xl8D
	 fC7dGQ3hTFS24dC1dpt820XtGiYlQZJow6GTDUSzsesVfcUc95pFCnKyw7l3xIOMEq
	 Hhma5tHYqvIBDxWaupTkW9niJNiqnyVU/euHRNCgAlew74oCFXnfUOO7D6BKw6mPKW
	 TGe9HyuzPAngW+1RE2jE+5bPMa8MgSkpUHDP4BxQYL1FAET3jktwmewOOo2xjOXbMu
	 4it7mTkEiChYyueE7EB+s2sq0w2sqPJBHcbHt7RmwBe4GNFw3LHse0ooDyBchZgW1I
	 Dv6F9kSfDtWAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/21] X.509: Make certificate parser public
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901010347.2614656-5-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:12:18 +0000
Message-Id: <20260901011219.2CBBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lukas Wunner <lukas@wunner.de>
>=20
> The upcoming support for PCI device authentication with CMA-SPDM
> (PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
> in X.509 certificates.
>=20
> High-level functions for X.509 parsing such as key_create_or_update()
> throw away the internal, low-level struct x509_certificate after
> extracting the struct public_key and public_key_signature from it.
> The Subject Alternative Name is thus inaccessible when using those
> functions.
>=20
> Afford CMA-SPDM access to the Subject Alternative Name by making struct
> x509_certificate public, together with the functions for parsing an
> X.509 certificate into such a struct and freeing such a struct.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D4

