Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104357;
	b=SyYAKFPMDL13WM92x/Tf0fE36sJSq46ozNLORDZl9FdB4SQ0joAqIcb7goac7t2qHbTQ
	 Y3ls7jtpMM3WZ0vKIZ7QtTu/pRgIgjgiUvuPeFlWPvHSgy+O6HNjf1Y+Sm5qLhGJU4zTB
	 kd6k4OK1eExajc5M7To6gdPFEZBqkFRc9zxutE18OkRFM3VvdAu5jB4v+4TtchI0mfRTd
	 NtibdRA1rssih/jRkfUx9cJKcvCWDEeFOEcGVFGJAHK8ST0fVeJyRnrILawXalxvBr+0j
	 nVjXIgnkXtgT8x0iISxyTnD9Tjyxnb6R0J2JTmeWSoIVGLkOAPU+bPU+LB77GBW1+Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104357;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oE2b3MxZMDThDvS+FI6IQQ/2lGACBOqXauwEV/2ZmVs=;
	b=MT0djC/YsBbrnZ2qy1RUzTHkv5llgh01sced74ARFrjc4CwjiWkiir0IBOxEQ1K0cXqN
	 P4ppDo3vOtYIeaONNGyCeMf5ZeSA2FevqexBHRT+WWKOYYHqC7qT/4+1w+t6CLaLjGlM7
	 N81koeB6Qk0pzrl2yCpv1q2bOFD6eUHZWEWxlSZUN4R8RfQBFKIIbq5oupwG36agk1fxI
	 1W1+3knxcEk0LblUNVjUQG1sVVaWhVqQBhfIxFkgD5qvKyEwNJkT9prIB0BOz6AOq+I8i
	 GRxf4cfIOTTIv/uZ26T8queVOtZQk54UdKDTHfVDDhWd/ZM3FjcwG7XlEJZ171eWK4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnmvwfnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E65606A322
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnmvwfnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A721F01825;
	Tue, 27 Oct 2026 12:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104357;
	bh=oE2b3MxZMDThDvS+FI6IQQ/2lGACBOqXauwEV/2ZmVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UnmvwfnLCkvgf9ZeBJ2Hi/uHQrNY1OHE37otxCQSD9ghO33r5BH1cCFmfSieIex25
	 uOEWsxufU4I/u2whCXw4SGryTrBO3JoMuxAATV6TaDpOjR/EhGD6zRC8w5hQrHNDGy
	 mvrmxdNiHW6vwuv9HjX8FdCvUVKSsWL3K98qlEKtSogZa4n9MsrdMoK8Pd/0MJtSOy
	 d4nH9pwj3s59tHCgqE3FZYUSbOqKXwBP6F2PWUmaRqTrkMfW1srpkupub9oAOtETvE
	 VTqBfg0XoxP+2bgawJqkcuO0RhDmTw/werV3okGB0/G6iBupRo3BQ7z1OE5rCtgTHt
	 GgsKzLFDm96iw==
Message-ID: <sashiko-outbox-186555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/16] PCI: dwc: fu740: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-9-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-9-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:32:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> fu740_pcie_start_link() is the .start_link callback. It runs after the
> controller has been powered up, so replace the capability search with
> dw_pcie_get_pcie_cap() to cache the offset.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D8

