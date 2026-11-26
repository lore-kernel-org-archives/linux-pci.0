Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720889;
	b=hPzNOZhAJMCvBY6Vw4zb9kJy0PTlZmyhGjodf0OkMuPumzWpOU+12FC0aCelnH7MyG6T
	 IWIoZO60xWZtEtTLvc0l/61NL2nDx1dV5tVqzrXkKZQvdH9Ax7EBIrSaVPFeZDKn4ETza
	 wqFmniLNDworBgG71tC1B0pdzlQpzWDYsXWxGua+b7WJz0BAmEbBoaelv9zdAAzxnGots
	 fcNLLIZ2x3yOw70/Ebm3MooGregkpqfTlLKlTgmPzjWUbHeZYVoKU5oKBLDG7j3ZEHaUS
	 IqLa8wTwPrX5ZO0oKrx/zC/pazhwRazRRgITo22dMO71j8VLOM0w+rTlgnQUlAZa9LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NetCvnqPDJTB/r6fpQU5vd9KMMA49Z9S10w4++lhwKE=;
	b=HGp7fnAl0Mb7IgAmA1CpW+4OF06oiCy8Hu/lg9VJ+RPSdaG099pvOGnDt6oaIT8cywRo
	 9ANRdqbJ0lTr2jL0Q5bgHZX6Z84jNSplR5ew6SP+wfanYJ8aecM3t+x1zAn0ZwRGJx2JF
	 D6s3eQ567nRKswtfn+qs5A1mJ65guCRKedtxXE7+KkA0+9IG7GVmnEqNDsKrg1j5TKl1z
	 5b0C6NTB7UA9SO175PtgQiJ/DT2QH1QHIoyL48mMdEyG692I0ID96HijD0KDs3brMh0Xh
	 nTK+p0dw9QsNLpUSinwry4F8smc62dSZqKa4klaZCeHcqaOU9lCsmorqQaAvbnl80KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwy7cOb8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01C606A31C;
	Thu, 26 Nov 2026 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwy7cOb8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249461F000D0;
	Thu, 26 Nov 2026 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795720889;
	bh=NetCvnqPDJTB/r6fpQU5vd9KMMA49Z9S10w4++lhwKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hwy7cOb8+Vt2ddgtrEVhv9Jf+tPea1hIsEbHJQ1gKSI0waYKp4PAyv6PNou5ii9V6
	 F1pxXP65j5NMIPtRsn21dFsibBXUF2g4L+iHnlbhRUJWBjME+C1dUdaN8qruuFA6+6
	 C7nVkCAoizx2K3naVlowtZuBX87HKoNydC+1Lu0u8fN/Ax0swi2ZvtQUyp7ZB2galT
	 9J3qZsuwSB+qTYWwoymRG+ozUFMej/Yj63h1yaa3oH7+Xly4crUF1Xr2ATBG/B6SqY
	 ntPdU8AN5vanSgGcec6sQePBP7IPghHXK3vSy8FYBMCQLnls4LrJ4zDB3zEfGHYtjI
	 N0qaXaI3LrJLA==
Message-ID: <sashiko-outbox-236082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/8] clk: qcom: gdsc: Allow USB and PCIe GDSCs to stay
 enabled across suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jagadeesh Kona" <jagadeesh.kona@oss.qualcomm.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
References: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 19:21:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 8-patch series:

- Patches 1-4 and 6-8: no issues found.
- Patch 5 ("usb: dwc3: qcom: Add support to keep GDSC On during..."): 1
  potential issue (1 Medium)

A detailed review has been sent as a separate reply to patch 5.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-usb-pcie-g=
dsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com
