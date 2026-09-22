Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD3531623;
	Tue, 22 Sep 2026 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066497; cv=none; b=PnzgoprH8msnvbHnPc8CqAeW6ikLaGP1QOThZFYGBBsns5OOxTjgeFCKlHlGc8DazblUBRUQd6lJCljSj5tTvWppUZsv+m7cwArdXqKdsI3+5oV0qAYgLRE89zWyyKgRe7fa3bpda8ZW9K36ewmX/JyKktefSvUAi/Obh6e9jaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066497; c=relaxed/simple;
	bh=9nrKyx71jo0nsXO9SsOd6gb58mN+Qu0PZxUXTeqjToQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uKecHhBXzz13kDqer+2EGoTyaaiG3ZQzxTmI3QWE6RQKY+kzd0Z4a5MGduzFzx7jBOTGS60gcKxTb/tLN357R8HNpXJdlV2jTSix8fP++f3jYmhxv2tlnBViEwzYWZWMzU+4wYeAjKnsHZ4VMwYLbjrXe2S13KpUkcQ0C/99Qag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGV31TIX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGV31TIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AAC1F000FF;
	Tue, 22 Sep 2026 08:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066496;
	bh=9nrKyx71jo0nsXO9SsOd6gb58mN+Qu0PZxUXTeqjToQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HGV31TIXcho+jPf5tbnVqbLnlwu5HLJCs/ITDAZR/nlMdVLJhLapqmn+tZW5S8auu
	 MXhjQ5YJ+o6Z97RiomGOosDxIRlx/fKQxDl+xzBTtgdLL4HP+s3jbOl0n3R/Auikw5
	 dyLg7uuqwI3Ai4v0rHPJjHuUHUP+RlierCEgxsVuL2l1hPHR/b+T/ShuDcY5ZRwdps
	 ZaPFH2VVrst1ymJOUA4cT5HcVhrM8Y1E4KrtBXpo2FCJitEGEqaTez0vw7Xri8qAjw
	 NYVyPl206ZqAU4etRs1fEmqDoZDdoBB6aANgXJH/GIkefd/NGQV1pkIGz9kxqF/MoY
	 iSWwVC1YiN55g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/15] cxl: Drop stale decoder interleave limit
 comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260922083924.2451158-2-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:41:35 +0000
Message-Id: <20260922084135.E5AAC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL 2.0 added 16-way memory interleaving, making the comment that the
> specification supports only 8-way interleaving stale. Remove the comment
> without changing CXL_DECODER_MAX_INTERLEAVE.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hla=
ptop/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D1

