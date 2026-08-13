Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF942C4F8;
	Thu, 13 Aug 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603539; cv=none; b=RN0UdZLiMZ+b+C1KHafeDAXwN/L0K1DQM4x1Dz8SQrAQh3LZiHwsKnCODj3C8VCsOHn9ezAhg7Nybxn3M4DpIUnrKTAO5asDWJML5mSNEc9+VpEZxNVTKo3Dt31ofjm8xcr9qHlf09yUoCSMaloyGOkZt/zu1L06sEB9nXqcZTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603539; c=relaxed/simple;
	bh=7NfdtbgYPFv3dwj6T//tAs42t4niH2jJe+mVY94/jBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U2qW54v1bwLexPQvLTpFKH3Z9Cg5hzDysU01Jgj4zHSW23a/RhtUBc7X09075w8F1sphsoFm6DRVy5UAl3MlNlT4YgwPPkqhFdJv0/l1U0qNsXGdaib4FIaN7mEr+Ie45FLmJMs9D8mXMi/i5A59LL5Ud++EuXaYDLcOJ5YXFJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIpEus1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIpEus1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54081F000E9;
	Thu, 13 Aug 2026 06:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603535;
	bh=7NfdtbgYPFv3dwj6T//tAs42t4niH2jJe+mVY94/jBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIpEus1glOet5OX7yUlhTUk0COpRoUoLIEvuPlbbc8GsYY3r10u8D30T72NnNi1WJ
	 0Jr0XThfAGrSoW18nHhfi8yWVM3lriijlu0A8rr8G/+3EgnZzY/oPay46BGs3cQw6Q
	 P5AzfYTTUosUehC/mGY17MbkALk7J5In/EsRGLXDrWxIVlJCTz8EJC93n1oEZk6dmh
	 vU1Mvy8dO3os+HBGe44FJqvmO+MV7dhbGuibLlRAZ35emtCYmxT9RifcpjsjJnWtdD
	 mYSHIY0vzJLBVEEwVhzvEERhNN5z2/YNaiton0ZfEm6sgiu+Q0sWsDFDQeGPxlq4ko
	 pLpdKrlLK5gZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260813063757.3131865-8-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:45:35 +0000
Message-Id: <20260813064535.B54081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Expose the DesignWare endpoint-integrated eDMA register window, logical
> DMA channels, and linked-list descriptor memories through the EPC
> auxiliary resource API. This lets endpoint functions decide which
> channels to publish to the host.
>=20
> When the DMA register window is already visible through a reserved BAR
> region, report its BAR and offset. Otherwise report it as a normal
> physical resource so an endpoint function can map it. DMA channel
> resources carry hardware channel selectors, identify the corresponding
> local DMA engine device and static channel ID, and refer to linked-list
> descriptor memory by ID.
>=20
> Expose DMA controller and channel resources only after the local DW eDMA
> provider has been registered, and only expose channels whose linked-list
> descriptor memory is available. The interrupt-emulation doorbell remains
> reported when the local DW eDMA provider is registered and its offset is
> valid, even if linked-list resources are unavailable. DWC non-LL exposure
> needs a metadata ABI and host parser extension, so leave it unsupported
> for now. Reject VF auxiliary resource queries because the
> RC-programmable DWC eDMA/HDMA register window is assigned to a PF BAR
> only.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063757.3131=
865-1-den@valinux.co.jp?part=3D7

