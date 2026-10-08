Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED13B3899;
	Thu,  8 Oct 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481135; cv=none; b=AkoBRLXrrWwPTavx41la9ZwJFyrSjBYRYilNgc7qW0Z5s5U1rY79DsdEj4kugFFuY8MBA8bKhvW+LzlIfkLfrIRYPMnPWMNzSnUnkGJmiVllIhum4HzidrfkQZNBgFRgXfMl6tksJ8bYq3UJK99vZxuOFqHSbX7byEtDzl/ZYfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481135; c=relaxed/simple;
	bh=A5kQ9xmzCNdrRgXkLcA08an9ucrz7n7y1+jowI9FDOc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=URSYjVpBGHBU7tEHony5FDwNO1WVDadRNKsPkpDwz53ayKmWBq5+vBRmv5hCWlR5/CCikaYJ95v4KOUUDLYxNBh+YB8vOAaoVLWa1TwXgsWDtQXTm5vMAMxw0pjO7cg9+48BwZ4sQnM9cZ7HCC8J6lPYIs1aLNLunEAILcaX5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iloZgYJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iloZgYJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0FE1F000FF;
	Thu,  8 Oct 2026 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791481134;
	bh=A5kQ9xmzCNdrRgXkLcA08an9ucrz7n7y1+jowI9FDOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iloZgYJ38fOIztCzXR/sVDYEK9rDi7VDjKq8wLqXSnDt0Sns25pXpug39Dpyde5lO
	 lyds1vnnVE3TLHq5672tHiEsuLd6oDAbUYB04ubeHyL0wvTLfb+1uJl5ppfWngUMv7
	 FhxlfWf7Wr/QbP6w/pUHCKkh1XK2V2yj6EDczX9yFj0r298E0/88MpojQeq0YBdBNW
	 qm24U4yt7KYKkSwTVipyed/8sj6B+a9X6HXkUS1CMOCfgcSjTVVtJZa7ZkRlVReJWA
	 G8w1g8D3lFoaZIfSx1ArTxfqvUJPx3+U2c/O1qySKw00nsC5q4r/MnKOOU8pYsra/L
	 t787qdXwCLvzg==
Message-ID: <sashiko-outbox-164429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Revert "PCI: layerscape: Change default error
 response behavior"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeff Barnes" <jeffbarnes@linux.microsoft.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20261008173641.199142-1-jeffbarnes@linux.microsoft.com>
References: <20261008173641.199142-1-jeffbarnes@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 17:38:53 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This reverts commit 84d897d69938
> ("PCI: layerscape: Change default error response behavior").
>=20
> The Layerscape PCIe driver programs the DesignWare
> AMBA_ERROR_RESPONSE_DEFAULT register at offset 0x8d0 with 0x9401.
>=20
> For AXI, the documented default with AMBA_ERROR_RESPONSE_GLOBAL cleared
> returns OKAY with all-ones data for errors on non-posted requests.
> Setting AMBA_ERROR_RESPONSE_GLOBAL causes an AXI error response instead,
> with AMBA_ERROR_RESPONSE_MAP selecting SLVERR or DECERR for individual
> PCIe completion errors.
>=20
> The value 0x9401 sets AMBA_ERROR_RESPONSE_GLOBAL and maps Unsupported
> Request, Completer Abort, and Completion Timeout to SLVERR.
>=20
> [ ... ]
> Fixes: 84d897d69938 ("PCI: layerscape: Change default error response beha=
vior")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008173641.1991=
42-1-jeffbarnes@linux.microsoft.com?part=3D1

