Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C738BF97
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785754018; cv=none; b=CvzLC15LocaxOiwgFAKBldTiDSTBbuwFVtVLfo2dLm63YTiq9B44zEnO783GklCniTehf0SeCgdq00P1dAiJKOdCsyou3boc2QsoX3sfUawTvAZlHgtsReUtXcpj5f3Q/BwOmp85PJ4wm6M8XwylFoZxi5zFiDBuBL6WBodXigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785754018; c=relaxed/simple;
	bh=9b2N87WyANRWHCcXARGmNtAd3AzlO9Xi6kuySgIQpyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aS2oJ+d/HkGLKa9GAGFW1VpfjEa40VrIzBlJrzdSeOWylaAn1DPGqL5I7wxOC3Pzoz4u3VLKgWM59m75hiAVp/iuDLihSB4M4MIFfMe4ZcE1N2ZG56+4VyjBfeaAwJxAdb44mVKXUjUjQG4i+jcoF2BaLs4e5QtpiKgw2ew3bjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnBggGkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnBggGkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332411F000E9;
	Mon,  3 Aug 2026 10:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785754017;
	bh=9b2N87WyANRWHCcXARGmNtAd3AzlO9Xi6kuySgIQpyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XnBggGkhifLRhJc/lM53zI3foOTeaLhl+4zDTVXNXqsDCgjEDPGPma3BCeaPHmgZM
	 yOhJyz3ElH8ca3GEf3KWW9dr9iKghwIPShe89efScqEF6oEVKkM/4PEHjOh7LuBB9X
	 OcOFFbGMJZzGyk1G7gbUK6r/RqHXiGtNqJwWAUppXM3pqkkQhuJPkEo3cHnpdzoOxb
	 yK/0tQihzL/gAhC1DTkr2lF691Ut16pkYqm9gVaoX/x34P6nZXgAoa4hOQ8kmLjX2R
	 ypexmAp+kNTLtomcfW/UNUv5DaBYvQVyZHjgx7kvbbZKrO8OmV/5B9IAlwC3fayhPA
	 06HkrCPqqY4EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI/IOV: Restore initial VF ReBAR sizes on
 SR-IOV disable/failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marcin Bernatowicz" <marcin.bernatowicz@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803103007.209625-3-marcin.bernatowicz@linux.intel.com>
References: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
 <20260803103007.209625-1-marcin.bernatowicz@linux.intel.com>
 <20260803103007.209625-3-marcin.bernatowicz@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:46:56 +0000
Message-Id: <20260803104657.332411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> PF drivers can resize a VF BAR via pci_iov_vf_bar_set_size(). The new
> size persists in config space. A subsequent reprobe/unplug-rescan may
> then cause the PCI core to reserve MMIO based on the inflated VF BAR
> registers in the SR-IOV capability, often multiplied by TotalVFs.
> On platforms with tight apertures, later SR-IOV enable can fail due to
> lack of space.
>=20
> Restore the initial VF BAR sizes saved at SR-IOV init time when SR-IOV
> is disabled and when SR-IOV enable fails. This covers both the resource
> allocation failures later in sriov_enable() and the earlier validation
> failures that can otherwise leave a resized VF BAR in hardware while
> num_VFs remains zero.
>=20
> Restore is only performed when VF Memory Space is disabled, which is the
> precondition of pci_iov_vf_bar_set_size() and is true at all the new
> call sites.
>=20
> Note: this changes user-visible behavior for drivers that rely on the
> resized VF BAR persisting across an enable/disable cycle. After this
> change drivers must call pci_iov_vf_bar_set_size() before each
> pci_enable_sriov() if a non-default size is desired.
>=20
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5937
> Signed-off-by: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803103007.2096=
25-1-marcin.bernatowicz@linux.intel.com?part=3D2

