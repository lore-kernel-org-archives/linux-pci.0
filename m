Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E99364059
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486179; cv=none; b=Hu5BoKg/rzqTJhar4mRouqJHfXXeieknxLpRVzKUF0+o5RTO2D/Rf9KVPHEKyomEf1K506oMGIxxvMW51vTMf5TeylcUeiZ5pIWoQkEj9mzHBbknrBuotex4DVFTcQVXrMnopi6uaNlR0ZrmabHrkvQGDM5QcvpiVrYOaxqbFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486179; c=relaxed/simple;
	bh=fJ/bt4C4Zc9ftgFwJOrzcDR/dnFQOjBBrU+rLmM5HBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mGhHm57HkBJUtetH83t1BFivpPP+EDq1knD5TzndQfKnjrzBwECy1XJOYDZ8UdznGx5zr8KuiiGvJYdbGZyo9W74LnEZz+OqCg8ssvDYDZ+tJy7rOOjPgeNXH4FlNnDajaNNkDYt5cak5emWIMIbmMU8V0zRtnxi0s3j10ZKF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDMve+Wb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDMve+Wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2841F000E9;
	Fri, 26 Jun 2026 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486174;
	bh=N1w4bIbLaNSgDww/70KVqlDecYIaWEvn3WGOogUNS+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDMve+WbFv2UcXEjuTyeGtayMKKO38N4O95FveMPHDTjGvUDQ+yfzVXxvrSVQYKOf
	 dUa1Y8fSXfQB1d3udcR4B3HPK7N9Me5OiD9JFYIRgZs04Ux0P5I4erPSXqw/FSq6Vc
	 kHSio/YVl2vqEP9aYJ5dx/HX7a4mHKPq87elcKprIeNt98vc7A/HqSstRPoilHfFx3
	 /HPN3/lpPRpipBlEE8xM9kpL4E8iv7jAoPv5EQPfpDDoNM6EL6rAA+/3TW6jn/xVfv
	 MIAEFl0wkAXKnLP0lOEAaYubDApTH+MuoMH1syqdDx+tTYtVBa0IXU9fhIMRFQ1ft9
	 Mk4k/385/8Jqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/20] rust: io: add copying methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260626-io_projection-v5-19-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-19-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:02:53 +0000
Message-Id: <20260626150254.5C2841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> One feature that was lost from the old `dma_read!` and `dma_write!` when
> moving to `io_read!` and `io_write!` was the ability to read/write a large
> structs. However, the semantics was unclear to begin with, as there was no
> guarantee about their atomicity even for structs that were small enough to
> fit in u32. Re-introduce the capability in the form of copying methods.
>=20
>     dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
>     dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)
>=20
> Model these semantics after memcpy so user has clear expectation of lack =
of
> atomicity. As an additional benefit of this change, this now works for MM=
IO
> as well by mapping them to `memcpy_{from,to}io`.
>=20
> For slices which is DST so the `copy_read` and `copy_write` API above can=
't
> work, add `copy_from_slice` and `copy_to_slice` to copy from/to normal
> memory.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D19

