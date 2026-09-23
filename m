Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74032396572
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131958; cv=none; b=iTP+IFLyJD6EhYgbp1aE8yxEfZVUaZTppPWhVjRB0BkzT+fRX+9YarvypGI6ddRIDSOmDN02OuZgViQgF9d9GZRZj0Dk97sDW8Ncl4x66ydBhYgS4jX/REiSrM0MgOS+bO+V22uvWnkwpEGN9eCpAuRx1ypwK9M/iXZ5crauMjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131958; c=relaxed/simple;
	bh=/8WRSk8AMDnDLhsj9r0UvZUO7ePSjdSXQNuFvSAjgJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jvMaM1sH6qPwigTOtdPsfzBd8ZJnmfywec5E4OCEX80YwK8cBp3mxeIzRX6ifjcaOWB2Vi7kYBUj8BxOAKCbA/Octk9X2xM49vUf39DY32mgoqvvw+rfrOjUu4T2c2cuqhhpCC66Ru7hLWzj+f0BpikP5jLy7XEsKHki158PaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKaKz33f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKaKz33f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49151F000FF;
	Wed, 23 Sep 2026 02:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790131955;
	bh=/8WRSk8AMDnDLhsj9r0UvZUO7ePSjdSXQNuFvSAjgJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GKaKz33fNceR9ACJOZZbZQ5iQvs2bz8GGeKSoMuqMbYGi+ilx2q89c3QBd2PVEDpY
	 BjGAGqNzmv3BbhIFP+PDM4vovKv1/sg0w88JeZF5g82eVHDRDVyqHHNXLSvWmOXsQj
	 JbthvFUid87/qag+a83nkQNfkYjO/uN9qf+LqfDhglZ9X224f+iuAKj0ruK9sFYJsP
	 YCGOX5comy3Vjhoo4n2Avh1vVt1gcGOIdhxLCwTIzmmFla7tvTfeLYEaultrQFYcaj
	 RXs8DTnz2bUjVHFiP9hFsvS1Iv0Wv6KCDY54Nw8hN9PE1jOSdHXSH+1nm9KP/a3Ocb
	 k7rwos/6vhgyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] docs: ABI: sysfs-driver-xdata: use literal blocks for
 console commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Randy Dunlap" <rdunlap@infradead.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923025018.848769-1-rdunlap@infradead.org>
References: <20260923025018.848769-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 02:52:35 +0000
Message-Id: <20260923025235.A49151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Use a literal block for console I/O so that the lines aren't merged
> together in the produced output.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923025018.8487=
69-1-rdunlap@infradead.org?part=3D1

