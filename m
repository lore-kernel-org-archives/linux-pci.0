Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD742233947
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273286; cv=none; b=CFGYLy7+Eq6VFCo3q0oe+m16B8/HJqT5O/dYn1V0q823szaRP4HZRO/nT4VWcn92j78p1aGLR0Lr7GYCS79HyBn4meKodA/Bsnw0DsxkVu2tzyBHY9xjlNsqig7zWqJD0J1Bd0TKFRxOfhfGm0szmkF+xTdqhEIGav3JwIJ0MyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273286; c=relaxed/simple;
	bh=Ua4PwViX+QXNRJVnpjBEc82/GOzjYd4cKbBvCqsYccE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rosy4Ye5LuUTt+wp4N4bXYN62FlKxMGLw1uOo4oRpa7ve6jD2V8NSmsP2bi6zO6TjwqRzqO8LKMCNhj+Lx4djtN5ZKTlllaWMUWD5mvoeLpRYIMlAV+m2D+ugbpE/iQxV77BzQ4TfBbLinqYpyVmIqqhViBBFUojenIv2bRqyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVU1aPsi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVU1aPsi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6EC1F000FF;
	Thu, 24 Sep 2026 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790273285;
	bh=Ua4PwViX+QXNRJVnpjBEc82/GOzjYd4cKbBvCqsYccE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VVU1aPsi8ROds+zhqW6q/IaakRek5hWt5LU5AjLp5A/Nd0LdY9n+M6i0gZA58Sx8Y
	 WV0S+epIP7Sa07OoZd/CwCTng4xIMLyV8r4zN3kYqfqODjLYn/ThlB8OTK6+Ae0lSX
	 a30GXCOOQzopswZmcFaSJshTj2kkVCvWtviIHO6ByL28itfyXrpVEIWH0KWmmMyC3X
	 GtNxLiDRhD7m6MGkgro951EQpwN8eIpX+ZIcgKO58e0emfCr0Q9zxV/X7MsvhnmPe5
	 xSKLjxtsgWgcxiHaXpPaZbmdTyKBvPakegf+DV8D5P8C06VjwzmrcDfB5XfYCmwH0M
	 w+uoLOJ1RYDGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] PCI: Save PCIe state in the saved capability
 store
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-5-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:08:05 +0000
Message-Id: <20260924180805.9A6EC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save and restore the PCIe capability control registers through the
> per-device saved capability store instead of a private pci_cap_saved_state
> buffer.
>=20
> The private buffer is an opaque array of u16s whose layout is a contract
> between pci_save_pcie_state() and pci_restore_pcie_state(). Anything else
> that needs to touch the saved state has to know that contract, e.g.
> pci_update_aspm_saved_state() patches the saved Link Control register with
> a comment reminding the reader that cap[1] is LNKCTL. Indexing the saved
> state by configuration space offset removes the coupling.
>=20
> Describe the registers to save in pcie_saved_regs[] and drive the
> reservation, save, and restore loops from it so that the three can no
> longer disagree about which register is where.
>=20
> [ ... ]
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D4

