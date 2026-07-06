Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E44314BA
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342318; cv=none; b=bg7/TEXgC1sNV/Jl9jEmxZHeyaTraBWazb8D2mPuml+puVBBBTYL95YZPkUlb63tOj6FQFfQLCJ/EDRYGnrYt5W2NT8yw9Ca6/xXLbYng/LRfXxk/yr+5cwlRKCCIrbSQopmRBsHG02NU4YRvyhDIX5JCYyrFKlIRR8td/d7jpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342318; c=relaxed/simple;
	bh=0Nf4KC7VkM1nFbr8or6WkWoO+AGsZ/VqZrO1mvzN4Oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bwsysfi4tc9LwGQivZhspREaFCZpfAlcHXc3yGSbbiK7Y8oUmtEj3jDPle5fZLOcs83qc8IW03EzP6fnbfr4u6Ap4xoELtdBQ6oRSilS2iCzoolbrkGLqG1YSPIl70HDHWMPERyIhdFmoCQ0QQ1szjH3he4ttjJzrxn2S8xTdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKs6DIHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKs6DIHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B451F000E9;
	Mon,  6 Jul 2026 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342316;
	bh=0Nf4KC7VkM1nFbr8or6WkWoO+AGsZ/VqZrO1mvzN4Oo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UKs6DIHwGRqnQ7hI7S/tVpfjqHbeKgKga3o9/G+A91hSgPrI2MT5Zeag1HyUpeMdk
	 5YkKkgkqb4mukz4NTQ2Ft8ZRSCnTh3ebHzq2npC7MmwKdT6mJAsUgYSzz+d3rAROLA
	 TuOwv4GkaFZbLDxNIVR7yW85DsKc7ukSZvUdy4YEhe3G48PpoDuIsbeC074Dy8TwQX
	 VjBE1XoOsBYDAmK8juKnbKjftV0SQY+7o6Nv7nJrOHQdusuESiXErw0e76hpky6hkK
	 o4u5gqCEfqpR+RdMpBsy9ImCeHHNJh3H5h9q4UW3AktzBkgt/plyg02GGpBducOCE+
	 tCgKivn55NzSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/20] rust: pci: io: make `ConfigSpace` a view
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260706-io_projection-v6-8-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-8-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:51:56 +0000
Message-Id: <20260706125156.99B451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In order to support I/O projection, we are splitting I/O types into two
> categories: owned objects and views. Owned objects have a specific type
> that is related to setting up and tearing down, while views can have their
> type changed with I/O projection.
>=20
> Things like `IoMem` or `Bar` are owned objects, which requires setting up
> mapping and cleaning up on drop. On the other side, `ConfigSpace` is real=
ly
> just a view, as the resource is associated with the `pci::Device`.
>=20
> Remove the `ConfigSpaceKind` bound on `ConfigSpace` and make it a generic
> view. This means that `ConfigSpace` object now represents a subregion and
> therefore encodes offset (as address of pointers) and size (as metadata of
> pointers) itself. The full region case is still supported with offset 0 a=
nd
> size of `cfg_size`.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D8

