Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058797;
	b=TanlBpKF5Lx6VwcjNSMpIHqotWvSn3FpSSyBBVyrd2vVsxNvIAabQmxolq6JbQB9EySs
	 QMqsf+x3inYcxMr8dgPWU+TQiSmIORjcR9rFCN/YdvmU9TnDSi/ANnxnYzazKpT4V3diY
	 yWsI6+VVuxNXDF37GXe720fniyMpCOcUYUZ+/hqiREeFP1T4KBdDeI4fveUrTQ6OC/AF9
	 kp4d4pyu9hnMfitLVJWCTKSEjD6O4itJeRhAFUXqkEfM/RrcIIDAHzDu1SnDlvbESZc2h
	 I/DvmPSJ+UJ43XsCwAME3i7TgqcFUM1SW+LOb54lp8DX1DKFlxx93rE1zUtdllnsZgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058797;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2z6Bte8nS+B3NHP/I3upxpV8ozkE07wwk9GllC+khNE=;
	b=amesEllhJIqetYHT7ZaREUEDJpxr/BVzSuoFGOrAyyxwnUHQyLgdWXkmMVAZq9PfSOy1
	 cwipGhu8XnyND+cKTC8Ui3cTHrP3f8wPG0i/Wg+njn4l0yZ0S2jmaEwdpn/QyTdQu2X//
	 tltFCT2++wUl5k/ezM6DUNVU+ouMvabuuX3X2CmP5SvPTAsdwb2/tS5qrY9fm60jdDjnu
	 gvF5kN6O4Prlm1hUyB3vDDnhZBBG20CqaggHOADURLChvKJ9LswfLluNfmRwDuCP7Jb1A
	 i/crvGXkt1goIVFfufVlEz9FQxfZ/ajPX6CXtWE+rnAPxddgd5JDX/4nrFANoT0LsgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvAzddhs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DF606A326
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvAzddhs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B191F0089F;
	Sat,  7 Nov 2026 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794058796;
	bh=2z6Bte8nS+B3NHP/I3upxpV8ozkE07wwk9GllC+khNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mvAzddhs5TXJsarYxm5s5tEqzdUbGbxV26OSmS9AP8dPofPNY8QB6WmGGH/PxJ/JK
	 y3Pw1xzJAV9luC3bbkrxEvIhLtBDZQJEVsw4ZgWB0egLCJFe9NCcLsY0jT6AeFc4uP
	 383OD011R9FWJejoEOgF7RkcEib+YY/7S2GHIQAtW5EBIZgFYvUWEot+o1MCbLdH0w
	 zTWjEbkYZF+fBuweLSRwbiKv0pT864qEBvJwuWtlMBFHZHTcuSr2f5uRCPsOfAOZ6U
	 v6YcmcYoxCwGa/W3V7fMA4Zb17j1Z5cknX/Zuh7tjNO1oAqWZu95fhxEyWpK3IZK6X
	 L+YP8GEMNPE3A==
Message-ID: <sashiko-outbox-202932@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/7] dmaengine: dw-edma: Use HDMA watermark
 interrupts as LL progress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107133027.364237-6-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
 <20261107133027.364237-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:39:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> While HDMA is running, DMA_LLP is updated only at watermark events.
> Enable watermark interrupts to track progress without waiting for the
> channel to stop.
>=20
> Set the watermark bits on entries that request an interrupt, configure
> local or remote delivery, and pass events to the LL progress handler.
> Unmask local watermark interrupts only for LL channels in local IRQ mode.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107133027.3642=
37-1-den@valinux.co.jp?part=3D5

