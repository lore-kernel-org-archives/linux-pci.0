Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190994;
	b=VGFFjufKQnV5diu6bqZ4OGi/Fp6PrKA7DRGUhOXE+Aje3jBEa9678wdNLJCBteC2Luc/
	 OjO8uKPvh3rIUGcDW5YRcm9R63sik77o+D4GYYhMeBlzs7TlPthaHOPiaInAfUgpO4gDD
	 pRR4jC15lIZoi+q0lRCfMTRpmPyd66LB/LJd3RvM/YrO/zopoVEVU8X6WvxN3O1GDS5eo
	 2au92VLATqwAZrJBtDptQRNVWr9+mptMdzw+ZHAVjx85OftPilUXCvEYDqbcnFwb2S7HN
	 cmUSXaVpmJM2wh2UqmP65/IIuNjOdRCawseOWNrc6zIIMPV3lek0EwYuwfgLPQCznOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190994;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=887C86BMIDKwdKLGgBAQ35x4WrhrCTHmPSRLvVyRhR8=;
	b=EFWIsaVWH7vveZjsBs4Js1SZVQaPf4Qz1qZsryfmBexhMOzMkNYzNAI1koggTK73uJzr
	 FykSlgcPrvO1fkTFy7f5Z/hLEpBfllw9WcpeSryd/aOteHa7z13O5xwRcOy45n+pzPvgh
	 kBdl89mywWJhu3m+kTzK5t7cpwmIWyKp8E5hdyGrmso6LGtmDgo+UCALUeWKXQT/8vo5i
	 FL+jet1/yw8FAYpgQXflr3BXX3eBP6Xnx2paTjVBLJ9/HpT6VKi+83X1zA6Mdwr4Q+krh
	 glu2J4ZfetTZPoDafr4sHtmoD8JhWn1WhGvoFf0b/HaTPv3ziz60aeyavbGbWJWo+cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2vnEuOf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83691606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2vnEuOf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB561F0089F;
	Mon,  9 Nov 2026 02:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794190994;
	bh=887C86BMIDKwdKLGgBAQ35x4WrhrCTHmPSRLvVyRhR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M2vnEuOfYMhWn2Kr8sRleUTgjiirIamdPKqZEqkHHEJmVp3bWzzFKckrJSgobP0fj
	 esyb6gOjf/3VcJxemUWKw5aiMuFZISm3G6kMzfQXS/0U/EsVeW3gm5XPreIZWoWEDC
	 qS1XzqjrXcZ0ojwMivx3Hp11P0zKfdelR3vr1GhcBchIAwXskEyPAbf3CRaFoiwrBI
	 82KKgA4VCD2umkEpehYg3N3jT3A1tcH4AwrrxiLUDGf+rQZP46Vas03UoXr7ir0k2y
	 Sf+Ie7ck4m41sfhoxsl0vb9ku/yYlmzOK4Xh+SVhnd7rOwGL2V+fKBMnS54GwEQjbS
	 HzNc+hhQrzQ0A==
Message-ID: <sashiko-outbox-204346@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Enable L1SS support when supports_clkreq
 is true
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261109022139.3226052-1-hongxing.zhu@oss.nxp.com>
References: <20261109022139.3226052-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 02:23:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> Enable L1SS for the i.MX6 PCIe controller when the `supports_clkreq` flag
> is set. This ensures that the PCIe endpoint can enter low-power states
> efficiently when the link is not in use.
>=20
> The commit a00bba406b5a ("PCI: dwc: Advertise L1 PM Substates only if
> driver requests it") clears L1SS capabilities by default. However, the
> i.MX PCIe controller supports L1SS as indicated by the settings in the L1=
SS
> capabilities register. By setting `dw_pcie.l1ss_support` to true when
> `supports_clkreq` is true, enable proper utilization of L1SS for i.MX6 PC=
Ie
> configurations.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109022139.3226=
052-1-hongxing.zhu@oss.nxp.com?part=3D1

