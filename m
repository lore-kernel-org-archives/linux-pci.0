Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04619D07A
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485633; cv=none; b=h1uiHmKCVbXQzEzvgrH0vfjA19A94IipGarOq8k0dP5F+bHKeVLVdPxWqf0ttuqymRg/sRCQ80EhDnPYgUt+VFQ2aH20n/p0H/k5G/JC0LHE53is2gDLNJNio5J3dJLMTobZpFuaZQxlSQkK5/J1xa82eFkMnBbpF8r/TxngOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485633; c=relaxed/simple;
	bh=jbc4hSqLknC659WftQfiApIpJ5hr7aBtZAQhdOmcfM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jc4ueFpNGSbfZYKlFgs9pfNDet9/iMGQyWqgjLQJ2rgZoUr/GXamZnMq2xsmG2PQf72BP8mP+UdHZJxY9okxrtNuEfywr+BE5KXGxVeq2lOD18lLWnRhWRUx8W8bNGzJiMKltW1Bn16PF1OQqFIGSaPufag/15pR4/ffPI99m1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXngImC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXngImC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E423C1F000E9;
	Fri, 26 Jun 2026 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485632;
	bh=jbc4hSqLknC659WftQfiApIpJ5hr7aBtZAQhdOmcfM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gXngImC3AafpRBBcjLMi86XgXpfh1GhHszFHxri+YLQ2cvusdLdaSnQhQmqNRyBER
	 SxMp9Sq2Vwhxv7S1AwSYv67TvMRvjTh2QBFC3+NIKLJA7TIbPQwqkWxFpI7nhT0A/H
	 tw7CmTywx8Y+iMHvr51OpkiQhGB6G8yzADeHbs/x+Y2c5jdMzrWqQIP9ImuihqeqNW
	 UsFNJaWiqWzhPVK0uazLmmLA5odee3KDOWQceBaS5SIBqnqI5Q6gkiB0eJnDgsyCrl
	 T9MIM9TzVCnP16APPIbOomaeFayPmuh1AxqNt4CFk48O3RDLH+H5kxdwn4ZBJ2jV1q
	 afov52rFK5oJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/20] rust: io: remove `MmioOwned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260626-io_projection-v5-11-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-11-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:53:51 +0000
Message-Id: <20260626145351.E423C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `Io` trait is now very easy to implement. Thus, implement it on `Bar` and
> `IoMem` directly and remove the `MmioOwned` struct.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D11

