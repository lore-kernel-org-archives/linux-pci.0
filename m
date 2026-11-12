Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494098;
	b=lU9zhVawpJVYyBNH9ajcUL6fNgZACnTxE8xqSwyish5D0S4874c6ZoCz1+y2y2m7uGvi
	 NjEDiXXmV+G0oVKkx72ZPFWGFjifsMzyRHKo7JENZv1mtV6e9S2fZqglX48hPyLRGSLjl
	 vAdOg0z2Dook6lKzMFYIiV99AR1G0tgySAqEn7bABOln0FKosmlL4iSOUjYLFAdottjpy
	 y0YChYPLE9pbK+tHUkB3aSk/XGOFcAveKWy8tOuxcGaOzPemam6lmc3feNNNVvRoj630S
	 +8dxwvhE3NYpKP1bqdwGvLPa9RblIqoS1Y1ufTDfcfVVaVUz5iDtDzsO3UNHQyNbkQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494098;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=okB6vl/1TDzisI9DFyez22xC0rlSnWh4wi66jyHWIt0=;
	b=nR8vhM6RjeQF7dY8ftkybFXjR2EWPb25jtl4lPUe2qw6pL9DorhNwKNObMh1X+yR75Nl
	 FQ8Rvnj/h6g8Lb/nyDi25+QwooJDON/dhwKjN8gnb7PTT+bN1/j7wISDleexiqZockCUt
	 n7qtsdWtHr4Hmd4ZzJxyk6IuU5v76vSBGln54amqlbHpI2oyKyU5BRmQjNOwmU1CnRHjQ
	 FBsAHyulSBM7V2In80xTgXwBubeh4LN4UDHidof4pkDTOIJqoQ/aeOhNEIrjSl95P5uV0
	 as1O/sdDlrlvt7ra3mGuexfevREa9C5cg4S7VCcN8X44VOS2AHaNQHxNzrGRhOB9CuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tm0o16bp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D54606A321
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tm0o16bp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA2B1F00A05;
	Thu, 12 Nov 2026 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494098;
	bh=okB6vl/1TDzisI9DFyez22xC0rlSnWh4wi66jyHWIt0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Tm0o16bpLUtUxxricVY1uKniHCDjuc/mnG+uQC3VciTkwJpUJEoVyhAjlsols0eU2
	 rLY08nyDHlSpwK0m+zx6/L/oMeAz4aejhU7FZI1WIQ9K3gpJOvFAeA5p1eZX5l3Wz/
	 2oh0MagCquUBsPnCHG0nIH1qIZH5QU1Ul6AznEVcmUthYc0qV3lNCRdrpqMu0GWPdU
	 i+ePp3DQNMhlIMhUfIFlbIjYx3mYyiHYHrvpwpLBmn8DraWTE9uWfcBa9lvtrmOgM2
	 gIxlZ1yiLfrMp/VzgkGQmGT3AGyqGKo8I9qW9rCpRrqip1d3euCzGNGrC+hfErsx/x
	 zAwAXPgfHd1Uw==
Message-ID: <sashiko-outbox-211345@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 06/20] vfio/pci: Use access ops for BAR and ROM
 accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-7-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-7-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:34:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Recovery needs to wait for hardware reads and writes to finish before
> changing device state. Use access ops for individual MMIO and PIO
> reads and writes, covering BAR, VGA, port-I/O and ioeventfd accesses.
> Keep copies to and from userspace outside SRCU.
>=20
> For ROM reads, keep mapping, reading into the buffer and unmapping within
> one SRCU read-side section. Copy the buffered data to userspace afterward.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D6

