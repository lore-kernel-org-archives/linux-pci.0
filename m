Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC846EF71
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016273; cv=none; b=LwsZWuXsGQUyjcnvAIsGlaaqb4wm3bXKBiVqUY/3nZwxLu+JZt3h+BzKtYzeXUdjNW6SGkGMe8HYC1G7xrGKxh3Z/H06HDdBozbZxDl6m+Quo9/IVGBKrbDH4jV05i3JW0f4OmH8UGERXD2UXK2KSkxtk+1cR6rE11Dor4M2ShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016273; c=relaxed/simple;
	bh=VTqvagnywLMRBzrV3LPXhIpFmA85X+BnH8lQV1916ko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LRig959V3cIwv5KOk4/MprLCuO85nrijBpmyXJuXPMvnelVVNiznZZ8Qt5wj83S4dCHKEDlB4nq74te7p/gyFq+jQoHHS9hhN0h13GTm4G0ANtSTvs/Ah0IPvRQ9qxFQCpUrhu+6+99LleayrtturVBv416XbNlor76OPw/Gpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROSYvLO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROSYvLO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12601F000E9;
	Thu,  6 Aug 2026 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016264;
	bh=VTqvagnywLMRBzrV3LPXhIpFmA85X+BnH8lQV1916ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ROSYvLO1blaLJgqxDx+GNpk/50jbboxxHtPGgb10fk5cca/4m4Nlj30Hk+swzGeI0
	 r1JvsbMj09fClaybPGd+uvoalwdpSj2tLJuM1Le6WzR1c8Pb6ui9jCi1ugq56sAr9Z
	 3J8R8Wyd0QURDFDM+B4cqd3ZTiUin3NZu/U+iE5m+yIhOB62UDzqliaor5ZmIBqvdF
	 zBETgZ7PJI74Yo2Ct6tc1lr69fxEEqfy/fEvkiFJ9tsMk3kAP3oDKQDYc4EtSva5Ju
	 sCFh1aqad0OpL2+8sq688zdzWjagMPzuY3iN+D4x84kFOEUYj1mH4eIl5CH0L6fb7s
	 82TdpN56lgWmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] PCI: Add KUnit coverage for ACS isolation
 checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-13-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-13-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:37:43 +0000
Message-Id: <20260806113743.D12601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Direct Translated P2P and Egress Control both let a peer request reach
> the peer without Request Redirect, and whether Request Redirect still
> isolates depends further on Translation Blocking and on the flags the
> caller requests. Firmware owns these bits, so the combinations are not
> reachable on a given machine.
>=20
> Drive pci_acs_flags_enabled() with a fake pci_ops supplying the ACS
> Control register and check each combination. The function is exposed
> under CONFIG_KUNIT via VISIBLE_IF_KUNIT.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Assisted-by: Claude Opus 5 <noreply@anthropic.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D13

