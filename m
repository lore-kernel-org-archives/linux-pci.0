Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7536EA88
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815683; cv=none; b=mJiQTgrfoDX7Y8BU254pvjvo+p4GAVkxQP951Q6bv/5HfE5LKqxI+mbGTk600lNNP8HWxsKFjnxRSh3qB/7P1/kgX+lUTLgvLYO6bSdz+bksQUyIVxJm9gAgE8Gb7Jveed56gnVjifkErbijHpUbOYKKhYIbGRasCiFpK93q1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815683; c=relaxed/simple;
	bh=flZb3gsHy0EahwOfkTw558HlBlNKViepaUVp36Jv6Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lqARBo8lWkmyj5SLpiLW/DKNLeJRUO6+YisZhUBgospY84UJA/sRZgrIxY/dSDd7Fs52JKvd5aHnkeGpVm/JURgsaZlM6rh8UYhrbD9t97VjY76XqUzM3oWEsjRMhGHhdsce+VvV6dHS+nG0+OekLfHT1tuduQsvPDOeMY2tr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxSAIg2n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxSAIg2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5381F000E9;
	Tue,  4 Aug 2026 03:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785815681;
	bh=flZb3gsHy0EahwOfkTw558HlBlNKViepaUVp36Jv6Pw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DxSAIg2n5tm2PQOyyx/nLNHM3wpMrd9QDBQ2jDAIK0HoBzQfCFfJFNN1qq9gHprnn
	 vaDAMuynS2VMa+RkUiA/PQdNT3+aJiE9NclEk0XPi8MJJ/gieJREduzvRso+2Gj/RG
	 RgiSPCuBjHQlM0gTn3g+sCrkypRbAxANAMTWc4Qn1xWGVfxrgxAmWTbaUW5NcpnQFF
	 fDTcAfvWdnHFpKdYGI6F0We+9aTm01/WixcTojkk5AIYA0bzrjO2wE5i1xzZOyA1zJ
	 TLsjMKkpZIgidstE+/9xPqFGpOpXino+t7ROkXOsF392mwHtWheHqgm5dvGiRuiHD0
	 c3l1OV00jH+pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260804033855.2115817-7-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:54:41 +0000
Message-Id: <20260804035441.AF5381F000E9@smtp.kernel.org>
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
> resources carry hardware channel selectors and refer to linked-list
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804033855.2115=
817-1-den@valinux.co.jp?part=3D6

