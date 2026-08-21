Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110D235E1A4
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341842; cv=none; b=DPEOLTnrUN1/ZUheHDviazgyeXt8xZhtyw1g9mQtvFqzVuIH2b7glELyWNz576PubXtCf6PkiZqE9qlRa/GZdRxerRXyQyHZWBHT3/OfYjKsms1nRfw35ZTMFei3kdpf4SN9zJp6hgYaDH6pF+KaPYcc0TPXkpBXGBz3hZhxV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341842; c=relaxed/simple;
	bh=Kwiyjhsf+Ae+0Q0hO48f2rMICwG3BTdQAlC64j3fF3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q6WyeaR8rjRX71vdN/h00CRJDe0cDA30GJgCnvW56JSTcEw/2MpDNKIHhNKZOYUb3k8xrvV/GB3rRk9KlphIYuvz2oxbCQTk4QJS1GKkB9OgjN+E6yAtu8ufYjSuLHQvyarTZT4uxCZZGh4Cc0Y9+eKOaoTrfviizkTWe/WUJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKpyeGxD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKpyeGxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDF81F00A3A;
	Fri, 21 Aug 2026 19:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341840;
	bh=Kwiyjhsf+Ae+0Q0hO48f2rMICwG3BTdQAlC64j3fF3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKpyeGxDjcgvqPqqla6R+f+2zEHIep1lTR6wpdtCnP5Ro1x6ZbWo8h0RXdhdJsqaU
	 1MKbP0gRpI6SkLlH2kNkTeX6PK+UZ3yoQbWmepzAfQgSm+G8/OIr30dpOqKhHBMtfK
	 tV4xIlZhkxnSztwKhYY8hdlZ58R8Y88z+ql2Jn4pG6LCs/uQZCF4RLH8FJ3+5QvUkP
	 wG74nfyOm/RbXt5k0kyLlvqJe0jRMIc3pXxrRdNEWA9vYHv8l+lhJUKBfGNLlijG/g
	 sci03qbY335amKPAWzFEnzXWa3woUa0KbfzlBKMMn0WSXTIlf0fdg5OaCBQdMY3rOE
	 88NltV+teFV4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/18] PCI/P2PDMA: Add KUnit tests for ACS routing
 decisions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-15-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-15-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:50:40 +0000
Message-Id: <20260821195040.6CDF81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The ACS routing decision combines TLP type, redirect controls, target
> availability, and the Egress Control Vector. Hardware cannot reliably
> provide every combination needed to cover this matrix.
>=20
> Add KUnit cases for Request and Completion routing, including
> reverse-direction controls that must be ignored and every Egress Control
> outcome. Cover vector-size boundaries and config-space access with fake
> pci_ops so the result does not depend on available PCIe hardware.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D15

