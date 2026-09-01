Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173E486E53
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281945; cv=none; b=KhRQeKNzvwYQkD5en4PqvkxQ/erJWQVspXKI1uFikitklaQGrW+FBZv9yD5KmONsjAgJQekdT3qp70ZXRqMi9IQDireugnP3agjMJ7G0EOgJ/oKAqK6F8N2TqaquAfmOw4ZVGD1EfHQk1eOif2IbppPXvkMsN6ZzIT17+rSI8yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281945; c=relaxed/simple;
	bh=cchq70ZENhU1nnYN9GEBzStZcJtso6S7bxU+vicxzA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ut5lIgSFl25nsz7sIxtCwhsF1W86tWgnsecV8gUPCDqkw5/rAUWqo3OdNBDA9s2urV7MKKPkk81Fh06lq85idjE3OBMKp6MvhOPIAnO0r+p4YHTipnMtn0EondtwBrDgWnR16kcHTpNRbaytCQ/DP5A7jgnOV0rRblzywY7gPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE2l5IJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE2l5IJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B239B1F00A3D;
	Tue,  1 Sep 2026 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281943;
	bh=cchq70ZENhU1nnYN9GEBzStZcJtso6S7bxU+vicxzA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UE2l5IJSJDE8cKdqn/zyggr9wXOT+ojkCZrlX0PdFPkW4GH83rgjgzeXgPPOBGME3
	 R7JVRO7Ggx9c7/VUk9hlp2MQjdJQk8Ik24HA8VnuViIkEkOZFGbCvjdtPwORIq4Gk0
	 rRHOByANN1EysZ6EZdTUFIjVFKOug/pcLCR09xjvbNaaB5Wh0L4+9jxdFYxUiwOqp1
	 WN58WUlYDrfI1cV0jC0zDKNZuylKsaibcfmCKL6Df5zT2VdcPOWgO9lRHi6UmJ0Sh2
	 eUgmChrermENGndxsIdWM3U7tJOD4R6g5SS4x7ckMm7lxsKeaOIF5xyM0QFdeFglL5
	 rW/yMqa118r7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/16] rust: io: register: make register have a typed
 base
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260901-typed_register-v4-10-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-10-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:59:02 +0000
Message-Id: <20260901165902.B239B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Previously `register!` defined registers can be used on any untyped I/O
> regions. With all users specifying their desired register type now,
> propagate the specified type and restrict I/O access only when type
> matches.
>=20
> Also, add an `io_project!` example which is enabled by this change.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D10

