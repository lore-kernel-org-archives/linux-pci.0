Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150447;
	b=ijcmScgzdcjYIkU8Yhe/A6Gc/cus4cxhDDkMdOGm/wX/gszHMtoCd6eEneFt+Ai+6Ggg
	 ADoBapfvPCSbAQ/byoxJkRjrPeud1OBQDHpDUnmM6RfCJ8FYJhdxqgqjk7OOke1ICBHQ2
	 MYUmBO1z33/Nl8TQaLCiQ9mZ5eVXgx/BIkfZEdqnvkUMDF6H6OfS9jbDAzgNfIDe03/uw
	 N7zP5gEcDFzmdjuP05pFa0gcfrvUFbvLoQE05J/QlXEVDCJUQJbF64Ekn/fAUcUXiBnHn
	 WoQkP8R+YYanoIIUHnyvlApLf7JH9bnpUcEu5f5WGRQ8hjxzMnqPiw+bp5PxO9OiBHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150447;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wV24XaO3BX9j3rtXIkJrdefaVdloOi0t5jVbyUninaI=;
	b=IwPf/jPmurR5JZj9ENkOJOsVh3EcIVAMiCKyciQpBfdlUkeswJ6xB8nCN4tDSLeBXR5A
	 614ddGY1FJjTB5fgKmB8a3BwzIfP4sZbNTBoiIxzKHwFQUNNaaRj06D1kICbH6+7oiu1/
	 AQFTkK7KOh/KbhgMhfn9ok3EOuLFFOKAjhHzK38i0gZKg209RINmh2P0+fdasWNiY15Su
	 M4OP2Aau048f0Vv6SgQk9+5WrTPdOTik+QBm6GW3Z5bAukQqEusdokApqpKQZ99vQ0+pt
	 0ZmSkI4hq5vUW4tN9FW3P//4Eo0a/8eQPM2ouseTWpc3BOFjMolb+8el84LJ0AWgm3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3tPmH4L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B1606A320
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3tPmH4L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038511F000C6;
	Fri, 20 Nov 2026 04:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795150447;
	bh=wV24XaO3BX9j3rtXIkJrdefaVdloOi0t5jVbyUninaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P3tPmH4LzojVwU9u9Vwzb/2rRVAE95eMXdtffcfEIMQQEjT8xxy8mCQb1PLHRNtZY
	 BEx/5RjIDcxZWz05XxvTmLW8iEJcTAJXGvZA5odlKH2TKjLp7XZ2B71dF8PHoZmSqT
	 664KUETH1e6NhePietgF4aEHRz8xFVNzyxRLG57fc6hq6tsvIaA3J8YknqUPxpnYX8
	 Pp2dl5L7T1zP5fIb+gmOBa0imhqXC9INR5JpT5MGmSL24T6lJ7BCyFNgW733AW7Cvj
	 QCgZv1tJyAqkjWLQD3ArX65jYcWzwgFLbHH0zGr+8iFtyWY9a1rrI4qU8kvo8r13R0
	 kBWYBngcbSguA==
Message-ID: <sashiko-outbox-224481@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] rust: pci: add domain_nr() accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120044704.165223-2-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 04:54:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The nova-core driver has to send the GPU's PCI location to the GPU's
> firmware as one word that holds the domain, the bus and the device
> number.
>=20
> The PCI abstraction has dev_id(), which packs the bus, the device and
> the function into one value. It has no accessor that reports the domain.
>=20
> Add an accessor for the domain number.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120044704.1652=
23-1-jhubbard@nvidia.com?part=3D1

