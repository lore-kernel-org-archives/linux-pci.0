Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96841D11C
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948169; cv=none; b=J0jMD243DCW9irDnZqX4UuTCVrKICSyGWJaEpYQhfsTtWtNY1Nl+Etddr8eJYq6g66ln4rYT2YDwVlqNRQc0/nFY3RiDy0Offv478E/yqvH4fFnBcktjx5h7uA7bScm285JinF+Ra7aYJObJ/FqL4kNISY5MwBjvtpCTbIk1FWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948169; c=relaxed/simple;
	bh=DkR8ODVbDpqOsaHlJvLbBFWIWBIyEXd+addmLaESPGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=taqlEUYF13HL+SlbHLqT4nWC7WE56Tt9H9SP9Z0jyVBDYJgpfkTDj+FL9kJwMKHE5NEuFJWxomcKr+OsSI8FvSJ0kYUh/j9t/2+4V8771o2TDNiM94BAXdgJN08PrKLmzLF1/HZxzHY8yWid3B/pubkYo3m2a2EmTuT5NGvx1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7RX7wEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7RX7wEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B262A1F000E9;
	Wed,  5 Aug 2026 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948168;
	bh=DkR8ODVbDpqOsaHlJvLbBFWIWBIyEXd+addmLaESPGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h7RX7wEEwTRmnA+0mN4lQ+Ozdwoo/ynnox7rhtixey4PpxH013BufCGHhY3fgZD+V
	 c6KdCAHFlhFJyfqKpM3oy+4CQ7+86kpQAarOGIGk4q/Av5HkXJxZ2kNMwscFZ4c8ck
	 g50GJKY3ZPP7ToL9U6MekcV3OO+aXNBx0IxQWJBcvFii7o9HIy3lasMo4WpxoWJlhN
	 KHP2RaCiVoZusHdmG8P7X52QcNBi4yRr8u6C7KlNAe6jzuAwT6Br3ldvt/eeRdZ9lU
	 pt8zj32ZrrlMiC+0DmOZomFahQMH6zU/sxAMYKmoZfRwZa+5CpL9ieoTJMsBZUIF2D
	 sSufdYjQhjlXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/16] rust: io: support register projections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260805-typed_register-v2-3-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-3-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:42:47 +0000
Message-Id: <20260805164247.B262A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `IoLoc`s themselves just describe a projection from a region to a concrete
> register. Thus, support it in `io_project` macro too. Also, update methods
> that operate on `IoLoc` to use I/O projection.
>=20
> Documentation of `io_project!` is not expanded yet as the example works
> better when `register!` type can specify base type. `io_read!` and
> `io_write!` gains the ability to operate on registers as corollary of the
> capability of `io_project!`. Examples are not added because `read` and
> `write` is still preferrably used instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D3

