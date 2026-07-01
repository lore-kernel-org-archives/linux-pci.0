Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C55E56A
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937391; cv=none; b=UWZ2FWz/kSK+nz1ex/QkaOqmiHsTA/ZWropC1f0yMZYaFTGvUbPVyfxTd4+fNnIo4Qr5VrbBQ3HgBczdjS37w+myUenODYmFJFMG7CsAxJQoTL5GsTuBgf/fKDWL+b4bIgf8ED3FEyWXZCnX9NgZ8ETQBp6lrDHZutd/dcaZclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937391; c=relaxed/simple;
	bh=l0MbCq5Ag6y5Ty4pbQ6u9eyUbPK8/iUaV2dAiHRf42M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+ZrG0q2FdGn55RyecBVVHHRGbYLIb3p4Uf662qDHS3tx0GcVO7fjTLg4ke6FfDWsHcw/pinD4fnRVDmkV+kM0btUe4h6vrt8yReFbqmXiLrxERHICgxfsaLCL1Q73uCVXu7NHrYpq1X628KzopJy4m0djBpqDQXvJzIKSY8ktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXF5iRCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXF5iRCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4C71F000E9;
	Wed,  1 Jul 2026 20:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782937390;
	bh=l0MbCq5Ag6y5Ty4pbQ6u9eyUbPK8/iUaV2dAiHRf42M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXF5iRCegBo1fjuuwLZuHT79PTGXP43SJVSB0eNqR+Z2POaNFM7dqkRqlwz2YR3Os
	 gNxdFVACbpMkkNiQu7u/7rhFBUXGcAR8QODRvl/baAsHPvTygZYg0vP+lOaHOOZ0m/
	 fWajK3Wq+/GRQPylpGCjI5CgNsFaq5oO18ZHIancenLNBPY4gxFVDNLkfaoNRV5zbu
	 Hr2fjM7P1vTU9MHjBOeXWzw+rGV73BKA0cqSJ53glKe0Fgurr/1Fnc2qKWtH1KVT4d
	 8y67e6XkC22vVWuRL+1Uz+PQtb3ivs860idTPKdkLJ6jf7lkX0Z9kppGYsiJIVONfl
	 TkJgwCXTP/kSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC RESEND 6/7] i3c: mipi-i3c-hci: Factor out
 i3c_hci_sysdev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260701201533.220818-7-adrian.hunter@intel.com>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
 <20260701201533.220818-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:23:09 +0000
Message-Id: <20260701202309.AA4C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The MIPI I3C HCI driver needs to identify the underlying system device
> used for DMA mapping and PM operations. The logic for determining that
> device is currently embedded in the DMA implementation.
>=20
> Factor this code out into i3c_hci_sysdev() so it can be shared by other
> parts of the driver and keep the device-selection logic in one place.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701201533.2208=
18-1-adrian.hunter@intel.com?part=3D6

