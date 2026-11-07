Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058416;
	b=ZOl8+Ny1DOBb6tUH5/Bin/jMgBaSLSruKf6UWohFmRbSrbDtNt9YILDMyoCL2Np5dObk
	 k3GmSk2W2yyKmfhnAKp7USSFbU4NV5eJ/Xd7/JHKQMticDruoI4fZtUhU5BGvalbK5i0h
	 o4EKPGZtlDHDzmg2HrPYEEKb+r/If9pvW7SuP9UFIwEeGbb9zzPaPS/t+SczcWPQeCxIx
	 9qaUPrgS2XcKHv457JV1u+JluT8A6N3JntNJhfaUXsDyUc4+9/t4QmlgBVnTtc2v8y0Cm
	 qzaxCxcLMp2x/mcXrg046ES2JAoye6MO4pHY7GJDsGgUKLDqAKly9jGEcJ1VftzQHiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058416;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CIMdxsnEZan0cHWGuyPruUf+f/Kv7LymkNewRMLKHOA=;
	b=KrTo9adyjqiyl/tx7goQpOB7dBQ2b8auarvbG8y0GJvLERd/JTnilGGoeCYsElq5xKKj
	 YMeGnm6mrsJ2JWBWDplql2/LhZcd0NXbEoAhyetoBsdVP5Yf4WGWo98avvRPHTMl0Mijt
	 iNcTarq35Jel/AzkRXhG3X4h//HIZlW4kxVqeHjJxh9d0BLmkexFnYnvNwGTkblWU73r9
	 6PCH4O5wjuArp5g91rxcvA0F0pUpnftGxatqXf3WTuNhetoFT+8eM/RqnhCLoR5KG//SI
	 47l5bosoo/08wOUeBW2jFs+RTZC99sxrAnRFatTLPxJ+9jBodfuIp+Mn8+qYyO3GfNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoVgIKob;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0251E606A326
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoVgIKob
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726571F0089F;
	Sat,  7 Nov 2026 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794058415;
	bh=CIMdxsnEZan0cHWGuyPruUf+f/Kv7LymkNewRMLKHOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NoVgIKob8DX9Ymo0c9jONISu73fu9M/abTAW5swomVG35QeRiFKEtEdpDrRKv9vYj
	 hSVG0StQRAPh527H9OKr+ciDBWGBFtlnT35T7+oBGRY+oRVHce5I0HYk/UREUk7ItT
	 qvyWhnhdqtnSuxsHEOdYAOr9uwa4l4BBz4wAk7q4ZxHWcOqJgzBK/NwFkNemCrGaJC
	 B0twC7SG1GDSLKwQADqnKwH8Ng2tCsfZw9XTbOZyOsn3Kz80P16ckRbg2sDmuLwXAq
	 d6q5QW6ro+DEcOhl+j8+7G3fzgQOApCjIdqOU9EtVIHYX/phQw+sRUXxoHyACyGe1X
	 0Tf3IRtPxhgHw==
Message-ID: <sashiko-outbox-202929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/7] dmaengine: dw-edma: Add a channel transfer size
 operation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107133027.364237-2-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
 <20261107133027.364237-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:33:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Expose the channel transfer size through a core operation for eDMA and
> HDMA. LL progress handling will use it to check for a stopped channel
> with no payload left to transfer.
>=20
> PCI Express DM Controller Databook 6.10a-lca06, section 7.3.4,
> "Detecting the End of the HDMA Transfer", documents this polling method:
>=20
>   STATUS field of the HDMA Write/Read Channel Status register
>   (HDMA_STATUS_OFF_[WR|RD]CH_i) is Stopped, and the HDMA Transfer Size
>   register is 0x0.
>=20
> The same condition applies to eDMA as well.
>=20
> No functional change on its own.
>=20
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107133027.3642=
37-1-den@valinux.co.jp?part=3D1

