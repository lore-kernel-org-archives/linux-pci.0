Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3B530DF0;
	Thu,  1 Oct 2026 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869063; cv=none; b=Be71iC0gMTf+xS0ksPVhTc/hUr0CRYwkKQA9AXgG1QP0GBaCFz8ldGFP8hbCoRpdTBwbIttQisvAQ3qt933tqjuqzuAyclEG1rdY81y0vbjD3yqNMiB+xX2slpOlZoiyXYpcp9X3VWtNRfHDkgypF3IOATEBzlQm0WEKxrzBtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869063; c=relaxed/simple;
	bh=SRJCKrM4BwX6GcRWBLCdTQ71h2JrYLAD4CRtmGA/Okk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G1lfd4gJcfFEG+ZCEvhadHlGX4hSCBzxXJ0Z8HevEB3LJ1KA1UiGnakV+b6Mby7ljfNSo/eI0X8DXGVouM60s+TXcIBgLAAFUpUFaC7KTBJJW46qVHsNmiZZXxiv74gqKZ60hZEhpaf2Rd/j2BeUikf3kF6PchK/X1Z20S4dK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fItB1hAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fItB1hAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDC61F000FF;
	Thu,  1 Oct 2026 15:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869061;
	bh=SRJCKrM4BwX6GcRWBLCdTQ71h2JrYLAD4CRtmGA/Okk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fItB1hARx/HtlF2lih/iGexB7xJkAEvXJlrHugbz7tiDp3EN8Cyx2SJ/DTKlcUIQG
	 NBeWBdI6mklLntrSF8zSbUGsml/eLcJtOyjaRPNCfaipfK0+Y8RrysW2q+v7TAgNKm
	 yRtn4rYUYlzs4ks6xJ9ZlZdX98pOlYLEY/M7IMyLSLHDU3YcowGcyXRPrLtaq7cWDW
	 8VgqKkNzftboKRwNzqdK9vfCqCkL63ii6TXWfFgZNOX5uOudtjhvL4g8PMNsqtutkO
	 b54ycveSBZ5ggqp5M8VW5ZpLL8It12cGMI1/3mA09bILDNJYD1hzLWtaCng9WsmTy5
	 LA1WZrw2RJY0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Revert "PCI: layerscape: Change default error
 response behavior"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeff Barnes" <jeffbarnes@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
References: <0FEA6868-5A7C-4955-9FBB-BE9A1AE8D3F7@getmailspring.com>
 <20261001153323.1965074-1-jeffbarnes@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:37:40 +0000
Message-Id: <20261001153741.0CDC61F000FF@smtp.kernel.org>
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
> failed non-posted PCIe transaction does not become a fatal AXI error.
>=20
> Fixes: 84d897d69938 ("PCI: layerscape: Change default error response beha=
vior")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001153323.1965=
074-1-jeffbarnes@linux.microsoft.com?part=3D1

