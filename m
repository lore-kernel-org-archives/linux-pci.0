Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894883;
	b=FGbZvCh0avmDczBsvggfnfJbdXO7WdkmO+A99r3aaN0mmWX6OkHgnQEB4/iScec8HutA
	 LLlXFvO2Rtguz5u/oeaDHwZuRzApkdQQr7oR3yiYtj5314W08XC7LTh1xJLWb7g+H7eEz
	 6aZJ3Dopo2K+9qbWkofS559evjZ1mKNL2QhZDpW3SHZybZnZC17imoYkfKCnMvvXwSQPM
	 HdDXpUl8quYZncWm+jSVImV2QsefBZRHvIDUIZjuiRbSSh1Sa+ETnvGPIGXhgHGNpmiF+
	 0uCkBNKaHqOmLlOawbA77wqKu5e41X/MPAm6iVVHwxXSWdAWcutzeN/AEvg9r/t8uyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bNqlvAgbwKRydorgzy8RZsmUK3FpgTh8AS/lx4HwAzQ=;
	b=Cd182i4TJ13CnkGvPmWYDiC4spRoejUzi9T9k9DnTvsY0raSg6pXnWvwRl/NUuzjK8Qc
	 ixbL+ng3YMwJvX2mTtoZKwNYxWvGDKUCqCWf3Qp9DvsCF5+H9rsYzEadGpjfW0a2/MAgu
	 Kh0AOSy0tlhMaE/52WmHOhYduWfjhV5HYl22SIh6yKhCb4QQrdpj/me9f55uuYt3DeysV
	 tEhHqYY7CI0sYqNzQSk08eFAFTxfgCIygGgfhJ8cRmkPTiafFy2lu2XuPT0rpoRUaWYkG
	 i2yuPi/po4gYZ5LnvzGKRHNH6eqBwske6Tli9xBoCCXAfjcwuc9D7qcQXO12TDRPL/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdVj5q99;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA6606CFAD
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hdVj5q99
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45651F00919;
	Thu,  5 Nov 2026 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894883;
	bh=bNqlvAgbwKRydorgzy8RZsmUK3FpgTh8AS/lx4HwAzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hdVj5q99XwGQbWCmDlQlyyyRoHl0xnSykaCGUNUPbT7kiIZ/WEKHTDFvPzmG15hA8
	 USJ4BmDYnFWLu4MRjqK8LiBT0r1bTPtrS7iN6Srw0ZLJRBA6+EPPS7kLcsDYT7YaB0
	 0pp2ydNvW3iGKAFX8dIq2MmDtsDq6AJyjfG4P/XqZzzBXb0Af747swoVxZLrDfOWdA
	 k29svulfvSaw24+kJC1Yrw+941DZfPM6/BCa5H6RmfOdavRZvydd9b/2hqURgQynlw
	 tyBOLedntqS/0vKSgGf1L7q8MjwkopjFJGnP7KmlqgpF5qGndstkzlOpX2TzFO0srk
	 CS53HKaIygbAQ==
Message-ID: <sashiko-outbox-199416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] PCI: of: drop the reg_num argument to
 of_pci_set_address()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105153801.435566-3-elder@riscstar.com>
References: <20261105153801.435566-1-elder@riscstar.com>
 <20261105153801.435566-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:08:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The reg_num argument passed to of_pci_set_address() is always zero,
> so get rid of it.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105153801.4355=
66-1-elder@riscstar.com?part=3D2

