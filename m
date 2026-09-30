Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D8D489899
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764591; cv=none; b=e3g9uEDe4AKmQZeSimy9mRdYwzgzdSUclqz2jyzwtOucxuw9W440aS98hs4jQgya+sHDifrw8sqbTHqg2x8kdLWlxIJRni8vHqpsmjYQU1bGHZTF3tqnok08bRzj/Ap84gWljjNlsptf3tLKns1fT/HOWAJvukZOYSKx5xOmEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764591; c=relaxed/simple;
	bh=bo7TGvqeMHJ7pzFe7okha7/gu0XKDHrLwwXXPYtYgJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BylwjPNf1UvoKGpZnu3rtymRrXCaTq/wCduo8+V5gdX352+N6gUcQ4U0h02sSo1XiavrqLtmYapJmNjsfgdeKJIqFQI/mQB7f+rg6thoc34f36v6B2qkliWZZm0lVQbzzBQEg6APXDFXCro0qe16xL72CSTRMOEuWxuv7+UPaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF4B0W1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF4B0W1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD96F1F00899;
	Wed, 30 Sep 2026 10:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764589;
	bh=bo7TGvqeMHJ7pzFe7okha7/gu0XKDHrLwwXXPYtYgJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KF4B0W1U4/duF5fywFk1hnXaoQS9wGyDhg48yCPXxTZOTaGEnv6QEEZXt/0udvMVw
	 3gxrkBbmg9mRGB6m13H87ohfZ57fIKpuCj1KwTCFlVvazyMODrhRlCyMJtAGCHyK/D
	 vAvLNvOjpGq8gTF1mS38Daap0iXc+bQzKugplAJALS25vC6v3rPNPnhgXIP7IGGLMk
	 +eh6wf+Wt8IW4FOE5V09cp39Ey+vgn1kvr3e/AxXpWDki4n2KWwAyvkCYCO3CyFy8z
	 R2m49IeOMwhNN5LG3fESWbT4TUhNLzw1itsj9GSwAAFemD/6Zy66SW2tc/OaU8Cc/H
	 xb4ZsbUgu/xGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] rust: pci: add typed SR-IOV PF registration
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net
In-Reply-To: <9fa15232fb869a562973454d9d21a5287b3da080.1790759932.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <9fa15232fb869a562973454d9d21a5287b3da080.1790759932.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:36:29 +0000
Message-Id: <20260930103629.AD96F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Rust PF and VF drivers bind to separate PCI devices and may reside
> in different modules. A VF driver that calls PF operations needs
> typed access to the data exposed by the PF driver. This data must
> remain valid until VF driver removal completes.
>=20
> Add `VfRegistration` to register a pinned Rust object in the PF's
> driver data. Add accessors for VF drivers to borrow this object after
> checking the requested Rust type. During registration teardown,
> disable SR-IOV and wait for VF remove callbacks to finish before
> dropping the object.
>=20
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790705494.gi=
t.zhiw@nvidia.com?part=3D7

