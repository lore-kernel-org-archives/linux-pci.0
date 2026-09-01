Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698CE34D382;
	Tue,  1 Sep 2026 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225002; cv=none; b=JwvkgAhbT9tIA8pkh67PXTbpBXItrc++8YIu2oPMmVWMzes9B53Vc1zLEEjaHO8mfbRsxBuTpkqGqVGS6Dlv0H95lMu08Fv/V4bdBLrS9JnUkwbVrV2Chk+No7z/j9tozj916JkR3pmc+eYu/mqH368lRAr4A+lnjVamXLm21z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225002; c=relaxed/simple;
	bh=6xJGVT2xg30yIEb2vWMWuJ+lQJANQzE5b2Uvx3qLnaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kG2tO+R0K+am8VvSyZhRbfxZ5u4vwPwtiCllEaYxKGALilyZ0jucg8DGlhsMdpjwmRrEDSZLQoZn+SmyC43qoY9etsNcficAGX7T30VkDlZk9wqSiTxYO7i//VXeWRBzFeLUdy9RlGEv3GWP+2AMEQkW+mnXrw8rY/WYYcXgXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9FgXQOv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9FgXQOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D60F1F000E9;
	Tue,  1 Sep 2026 01:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225000;
	bh=na75dzsDa33wmQ/EexnDWo83eFWbKfNYQ2qAIXEy3gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9FgXQOvEsFht/ZNKx4x7pgtiMUFsoyhAtWsr+mlkRynTynwX4bKkQJzwblWoSkL/
	 Zcn6Vh2GrxRL2Ml7/jKliJpUit7VR3z7TJ7yLJIIPwfvXY8x3JOtu7JbQ2J4A5tuw6
	 id0P/M/AxbrIe/UqplLWcHIkT3gBRnZfowmmHvxwO3cBO5f4ENI7//M6ygcgsQi//b
	 cyk25slbUIqdIuWvjR3dOuNXFD1K8WcU8Z0clvond4ouwBJ3ncKp7HVLZiIb1k/2gc
	 GVaujx/16DTJW6HWh868KRca3mN8xYKgz4CeiXZXF+po5Nf5oWvLafyt05NLdwmPz5
	 Jrb+o2KsNTY4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/21] X.509: Move certificate length retrieval into
 new helper
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260901010347.2614656-7-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:10:00 +0000
Message-Id: <20260901011000.9D60F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lukas Wunner <lukas@wunner.de>
>=20
> The upcoming in-kernel SPDM library (Security Protocol and Data Model,
> https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
> ASN.1 DER-encoded X.509 certificates.
>=20
> Such code already exists in x509_load_certificate_list(), so move it
> into a new helper for reuse by SPDM.
>=20
> Export the helper so that SPDM can be tristate.  (Some upcoming users of
> the SPDM libray may be modular, such as SCSI and ATA.)
>=20
> No functional change intended.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D6

