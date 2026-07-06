Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74EE3DDAE3
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342768; cv=none; b=FfUqSdGXs++ow6M5Al65O/76TB809HRgkw7OwkIVsyvZhz2fgeVZ5ju+OLAbsggGfFpM2q5MPB6aeKxgqZUfvJYPl2Mi+hKlqqAVxgj0dSoYMOBOj+B7M3kAN4gveCeR3GI3B2VYyoa9aU3Yv84bJWajXwdFGo4l2T7MOWcjUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342768; c=relaxed/simple;
	bh=oggRVS2rgIQ9ABXYY+afSkwOSL7t1/1fYeYp25SWOM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mitd84+GIdm5x1Po2N5XlGYlsBKgctQ7/UdE36D5eJq5gNWRBFo82n1A4s5PCFF/C8t/AhXjVmeJiv/KUYEGkedB0W4iYb6hXGHWHpuE/nhO3eATEWyxw0No1NFxDRk3pPAm0GPCWheIp7GWxyFM9COlo1e9YWXYqgwqQYn/sHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwLM4TU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwLM4TU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B511F000E9;
	Mon,  6 Jul 2026 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342767;
	bh=oggRVS2rgIQ9ABXYY+afSkwOSL7t1/1fYeYp25SWOM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JwLM4TU84CVQpv1ggZ5AtcOXtRbJXTEJr2P06XjvrrRMcbWyODJWorTR4a+wsdfr1
	 I4dRSaeFBNMpeTjF/FVEwuH1LVYXXSPYrVbujG/OMFxNTlQIro7LFi1vMg9lkw2c5J
	 RhiM23qkvFTP6O4vSBNwFuA5acONkjXgkBirvDqXxpCvfLiUav3d7rRoqiZNp6YxKU
	 UGSDq54vznEIW4DQZV6ABDpjSvZIW/qtOgyTL95ZhpSamNOy8jYLXNPMXdUpBeFTz9
	 z3FgBZ6ZgUq/OLTrbKE7vSXDVL2vD/i73tZFQHg89Glfmwds/pw34WXMQQ0agd35n6
	 o36UmYznEcSNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 20/20] rust: io: implement `IoSysMap`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-20-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-20-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:59:26 +0000
Message-Id: <20260706125927.14B511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add an enum as sum type for `Mmio` and `SysMem`. This serves similar
> purpose of `iosys_map`. Thanks to Rust's type system, all of projection a=
nd
> struct read/write can be handled by the generic I/O projection mechanism
> (i.e. `io_project!`, `io_read!, `io_write!`) for free, and there is no ne=
ed
> to provide things like `iosys_map_rd_field` or `iosys_map_wr_field`. An
> enum type also makes it very easy to construct or destruct.
>=20
> This could be made more generic by implementing on a general purpose sum
> type like `Either`; however this is kept specific unless a need arises th=
at
> warrants this to be generic over other I/O backends.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D20

