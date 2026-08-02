Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B03BADAA
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685880; cv=none; b=egOMO0VJ8ErQV7ANTX+9p1lFYtTrrvLj0l5LGt56jk430UZ2hcoAdvAcXl8oQnrWypi37QIbwiWXje/mbJzuCN4yeLFPmBkIHpacaKBIMzeaifKyw7/tXNkpDLhso/QhIPxgju7RFb6p/0Zgps31Vy8FWgmAuzu05xA0fGANF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685880; c=relaxed/simple;
	bh=kox2ZFUThpx7XVt7lzesLW3vPsqEK+ltDNFEZerifFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ndzpXVYub4O3wwWZl7VleW0U/16Qq5JCkvmTvdkiX673TBTtXDYWWRWk72BhHlpCfGujYa8qLb+/pNwY/nvozRb8LQkhD0zSt00uD0q2tmt9vjMvzFxnPVvSJUSWpeb+FYed5HRGSorYrlS7JjCLi0X8K8JBgdad8nuXAXnnEqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5dxhXvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5dxhXvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3850A1F000E9;
	Sun,  2 Aug 2026 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785685879;
	bh=kox2ZFUThpx7XVt7lzesLW3vPsqEK+ltDNFEZerifFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E5dxhXvVfD9akvm1/U0xIB8ZsVNGWoE8+BxagyLiRTNjEKYkKvIHUY47z8bDx73+R
	 GLnqGFbUq+oi2B1c1bFB237wgXmLhymSJgrxoTdgDAe0ws+CbxK7n+GTztXOTz2sdr
	 l3XQe4veYP+u1ig6UP0fpzaTkEp5F/u+kvqKOeeuVcEsRioLc4arvq6835YdA0gtgo
	 FUfaV+BTBzuq59up63BHuWHulGka3d0rEe0CQF05K7kOsJmnNRdE10NAHX8rADA+7j
	 J6xuTGuIiqOUHo5gmbQHU+/Qd+FeSsehCKG3bOexfDItaaX4P6m8SnDs1M77wZroO0
	 13fVJY3JQ2oag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] PCI/P2PDMA: Document ACS egress control handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-9-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-9-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:51:18 +0000
Message-Id: <20260802155119.3850A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Document the ACS P2P Egress Control outcomes used by P2PDMA: a clear
> target vector bit permits direct routing, a set bit with Request Redirect
> enabled sends the request upstream, and a set bit with Request Redirect
> disabled causes an ACS Violation that P2PDMA rejects.
>=20
> Also record that pci=3Ddisable_acs_redir=3D clears P2P Request Redirect,
> Completion Redirect, and Egress Control.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D9

