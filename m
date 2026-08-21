Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753BB29CE9
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341893; cv=none; b=b6awOvRBcVdNQ3r/5XKaOFkSeLSGZMH0N/sX3IIqg8A8tLAdOgaA6JliGvOoAwfIp7968rIi02XL6ULnS2ExzGdhR2KqigtL4XrHuI22LRWGJYWz3dHgKwX0+Z8nlWdIj4JQxFyddKsOA3wCYRvKOaBEuFJqNfc4gBLIUIKSIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341893; c=relaxed/simple;
	bh=QnNl4Sis84qKpEKLr155nAQ+mFHJ/9yyT8ckUimXXeo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DemGbY0jBerlJUVGFGcD7cULPT5trnZgA28iiX8b6QunZscwo5V+nvmGBv1XSnz+XvJMReozufWLTekDK1SozddYi5oyniH5PwC6qq3dWzcoOTSu3j/U9TxZ4otVOJV6Asp5jA78LbDtpAxM1VJ7OBRxrHbrzL/+0qJsi4ZBbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRAvsGQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRAvsGQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058351F000E9;
	Fri, 21 Aug 2026 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341892;
	bh=QnNl4Sis84qKpEKLr155nAQ+mFHJ/9yyT8ckUimXXeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRAvsGQeFsFERsURk16IlDEeSo6WjdzegtC8Ng4EUzPpJafd/aOFzDLEASNa4vDNF
	 diTJLSKwlp/Dll0mf3IV4xhqnpud7LULp/Uv+kFI5Fj/6tLipnkqOOpahdAmRAORol
	 oZTiU5EaxcGgpXG83XEBLYu4jWxwvwvtHqruhNC3MGHBSTKwpalRGyKayzE3XOntZ5
	 4OGUu7Jo7XSggOgRvGQ/WFTkqLq6OffTRPQftllGOUIdH0ekxzEgo6jgxbFKVigHm7
	 ePryYdRQINtvOXhf6p5VhOoq4ApiTIxgkGzXmwEbTgIO12cocQSlgx2ZKupS31G1rN
	 gT9Z2QQ83HPgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/18] PCI/P2PDMA: Add KUnit coverage for the ACS P2P
 routing walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-16-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-16-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:51:31 +0000
Message-Id: <20260821195132.058351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> calc_map_type_and_dist() must apply Request controls to the client-side
> divergence port and Completion controls to the provider-side port. Pure
> helper tests cannot verify that topology assignment.
>=20
> Build a nested fake PCIe switch fabric and exercise the full walk. Cover
> direct routing, Request and Completion redirects, Egress Control outcomes,
> and the asymmetric provider-RR/client-CR configuration. Also verify that
> redirect bits below the divergence do not affect the direct path and an A=
CS
> Violation without a redirect is rejected.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D16

