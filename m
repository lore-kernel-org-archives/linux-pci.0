Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058695;
	b=l0OFUaiVfrcoXwN3wAfTMYXG/4Ee1KefzVY/ta8LvBrxZ6XwRJq8jA4iENNQ4rDuHreW
	 CDtN6/VzqKWuv2zjVTWz7iqHKfsQXU0zCBoLxEHswv/I22qqC1Vh9j4OWkudW5/V1URpS
	 jiZBI8HKZNpsMsn1dLPNA4XER+qPJGqUeEBcf/sJYh/ZrREBss706OXzIlrj7cmqve594
	 lreGe8HpABzTrfjm6vIBSEV/DJuftM/OoN9N1mg/Ws/7MXVJlyBPbIV5RuJ1uyiuJ8Fxh
	 2fzMYwMf/4tlpi7pLSADwOMOVfwrtxIWAQGM9kIcgABhplVpPLeXC0P5V4MWvSASnnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058695;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2gY55SjKvbr7WEU3Y6sksQCjLrTELqkq+xZ4h8BaQ5g=;
	b=0Sfd9k0b6PBJW4t0UWN9WXOdxe74WonBbqr/ZqKiDcsJwSbNLRBKW7ZEj5XqmOL1STHS
	 YbpP2n0tYe7JE5sdjo6b4LJXadoeSw43QH60tJtiL4vcY45kJyaJ9/Aqjg4PaxLQGQLHq
	 vGagOGejuO5kdZp9KhM/DTiy/+YXtBh+xhQkZvbHj2pyrkClG+yLiVL6GVcGk2T6lotF8
	 Tjqefys+z4KSeX/wQRtKuwZbGFZ0/qruotIDkiMsZSmT8QCsW84XqGqoVDuTC2ISusb1N
	 ImByMZg/vZbevMDMBxIPrJ/7Qf/TNRWjAvSIUuGuns9bp151dVoCfeCnTF3dpZkpOww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaFwYrAi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77640606A326
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AaFwYrAi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEFD1F0089F;
	Sat,  7 Nov 2026 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794058695;
	bh=2gY55SjKvbr7WEU3Y6sksQCjLrTELqkq+xZ4h8BaQ5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AaFwYrAic59fsdCVOgGkPaFu2HIG1O0CTH3X+OuXR5EkRF9Fa2bJx4FNw09iSm0E0
	 qfJjRQ6jY3g5aZEDBGdg4B4iHnp8nK3zweB+FCYi4ktXY9NOO4ktjb3DPmofg0YxUi
	 tTyWhaVeAlBHN5ril0bJ9oNr7PmtJZDBCLMHPguf74x64w8XSesfscYnOoCXEUptA0
	 2JEFxzZrXRn+Jg//fskI/ZdzLxmYE4wSwM7v+nl3xUI/Wr10ozmZe805zLU9RLSBUu
	 E6aKyRpwg65pw9AM+CoJFFzkTXO1+SMcun4KEd5Vi7+MyabsHGhDdtDYLbFaCALvkw
	 g0zcJ9Qnli4Hg==
Message-ID: <sashiko-outbox-202931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/7] dmaengine: dw-edma: Add trace support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107133027.364237-8-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
 <20261107133027.364237-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:38:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Add tracepoints for LL publication, descriptor append and completion,
> and doorbells. Record channel and ring indices to help diagnose stalls.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Co-developed-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107133027.3642=
37-1-den@valinux.co.jp?part=3D7

