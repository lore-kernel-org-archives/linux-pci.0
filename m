Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299309;
	b=Y3nNdZ+e62A1+tNZ+Ox8/lH+UkTUrHw7KPvuiCBRLv7ar80eNR3REbktoRI8jh3tTUOJ
	 z9x8/rTeDesT4GSb7yfzzKuU83lNd7JxjyrfO4ojK+xTnyDJTpH7+7257YUu7zjfviJFF
	 PRjM3Y9W6oJ4jmrMKXihLgbokcxmiGMWFB+i8nSABCWpPUlYPv+/syV0XX91IMC11UUE+
	 xPJvKa75kAIIQslH0aLhYCq6YTcup7DPrdahGTLlgAx95O2qlasZnRdt9pLAAqsyEh5R3
	 Ah1Xev3di9GFzKCRgFc37B8ojalXegydrvPeESm+xrldYUUSaniiUJrtbdSTqKEQHfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ckgtNmp+wbL4xA/8FXGuP43NKy2+G1M7Cm4rRUsH2cc=;
	b=DJXyZXg+CPsOVHQZPRBcwWD5j69t+ZsPu9yJNz6J4YRWcgo3VWhXKNQiFKW8IctSf++n
	 pDZUbqTu/XbCy/sTlok/c7kBgRaCrZa6AZT6ibLfUICOPDfCGf5onscYiTJ6oDtt9zLlc
	 0npl71ud1A2hjn8spRk/u5FxElBHY9Vmsh3Ut6Brh9ubKWi2ygxYFNrojMF7QiQn4EJkF
	 v6twhB1vphYbpBfRGCehX74jqXUZI4Fufdyiccmo0hE3ytlNTZt3ngi7wZ+7q0aAaYwXY
	 hFwGDlWfwzdhA33IW6esfPyrhzGMfSZJsGZIjyqthnd8d9YVJlDJCRrs6wlwvCqY41Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crYm3XKN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD23606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crYm3XKN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849091F0089F;
	Tue, 10 Nov 2026 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794299308;
	bh=ckgtNmp+wbL4xA/8FXGuP43NKy2+G1M7Cm4rRUsH2cc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=crYm3XKNMNJDbkZlm2ENSNdXg3W76HpI7z3ylKpH5YWaBy+zN2R2xRIEJiDCe18BD
	 8FvhbY8xxtQHjGaQSfvxFsjnBrXPZIvkX7dxpY0KkzRXL2DKAYp3Ud8z2bNHoTGw7H
	 bFDaoRC6kMtavNuc/kx/MUlJpTpdyy3drGh4gwNf331iNeLeUO7X+nNrcEA+CJHdTU
	 dQA0oht2iP9BDjqGY9t0FNHdUd4klas08xgZsnVefAHk8ne5KOK/6wHXj2kPTaKC55
	 5jkIGvUj6QCYcszBPER9gBAAYnstV4yeofhMV2p1nYkUBpKPtZ7u/u1G/hjfYRET1v
	 u8eQ97Y7DxJjQ==
Message-ID: <sashiko-outbox-206615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/10] PCI: endpoint: Add pci-epf-ntb.h for the
 shared NTB control layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110082459.1798763-5-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:28:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently, pci-epf-ntb.c and pci-epf-vntb.c each define struct
> epf_ntb_ctrl, and ntb_hw_epf.c mirrors the same layout with hard-coded
> register offsets.
>=20
> Move the shared struct and macros to include/linux/pci-epf-ntb.h. The
> vNTB "reserved" field takes the pci-epf-ntb.c name mw1_offset, which is
> what ntb_hw_epf.c reads at that offset.
>=20
> No functional changes.
>=20
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082459.1798=
763-1-den@valinux.co.jp?part=3D4

