Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37AC37DEBF;
	Mon, 31 Aug 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215074; cv=none; b=fWuRjzv8VzkUOKFiNNq5sQj5ihgSVjJBhUEEzW31abkQTugG8d5j7rU/u4KCXuj14nE8lvWdlt4werwsDesUILkP2LpRCjRWUiXeGl9UFVRL2sB0C0dBbyKtf/56jyw0wNb/AmhGpi1PCpb5l4sKzDA6iK2l8gmrdVYZHmmk290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215074; c=relaxed/simple;
	bh=3PVkW3pJxiYi1HgJupelmXieEvuOLNuVYCR+lJjdkS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FvPO/TwCONuLvqHMuuYKOdZ/gjiSgiO9aU7G0QojwxgSHJHldcvKZKVWWWe8eLuGxuRr2oXTb0BezA7tL//PGiXfd0bE8tFxBUkq/Y8XhE+MjE8htw4d2Mku1kAyZWyxiZ6tJiM3cbz5fmFqkFrPRAPwvGgAm446K4HHeJYoem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxvu9y+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxvu9y+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6BE1F000E9;
	Mon, 31 Aug 2026 22:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215073;
	bh=3PVkW3pJxiYi1HgJupelmXieEvuOLNuVYCR+lJjdkS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rxvu9y+cby86JhUVCWLX+Geolq4m4MnJHb/IXj39urY6JnWNtuZ1i0E7UNLwmI6i6
	 3Vwp7bnT7YpvtWicPs1QH2WIFDaKsQ0zVUjgeTujJgMFGJdzgtupbRNBC2GG3W62DL
	 oH7gKguk4OmLSdEPDHXSiHaGTfQbL27PtXnTKzEgnouS0TO3ztFVQ1BCbjP+9JDijf
	 5BbxCLkA17OyopIyynglf9rN3O7Cxk6nxr6NO3EKA12pPXYpITx9nkkV4azkpQB2we
	 ywcR0SfX0cCmN2Ctl7xCZ6hTCSCme+QdWd12I7nQYCIg49Dss/OIhIos1n7WP9qLs0
	 BfGcbqyrN8Ppg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/12] dmaengine: switchtec-dma: make
 switchtec_dma_chans_release() void
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260831191403.207631-7-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:24:32 +0000
Message-Id: <20260831222433.0D6BE1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D6

