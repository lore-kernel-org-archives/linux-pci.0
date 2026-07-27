Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD17338910;
	Mon, 27 Jul 2026 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176415; cv=none; b=mGbKJDY/hF+NRzFzHqiTiefpZjZZHBGBldgpYekb+NxrqHra01ZcOTEv3OzuZfFT9j/gIH/ber8FeflNWLcNL8uhK/1dS2lqpchTVBKCRzv1VDfeeZChP+p8r+3xPMwaVb7FKpmuSuQXthMhjshSPxMakhorDSd6m/t/TQWBU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176415; c=relaxed/simple;
	bh=GFezhd01ZUWhC6yTRSCZYS8ooyAfvNDFbo8Tv0Tx5+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OahbYmOpypPs6pmLHd8oBEBwZjHd2/BgEgNxpVvG7t2hkXNNzUPtcW72QjNFChSkKwGmYnd3SMRit0N90BjvtCrulXaCgXtx5iz6KIxSJHHHhKc8PxwfZc2GqPkSXuaeGvkDN9YzqaCyCtXdRbXLjzTrLdkfnS+WjOvFJWsggkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caaRn6Ik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caaRn6Ik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C271F00A3A;
	Mon, 27 Jul 2026 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176414;
	bh=GFezhd01ZUWhC6yTRSCZYS8ooyAfvNDFbo8Tv0Tx5+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=caaRn6IkzWxI3U/JUIFMeA/4SGpPiMeDuyzr4EUec5iEphT5sWGB5S9ENhmhYWVPP
	 iG/oeS5ibOhrtxk0ERdblI/zLTUVXHSGm9CcNwo9pSAB2GEO5JegXgcRPv208SgC7X
	 txsqXIyBSAa2QGj9MCUCxwC7hjpsPPYnSuzriFN1EX7fboquiN8ytpvj/BwjQK0Fyq
	 SARTRFEhzUzuaQoFtPK3w+X7Cy8AmFKiRo6sQQ2XKneYqNiOc9y0lhuw9a5jB9FCar
	 MA1m8hsmmzjKGcsYOVbVtDJtpMtJKdX4gFpZ7az3rocDkrLfuvJr8kmLH4kL7SHdPv
	 zNN31gLPtk2WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/6] dmaengine: ioat: use sysfs_emit() in per-channel
 sysfs show()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260727174837.6645-6-logang@deltatee.com>
References: <20260727174837.6645-1-logang@deltatee.com>
 <20260727174837.6645-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:20:13 +0000
Message-Id: <20260727182013.C6C271F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Convert the sprintf() calls in the per-channel sysfs attribute show()
> functions to sysfs_emit().
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727174837.6645=
-1-logang@deltatee.com?part=3D5

