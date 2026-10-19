Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2033939C
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392877; cv=none; b=Da6+zbeoIQQP8uX1Tg4Sdb57gURBGC5Un9w66vAoorasite4JLaMQrSkPEhC+C3CqADg8WGiQ9A69OQaCbqhT+cKgi2CS4YIRXmfSSCknEi6F7SQp1pvcz1g/jldWuQbwZV58RJb7qRHVrBOXBR83Cj1fuxRLwMArSVgzIqK2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392877; c=relaxed/simple;
	bh=6h0co11HwniKcqjzjl+cAWCaYAxekq/c8b7HHzzMra8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qoKP1lq5G5vkfwUiXYF0RcpiMNBucx38FSENuGZ2IpXQzoUgd3S/XsXs/E1sPH5lpbu04yOH3FwgvLeK5gYK0KVnAlsL7E1q8ikQNWbYm/i1w0rqZoJApBuX+0eJ4CkorcZEU6KnNcKkAt/zY/nZqRgoKW+m1xWFQJsccFSbCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM+t/JwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM+t/JwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E521F000C4;
	Mon, 19 Oct 2026 06:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392876;
	bh=6h0co11HwniKcqjzjl+cAWCaYAxekq/c8b7HHzzMra8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HM+t/JwU3FjWvBLXMqWGLT98aa89KBZIjScHOqntYUJsNGxF69ofzDxdcNlXoM2+u
	 rUDWCyuIUPYWX/C6MaNEirbkdbYyIzE3IU0c+nSEfnaprwdKXRfYTLefm51eUT75/D
	 uNfKAdLkX9Z+qf/h/AwAstByzlKjvyqiPJDgFJmAipuez0RXP8O/l0auWQSO5+IpBZ
	 sFZRZd5tpufLKZrfVRx++6H7knKpEYvx2UY6/ugcTTVVGuXksS8W8UlzF6KG94ygl+
	 wjVw9fVc1RB6CJuCh+DRWIPe1k2BpmpZBchjmIYGj+QTUvtae0OSG/z+ZYg2MMyrDd
	 Z9KLBT0aRENFA==
Message-ID: <sashiko-outbox-176709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/14] PCI: rzg3s-host: Drop read-modify-write
 approach for the R/W1C registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-7-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-7-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:54:35 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The AXI registers PCI_PINTRCVIS and PCI_PINTRCVIS_MSI are R/W1C. According
> to the RZ/G3S HW manual, Rev. 1.30, R/W1C means "it can be cleared to 0b =
by
> writing 1b. Writing 0b does not change anything."
>=20
> Drop the read-modify-write approach and make use of this hardware
> capability. This avoids clearing unwanted interrupts.
>=20
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D6

