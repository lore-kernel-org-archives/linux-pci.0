Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29630488757
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764597; cv=none; b=Rh5hMPsPwDRYeXNHIw/v9APQzPUoqdXs8lC/uwmvXR7r5CQQVH2cdS5o6WECtHt5qrFODgflsBVFx/A1865c/GmLhu0Uc2SsGiJXvl/cpnF05ZMZLrU1kxe3fIM17aDjkgJNvIrI2mZXLDWRTliGMwjVo6myTWLU6SqmXq0xaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764597; c=relaxed/simple;
	bh=/efuUALaHa/ZPgPxKGHjyhI4dRbeafFgMi23GNDpXKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GG3Y9YjwtPO0MBGBj1DzaU5sIBFJe3vxuDi9GVxB1eBxOdrqxdxrQ17h7O4/eC/z7TCfBoBF+r0Aq3hwnsPQ31qwm7xOrvBjfMn2yizRCqa37PnAK/yq/MTNyk6Du7aDXqtOS6z6dNlc6aFlCV4XV2W/HsQgTznC6jBw04ycIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LanUb3yK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LanUb3yK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723981F000FF;
	Wed, 30 Sep 2026 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764595;
	bh=/efuUALaHa/ZPgPxKGHjyhI4dRbeafFgMi23GNDpXKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LanUb3yK/0Mo1vnBwsXwVi1ibGaX+y1GuOjxMwPkbHVgDBIYNkMtGoSbyAYxvbddd
	 UKHy8NbaPdCkhVK7c6wD+yqBvqfzhe2n1JsLcp02RRKaFnDzTY7AAnCF1+XT6zEBX/
	 dNtudSPGkO1zGpCWsM9ZC8hPHfBsSn71NChoVsTf9B6ZsZUPZVD5lKFhFrbBjLwxJn
	 VOcjZy2rJF9cq3ZpWBFrC2Z6I9jRCYQqQqBQTREHpU7S9dYQt9bKzh+J25nMFMRdO0
	 x7ZRAzxKMykKWHCdGUFd+wNpEmhFgJ3STPzcBqGHMIihEkIK5VIcGKNzvwj3qVB3Cj
	 62CossupkF0qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] rust: pci: add vtable attribute to pci::Driver
 trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: gary@garyguo.net, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <aa99201bf126e07b654f7cd5f35d0c3b5062b6bc.1790759932.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <aa99201bf126e07b654f7cd5f35d0c3b5062b6bc.1790759932.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:36:35 +0000
Message-Id: <20260930103635.723981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Peter Colberg <peter@colberg.org>
>=20
> Add the #[vtable] attribute to pci::Driver and its implementations to
> support the optional sriov_enable() and sriov_disable() callbacks
> introduced later in this series.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790705494.gi=
t.zhiw@nvidia.com?part=3D2

