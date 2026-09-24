Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B24BD119
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272327; cv=none; b=hAYIvxIAkl+qrKuN66blFDVVIn6Ieu71KqamGjaEOZh4ffdHOHwEsvwhCzCcDwFKM2Gw/LOCymgE3eT3NYPaREjNPYPVgxLTrSK6speTb4PzS/lBehBuR18wkiCa1XHqqe8BZ2oCvBekTeJfGi7ltk6Rv21hZ1q5k6nA2TMy3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272327; c=relaxed/simple;
	bh=xFjghIflEiK+09dhKOue3KAKMAWnvAVeTXpPoU+94LE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UqybIUWupXFAVd4r0MxjOgsRqk+nZgzAG+vp01TEf6XbTX+YjCedr7qCzItlIXklK90/i1dC1BRwAcwlVX7eztFbsU5nLidOkPu34S4KN3tuMJiJfwV/zJuV79pqTerVQ+wEbZTgJc17o2PAJk8MTChbrp2rNK2DDJhHT5ZhQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Shvwalwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Shvwalwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1F41F000FF;
	Thu, 24 Sep 2026 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272325;
	bh=xFjghIflEiK+09dhKOue3KAKMAWnvAVeTXpPoU+94LE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ShvwalwpzNcAgABI600fRWqOHujNwkZoYlYEx9bfTqxBxXDrW7cKxM6WcHJ4g+JcA
	 H8wyuS/IxtwjX1340Y7SGW4Q5RZCbUZqdSy8Kqqhb+6ssdz+9+quNY3x/srR+EoM8a
	 Qo4zJzDYCBTUIQeIlj8qZ7f5ijYpmYpLBe6nKR9pQ7ViJb4WdiCOzY3qqrupSNVzOi
	 8RoT04FW/xgJtFNbXP+Sr61fZJeGT5uX4U/I1iR5pPjOehYbINGACGpeQg0cTizbfp
	 0n/cIJCXNXQsu8Xqryp0NpROsqGUtioHEYKNK6lbpth/56vGqiHCZsfFhfS55yqAB5
	 MBCZ7MArtKpsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/15] PCI: Add an offset-indexed store for saved
 capability registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-3-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:52:05 +0000
Message-Id: <20260924175205.7B1F41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a per-device store for saved capability registers that is indexed by
> the offset of the register in configuration space, and whose values are
> allocated in one piece during device setup.
>=20
> The store holds capability registers only. The configuration space header
> continues to be saved in pci_dev.saved_config_space, which is embedded in
> struct pci_dev so that saving it cannot fail.
>=20
> Today each capability that has state to preserve across a reset owns a
> separate save buffer, allocated by pci_add_cap_save_buffer() and found
> by capability ID. The layout of each buffer is private to the code that
> saves and restores that capability: a dense array of whichever registers
> that code happens to save, in whichever order it saves them.
>=20
> That has a few consequences:
> [ ... ]
> No capability uses this yet. Subsequent patches convert them one at a
> time, after which the per-capability buffers are removed.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D2

