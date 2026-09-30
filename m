Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0850B435
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780285; cv=none; b=i1LDofRDek5OIRvEWdwrNxL1pBLQrYOuowlXqT8TQIY5Zmiyq2X2KF3Pa28etOCbKKy75ltVlLKly7QHPTq2a9nJc+TIiknS8HnB0Zn9PMcFRP1JITK9tohdnLJEo1bJiuwjGsA4/9KOgCKNzPPBZ/be11iUXMRXZ7LB18Ansu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780285; c=relaxed/simple;
	bh=RfK7Kl8yVQyl/4+jZpsCjQXHuIi7h12rihRMoqkRN3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FMlYFi9vgQxwo7Py+8tOpjusqMPccDz0VW35KU0KsFeROCJTSwWw6W+89XX/4fZnAxWUqD7U3n0ztCV4U6Fi6lVdBFel9mAfPI/b2xfq9MFb8MHMT7w4S6Pfj0/hWSOSFdZmD3SZqOQgMgh+kEIYB0oNo0uzP/1fSqPjDtcsjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTT8rSES; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTT8rSES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F4A1F00898;
	Wed, 30 Sep 2026 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780273;
	bh=zeczajftE7m4hge0KmE3dUIK4JSk8WdnAPf0ngXwdNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTT8rSESlkwe6pl12uTYzZueZAphGZA9WW+fLTgGSIL8ZlVWzKIbZVUSILQ3dz08m
	 lZBUf7f0qXSVISPqWq7Ty5+TNlvjolEAH9J09dUdRVP83tVXaxgJ4ny+W725TLhRwX
	 V6CmG2eISJII9d6UHU5iUOOvbyQOjKYNgxEw4LkOF9+97FWE8Kv2sCOZxp/E1Y8a9q
	 Xc3wnLswRxs3na9xjfh8p++VcFNyNErtPPPqZzVrZHVXvLFVt63akhco9o2SAXzISd
	 cI7WIQ/PCtWk0q+s+bEsOcDKwJkHARCBqpilz62/dthJVnjV6OgdK7AYq+KjHnUogU
	 9EyRrGyWqazsg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] PCI: Match the hierarchy's MPS to a device's
 MPSS as necessary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260930145017.1356088-8-cassel@kernel.org>
References: <20260930145017.1356088-6-cassel@kernel.org>
 <20260930145017.1356088-8-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:57:53 +0000
Message-Id: <20260930145753.56F4A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Hans Zhang <18255117159@163.com>
>=20
> pci_configure_mps() enumerates top-down and programs each device's Maximum
> Payload Size (MPS) to match its upstream bridge.  When a device's MPS
> Supported (MPSS) is too small to match, commit 9f0e89359775 ("PCI: Match
> Root Port's MPS to endpoint's MPSS as necessary") reduces the upstream
> bridge instead, but only when that bridge is a Root Port.
>=20
> That covers an endpoint directly below a Root Port and nothing else.  With
> a Switch in between, the Switch ports have already inherited the Root
> Port's larger MPS, the reduction is skipped because the upstream bridge is
> a Switch Downstream Port, and pcie_set_mps() then fails with -EINVAL for
> the endpoint.  The endpoint is left below a port programmed for a larger
> MPS, so any larger TLP it receives is treated as Malformed.
>=20
> [ ... ]
> Fixes: 9f0e89359775 ("PCI: Match Root Port's MPS to endpoint's MPSS as ne=
cessary")
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Assisted-by: LLM
> Co-developed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145017.1356=
088-6-cassel@kernel.org?part=3D2

