Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C19446C17
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448140; cv=none; b=SUkfEn0yhMBeOxl9QOasQQaaCEu5OHjI/L1UsDKJBB24bsVugL6jDqJjLRGpUG+XYoHPrC8/SRGFvMC5KC0xneZEDhB+rYHzZRS949XUAPJiA+3DDJ9Y3ZpTLutJ3ghINMpfXJbVzS1/yX8Bsn6c1Le+A7jdXnvGpFHKQF8jgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448140; c=relaxed/simple;
	bh=fMjqvT0MIeo5eD2rjhx6p7fZE/+Nd8HamjEOYPFPAEQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kKVXV8EZwlBOXT6MvS1VEZTAIpbFtQXlUr6g99Uzrw1wD6addj6nHc9hvOEhNhGVIayceq/Drf2VEA0aEjiiZDpChK0Rm8jIyHkcq8KEJ2C7NCcCdnqI7UTbD8F8pZhgM3y2GLNmWwCTbx0AS6yEDgxpEuDVNnECQjfA8qbKmVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJsxYUXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJsxYUXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F69C1F000FF;
	Thu,  8 Oct 2026 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791448139;
	bh=Uh9gNHxoZ392DKyUxjjzBF57SiYlnzQ/G7RRAL9IeSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kJsxYUXUr0MOgBHJeff03/+cGErmPXIdXiKYTdmn9lRqLSGUqw9mBkynXW2ZYUgct
	 R4XVyyjCX7M5v7aTXmY9AH/K/T8nsYJBvHzYeMJsF/rJsN/+QuG7HX+TaKQxAfBzsf
	 Fp+mkyRdvlLgwr9L338HZGLxoPrDxlG9fv1SuTvkntEA9tAdcbmonpNgsNv51pbzyf
	 R+qeY1MERAwiX+nCIV2qg155y1aUQwaKPE8aAWc4T7j/sOKZFj71tdmaN5mN9v+WFe
	 2k9dsdXDGZKc8y+8OA0F/vQkw2g6JfISRVrueNQ5gBZi4xxh7UyDx9juhcOi27GXHT
	 9VSj8Gny6/kTg==
Message-ID: <sashiko-outbox-163840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy devices created by pwrctrl
 core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1791446700-100166-1-git-send-email-shawn.lin@rock-chips.com>
References: <1791446700-100166-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:28:58 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_pwrctrl_create_device() only creates platform devices for OF nodes
> that pci_pwrctrl_is_required() accepts, but pci_pwrctrl_destroy_device()
> unregisters the platform device of every available child node without
> that check.
>=20
> Nodes under a PCI host controller that are not pwrctrl devices may have
> been populated by another mechanism.  Destroying them here would tear
> down devices owned by other code.
>=20
> Mirror the check done at creation time so that only devices created by
> the pwrctrl core are removed.
>=20
> Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl de=
vices")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1791446700-100166-1=
-git-send-email-shawn.lin@rock-chips.com?part=3D1

