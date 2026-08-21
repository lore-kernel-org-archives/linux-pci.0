Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD6375ADE
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341451; cv=none; b=p68WeLXNHxg6xBS9s5GGe9Tn5usN3dbR9EgYUDa3VF6wV6nF0QeQ4/a+XzxvTqt/QyeR931CBtwAv5GNMJpUSDy4SLUXSo+YnrqUvIYeG1fPo7uh6pkSU4xhwKpM8OII8B+/tQWd06RlUUbizokb+IwrCtF+u9x7XkQqIVdtNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341451; c=relaxed/simple;
	bh=Y0srATQ/ozsPQAbvWQizoSj0QormzjdsHv+wejLbe/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=clP4cHj9tiBMFmj17f33zbXxhhEQjR9J+FUudLTaUxHqAdlzqSqYjT3H/0Yk3J18ac4vwPcpSIRlwLBqK2u9IbC6kFH/Vjf7u1yuCX57IrYXOEoDp3fN7sH9gdEoNN+QXbDZON6qJft77tP8qktac5ffCWJzk82nLn3aZTToA5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsDHbucB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsDHbucB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAC41F000E9;
	Fri, 21 Aug 2026 19:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341450;
	bh=Y0srATQ/ozsPQAbvWQizoSj0QormzjdsHv+wejLbe/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OsDHbucBKarN2cCfFpE5MrupJfInR2U4gwAH2a9IVjlHlO0sr0aOCMxrVofK2ySAD
	 vhM/O56FjipRcaNlFNhprzhwLluQqF0xlRuvD97PgZDnoaaJkcnh7jL8rtkX8HxJLU
	 o8qw3sxY+7O9Fw5pPzbFmaBBlXRQCG8LKlluXvRNtSQbVtHLFQjV+oorNIvkmk1++B
	 bbQK7PG33QxC6WyD++szrU835nXNEQtpvU6LjFGi9KyFeIJLc+qhv6b0zP6FPnK0Wc
	 TWvr/ApFfCIUuCe8a8uxTQs3r0gAL6bMfcll4Drl5kVLffMQVZGXHSAUnCEhtehXV9
	 q9nJpAACJV1Dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/18] PCI/P2PDMA: Document ACS egress control
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-13-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-13-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:44:09 +0000
Message-Id: <20260821194410.5DAC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> ACS controls are directional and affect only a peer-versus-upstream routi=
ng
> decision, but the P2PDMA documentation describes them as path-wide. This
> can make valid asymmetric or nested configurations appear unsupported.
>=20
> Document the fixed transaction roles and the two ports at the path
> divergence. Request Redirect and Egress Control apply on the client-side
> port, while Completion Redirect applies on the provider-side port. Contro=
ls
> below the divergence cannot change traffic whose only route is upstream.
>=20
> Distinguish redirects, which establish a host route, from ACS Violations
> and unreadable routing state, which must be rejected.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D13

