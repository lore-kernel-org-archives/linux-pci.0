Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A623424645
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342104; cv=none; b=iE/qGhKhMCp09QsVncpebQIHg4sC9QDQRr6I3jqiL5C7nrVEcCI9KOMinB7srabk3bHg5op3AbYTX6iwBHyhf0tWvX3hcP6o8sz0xe3mqfRi8T3MvuBWDWnJxgIm4V6M29nS3gmzVl6WwdrzcTKqSixp1WdDoXMi3JTh2FQEPZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342104; c=relaxed/simple;
	bh=5TP5FKXV2QfYP4taY1l+31Qs8Zcpx4j0j6opOvtbNfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQP0vppOxqnMKmlu8KGfQS1cd+CG+Pb6cUJkByN//otAzJYuHQAlQSHshIEgTcB5u4YTHFB92X/u6csccgxf2Vb4DafhgqLAMI32KAKXY3OpEyyKmeVGxW+Ifph69dQ+rqiNsN502vAWVGtMm52JPWgTLs39KOkiL95OsVfMHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCR5/bev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCR5/bev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7793A1F000E9;
	Mon,  6 Jul 2026 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342102;
	bh=5TP5FKXV2QfYP4taY1l+31Qs8Zcpx4j0j6opOvtbNfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCR5/bevwpoNx8rvWXE4RASOYTfIJb0kfDHzopOYg0l2n6JUgts8n1zdWl32rUl0n
	 lmIpIdgxazuR4jrcyqluSiCChH7/49xKgn7bFCjOZ8abi3V/JWs47Y3EUA7XPpjNY4
	 Cv+sR2vfktlAeyvNhb4qAGqW0BXFKKTO7j8zo07fqAZr0sGXl2dCSO6dA2K9rCLZ8A
	 8eBWwBwfsW5oNJ1uivaSu8jdp2eHEkKI0qr44Ddf8VC6+791ySXff3M01RQA6376qj
	 Q8nk5UMABj27rJ8OoIzDhHLlX9V8JLktWU4tmDrCXUqkQIisUFr9kEXzNLZeEqbqeJ
	 6+raQb5AThqCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/20] pwm: th1520: remove unnecessary `deref`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-10-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-10-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:48:21 +0000
Message-Id: <20260706124822.7793A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `Deref` is automatic and should normally not be used directly.
> Also, `IoMem` is going to be implementing `Io` directly, so it will no
> longer to be implementing `Deref`.
>=20
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/to=
pic/.E2.9C.94.20Projection.20in.20dma.20bus.20address.20space/near/606672061
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D10

