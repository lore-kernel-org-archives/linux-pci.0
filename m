Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284837;
	b=lE4VGMnGSYGAeI2NFXGFje1/q9tgukcHiw2m5GapAw4G5bgT1NwVfK5CSclDSb3oLdqn
	 5SSJMEwiDYxY4Zil7wUQu8rOy8107p3I21Nn1rJdHx1TKggqPutwp6qNM+HBkIOAMNfae
	 HM2gN2pPSgSRsgHHYooVz1Bu0/w92TzCr7OUT4M9Ci1h9h/78Ir97wNl12tDFc8lo5L1D
	 TkVmO/PekBqwgzJKNupeVuTTaFiieU/4tB2FwRpgv0rTMOK9pVI5LbYJWOvNKGMjabaoz
	 yOy1gUb3HHVVh0E3h6J56u5R/dQSsX5OfmwfHny4uTOWJTLvn8v+wdtfvwHCtHCkD0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284837;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X1eyjuTt8K8+EyyTSAouwjB3nhqfTJ6BkBCBK9lXwRs=;
	b=lVaAM6v4pagBqSC3hTMDduBQmh4TuRSxLggSqP44vMhMnnlcy7887OMEBbEf3iXeFPdh
	 mPiPYb3wwiNpr2HwzJyGnP1j/5nKUBlpsDk/4jc/59P6t/L104eHYp5z2wxbjfH/+ian9
	 bCU6cZx9EWFJ5NJ4nEKto0dZkvFSIXw6aH4vgBld5KXMwSF3DADzJhcoJIGvab3fNxcek
	 31HF3qOHlo2lGrOz0o6iDlWFSGnlEbPnxbDG1uNA5NrNkVq21SmPNdjxsylkF3jIWkjZv
	 uN9ru66cLjlb26S+UcNMoElIZkVvMSSi+MgfmnoxZmbV+wrPyQv9uvEJWdmDV/u9nrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfEOEahY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B9606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfEOEahY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638F21F0089F;
	Tue, 10 Nov 2026 04:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284836;
	bh=X1eyjuTt8K8+EyyTSAouwjB3nhqfTJ6BkBCBK9lXwRs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EfEOEahYOceunIcSPGp52uDGX9XXZUC1DyBAT5lxkb4nXkA6w1GaZx83vGsiUlODv
	 /+hAo33j49kom5dqQS0DQpETtGnLuM+RWE65m5MgNMuedNp5j8SwkZ2KuPoyVy8iLn
	 2D4OYeUh2CTq4aXRa3iOhhTg9E3xyVnZgAhKKNhnA/PYJq2+uBNnWNS/Ni5Uwhv9Rx
	 7V7VUTK/KFIBZXaM51Jc88YSMQfbL3hwfuhSu/XxqvADpVhGZUihKoUN2FUm9DNdau
	 cDagq+SDJEUoPobZ93d2o4tjdX9XPshBxkMoukINioLYZRrJ254yrVU98grscsNhWl
	 OrnB6wXwXN7dA==
Message-ID: <sashiko-outbox-206200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/25] X.509: Move certificate length retrieval into
 new helper
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-7-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:27:16 +0000
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
> The upcoming in-kernel SPDM library (Security Protocol and Data Model,
> https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
> ASN.1 DER-encoded X.509 certificates.
>=20
> Such code already exists in x509_load_certificate_list(), so move it
> into a new helper for reuse by SPDM.
>=20
> Export the helper so that SPDM can be tristate.  (Some upcoming users of
> the SPDM library may be modular, such as SCSI and ATA.)
>=20
> No functional change intended.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D6

