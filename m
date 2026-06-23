Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D2175A9A;
	Tue, 23 Jun 2026 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205407; cv=none; b=ui17ylu6M1q9t/z4DQV6t5LmH7wn4x0/cBiCkTalImhfFiyIqzkgunedPy5uKpnrTGlVK0BoZcUbyAjpKzLSEYXDLwDPDQi+71npVp+TGVCUu25rCK3U3qHvDMB+yZZ9vLWQQ10XYj4rQJlsoH6N56bGEXkOrpSbqhDBKx+Tr98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205407; c=relaxed/simple;
	bh=HA7XOGpkrOHjAtstumG9BJsm/CpPOgraMpn/+UYvlmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uvF2Zn2k41O9edgRF8m5haXy6njbmHIbBH47C7/+AXUKvPJ1JA2vl+UnLt/jnqfQuDVeNMEWOcSDvEkmyJban32t27G5P05o6qRoY12wuX1y5PJn2HQPshmKXusM1mdL5nIvLdD1Vtnql3BGv1YzUsBAbm+IjMltuC9oKpN1/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0FoDjcA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0FoDjcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8D01F000E9;
	Tue, 23 Jun 2026 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205406;
	bh=HA7XOGpkrOHjAtstumG9BJsm/CpPOgraMpn/+UYvlmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E0FoDjcAHnue3XMCAlaC1H09iUhV2UF7GeuAojYWdc8XZ+h67HK3UiDiXxvG8kBVE
	 VoKDoZjv7rRhehpuTVyyu9Lo4C5LyIoY2Ck+Nt/FJ/637WuR1KnVI/+Dk6XrY8LTxb
	 2kh58hki78eVmH03KZgyUzePGbw2saPmMwMqkJiTN1K6utDGH5rNlIuE4CdDZQ2B4R
	 qPvnvDBRQgJVHDlJMLMOUjOwYcJNHkEyYJN/A5SyvTfk/oYKXIpdcaNY6fWVjit9bT
	 Tu9iUIrhvdj4dHuEYBsk9lWCPt4Fe/6wm3P2HMJBmXVrVc/NAM9wDM05fn7rFMd82S
	 BIOtCXbAmpaYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 10/12] vfio/pci: Add TPH_ENABLE feature
 skeleton and unsafe module parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260623085048.51139-11-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-11-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:03:24 +0000
Message-Id: <20260623090325.EA8D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce module param enable_unsafe_tph to gate all TPH related features,
> and add VFIO_DEVICE_FEATURE_TPH_ENABLE uapi together with per-device
> tph_permit flag.
>=20
> This is a preparatory implementation: only feature framework is added
> for now, actual TPH_CTRL register permission control and steering tag
> features (TPH_CPU_ST / TPH_ST_CONFIG) will be attached in subsequent
> TPH capability virtualization commits.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D10

