Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E840A950
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342449; cv=none; b=qYE4deTjLT3Mhvmv3maYRCkEU9Ds+n7DXk7W6J5aaO26GJ8G4huzsdrWSzvPruO7tiH9yO/KNS+sG140PH7yYkLl6KFZLCGkXJ2Vf4nyYxsk1/lJrJvFjq97LtD+s+Dbfv2yJP+lBzWufUcZaX88MEFCczDel0+TrDH96L5787w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342449; c=relaxed/simple;
	bh=oceVGSHWVJ1LVqwuIdHu/3w4DcAK6NT5oD96eQmcbi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AuyfLTaO75hR7Jqc8Mjo9OF2FRD69Tt6K7RoTSYM4nKQSi2eS+q2bfC0OKbZFYr7ctlrf0Bs4qR3qneoNa2vutyeZfiodtJM8eRs2cEMRh7lqDlN2XGWhBKq8/AOcSehOKe3tZZPvVy5CDi8MQ6p0Uf9gSqCb1YPaF2HYoCCQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXmo4dlM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXmo4dlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D41F000E9;
	Mon,  6 Jul 2026 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342448;
	bh=oceVGSHWVJ1LVqwuIdHu/3w4DcAK6NT5oD96eQmcbi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VXmo4dlMeYELXOrWrgLomiXuEU29gyY9LuoA4lCRzsOlTnWfIS8exo9VYtMqHLHnb
	 nbRBWmeAsx76PDC1Ln2vKQlQ9ZXqJXKFoUZL29McI2GQjcDAh9IuH8rRWCXxqapBPZ
	 24s4hBDEqgw18jYgGBjtK4Zrsq73Ll94P6T2VIv+xonjiTElS95JsOaxjV32YXDGcL
	 9kQrS58q122hTPxtjVeTm8LaubbFTD4BISt+nI5nUK0U7GfWboa4DnwW/4a9CnBNJH
	 F0DUja1uOlOCksNOl2VCsS/nc8Hl69PiCTNC9sQ6AAp+Njrm1vpuUVdOkT9JKjNfNM
	 U99Gfql67Li8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/20] rust: io: add dynamically-sized `Region` type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:54:07 +0000
Message-Id: <20260706125408.048D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently many I/O related structs carry a `SIZE` parameter to denote the
> minimum size of the I/O region, while they also carry a field indicating
> the actual size. Proliferation of the pattern creates a lot of duplicated
> code, and makes it hard to create typed views of I/O.
>=20
> Introduce a `Region` type that carries the `SIZE` parameter. It is a
> wrapper of `[u8]`, which makes it dynamically sized with a metadata of
> `usize`. This way, pointers to `Region` naturally carry size information.
> This type is required to be 4-byte aligned.
>=20
> Expose the minimum size information via `MIN_SIZE` constant of the
> `KnownSize` trait. Similarly, expose the minimum alignment information via
> `KnownSize::MIN_ALIGN`.
>=20
> With these changes, it is possible to add an associated type to `Io` trait
> to represent the type of I/O region. For untyped regions, this is the new=
ly
> added `Region` type. Remove `IoKnownSize` as it is no longer necessary. U=
se
> the same mechanism to indicate minimum size of PCI config spaces.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D1

