Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B238C2AA;
	Thu,  2 Jul 2026 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027744; cv=none; b=d97NsifW4foFugM2PJ1vihzIG9XrmKt74ne+vKJAqPJBVBCpKBGRz/G/EXipLSWK+WNPL2HkBwcleRMrRNeRZ7RyxEfRjyf1sPPotajD1mP2ocOFLW28qJRNwUNEAD/9WegtVNrpg2HlgfOmHPqHzV5lr5xBhwuqlvt9aDUvYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027744; c=relaxed/simple;
	bh=OURZqhzVCE1Cu4RwoJCMG1I24IxW+4oEBuyUV3erHaM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nw7Wmhu7UiFX/32qwbFvaMt1/qXoCVJ8DZc/W+r3wk8lQ8bsC95XlMsmezFEGJWKL72cIQV8gGMuZfUMDy3xfRBv3JPdhbsOg6wivvu9bXbYAYIi7+6mV2J6UAhASiwQ2vp6FfQgtz4qv2nxPXoZ2rFSInWmyl+gwq5btnqkNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9NE77kp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9NE77kp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4431F000E9;
	Thu,  2 Jul 2026 21:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027743;
	bh=OURZqhzVCE1Cu4RwoJCMG1I24IxW+4oEBuyUV3erHaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U9NE77kpdyaNBsPA6sK+rElM6kUavGYie5xz1ZdPQUTQyQfVzFMiYw5cmW0+3tbJb
	 7ZJa/SkNsu6vDrwQ9ldLnpyQv5rqo+tV5jSrVP4wBl2enDUkwvsbeWVYlMX2RaV/qK
	 G8gDR5te0YeUUGONCG/srI5P8XBZCLdd9/hI3cX9pDCcuSjcmlhMvCMqyEgZeoxpIT
	 iNfND7Yth1n+Isol+FX9atgBoT3etUvNsJLWxmI4Ip6S5OAT+o3ki2bREmyWzZD3H3
	 /Nq+bQORgklFitdS+EL8o58zDqfm81CuD+oM1FsrHyrNdAaIiabBrW9yEG2TOEIUl5
	 EU2dVKyQNQthQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] dmaengine: dw-edma: Add helper
 dw_(edma|hdma)_v0_core_ch_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org
In-Reply-To: <20260702-edma_ll-v3-5-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-5-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:29:02 +0000
Message-Id: <20260702212903.4B4431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Move the channel-enable logic into a new helper function,
> dw_(edma|hdma)_v0_core_ch_enable(), in preparation for supporting dynamic
> link entry additions.
>=20
> No functional changes.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D5

