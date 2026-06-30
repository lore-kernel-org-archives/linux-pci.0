Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30720400DF1;
	Tue, 30 Jun 2026 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816767; cv=none; b=Ablw7xdy3tvpJtcaqxY8vctyUsQf6LgBJdATqlMk9NKiIBsXobbKCX0hbKsjNqJOHpcNsYxi1Ee8F8dANhiouGFzfdTbOfWqlkOPX5M/eD/iy3qtlkh6i5T+sjzyiO6tSGyeqbuMGTpRTuDTFTn8uVaxmZDhFZ01Fyniq19zapk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816767; c=relaxed/simple;
	bh=OdOIy38LjnooPWfdjrTjgq4gJyY5WXtc37T1PnA95cE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GaWekKJ9YQ8533l1I9YBVh5x9s3zdUL9gyedjhj0CZTviz19mZeNNpVQSRmZ3Ldyny/G5tWmnor6q65QFH/RLCi1Ojg67Nf497aSsrwhtTCgmR3qRqsx04HRH1DXTlaYy7MxMCBmd6ck5yS/RaOGkasiZ3Jxi9exbb6ORTDWvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK6ISfYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK6ISfYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450DF1F00A3E;
	Tue, 30 Jun 2026 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816758;
	bh=OdOIy38LjnooPWfdjrTjgq4gJyY5WXtc37T1PnA95cE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XK6ISfYiUl1W2uq3uLpcahiHG/JuDqAZ+VrDkgocVe5gaamcz82eIE2DM9eQZ1EqR
	 rC6B7r+4CmEtWcSL4B9/6Wk2+QIgxJkHLGFN7f9mWZkyHZExoGnFHgxyEXZ6oVknrF
	 Ebus2Rod+zLtSVq33vI6tw48iU+hGGJk61a4CyJKulONFgoPplihBhtvPrgYuoq1PW
	 h6Cf/mQmuJV+pmj1rSgDEZri1GrsGHQNW2DMaHpzh7XXQ5aTzKpYPdGKl3OyV8WfMM
	 9ltNwW2WE2pwOBSVN3S0TyQynqGiAd9zLJOFnZmrhOrwBKY61W5K9jrZ7efay414dq
	 Bs0EdySVu/r6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/8] pinctrl: cs42l43: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260630102804.413563-4-herve.codina@bootlin.com>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
 <20260630102804.413563-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:52:37 +0000
Message-Id: <20260630105238.450DF1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode->dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630102804.4135=
63-1-herve.codina@bootlin.com?part=3D3

