Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC035382383
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653107; cv=none; b=oqoy2hV9Qv6TYf0R8WZg/JiwjfH2IV3P1yDD4kbsDine1KJyKKY6PnWZvTzwCMr41En18TfGGdghAPrIcVfQBa1ohrH5kPlNhQZMPrMp9e3atQT9TjTMxBLCo1mNoRkE/npq2GSJ7kpFe8cjToYvfvAushsfWT/3V0alfy7wHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653107; c=relaxed/simple;
	bh=gq6vg13GJqf8zhAbZd8/FHgF5n4EzcvKVwTI9BJ6tYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CVDrF1asLEDdKB1hAvHuLCLh4O3ulwZK+fRWexEl4gYgHiRH/ioLy43Bx6DCX5jKzEqwP1C2VBULLI/BRnjf2yechLY/znl94IEKT+h2Qd7Sqq3OD8KXzi7Jzd/Jkg3Jb7mw66ehXOQPBAQGC+hXqea/12ioZ7kbVUNPqdVFi6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhPWTuXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhPWTuXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DF51F000E9;
	Tue, 21 Jul 2026 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653104;
	bh=gq6vg13GJqf8zhAbZd8/FHgF5n4EzcvKVwTI9BJ6tYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AhPWTuXYeNND83V4VMVsvxYTM4xw+276b0EEbTEmlGPsxSVrMSW2kJzpJo4Tlmwz3
	 Y25YpFoN2ARx/LHdzVKqeixvAkX16I0NbSG2jc8avWnJ4ZIoj9mq9Ai1419L/WkFNe
	 Y0kbxd1XXPqGcuvC1hb2CqJQVnTRXp711KZPvY50i3ROBl7s0uMH1vgxY7OZt2WIYd
	 uFYfO3BMP9BbEzQNBm3QVyEg6bbgJcDyHZFIr7F//xoMyym9e9qY1gRF+TJeLO0Wcv
	 HhEnY0deOo2fHTB4fQYY0YsghhU3ZbbSiV+6hptV99IQbx1G/O0EP0xmXDnAcvPdMH
	 QecgtfCVVgkXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] rust: io: register: allow explicit base type
 specification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:58:23 +0000
Message-Id: <20260721165824.16DF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently registers work for all untyped I/O regions, which is not ideal.
> It allows registers defined for device A to work for another device B and
> there is no safeguarding at all.
>=20
> All users of the `register!` macro know what type it will be operating on,
> and that type is consistent across the driver. Therefore, add a `base`
> parameter to `register!`.
>=20
> Currently this parameter is unused in the generated code; it will be used
> when all users of `register!` is converted to gain the parameter.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D1

