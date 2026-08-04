Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D845E331ECC;
	Tue,  4 Aug 2026 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873618; cv=none; b=qxOkMQTvk2MH6/tJbw/lNjvcKhZPMN87LYHj9l3uOySz9Fs95TXsRv4OXjYZCDlrILFLqRxcf8Q1vDbNotZTorrjwPmnTtl6l/Ncz11ws5iCU8FX4TBn7Y+jnqLaRd5KJmV+Piq84wPFzsmzBZQ4l7CSbPqbfIat6Y8oro/7v+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873618; c=relaxed/simple;
	bh=WUSlNXsDoYTPaVsXDXO4Q0sLrWz0WsIwfn5T6g9aMJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hjeIgWGHCerYDkfc4M7/DeKGu+QAnI6AAmLTJ9id6PNZaJt/AS3BTBjNO6viSFKxnUU9i73ioYkObBY1fiz9m9uphdwM+kgDYLGe2ir3PmCmGNudXSbT1vstRlwttS1iOyo5KC8vVeH9mES21JhV1v/rAMgawRE/zFTrHFFoiI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xfv/QyzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xfv/QyzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519391F000E9;
	Tue,  4 Aug 2026 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873617;
	bh=WUSlNXsDoYTPaVsXDXO4Q0sLrWz0WsIwfn5T6g9aMJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xfv/QyzQDAe9l36RJAyfCdWJ/EZoCbR5B+b27lRb665mvWH9g7ib0CN0P338dWlnZ
	 TiJ8Pdq/TQ6cvFMTi141AuF4lSEaU5EcMofA9fft0c3OcnSOtrHA5DmjA5i4pbKN8V
	 ZTpmz/Fs42Jwic0Ozh5C/wkdiJjCd74VNm1Th1QyDimBHSRh0/sGwWyxSoPLyfmejl
	 NjUUIzek6EzYzPL94zJ12VTBfRhEL2XsJK3sqfgdbU1Oxh++e2lqIABgLbd1wMDZTx
	 V3zejiUfFfX8I6GvuIkVjpPrnkxGBgx31nxau/Xun6ZGvpp5pE9F9/xwvu+plRTjb5
	 i+coMsdfL9/nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/12] PCI/CXL: Expose CXL Reset as a PCI reset
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260804192958.1823952-11-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:00:16 +0000
Message-Id: <20260804200017.519391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the CXL Reset helper to the PCI reset-method table so userspace can
> select it through the existing reset_method ABI.
>=20
> Advertise the method for Type 2 CXL devices that report CXL Reset
> support in the CXL Device DVSEC and pass the function-scope check. Reset
> execution requires cached HDM decoder state for the target so affected
> ranges can be validated and HDM programming can be restored. If that
> state is unavailable at reset time, return -ENOTTY so PCI can try the
> next reset method.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D10

