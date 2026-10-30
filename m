Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373079;
	b=VaVkWpoPKZaAeyLmEsa9pMCUm+bczp7Zldii30THFNNK1SnDh5EMVVbhV/V+jqWuEFFp
	 Z75fsSUd3zL1atgb/TlHOZO4R9nJMbIOjcORakMX6PVddccQYpZJslhEZWSFWsC3pkMGQ
	 iI/wjyg45PuQEjeQ32X5TsAv/KgnlhT66qN7wo6JdchgjWpTcbYrQaAGjxvdUm1CVyVNp
	 37DGfbL0ACeg7M4OUtYJNY4sDY1ouYf5GQdGFhWGs36y//G3gRtUnGNS3pGQ5r8e223NX
	 WOzNB5OZX/AEEYphpx6n0i2+mm8XISvi6m75rQMM/v7uQgtqVIqitVbvzp/Hhb69vsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373079;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aEc2rOOdIJxDt0pepX76Khu18PUotUZReZtKtoIPIsE=;
	b=e0bLhv2hMx8uyQ1cb6vNBPenCHwO8MKSn5btsjf0QaFYiIDUVUVnQ9oMiZU4saAmgI0y
	 eVzJxhgt83Htfu3E2tJQfDbiRoheoE3eYUwhrO4RBKNC6rl7sdXq54FGh+Kn0VVQhIOgT
	 xTFhzEISn4Jvd2BaZv3PysrGcmdbEWEpLALRbpA4q4r1Z3vigjGnBma1MdRzs7yRAqZOX
	 Zp40P6Hyhq6f+BJU/bvIDKMc4JtTf+jFRwNrjSr/pRlnl8NtDU8Mc4hSL7M9950VewJ+D
	 P6SY3ewbiMA7JAcNwrOn/jPcnHZuInqecQqpaNmqgF2tzVHLg4pvW47rr+KsNuwOYtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFqIyvZz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D231606A31A
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFqIyvZz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5841F000C1;
	Fri, 30 Oct 2026 15:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373079;
	bh=aEc2rOOdIJxDt0pepX76Khu18PUotUZReZtKtoIPIsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eFqIyvZzcekLo7v71IuE9WJlyojRSdWJArPrM1CnpTsOPIoTFN3+f7F/rZ9i/EjS6
	 o4vYx6Z5tD1sQ9scAxxbma8DlyNVN44UW3u0wC+0yIVib1tl7aHOhUdppRIkAcL/Nz
	 XFw3bhVX9dqBqYud+qlKZp9nHHlgKzxipBUrZKcXkkgWpEOIhuG/u/TcFGCOL6hjl7
	 N8tXVpaG5d11MFt5Ez3bhtjJLs4M2g+NzghwdocerZTZHE7XH0gsuFV+8Jruxi8aTR
	 iyjo8nOwzuNLKBbk1zyYQsS+7qjsFSvP57rOM+NFimYpyluVdGOVYDCHKJQ5ggjBAw
	 ZDxtk+NNewfRw==
Message-ID: <sashiko-outbox-191143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] dmaengine: dw-edma: Add a channel transfer size
 operation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261030150742.2586776-2-den@valinux.co.jp>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:11:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Expose the channel transfer size through a core operation for eDMA and
> HDMA. LL progress handling will use it to check for a stopped channel
> with no payload left to transfer.
>=20
> PCI Express DM Controller Databook 6.10a-lca06, section 7.3.4,
> "Detecting the End of the HDMA Transfer", documents this polling method:
>=20
>   STATUS field of the HDMA Write/Read Channel Status register
>   (HDMA_STATUS_OFF_[WR|RD]CH_i) is Stopped, and the HDMA Transfer Size
>   register is 0x0.
>=20
> The same condition applies to eDMA as well.
>=20
> No functional change on its own.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030150742.2586=
776-1-den@valinux.co.jp?part=3D1

