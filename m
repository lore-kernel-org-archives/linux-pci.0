Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D26548555;
	Tue, 29 Sep 2026 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703858; cv=none; b=U0AW0JjegUdUoyGzr+Y4KMXiCmE2UasEJ8po//XNt4sJHWusqaUuK8nxd6LZIhFHGP83zvq2PAg4BhSpRGAdXOoQFs/42INf4VjYwElJGXDrZCT7HhSQmDqzu+S5Xm6DI2AFxOjZO7KmrUGVc250LTZ9rAuXhLaW8lXiiwyl6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703858; c=relaxed/simple;
	bh=dtLpG/mAhu8NEvZzHnaz/yYAp5f7LjhafWPXCqYSK5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iqr5Gj+9zuEx3ntAzutyfCaWGHdsi2RjKCnM0BbJj7owta8yubG/7wh8eNu+qtknxH7Ef8iC6CDN/6U0v5rS31sfdvEv1oLeOfLS6pEhRtxaA5WT6Rmb3mEFxLjfXElKYYLQdVtI28spNwinYN4uUbxMcDFPNiN04dGwi5/ljZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoZW87Ot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoZW87Ot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739D71F000FF;
	Tue, 29 Sep 2026 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703856;
	bh=dtLpG/mAhu8NEvZzHnaz/yYAp5f7LjhafWPXCqYSK5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WoZW87Ot5DA3qeLOoLn3Q1jBYT7Np4Q2t3Nw+USnVHHK4M3tx2xdyA4XO0Z8h0eew
	 QnjfsnisUMeXjl3ArkglOPKvsC7e8mnZq06CGb5eH0zPo9E5pyHQFvZG6QH7D61rf+
	 OwV5eLnB70oKlKouhIUFTi99XcGjxE7LLRv0QGAOaijpNoqAzqclQm0yCW2BxOHk9x
	 GbV1I1pwhonHtKKVHlzY7kyErcfUWUpMxA1TJVkVGNlEOZFvbb1yyYvd6AKKUeTuec
	 1tQgzUbnEbm70MEcnWSK0qo7nQHkkv2h+s45CAaM6O9R60oBp8WDiRnH5oFTDKfzb9
	 sFxU/KHvcf7Yw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/16] vfio/pci: Add PCI error recovery state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260929173305.204856-10-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-10-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:44:16 +0000
Message-Id: <20260929174416.739D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add recovery flags, a sequence number, a saved PCI_COMMAND value and an
> eventfd for recovery notifications. Initialize the per-open state at
> open and clear it at close.
>=20
> Track the host transaction separately from the userspace session. The
> host-active flag survives close so a later patch can reject reopen until
> the outstanding recovery completes.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D9

