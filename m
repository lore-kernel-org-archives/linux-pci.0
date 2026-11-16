Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843320;
	b=2zRrqzxhij1EsvlPvtVX9uzfTQBsm7UtkOrgmGzWGorZutFk2vUj+42uF8l49QDv5T+0
	 y5IlXaLB3WVyPWTntvYYS+3Pur2v6HP71Cqu7bUqJnE47Ir7LvTRX7ZtwmVZ7JM3SijW1
	 zUUTPstsadtXZO029yku1HzbCTBvaelkJteSG5upA5Spk01xvF692YEs4yERoIae/+pt4
	 L/pew62JoyGrztuknRReMCReRolQWAZ0wkCG0h79XhMsbvXeJc0AIBGpezohHt7iBUPXA
	 oCir7ldq2dyat3P2zjvRnSdz8LfTgxYGZHJpd4EBOq49/vRt1pAXnhpoHWKJAtO6s6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843320;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XjIqpf7VArp91vXLQJsmtqtchIAnfH9EfjbxAUvySno=;
	b=o079U0OplaeMSequS1r9qBWtEf2uwKFFiB0vHMUh9/Xmy7tohQ9Hyp2HoJ50L3W9jwuM
	 aJLoM4gE+F+Gf3Epiinb0q0b1TV8FAMsXpJz6cfvwIcE0jYooNZLGU9KV66+pOWN8SpXe
	 uWDCUp2uppospEa23HrrcNv6nDKzXAempJ1WeCsWDbMGlFvzB79MwPzW2Gw6y5rM5LfMH
	 9W6RkJZj+nsI+3tGI8m3K4X0tsWYiIimOIIXQMoxk3awCYPq8zqzkOc+UyrfoJ++bGeQp
	 sYJ9sSLDICbLJs5OGZZtDnJXDgM681rWZlNEW8aoAVcSKZGXVc0IxWnSpw3hToViRRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vc2T0Twa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F51606A329
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vc2T0Twa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD441F000C5;
	Mon, 16 Nov 2026 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843319;
	bh=XjIqpf7VArp91vXLQJsmtqtchIAnfH9EfjbxAUvySno=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Vc2T0Twai93u4kYP2JjKsuWGYdJY1osvJ5Jykt6gPoRcYUG4641ANeYYFAGgf78Lo
	 EiZ3N1cgNC7UaNd3PX21uq1AnNHE0ht4PA1KhYqOexVvpb5Vv/Vfc/6c3UqBxSLvou
	 MvKh946QySazLWeHqzqCw+l/UMpmuf/XtgWlDT1VM64GmXrqYgiW5ycOEI3aTpD5r6
	 d9g3JeNBL2/zLa9fJymkT1p6z/3ZXaPlRA3GjKSYJwkg33Ntdnu96z2Vsb3L4CwRWw
	 uwftskVxx2S1Mvme9BCEG+nqTlgKY0J5u6/8gum2BWWPf2ujJUF28vR7A/mWj53iuz
	 Cs9uP5lU5k5MQ==
Message-ID: <sashiko-outbox-217294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] PCI: Add pci_bus_size_and_assign_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-2-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:35:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Bridge window sizing and resource assignment must not run concurrently
> with another sizing and assignment pass or with device removal.
> Preventing that requires holding locks across both phases. Many callers
> outside of PCI core call pci_bus_size_bridges() immediately followed by
> pci_bus_assign_resources() and cannot hold the PCI core internal locks
> across the two calls.
>=20
> Add pci_bus_size_and_assign_resources() into PCI core which combines
> these two operations and convert the callers that call them back to
> back.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D1

