Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515FF19D07A
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485538; cv=none; b=ZCe6R7qik327R6/rD/Cz8Z86cf3KSGKI5xbBqPLLdxK/Q9dj9mFZsOp35QoqmBQZN/TjvJCUDAD+J+6NBz9/tbjMCZgjIgmO0O7cVAamB3Nht2Og6OFF7HWrSYbMY2y+/lLzjuDqoWpVlOZFEwpFC9x6uPZ+5IJWalLv0RPJhDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485538; c=relaxed/simple;
	bh=NbT9jLawGsGqePH+jW3ahHXLyZeNZZ2Wf+s/u3aLdGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XnibcOB9zxQKqmrla2OGjnbs5S9+TPIwqXOCtp1ZCeV2VTD1Nxsfz+svHkG4EvwYuF8Sbt1dq6Ic6Gsp68C6+v7m1rU06D2W4t2C45YNUay2MKT0fnDjiALhjfEtUjOilLTIozoCeKDbZ3schxrVqsJy40lTdXL+BxV3kgeT8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMstkal4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMstkal4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F611F00A3A;
	Fri, 26 Jun 2026 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485536;
	bh=NbT9jLawGsGqePH+jW3ahHXLyZeNZZ2Wf+s/u3aLdGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMstkal4tm3OkH2dTlTy1acp0I//ocSPp5sJ/yg/O108J98yQuuIXTQkUc3dKOO3y
	 hwci/Kbt6G4s+ZD0/Cvje6LdjIq9ni0PlyQ96p0X0coQ04ZbKJSCdA5ql5ToYPGB6v
	 amp4FEOycAw1KjReQaL9d3MnhqfBnVG6HGVc3Dr4ey/gkvbOTog1kyrNttdXVuoe3Y
	 cEKoN/+/KudAxo43zzm3izQFYqoVq9SvDDYlmKIQAAlGa21znncQwJmhvmWdLgqKcY
	 OT4W8sO0KXzSE89o6tCp2J7HITOVMYcIfAWvGBGU3l7/hT22QF0hJb0AIDPM7OBhQh
	 cdbR3wN4YNuPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/20] pwm: th1520: remove unnecessary `deref`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260626-io_projection-v5-10-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-10-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:52:16 +0000
Message-Id: <20260626145216.A2F611F00A3A@smtp.kernel.org>
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
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D10

