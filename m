Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C52D47E9
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784243289; cv=none; b=dZefWYwwyURhIqP3T+zMsOYdfsxox6wcDqkToMK8DF3AeaUlY7yMzPIN6fXNAwqFizqRJmFXz3A6RaL6BX/QOU1kWKMLwSUlYUsqMRNwM0uQODB0E+Fp4g1vjvJwVclCw1rUV11IlpUvCKYH0XlwwCTOr1rQXGJzIjQoBstpMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784243289; c=relaxed/simple;
	bh=/L3/0jZpBhAgr54Jp8wzoPetN1oMZfYChEW5Vden4wM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g8uZE68vXzKtATjpPYIHA2v5IeaW+jLFMZSXQ1b7qHHVbJVdpX7f1P9CEMftE5OlPUTVpW2Jd41/InMFCLQfBJnvuViWr+Z3j735dIcK9wX+0pjEJntzN78DPUJPBpvKD7a9qcudK3XwJeRaYdEMYUKlc/PJrJDnZojS0+9LS1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWJI70wv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWJI70wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1C01F000E9;
	Thu, 16 Jul 2026 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784243288;
	bh=/L3/0jZpBhAgr54Jp8wzoPetN1oMZfYChEW5Vden4wM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eWJI70wvB1JqwFIy4Qr2akRU1HEBTTqQxo0tbq4vE8yXQTGyLcGAH2PMhO7HCmJt4
	 Df094spS0lxMJ7CUmYfbgwB6jorVcuhDGFnTT2CWG1G04RjJ8WgP3x4baRK9gW5HTS
	 hGkygoSCuFUlg9OCQH1SThajvb9EQ2463QfXIbZHWVZymRp4YvmVja5ImRrJVx3jtr
	 AFkeUbiwSqVv71pKsW6V7EE0thTKTaP2zhYacLG7VwNQL9Ba6JivLcVUOQ/w2eN0oN
	 ypVLLQ+S2XyMMlrQLE7iMLuDnsI/LRt8g50B0KX+DXZY496KZsJskFIY1T1fxTJ6R8
	 ND+99VI230CFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] wifi: rtw89: pci: enable 36-bit DMA on spacemit
 K3
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anirudh Srinivasan" <asrinivasan@oss.tenstorrent.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260716-rtw89-spacemit-k3-v2-2-392b577ebf75@oss.tenstorrent.com>
References: <20260716-rtw89-spacemit-k3-v2-0-392b577ebf75@oss.tenstorrent.com>
 <20260716-rtw89-spacemit-k3-v2-2-392b577ebf75@oss.tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 23:08:07 +0000
Message-Id: <20260716230807.CB1C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Spacemit K3 Pico ITX Board has a RTL8852BE pcie card behind a PCIe
> root port, but the SoC doesn't have any 32 bit DMA addreseses which the
> rtw89 seems to use by default. Enable 36 bit DMA ability that the driver
> has when this particular root port is detected so that the driver can
> probe on this SoC.
>=20
> Tested-by: Aurelien Jarno <aurelien@aurel32.net>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-rtw89-spac=
emit-k3-v2-0-392b577ebf75@oss.tenstorrent.com?part=3D2

