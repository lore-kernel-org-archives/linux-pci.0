Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699815;
	b=PrsZmH3LlW5sQ5JsHwr/IVogsStEmN3HsvAYUWk3trXpjw3gl1FAra1voZy0J52aN4G0
	 EbkATPpgWZejvflS4A4x9Oo6ZpuRuo3seuvSKwTN8Ac2dLCjAmIzAk9V3UibZ5TYnYEhg
	 awDbzHXAyIgUKx0nqZo+MdLX87Z6Ys9rECY08NJZB0xnUST1qDsfBuBteUFHJsqS1CLzd
	 wIQH2UxT9CdCU/ElFekM1UKlBLjGlMyff7eDXNrodCNu8RbhQg+syohP+qUtQLFroe2sB
	 C7F4DsUjRGJ5Cirpe/qPZhULz2wOToWbt47fjrQqiUg+z/KKrt8nekYqcuQkC61lu8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699815;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CW/YVxXfP11r2QeGRogosfGOSndboPPIEi3HUmru9Yc=;
	b=llCZ2cGYa0uKQQvKuN/i+UyUslGkqq468sy+KW5xUk6iSQ7fG8rTtQ6COso5aKo9ynis
	 Ol6fHDM1BMI7iC6T0VypUV57QTnog02+R+OlAOT559CRnzOrosDBJIn99K7fAOZPRLeH0
	 7brbYz/fJdmNcEA8w086noy143t7ubTYi0cnnOjRbPwkq70zRC5B3VwXixmszAfUFz7CX
	 MaAVryT/ZCnk7pYo0LnRnDTSEpYWSFF7EklHLk/hfxctxv0PamrnkGHQz188AafZT1vnp
	 F7hsf01D3x97b1uffTp2IZHba1XHdsDual1ib3fCeGPy5sOQF/otTZrFj3zIlxr+kNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5twyuhw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96F606C50B
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5twyuhw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9031F000C1;
	Tue,  3 Nov 2026 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699814;
	bh=CW/YVxXfP11r2QeGRogosfGOSndboPPIEi3HUmru9Yc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Y5twyuhwwd9N09Jh8vLky26R4+g7soc8XQ5RgmHGem9CAEgCgCq+kBJi+9w5LwTHl
	 0M0R7ujvBsn/pGvYu+8kjvot5E/Zgc7QXjhGB7zJINohuA+566c9qeCntsk2+k6boL
	 DCvYlYyczeMVyyJ4Uaa4o9o1upfbxBvr8RVYw0NTLB9Y194NLf2BYEev+wC8Uv2H2L
	 qwgDk2/JJA/cK7Fx2Wi6WwglX8XM2rbGud/A1KhusyMCZV/GF3P+GokzjfANajLLZl
	 olVsbfZfYckgKvaKK+Ot3/c82wNeR74p11pBgbFRn3VLAinVL5ut6eIlc78JU1UXgx
	 af+WBKoKHIxkA==
Message-ID: <sashiko-outbox-194988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI/AER: Avoid NULL pointer deref on search for
 Error Source
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
References: <cover.1793697480.git.lukas@wunner.de>
 <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:56:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A Root Port's subordinate bus may be NULL if the PCI core runs out of bus
> numbers on enumeration.  Yet when the AER driver searches for the source
> of an Error Message, it dereferences the subordinate pointer without
> checking for NULL.  Fix it.
>=20
> Fixes: 28eb27cf0839 ("PCI AER: support invalid error source IDs")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793697480.gi=
t.lukas@wunner.de?part=3D1

