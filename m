Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69023D9DC3
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764521; cv=none; b=C1OdV3pX/49TTnl2lAcA8ewSH9pz0TpYC/CR5WZURcsxV3iCKrD6OmFzOTf/sb815Z9nSrKFhmYFz+om3JLWC+jQGOwurBk1ADhqJdvSohpxRQ0/tnfQ1Gxyc39F0xm8KAB7RSgT4hr8EyD4r9K0OnVb3IAGxR3yhAzU0JX6CIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764521; c=relaxed/simple;
	bh=FZ7rko6ox3o4E5Ss2oLXJP/WCGALTqpkma+OC1bDPqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JCawyJBNkkvEHVNQGtpdMTXvFedRdMBpvIuJponRZ6MbpjsKtsj40Ryly/ejprXJp9Q4ZfDPzT+A/0lpVWFTB2PeGMqadBBURR3Bc3bVpoErPYhqRYE0XR8pVFlMxVvZBtCz1aK+pDxmdr0IVRm5lSN688f+057K8rjzDS0OZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjOc1Ynv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjOc1Ynv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9304C1F000FF;
	Wed, 30 Sep 2026 10:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764516;
	bh=FZ7rko6ox3o4E5Ss2oLXJP/WCGALTqpkma+OC1bDPqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjOc1YnvhqsiYyQz3G64a4SZcICpdJ2kLrj7nYAuUvKsLtd9sfrZQUI8L876SzzsN
	 jeia11iNYDqos0T1C0hfp6qP3gmUgNEDkiX3I8sJuP8vHv3doDeM1aJfC49ozsAsGU
	 d3gXEjZiFbqb248omPnaebwvsLemATkfcE0/TB+kvZO2ZziQsqmeM7voxfTFTrA2xc
	 d7J1q3nMFMU9DIRiuLWW62HwyoSB3cgB/WJCihZ34ytCPGgkaoeZZSZvpKBWgnkzfu
	 rNzjzCV1MQYRLUyyi1r+rEnbPBhFfy7j5aQHJFokBRDBIaSghZNcDeq6rNPWvrhjOT
	 Y8dlJEzyccVOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] rust: pci: drop driver data before remove
 returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, gary@garyguo.net, linux-pci@vger.kernel.org
In-Reply-To: <26765341363d67dbec03c238aca0ba027a3a9258.1790759932.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <26765341363d67dbec03c238aca0ba027a3a9258.1790759932.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:35:16 +0000
Message-Id: <20260930103516.9304C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Drop PCI private data before the remove callback returns, so its
> destructors run within PCI core's removal context.
>=20
> Call unbind while private data remains installed, then take and release
> the data. Taking it clears drvdata, so post_unbind does not release it
> again. All borrows must end before the data is removed.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790705494.gi=
t.zhiw@nvidia.com?part=3D6

