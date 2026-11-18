Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026290;
	b=05SR14tdMls3Y9El7oX1cBrl221BUKHbv68hDSh4Tr25XgmaIa1RsKMm2F8KutwLCXmM
	 glUP6vislqDpsctaDd7+YItZaLnkoWQtW+VAeO/i4rrsFkcaZi1ytyHSuoGJ6RE6UDGgc
	 2GV9LIXNDuddaOXChz9g6f9rRTORG0AWUOrfQcUxdX8QSdwAuqXdc0AN3sSCVQR/oRbrX
	 j2VJx5GuaS7Up4tRQHR2VQFy0SH4Q6MOv/lyjc+OQtNRTWjfRa8YZM186lTkbhX/1eM8p
	 3c/vYHA7uRXZQBJN2imLuerYycMmHBSrnoW9iAlUIBvEFIbNoIW3UHWgOrFfRncPihA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026290;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ybUzBel+Zq/klrQaW9tGfIaNed/2/786nfuPlQ/tvYU=;
	b=AbpfK4yBDd9pRARBl4eYEIPtZ6LhM1l+1ZhHA74fOQwc6uVh+j02P4/xRHfmnSwy8hCG
	 b6cfF/i8zJTJRBG/eSp6W92ABudwAkFGkUO6V9m7FI24oZdc3k36QD919MxbRXDpm/YGF
	 HGiF8M3A5KOehAnn4JemGvu477Y8Y02dkhJo2aqHiOGJhNnIMNAOt3zcJqKK9w/uYiNl+
	 INOu3187AuhzT7AaDVvSz9Tku5iP3JpPaGoCJsN4ZTaJ9l9lKnTR02yXPeUFPv+Eux8oH
	 ojW2tAQolW50/HGZXG0rwkxKP/braS0XSI5HhRFltZN7LJGXQUvKCdDokanvMWxfBiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxG1Mkmj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B00606A320
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxG1Mkmj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4124D1F000C4;
	Wed, 18 Nov 2026 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026290;
	bh=ybUzBel+Zq/klrQaW9tGfIaNed/2/786nfuPlQ/tvYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UxG1MkmjIYnqz7z1jXlnI1sQ8BzT/ZheHPeeSWvY1/ZmLgle2ORVmBWm7H0sHOh+X
	 GdUFpNWv8ipuHBYkX7xyzkRDmKWAcabo9RVinu8+yNFxeiJKUThZC5knyn+DIk6ow4
	 aw4hsaBUFIpLNd9SzaCXYYwmNmppnV5AfaZ5qbvN23AVkDtAJy/Cr16ZhAzQjk9rwa
	 hcUXFW6TiC0Ltn64cihKGLF0anNGULzQ9o4UqUQcX+9gb04sM4PbPuVa1kit3NyvO1
	 2JOXeBnYYYGn8JbeRNEe/x4783BM4ePLlONsdd8ELQNFtU9ipba2P97jaxVp+Hcslj
	 9RPApIpxbo0zg==
Message-ID: <sashiko-outbox-221746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] PCI/EDR: Build EDR whenever DPC is enabled on
 ACPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261118181718.3907441-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261118181718.3907441-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 18:24:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Error Disconnect Recover (EDR) is the ACPI half of the hybrid DPC model,
> where firmware owns DPC and notifies the OS of containment events.
>=20
> CONFIG_PCIE_EDR made EDR optional on top of CONFIG_PCIE_DPC.  This adds
> another knob to the decision to request DPC control in _OSC.  The OS
> requests DPC control only if it also supports EDR, so with
> CONFIG_PCIE_EDR=3Dn it never requests DPC control.  There is little reason
> to build DPC without EDR on ACPI systems.
>=20
> Make CONFIG_PCIE_EDR a hidden option that is enabled whenever
> CONFIG_PCIE_DPC and CONFIG_ACPI are both enabled, like CONFIG_PCIE_PME.
>=20
> pci_dpc_recovered() gave up if firmware owned DPC and EDR was not
> enabled.  EDR is now always enabled with DPC on ACPI, and native_dpc is
> only cleared by the _OSC negotiation, so remove that check.
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118181718.3907=
441-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D3

