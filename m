Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA43C1405;
	Wed,  8 Jul 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536553; cv=none; b=mSoy3nZPvph6G4Xcs6NqSXq8Z6YbjDLxGpNjvxy4w7+n60xDRpX6SKukuwmnR2WdeM/Eu7dA4o1t6aca/zQQDTE6bBP9FWVfG1q0UQ/XSL0XVEpSk5utAqmf+kKTRTd9YSSgHN5ly3x4Q+wfXL/EOu+aNwCdaITL7L1s4+r1eTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536553; c=relaxed/simple;
	bh=1hBVCW0Ljj9X4HeljrRIvLOjBDTsLPlzXXsGGbxTyIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zo2zYO1FzAwOE4rjfd/kVn3YDMAJ5Dnl+dM64FouJsZp14ummeC2Ww2TDeJYhsfNFLW5fMuShUriuzzGbAvjKUGNC8hlAZLmejtC6p7gCjifvdYGRsciyf0Ptt3Ho15etE6yScoMARb9um6H+K5RwS6Mm11CgBaYVKEtRJPr5OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+blREBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+blREBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9126C1F000E9;
	Wed,  8 Jul 2026 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536551;
	bh=1hBVCW0Ljj9X4HeljrRIvLOjBDTsLPlzXXsGGbxTyIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W+blREBpTeOfGFYmzWFbpQFYK172bZJda+UtHjxHpIghWw5EmuifNSq1eb1NSO7QI
	 zt67ccd73bO6brcQH6fLlgilvSRRRpM9cYbXCb5nJYIO2t1rGx5K5uKBDdPnkgu3mk
	 3jVn6TAZaKyY5OLFeiMv+0ju4aMFArkRmgf4DENFRksvfXxnbZ2AryPj3ExmcH1QZI
	 EIWZcPOmIp7TXH/WvIaLS63n3x7YgLdGUszTDWo4wQZ7lr38lHM4BeMBX/KSXzSwTv
	 yV+hZuOacab1mbifZZbkYSy3t5oX3NhBlxQqJ3Vw6TgIlYtPd2gkGg3ZE/E3TACBNW
	 CJw9Q0ssJibnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] dmaengine: dw-edma: Add non_ll_start()
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org
In-Reply-To: <20260708-edma_ll-v4-7-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-7-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:49:11 +0000
Message-Id: <20260708184911.9126C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Add a non_ll_start() callback and move the common non-linked-list channel
> handling into the EDMA core so it can be shared by both the EDMA and HDMA.
> Prepare for the upcoming reorganization of the burst and chunk structures.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D7

