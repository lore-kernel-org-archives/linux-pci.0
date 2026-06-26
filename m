Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559892D5C7A
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486004; cv=none; b=DoIPKJvwsRngl2dTHOwiKO3M0PNWte9GHX0gX1nOjNl0ihXNY1r98Vn1x7OXHQp2h5j73updne2DZBt0u4vKWQ+irW9n9b5PvwC0oDBhXjaT4bUSxdrqQ4K9rru5H4/kYdKRZIEBa7avnst0ceV4bWosVDFwoNdkhCKRRyHcylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486004; c=relaxed/simple;
	bh=02lsSfPBDNECpgNgJ/RqqGluA9eXFW05KmNtE4n7ypI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n5HGkbExKLbtruuMTjfbksJlXH1GvB74sWJ69fOaS9Douc4jhLWALzUMwC7pn2eeJ2a1PuAndQ3mETBXFF5kqfXqd/ypRlwJtXHt3yMQV8xCo0S3oTPKJ8aqhB7swfswbJ2AVbYu6uRr7CCC1YBglsD8nfVWF4JM8T4Rjizwqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/8/quWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/8/quWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7373C1F000E9;
	Fri, 26 Jun 2026 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486001;
	bh=02lsSfPBDNECpgNgJ/RqqGluA9eXFW05KmNtE4n7ypI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/8/quWIZkid1pKBK4jc3IGf/fitziDFQvSJmdmljEVGxSrvRhyKoUEflPx2ln/t1
	 WQWtsrNgyDhEHCd0lFNjPl/pjSICg4z/W27onxZit+GIaTkMnciheKZMxlPQdI+Bif
	 gjZyDREOJ57av3bduhkS/mWH0RFwLoBO0BhCO+70gypRxwFiQmc3SlDZm0gNy0TQzJ
	 OKup+0LMl0wWXfuC5mixM0FlWDdIyf5MVv09tAP0ifciuVddfZYvEDdqldSlsNbpnJ
	 rYwPe3JWpavcAxAQIjvvhB0QOVyTu1IlL6vPmYEOfDl37HRBF4Oy+KBvlTwGmNtzXs
	 WuLnx3/6gD7RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:00:00 +0000
Message-Id: <20260626150001.7373C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The current safety comment on `io_read`/`io_write` does not cover the top=
ic
> about alignment. Add it so it can be relied on by implementor of
> `IoCapable`.
>=20
> Expand the check performed by `Io` by taking `self.addr()` into
> consideration when checking if `offset` is aligned. For the compile-time
> `io_addr_assert` check, check using the known minimum alignment of
> `Io::Target` and the accessed type.
>=20
> While at it, fix the alignment check to use `align_of` instead of
> `size_of`. The values match for all primitives (including u64, given that
> we do not provide u64 accessor on 32-bit platforms), but are not
> necessarily true for custom types.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D2

