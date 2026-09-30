Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1B48A2A9
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764663; cv=none; b=NG6wNkxwauPlyrwUY3M1OxH/Us1sFWoQDMuOcUqZUbEfW8Xw90qbv2Wc0g/yDSIU0N1IZEcUmpUjgiYh4L6ODFnfHs1xw4NvLI1Px8OXD+svGyUzfp+0IsQAyVzUireaoylWgueFEdjxU5PRQhMMc49+ugP2vKz85Lxaa59zIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764663; c=relaxed/simple;
	bh=oTnqTYamczklmWkWqoDLkSL5CpYEvsjOXsxpAwqGX8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LTGH5Rf2FWW4tV58rDh9rhS7VaZARK8FXwxNy1rOICmDKvffcEGEzThBrjeTQoU/zP1vJWSnsKzWwth87FUBkFIEy88SwN7Z7LkEdcq5n6Jp2APHuSeNVFlUIq/BecnsVdb5WElvbKPyeWYJsXsF9POexnLWkaeH4DYN2fahW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+b1SnM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+b1SnM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474711F000FF;
	Wed, 30 Sep 2026 10:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764661;
	bh=oTnqTYamczklmWkWqoDLkSL5CpYEvsjOXsxpAwqGX8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e+b1SnM6sam8D0ML75qhG7GN1h78JIxCs5Tmhofu7VnhISUBeVy7dSFx6jr2Pdf5l
	 gP3ezBCCfnEpEQOt+m67SxIBf9msTUDjEjbNaRCtKNY9IEGQqu5uM8Bu6pYduEmzCn
	 yegGWQyDf926lKcJN/sXfVH/r1ecXYZqnVjXg77o8tMNDmjAc9sw5sryKLTdhrW85J
	 /6rQmqpB4g28iSESsPYMHa6taK5DPQqav3j8kxJ+z/ktcK8/jSTlM1dweDG6czuh6e
	 ZYmnB0DFdoS1f7EcWyNsHLS59fP79GKgAV3bknebh1J1qdRrvqW4jkRaJhJc1ptqRx
	 FHsMb6Gqdn1cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] rust: pci: add SR-IOV enable and disable
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: gary@garyguo.net, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <d3eb461be2a07e82ae69dac8855b687a2094c20e.1790759932.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <d3eb461be2a07e82ae69dac8855b687a2094c20e.1790759932.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:37:40 +0000
Message-Id: <20260930103741.474711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Peter Colberg <peter@colberg.org>
>=20
> Allow Rust PCI drivers to configure SR-IOV through sriov_numvfs.
> Split the C configure callback into sriov_enable() and sriov_disable(),
> passing pinned driver data and a token for the requested operation.
> Require drivers to implement both callbacks together.
>=20
> Return the enabled guard's VF count on success and disarm its rollback.
> On a disable request, verify that the driver has removed all VFs before
> reporting success. VfRegistration handles VF removal during PF teardown;
> these callbacks only handle explicit configuration requests.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790705494.gi=
t.zhiw@nvidia.com?part=3D9

