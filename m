Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075233F377
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199069; cv=none; b=doldSc23Kou+8anHsamFrrzspAYAwCx4I7LXy5R6EgLwIIiIR35bdD60392bIdyDybCSKhCJvTS969AjL5HKSafIJo8qlmnM0uo/hbr5Opq69ZyzuuUCnRXKX/KmZBOF9V33xNXsFEKZIZv3AF6i7cRMykeJETlXu8l74dUVPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199069; c=relaxed/simple;
	bh=D3wtnpbbGlx7KMSYmBphPEdhLc2D/VXWZwWPFr8KSMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ibJLPGD8vsLtTg7giv9FpHoTm5sgtT8irOGPiIx9p6gqDBNW28JGfww5wI4kbsPoChu8hsU9ao499f9r4JcMNKiyME3dntPXo1LeXhj0Bux8hQupqB9pA4ASiG2cr8GcyhzKa2paCOhHh3CFH0mSWP9sbjipyXXtuscsf6Rj+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzY9zR4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzY9zR4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6121F00893;
	Thu, 11 Jun 2026 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199068;
	bh=D3wtnpbbGlx7KMSYmBphPEdhLc2D/VXWZwWPFr8KSMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DzY9zR4BlsFfgvZrdY10kgT0VmgxOKWT67Evq+bl2vpVHRZ7XQ3+4WcDVhe5OI4Jb
	 xkGpFHiQ0rPSDwWp2oxOBjCM6jG9ZD2Wr6SRytt2D/QJqHBREGf1g6jy8XjgdCf4yU
	 zCoOCuVTcNRPHS0gKTGNayRONIGp3AADnZ0RRfKR+QGqy2MQBac51Bqu5Sdjz8pvO4
	 CPi3VTKyBeInohual6yujrYfoxVz0X2heDF7jS3YFqJt9YTzqaH+q0Vtyt+ksr1rek
	 xkdL3ViyQ8KXp0dh4XhYrcq4YrzW06JDHbHRO4Y/w+Zes2rTs3aEDXoR95REp1mYAz
	 IF6WAvZk2rviQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/20] rust: io: implement `Mmio` as view type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:31:07 +0000
Message-Id: <20260611173108.5F6121F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement `Mmio` as view type and convert `RelaxedMmio` to view type as
> well. I/O implementations of `MmioOwned` are changed to delegate to the
> `Mmio` view type.
>=20
> All existing users of `MmioOwned` in the documentation which do not
> actually reflect the owning semantics is converted.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D7

