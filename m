Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7408486B8B
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281944; cv=none; b=jKUCmDU/tTsBGaHWfA72klxjmNvAlAFZMwCjuW29oly2C5BcglvISNfRFjhxyzR9+GmdDeKtTVlJSJfAhBRGcaAkskyXwaHYTBJnO4OnhUc29UkvdCD93emosUCJmMJUoIr52+gwDZLe4GGN2QWDdivW79n0WeWmIuEAybDvLEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281944; c=relaxed/simple;
	bh=D7LNZnzxQGCwBhlPIfy65AC+FYx8L0aZeDTvSsJLJMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tl+YGz0JpO8+gsqk76mo+RMiGUayX2VQV0wn1C8B5rC66tl6UVpvv8kg/z3IGBKZKKCBlTVuf1nBs8MAduc9bggLNEvaZ5yR2pRN0AgHCbrTdILAYdU6eRJNZlMt/o0VvafZR//3DUkHmC0nenMnI6i8TM6bVXd1odIHnd+mgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARL/K0re; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARL/K0re"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E1F1F000E9;
	Tue,  1 Sep 2026 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281942;
	bh=D7LNZnzxQGCwBhlPIfy65AC+FYx8L0aZeDTvSsJLJMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ARL/K0relCLNyHZyPyPhoByK9YHJ0D3KjdoVup8u9PdTs7XcN49yz/Id3WqVb7MEY
	 exoVNWeoAI1fzt0rJLirCph42hZNgg+BIgXGq1N6efmTDcO8LkXNRtDKGUhmVp1kYB
	 IXpIRqPQT33CT2oNxkSXaqlqSXnjM3ecJoGsrF/NDb7aV7mlqYnT/ZshFSyIaAjSBi
	 70tJOVjY8h9l4JqVB04Vg8Sy1ecxYjrBVSBOfLD8M9/+J2xiFoXZeeO/uyXB4HS94b
	 +XMyc4J+9Z45GJfJVy6UDcpKJHO/GSM08YSE8ssV7oUXBVOQW1pHsgknjGVcLlB4GB
	 UuE8ecM+vqh1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/16] rust: io: support register projections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-typed_register-v4-5-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-5-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:59:01 +0000
Message-Id: <20260901165901.B9E1F1F000E9@smtp.kernel.org>
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
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D5

