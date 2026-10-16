Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956A377558
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146328; cv=none; b=Sa0o24mDPRyAINwSx8cYIcFl1H1MvVRCR3WJBwNjEREp8VuAGfuXTPNvvaUUbS4tGLMpv2bnLCzRFMGhZVmH3GB5b81w3VZBMHBkzRDjO4luzWW3nr99+UJv0UYl/wI8qWXy/Bwb5y78Ae5MISWKV0iLJ1uP9/VpYqgKgs9JFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146328; c=relaxed/simple;
	bh=FjMIbBT8md/AE4QeVpwsERFz8aZGx+xyjmMiWAUP7so=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z5zwywD7D4+UENBZyi+K/0rxA0KhtPwG93GvRF1xNdwpBxwe2W42YAQ/NrajFB9hOXZnkdmMfWKvbBIr+zb0YuD6AKybjj/JZo7EmE7U4QoOXpnH+YX/xm/m0PbXhEEE0MkJzkn2k4TsTQKs3N/dgpZgkT7z4BoRYNckP7huT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWHTSqc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWHTSqc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911C11F000C4;
	Fri, 16 Oct 2026 10:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146326;
	bh=FjMIbBT8md/AE4QeVpwsERFz8aZGx+xyjmMiWAUP7so=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWHTSqc6gzurK6vZvF2DNHSGnYEqXcAZjfC8C4aAHr7qT8N9BOvuUw5fNFc1naYvN
	 jPVBv0lRnNPlLKy4xf+WzArWnEwAkhKK7IcHNzpUPv/S/DX0ZEyWQsSrZOfQSWUJxP
	 L9crGyEUMygUTOh+b8C6i7lbfn2ycLt1XSyDhjT1S83ZpyNZjkrwAtjT0CskXr5wz/
	 /pZFGCzMWViQGOnBLhWdGM/AiekCPqM5u6pZRTq+jHQGVhfclrNzKlvfP2Ugqg3254
	 Ii80GQYORj6fRARFclD2hi+yZ2O6aWhutJHuSQ1Tc+Xb28oATT4gtZiCLT2dMkMQMn
	 XyoNyS/aLtIXg==
Message-ID: <sashiko-outbox-174166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Ignore Immediate Readiness on Samsung 990 EVO Plus
 NVMe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gruhlke" <gruhlke@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261016102042.641801-1-gruhlke@mailbox.org>
References: <20261016102042.641801-1-gruhlke@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:25:26 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Like the 990 PRO, the Samsung 990 EVO Plus [144d:a80d] advertises
> Immediate Readiness, and VFIO passthrough of it fails since commit
> 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs").
> Using a bus reset instead of FLR works around it, and the latest
> firmware, 2B2QKXG7, is still affected.
>=20
> Ignore Immediate Readiness on this device, too.
>=20
> Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
> Link: https://bbs.archlinux.org/viewtopic.php?pid=3D2312085#p2312085
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Alexander Gruhlke <gruhlke@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016102042.6418=
01-1-gruhlke@mailbox.org?part=3D1

