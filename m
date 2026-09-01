Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D64480976
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281732; cv=none; b=IBkMii6nzma5jiaJpr+vD0SESQSq2dAWN/CDxG9QnQBQH6vEBkeeSdiOQlEKLF1v2ZFk9aog/zLDrP7Dg7CQg4pJIBtIwvjZymn9U6ymZUFv6aZD/83+ze9ouuDbwTc8deEoY+zzPmVxwrfGZGLGKBsoYKJYVmOyCO1f52O+hiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281732; c=relaxed/simple;
	bh=9gYJjWt1RaZrk3Ek06aGjK4JGzvbLvHWqNCWx85TfvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bTBpoHMyZBUIMu8Cd9msPlkgs3HILbx5a9vrwSikIGZIAQn/Ph78WlrK7LVdmKjUS8imU3CW2q/QMH+N3z9wb3W7KvnNwikgQ7g3M4De/w9eNPWDSvXS64gJD7XuB1pnvKo48ngB1I7M7PWdQeq9bWDLf8IDAlKXLglrDapqC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC7zs/B/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC7zs/B/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D831F000E9;
	Tue,  1 Sep 2026 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281730;
	bh=9gYJjWt1RaZrk3Ek06aGjK4JGzvbLvHWqNCWx85TfvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BC7zs/B/LZlPx89BEp4n3RT+MfViHOfKrR4+/QcVUo6T5wzTT0fw8ErPapABB3udZ
	 i4UYGAiEdZ1Oc3W+TfdCrlABX7vsd75h2cwTNhLkPQLREdEI3Ty829GA2920KaVaHW
	 pGSdSq5ppJ8y24+/vVnURSLo2tUPbOMn1zYyd+aeMARxo5T8c7amnQmUMxqwTJX4cH
	 qIZKZNngEdg8DBQGHAo4wDAnjjcwIowdUGUC5AenWt78kmwf+WcE9CJMSxiwg3bcoU
	 GWy53IXV/tvh9vA8drHuCv/YkU8+qGzaQ2km/I5t8eLxauJBTJH+WFT8WxQCKvW5l7
	 1woMZvbDxIFeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/16] rust: io: register: allow explicit base type
 specification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260901-typed_register-v4-6-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-6-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:55:29 +0000
Message-Id: <20260901165530.43D831F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D6

