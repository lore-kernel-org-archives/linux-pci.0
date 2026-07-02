Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34E3845C4;
	Thu,  2 Jul 2026 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027733; cv=none; b=j7p865rQy/zxN/vBarYYOSluK1dnR0OIBXQmeoWUFJrgqNcc6ydG7fVOHsNtLjahIljdUOhOJ16U9UOJ50nTfjc3p2AxGblBah57Eo2CYwtpo1Xr9XSrtQZhraBGR+1azu476rxwrEcIvwzpZZISD1E0Lo8mXp2ehO6Sz403Nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027733; c=relaxed/simple;
	bh=7+X2doqhWXjM80DWWAoyuDa/42mAlygmgH0hFnVPZrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5w+icFfHMsRKMqr36R0MKjCA0zEEgSCf/QZOz9jIlpFuJvb3h/Nmv73eC5pK8ipO72ZUxphegZ521IogYAGMuJvQ8pHCAtFRJ/7w86Ae+SQ/vbE/07Avp8SOrl2Qe6/47JRilTwftliXZ2efuWqtgEbZqwMvaXV2W+hlg6/AFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI2ESXYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI2ESXYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A777A1F000E9;
	Thu,  2 Jul 2026 21:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027732;
	bh=7+X2doqhWXjM80DWWAoyuDa/42mAlygmgH0hFnVPZrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MI2ESXYHfWy89Z0qCIgia8xuPHYHuYMEbZ8ci/mKz104IAPKCPFN9xuslNKQvaHTc
	 3/rWorqSz7GnXiCEY7YycpUv4GTbKK9Wa+fQA6Gez9Jmpq+4LZXmBydgUnflY5jbhG
	 8Yz3mL49/opr5/XV10JS+uq/9p6TVUUpBZtUhcAXg2wshuInxmtHHPYmhvj3P7vEJi
	 L6bCo87MI08uA5Bum1mDAm3MvGoHB0OWHajsArOiyH8i9xT7xhyxySSNQ5Du7A18nq
	 2t1f4E/F3YXK+2ModguTyVdIqillk4wdSbU5fRPuS25eYNVMC5y9yzDSvOCLTtQAwu
	 mogWaEeoY6Mqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702-edma_ll-v3-4-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-4-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:28:50 +0000
Message-Id: <20260702212851.A777A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Some helper functions do not use any information from dw_edma_chunk, so
> passing a dw_edma_chan pointer directly avoids an unnecessary level of
> pointer dereferencing and simplifies data access.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D4

