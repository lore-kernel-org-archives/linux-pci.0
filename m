Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6F389106
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282200; cv=none; b=fpD15fVawivR14Mhw/NPTivgeUw/Ezoq95zm/C570GCDhbSQwBX+mqiBTTWHz3vya8iqIygfOBhb8e7GU5xUJWQITWZCAYH2cfq/EL8bWMNcdSwaCcO0SfmUA9GRhA6O7cBzJYhq/1mo5OmBPSDEUiPhHNyqFllvOusZ7Rutsqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282200; c=relaxed/simple;
	bh=8IobpCD/J1G/fW29mTH47TNvdFsAfiuggZHz1+f4p3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cFSLxQkEIR0fl7kjCYHOffC3oFF5U884kSTMPh51BT2biJZ9IgGhwT4J+MrPUVK0PT+xZJv35zLD7BZn2FPU6JhU8QVfwFC3HFaO7iaq8zMbosZ2aMV18e6mC8/SV+/oP7tI721AYPJco90iQmhTdgPSzwKon0tX2m1mZP42CGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgH0zZhD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgH0zZhD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855141F000E9;
	Tue,  1 Sep 2026 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282198;
	bh=8IobpCD/J1G/fW29mTH47TNvdFsAfiuggZHz1+f4p3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZgH0zZhD8zDktf2I8703f9cHLnCdOowmejS5JeKNwMVrrGWJVzdPN1N+saNemJkHh
	 HKNsDXvGD2+ZhCwCQhXvIBQddLEyTwQ2VXZAwR20wLQO3YMart3JJsh4WLzpu0VrxP
	 Qh1Fhsma4S+1OrrZ+dOmkTftjmhwMXBeDK/PNnzwGfyaAvt96W3oZ1CE1nZi5nS+YN
	 lqnYNw8knvba5u61FTCrLrfFZJNJJOZQ3hwpYAmMyaCSlAgfj8t91y7I2DEia6FY4h
	 2p1TKKw5kCBb7A7fDorCckF/H3DL+hbrnVOxl1keowLR4dKZkXAgHlFCo7hLXqsx4C
	 CIVmITImZqFuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/16] rust: io: register: remove `Register` trait
 and cleanup macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260901-typed_register-v4-15-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-15-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:03:18 +0000
Message-Id: <20260901170318.855141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> With the removal of relative registers, there are only two type of
> registers left, fixed register and register arrays. There is not much
> benefit in having a common super trait for them anymore, thus remove it,
> and cleanup the macro rules associated with it.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D15

