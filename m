Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026263;
	b=H3k3Anm7H5/rpBzACoCpHrpFL48ncibjlobscP+u9H3G5CJllhy5MpoeDXHm+jir+q2U
	 cr47BqKWRdgK7fK4ct7E4i5qgyEARGxM8+TT0NhNbFb5u1Irhprdmxd8YPXRRCoBxVPM/
	 ib4GsaVrwwfBVR/UXZCDsO2atgi/Oa7iWKcKoY26J0LF8MXTg0ylXmUUyzNomEPzHIJ7l
	 oFzq2wEI9MRBfZDUbjRFPXPfjT1b9iV/BH53Qb/8WOebqNwuYdN4Jaf+eucROQjJaCGd/
	 4MgmDfPGYfw9hAxvv2C5zyeROunHv7+yvZBQ5OBc+ne3l/60g2BkbXxKEyfgOMIsZUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026263;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mMRX3LI5b0TJlRyBelkQ1L0rUxnPQBtxoAovkLcWlag=;
	b=dWy8KT62lKfAw9q+kRU6pQSMsJuPMxMXrfrkOVZRouRoicujhYVqa0V83+GHB8ky7WVD
	 Jd5JQYVADh1oKRr+qfGiByobfTi5OxkJm2gX3Cda4CtgCE61phcwJ2gOQZeUWQyDcw5VE
	 /18dkin0f3nxYDxltKmARUabdtPyA07pbnPUxkR+Jj2VKMUbryKATsELOHD8n/XfVhHAd
	 +XalrkY3LGk4i10APKz0bMwwN22qlvjTA+NUkF5JrpW3iknt7RWVi01pW91XISav98oYx
	 SlphTnswlnSH0OHOgSoENCN1xeGOV4OTwr+mkVz2wdxjAfKca1oRR/myYlDh2oEBpZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRLsc1XO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F2606A334
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRLsc1XO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F8C1F000C5;
	Wed, 18 Nov 2026 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026262;
	bh=mMRX3LI5b0TJlRyBelkQ1L0rUxnPQBtxoAovkLcWlag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRLsc1XOXCVkVai2MkgVMLkGIQA2ie3UtsRuvzq4jBOC+idwHSlT+NqTSBg4BCGV4
	 XoKizkCsTJmVZLFhsBmSqwYUxMYegsM3x81kAU7tVOLW5FJrUM3I3Pvmh0MnK6+zR0
	 mP5b4g8igmV/hBbkJzdMeIbAV+kjKQACAfDMXO5w7G+mZBumzylZNYK4llmX2ix8C0
	 LQ3HoFPIBYV/U4ILBL9F2FfeaPBqxnySVc1YfwmL4wasd7N/P5Ln7BsHDxZlR0pIai
	 JCVTUkAuvpRbOD0hEADYwqzaRLXorB9XEylbxQFr2tZn6vE/OfZ2zTRm1vTHIbMtx5
	 EJ8ROChT8X7YA==
Message-ID: <sashiko-outbox-221742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] PCI/ACPI: Request DPC control only together with
 AER control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261118181718.3907441-6-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261118181718.3907441-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 18:24:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER control
> when it requests DPC control.  calculate_control() requests DPC control
> whenever CONFIG_PCIE_DPC and CONFIG_PCIE_EDR are enabled, even if it
> does not request AER control, e.g., with "pci=3Dnoaer" or when MSI is
> disabled.
>=20
> Request DPC control only if AER control is also requested.
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118181718.3907=
441-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D5

