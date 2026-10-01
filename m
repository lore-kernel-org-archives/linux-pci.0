Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2BA3AEF57;
	Thu,  1 Oct 2026 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850677; cv=none; b=cecGdsRpKJRUTO6Rp/7AbB9kLdCxqOeHytdgDAUIhU0P6NGyOkoG2AmoZyq+mErrgutubgCvSleYPihSQgkuzlNO8r1UU4YhItAFYa1HEWFmfbcwndHk5+URJRElqxyj3/L0/K3wnDjY7FaRceWCp4zpBkyKSkdGvin0xrrYk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850677; c=relaxed/simple;
	bh=7ppqlQBPRreQgaQbXc0wgcQsXR9D049crhMJsxEkaOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eiGNldaMygo5OTFaHoEE0qjWMe8FT4R+MYPuZxZ17GP8QZxwEvy4yYOKeVKJoS+Q/Eh4fC9aaWX1htyqEGzF8fsVwlhGOfcwubIzfmX1ZQ8Pb6Nlpu7IoZDo1SEJlx0s4oM4aQkS/ekVWlRGE3LS22tkbdnln24m7FoitBZ3G/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBopn1Ty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBopn1Ty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10E41F000FF;
	Thu,  1 Oct 2026 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790850675;
	bh=7ppqlQBPRreQgaQbXc0wgcQsXR9D049crhMJsxEkaOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NBopn1Ty1yGX7/ltNPkqJzf24m2c48+jsd8nMphTWts7EDZ+YCdAVVL6UlIl4p51s
	 pWREcm7ovgcOrZaAEOUL7p7CPFJaIUYn2iEe5DPncGvzrd2JXXuzRQY6MV6Xtayv3l
	 3W20UmoBRD4uh2VOe44T7KGfhqZSsFUJYYbrG3jSTIlU2pZYmaMsD9mmCrD6wXcrli
	 u25JCePYsxuvXMq+YrUf4udvPY/hKCy1iiZoqcSroQ8XgLIME7S8CzaTqs8hbVs0R1
	 f4vLzuZbHnAoXX5BGjiOsLoaUaFpnrwdWcNkAEihF4f8KvlYkL528u2XMscWx6KwKM
	 EDc9AY9+FqpUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 13/16] PCI/CXL: Reject reset with unsafe function
 scope
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-14-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-14-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:31:14 +0000
Message-Id: <20261001103114.F10E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The per-device PCI reset interface must not reset sibling functions.
> Reject cxl_reset and cxl_bus for multifunction devices and PFs with
> enabled VFs.
>=20
> Suggested-by: Alex Williamson <alwilliamson@nvidia.com>
> Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.co=
m/
> Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-de=
v.notmuch/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D13

