Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573434CDDF7
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770390; cv=none; b=pKCjKguirO8QJXCJJ1M5alLOUaRPg+atQFed/HCgcI1sv6DRZbRert+U3LYI37oL7c2Kh9xefaBnbqdbHXa6eRGFiFaaiexTu8iLz5pno/rxpp0wbVtF3GzdISMmI4FPaCw0BibhYQtyH2EGvhqm+nT66bLeiyOydgprU6G26Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770390; c=relaxed/simple;
	bh=hDoILcZ1Y+eSq7EOn5uQuub6AR32X4+dzGkjqzRve9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WOrFSLcjgTHLphhl9hajjoEpyAsQ0OWSlKkSD/rCXEDu4ZqcJ99coTK7b2lhMLZAyIgZBvx4OC16EYFkY92jtQsW+6mtPbNkwDb50qW0vDJpNFHjrXC2Pr0tdPdz7OymUNYvheyto3R+k9pKmF9LJR6H9lRT+OKR5XoVBhkhtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7UvENwB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7UvENwB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0188A1F00893;
	Wed, 30 Sep 2026 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790770385;
	bh=hDoILcZ1Y+eSq7EOn5uQuub6AR32X4+dzGkjqzRve9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z7UvENwBsmiGqSgpW8j8yM4b9wPODi6qCMzdH+CdLO5GXhCIQiPqu+2pniIQKNVkZ
	 Q15kbSgPhSeliDgyKNxyKSkey+q+5MnZB/riyl9Fb/C3gygBGqoAb6HfIyVD5NCEb7
	 OoJmlDXWVirwxRLToOp9BX4geuEiyIxYNYCLhaRRwflAzqLXaks1/W2sIB1IhZGorJ
	 onJUoTMuIo9ajAizdF4axwIQzZv6bt0nJe21V0BYK5bqUQFFVWe2/+FLdkhheLTpxa
	 cILbiwbtpMmmaNC0T+KqJ+KxWoBbWMryRX7ktUHbN58yEsm8l2AhUd5BMF61E7By5z
	 s15iMyc96YdCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: mediatek: Fix integer truncation and handle
 oversized resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930120539.4967-1-sreekuttan2156239@gmail.com>
References: <20260930120539.4967-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 12:13:04 +0000
Message-Id: <20260930121305.0188A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> resource_size() returns a resource_size_t, which is 64-bit on 64-bit
> architectures or 32-bit systems with LPAE/PAE enabled. Passing this
> directly to fls(), which accepts an unsigned int, implicitly
> truncates the upper 32 bits.
>=20
> Furthermore, AHB2PCIE_SIZE() uses a 5-bit mask GENMASK(4, 0). If a
> resource size exceeds 2 GiB (order > 31), the log2 size order
> overflows the 5-bit mask. Clamping the value silently truncates the
> hardware window while leaving the OS resource intact, causing bus
> errors when accessing BARs in the unmapped upper region.
>=20
> Fix this by using fls64(size - 1) to accurately calculate log2 size
> orders without off-by-one errors and returning -EINVAL if the resource
> size exceeds the maximum supported 31-bit window order.
>=20
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930120539.4967=
-1-sreekuttan2156239@gmail.com?part=3D1

