Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D383DA5DA
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031119; cv=none; b=KjEScJhFwNYtq2DrZXMp65xAJVfO1rsv7iNBbLDJBBvRyY8xGwbcCXFtP7/t+4lA8MOQd/24UJldRPMqteqMELFWUQNIZrXS9EaTc3jOwnC3VSAvbM1WBcFXbTLllwFxQpNaELGkpjeqpNfmhdyX+XxywP8+wo+UVGpB0zHmiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031119; c=relaxed/simple;
	bh=GV1sdq7x4gC2/9+iZ0mAKAWXQI7nM+LrtSc2CkR7ZF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cF415GQ/cTjyWgsjUQkEriiKeUrp7gLmpOtmUQQHheV6o6pIKvfs7WBXZy2BzRmOrRzfGGfjqfNAWzGGzg/sFBcKsY1KiiitInlxzfpvOqwedZLVPPLDW3B2KArFsvZPRS/jA69ogonCOPt0FNXoCaHYIqrSG4nMo3C8YYR1pR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLpd8FPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLpd8FPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B05F1F00893;
	Thu, 10 Sep 2026 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789031118;
	bh=GV1sdq7x4gC2/9+iZ0mAKAWXQI7nM+LrtSc2CkR7ZF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bLpd8FPJRUo8G5uwh52gJrEBy42kdqhQneUkHMJ3vfXLLWY+E2WsRcVILmvBOsY7H
	 h0wWYF6juzly4l1v3FQAsxFlkJzwEUDf+qNAs1u/Cd5lnIo9FlHsYE+wwTyA92/1OW
	 1p0gI/cN/g0i8U+Vr6nvyJmy4gL8f32JVroEwXsQxYBQ1FS/wAHz60Os/mR+6+zBHt
	 xdRHNzgg0AeMtF2DDSgi2jsYlxsOCsjP4ciAEWL7k0WWnEW/i4IT3KYs3PARpI1WN0
	 QN68Z8Oh3UAXNuIdh+AYCsXWWtT7WhbJyfuSWIK9GoA74aU+vFXCoewWRkMhfozTfo
	 OBbvA2rbtG96Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 1/9] rust: alloc: add `KBox::into_non_null`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, gary@garyguo.net, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260910-unique-ref-v21-1-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-1-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:05:17 +0000
Message-Id: <20260910090518.1B05F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
>=20
> Assisted-by: LLM
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D1

