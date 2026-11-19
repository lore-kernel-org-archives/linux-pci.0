Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116583;
	b=nBFdRM2YrrhfjidA5j7qtpP+Z9xFWvNEeyXstypeoYUqQMH7EenJGuY6sBcES6GYQtwn
	 WLTcSkEF11D9jgg9R1QYkl5ZILndmPD4EWzQqn0EEvNN3qrOcDFFWQlRuPYZPPSOn1EUu
	 69e4SBR/svc/he2khtHaXzw2pvI2lAnDi1AYncAh5wAEzaH0lnhq5s91QSQYiDPz3Euzz
	 NXWJWoYYUbuCx05fe+seM5cshhXjxxCVJWAySpFREVjdBzP4WyTfxFaMl1G0LLhtDpnV5
	 Y2JhnWth9DvJ9P/iJKUjWTQBkp+ILSRCmit/63Psq+XymExZY3VMDr3QlsbyL3s0XWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116583;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H7UVaAxsNHzoGuQMZxoyOqJgJ1HNYhFtWBOhZqDaisQ=;
	b=5O8VowU58YQ9+hUzYFdpzpanW3glH7PKGwNr+miB7j4NmzcUPWQF+0OVhzCC2iqjF+DU
	 5i8ac9H40awPrIVB8Btfr0U/ioni6SSHt73Rktb6cuoyD0vgq8uZ7Z3xz0OUXyfv5lrIX
	 yAq7FUbGSzr0UJmdJhJJfjsSJDDZs7DtRSrtZcg1AubprdOJacva9siiRMf58Z4bJF29U
	 McDaghP/WBlFCaPidPdw5GBYgkDsAgehlpHugHPMp5BoyDCofaB/jsPj6NEkLTsolYZjQ
	 j9zsRuHXlN7whCkvC6iFnxZA+9SK87GFB+YyU0jWy9gtIiAq7nVwRa/bDeFisoJPEtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RFXxBeuC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9E606A326;
	Thu, 19 Nov 2026 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RFXxBeuC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50541F000C7;
	Thu, 19 Nov 2026 19:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116583;
	bh=H7UVaAxsNHzoGuQMZxoyOqJgJ1HNYhFtWBOhZqDaisQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RFXxBeuCP3OWVze+SrIN2BrJ6NMtvVsq153twsfx7a0pPHHf26Sy+8KbVJEw8f0hh
	 kg6E/LSa560VvrSIIZ6ZRZO6k9frMu7Z2Lb1CnkzDUmm1Nmnz4dtK2EtXx37TK4p5f
	 Nyk+av/G3Ofv6FjaOgYnXmlow/EmORTwzdvzhrWICtkOfpQWJTrOJlGEQpg9NieJ4N
	 SSpU9BOgJvC4CGvHwj3C6HWFwAQ3UT0FXuNoE3BlLCSUM+O6rAYlwNVIap+BAet+8q
	 4TomK+ZKI4kiB7Asb35C9zgeJXHYIPGhoINPUsFXWwPeqJ02sHhXmWL/CGYOU4hSik
	 x5/ug6kbgKddg==
Message-ID: <sashiko-outbox-223909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 23/31] driver core: Expose committed device trust
 level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-23-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-23-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> After probe failure or unbind, active trust returns to blocked while the
> accepted operating level remains committed. IOMMU state and other
> infrastructure can outlive the driver, so active trust alone cannot tell
> them which operating level was accepted.
>=20
> Expose the retained commitment separately. This lets infrastructure honor
> the original level after probe failure or unbind without mistaking inacti=
ve
> driver state for a new authorization opportunity.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D23

