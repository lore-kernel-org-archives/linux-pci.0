Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187430146C
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715478; cv=none; b=RMxb0ZXtOTaV/w6R8UOUGnbhLqhKdS7Os/Sei4jiA5E7gB5i6jGmHIMqvHbdFzm/vEuD2DB+N4ozrQCC4J/YjaA12DcNHQ+4eMPqQI5k85eC+RLjxZbCvx5JGX6cvruec1ujfZmlrAQFAtpFP1OtIRZPFdpzGNLHlHK6uEX8Lgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715478; c=relaxed/simple;
	bh=6WyFanqSOxi7Yw14XHz7lIf1PcNufpDzMfXTBk1cvkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fJDTiK2CSZcj0Qki4vHsd5Wjw7WBQ1CccucRrHwKlJTAsvLfLjoj6BaRLTcvUlzrQ/Bz2yr6RaiMx9K84EBxnw9AlBXHOR8m+pi+w5jRTledLqS+FTbXXkO/iu7T9SpLniBo3SwcFk6UmoElqBdryYexx3SjKY1GHv8a0scZDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aydkz+Rf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aydkz+Rf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F27C1F000E9;
	Fri, 14 Aug 2026 13:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715472;
	bh=6WyFanqSOxi7Yw14XHz7lIf1PcNufpDzMfXTBk1cvkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aydkz+RftdIL2EKte+Zeg2d3ozStKcK6CH8V9fv7ZaZvHTEIGfM43AkEZp78z4sKw
	 3WcvL5haK9k9OFmn/2OKtnlfQEH7pQMaqKHNW2m+RG+Sp7V/Ia5GaS35M94tMdEeyM
	 lrGd098pMEnMRUoPz8We2KCf7NVWaBhdWYj/zItzN0KfLo5jxeO/wliJb0WjeKN1D3
	 slnKG08rF6ltWn1DesMu7cifJ5g7G0q4I0QcF5vHzY6rcwvGo7eZmWDPXaCysy5oZj
	 9omF08CLa4Af2Mm/nexrdMMNxuSFvzFCqyWO8GiSIbqFS8cyp2lTVtXR9a0PvvqRSM
	 XVMofs29z/Jyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: xgene: Fix device node reference leak in
 xgene_pcie_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814134118.1387742-1-ruoyuw560@gmail.com>
References: <20260814134118.1387742-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:51:12 +0000
Message-Id: <20260814135112.6F27C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> xgene_pcie_probe() takes an extra reference to the platform device's OF
> node and stores it in port->node. The driver never drops the reference,
> so every probe attempt that reaches this point leaks it, including when
> CSR mapping or a later initialization step fails.
>=20
> The platform device already holds the node reference, and port->node is
> only dereferenced synchronously by xgene_pcie_setup() before probe
> returns. Store the borrowed pointer instead of taking another reference.
>=20
> This issue was found by a static analysis checker and confirmed by
> manual source review.
>=20
> Fixes: 5f6b6ccdbe1c ("PCI: xgene: Add APM X-Gene PCIe driver")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814134118.1387=
742-1-ruoyuw560@gmail.com?part=3D1

