Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761141;
	b=mMHexHuq6Afh8Kd2R8cmx5lpJ6DTOhZBgY9iSTrqd0S5nCW78+9lG1NwHvwB9B5DRduT
	 y1zpkiPkzWZ3KDGAdSeqtoYlu0AsDNK7y1czNMI9m9+F1BJoJH6VhbNpkotFBGC02Tcfo
	 9/2ZDiA7xe4li1Edly4V+96OaUKJHx4CH3KU5ZszZt9ILSASCd5E/+lhXApSHNYviOxuh
	 22GCufNP5vYSKkSuiKIk0+ByQhqfdv/BLCfiI3sweuxfcyqbG3r00+fhY37mUOhg8JE86
	 iuW67tKcuVuWirwnrwotqLhmKa/HmYqCNsgsxhdu4gEHAud2PID3gpwXa0xdLo62i6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761141;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R7aM1rIngKataKOwN8SMel82tTsO3hce/70Ax37W9p0=;
	b=0236JCvV1/xlUQIiRIn77TlR93KwCoBkEcLVVrp2vTbOzFHGSClxR24oEUz6IaithcaM
	 2YELWMeTmkVjEZOvJFw2weu51OiKXlwP3kB2zpDHXsrKXE+Dt5qx/atwkq/7rlQNMpX6i
	 K9L0hwve0Wi/zEe006a7xCKdHsv7eIUY+yWP0cBPx2xlzniefNyqSQG57rJbCd3zY1Eat
	 BNKn2NO40xh/zcvod6kmbWU0daBdIDf6c30RxqRxqTRW9/FerOnX9zhfugf18+4IfFfKa
	 QmSpzmh1dI4ZdoC/WYF9YSoehfMgo0d+PmL8zm8jNr9TWgklCEjUlJvqa9IOUX1PB8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnjlIssM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE2606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnjlIssM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4F71F000C1;
	Wed,  4 Nov 2026 02:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761140;
	bh=R7aM1rIngKataKOwN8SMel82tTsO3hce/70Ax37W9p0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VnjlIssMIt7JUTm4azoyEzgjvXF/QZZSc+k8SwNee4Q7W6D0axQFYEjATTW5sgJ67
	 ny2oWTNhSJwHfvGR/UL8i4MGq1apvwD66MLAFhMZ37mdnQRkk6QCOkgO6ZPTHNODXi
	 bvnbGvIyKtCqedcHICecZlkasLdi1iDs92H1U8z/jDyioU60YzgL8yffmen//T7346
	 YyGTWQxSdabAXdMFGwj/LDzdW7A8WogzyubwUqTnEH8Xp80J2lm+1Nzl53llKm3FVW
	 wqsMgedSFcZxr7GlDJLBX5PqMuq0UpnnU2Iethp3hjgVJ7OMGjTV/nb5TnF0Yd/Pi1
	 UrEhe3OvrrJGQ==
Message-ID: <sashiko-outbox-196554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/25] dmaengine: sdxi: Per-context access key (AKey)
 table entry allocator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-15-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-15-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:59:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Each SDXI context has a table of access keys (AKeys). SDXI descriptors
> submitted to a context may refer to an AKey associated with that
> context by its index in the table. AKeys describe properties of the
> access that the descriptor is to perform, such as PASID or a target
> SDXI function, or an interrupt to trigger.
>=20
> Use a per-context IDA to keep track of used entries in the table.
> Provide sdxi_alloc_akey(), which claims an AKey table entry for the
> caller to program directly; sdxi_akey_index(), which returns the
> entry's index for programming into descriptors the caller intends to
> submit; and sdxi_free_akey(), which clears the entry and makes it
> available again.
>=20
> The DMAengine provider uses one AKey for copy-buffer access and completion
> interrupts.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D15

