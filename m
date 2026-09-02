Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6181C75F9;
	Wed,  2 Sep 2026 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330515; cv=none; b=KNZyu20BDH0txHSBCUAUk8E3p892M2bLidJzydIjtOwM1KMlrLRNviqw5w+iBVC7+uElP5vdqRblxDjeq34QwDe14o4/IcqEtN+nKffOkhFLK+Q1fGHPdJsysy8PuSba3ecM95qDNPz0zIqQILykgWqO7xLgC0v+x9LbFXuEL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330515; c=relaxed/simple;
	bh=KpRe33pNGnnB+T7U3pW+qBc8JO+pgaowSX1LHfPbtzo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtxffaDfmUQ8l7Qr28/y6587DMsZ9nkPRfMDkdUp0x6zXEKd+LTqhWwEWKbM0jHkfTiAFSgQ3CK7uJz3lwe2econTTuqwM4xzcJyRtG+2j1XZw29Eyvw15vaNJP8Kar0+ojj+kEV8uVDQ5IuB+GBecYQBBtF+VMs5u9fbU3g4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp+uzkvz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp+uzkvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A931C1F000E9;
	Wed,  2 Sep 2026 06:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788330514;
	bh=KpRe33pNGnnB+T7U3pW+qBc8JO+pgaowSX1LHfPbtzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xp+uzkvzeOzBsawZTI94v+VLooYvhgQ/oCgPGjlPeAkDu+3LTEx/HWohk1AuwLXDo
	 bN8erX6Duxpj8CtiUmqQHCAnnOyGn1+B4xZabbVu7xQ65DVlwysanDlmuXaGdsarwU
	 SXlgD/E4baTAaQyzKtUPrtbOnFkVAne17GVcF07u/pVs3PaUf2KKflZYwjynUc2tCH
	 rf4w3gp0Atuf1M2x7o1knr/+Bd+rajJ7VQDM4gagv9XZMtNS5PtHc91wMJgpEEzMYr
	 iN8Wl8qWA6GmPZ6iQCgPjisbWTQBsuq04Sg68XBvmYyZghPU9M4srvsj42TLm8Mgl1
	 YYu+qsofvC38A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/10] dmaengine: switchtec-dma: make
 switchtec_dma_chans_release() void
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260902062153.31048-5-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
 <20260902062153.31048-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:28:33 +0000
Message-Id: <20260902062833.A931C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> switchtec_dma_chans_release() always returned 0, and no caller
> checked it.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902062153.3104=
8-1-logang@deltatee.com?part=3D4

