Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493792;
	b=YnKuGIjwl9Z6+xSNGdZMEl8+KYQj/Zr89agI9LQW0/aQXWCiTmyV0yUrgAO+L7AWK26v
	 +HpLCuvsyv0Fjyz42ADBRrHmSXCXGWtFtA1ayqDg3yw/Y0N8PDstoflo3HXFHzToyX3ov
	 Hzqc7ZP8ZbF+/tDZ+ttgI8GjfuXrECyN2aIFM3hkfSWUakMSz1xoNb3Tbj+nmIxjxN2VN
	 WVxvfMrMwBSRlvtxqt+0kWNjTBxCxzPHNNNW2QBfqdDyKyb9/+FDDDkY7IwOFjvl1rdCS
	 APBsavX4KkJwV8UCUNXhwPH8UbZvx9zsdq4Fz6R54y090PSJkqy2kl0zya6hsc/RkuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7kR+Aeq4nxZcdmK/GYx+dDRwHwRGnpW89gIGiC/TqVI=;
	b=SKbGvuZ/tFQJiPCsZ7ff56PYaXQv1Fl+Z3/Vdunk0moP5uab3caH+saDfTmdS+0Drq7Q
	 xUTUBaWiA1VYsLIniarpk1+oVjcr2RzLEdinSbW+v/DNveyfro3hWeIIUTrxzCOtthjnt
	 HU3w/X2COCsjdoAOyqBon7oUJdp10mZc95fd4IRqC5SEzfLt07xkX+JfJHg5DC/tKz6ss
	 eF8MmqiV7zljW+56SFIZqT6rkllkbNYxCCrauVdDq5hgEYCu6CCTV33SXxVgY+NRmYBM2
	 2wuOL51IN2xfR5niAuGZKrKQ6dbFnlz9tgsYMlT3NQ9z/b4A1XXoM0SfbFCc7coiddA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fo/hVUDZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A113606B096
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fo/hVUDZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378DA1F00A06;
	Thu, 12 Nov 2026 14:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493792;
	bh=7kR+Aeq4nxZcdmK/GYx+dDRwHwRGnpW89gIGiC/TqVI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Fo/hVUDZNhSrONK1J9uYlGO23+4vFvr73trOT545Pzruy04CQDOxacNwsQlFppNLD
	 8xYBIhEfrZ3mklAylrqesc9ZI4fr+Y8kYmlxk1CIbVF5MLXV3uOMIagQdpQgE5jCMV
	 5HD9XC1nIzjm754cKqTGl4kIj8xbTJvAS5EFF9Vd3cG646uJRDICCNIKonVdfUDAN5
	 d+GQU+jgvgOouINu12E42pdsr0s0Aa9EkajRq9ylV8SK+I5pmrLe4FFACuXcMl9hXm
	 kQmtCUZ5Rf9lPlPfXEt83qPCT9NBuOkFK1fS8u+kdLeGknKyoaBE2YEbSI9zIxsH8M
	 +PhyT9nALjFIw==
Message-ID: <sashiko-outbox-211322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 12/20] vfio/pci: Use access ops for DMA-BUF
 export and restoration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-13-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-13-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:29:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> DMA-BUF export can race with recovery revoking device mappings.
>=20
> Keep the range lookup, export and list insertion inside SRCU so recovery
> waits for admitted exports before revoking mappings. Keep userspace
> copies and file descriptor installation outside SRCU.
>=20
> Select ordinary mapping restoration through access ops under
> memory_lock. Skip restoration while access is blocked. Provide an
> internal helper so recovery can restore mappings before allowing access
> again. Revocation remains available while access is blocked.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D12

