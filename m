Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889558;
	b=VghuKcU1fWpCdO9Dg+rtw0hM96P5tqVNgmX/VNRaBFiLI9iCw6IPujZbYdUNlRG3Sgll
	 YyeLpHva7c7yzPmsXYo6ADCFVloIv/A1DJ+D2QFjSkWBeDIpi7JqQEDTqZoBkFAo68RZq
	 dIpI5j9oc5DGlGgQt4AtVJJjULSMJFziLuB4Qvb1MQ8+o2sCxSC/Qr3Zu8kCqDHFtqy6i
	 nE8ww2Zj/GnVPzdTMrrkUjnyFi6/ktiQs5z2zM+hf3vUwl84TAVYkSdsjrFe3HHq2tKt5
	 Y4/fFidty3xfqhJEjWCaWoOoaMwV7cGmA/cXxMAqqEF6wooDspSgJ3GItt/4sgdj4mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889558;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5e8ZLVvHDHjCwvJ9MgsVwHeEBLeyg7mdMiVRa2+gRfU=;
	b=pe05hcByhd8hfi3zVmm7wiMjUnleMhceCQBumQa8R33I5WIP5QrM5DcfYOoM8TqjqgJV
	 qez2cFmWIv0dEssWwmpxVg2lfbyuhBKc5NTGp3VL/ip2znvgpX9dVpzNZ65KLR3JjLkVw
	 ekYgjSwKcuNCwg8Vqi4RTZIUhT8+zHwIcJ3WdlxDwCoRlEMmtwBEqbJ217J596EyChyXd
	 esQJg1JWAERpFkpQ4XgTwJpr1jYgcm1cAhOLQxfxWWRJz+x61zs01LgxrHDWvzKQ3u/14
	 E87KSOkIgdDEw3rweXwqJIkI51o7zHyYLXnK8pf/qe1t3A41PLVc2wkiBR53WbLtMrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4KMCK+t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE7606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4KMCK+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33B21F01825;
	Sun, 25 Oct 2026 00:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792889558;
	bh=5e8ZLVvHDHjCwvJ9MgsVwHeEBLeyg7mdMiVRa2+gRfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4KMCK+t5udSLmlUQYkcqUqtn5KwXMLWWSjypcEL/Enym0MUwoPIi2uczghBTzpG8
	 SDDkNd9zx+THLXXyb/xWZCy4fzfRSwsUcEyEZ3UruzbaYKKkV71BsABeTjrD9kcmcV
	 dpd4rD8qEGUcd1ShMi432kYBrLiY/13R3Iq8jvtGfHHfgYFqlhSi+hDOE+zVg01F9s
	 hkp8B//jGDJjip5+sbUN9ugRZCLxVsuVY4VMGAsftkqx6i8ZPYReNv67EuSl3AbznR
	 Yno+uUCM1OqiJO1Em17AXWZO9pfMBDfo4XQBfvQvWb3aHuPz4/uDwIM3t88H5N6t4E
	 8q7kWAOX7Tkcg==
Message-ID: <sashiko-outbox-183958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] PCI/sysfs: Use user config accessors for link
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261025000836.58294-5-thepacketgeek@gmail.com>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
 <20261025000836.58294-5-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 00:52:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> max_link_width, current_link_speed and current_link_width read the PCIe
> Link Capabilities and Link Status registers with the kernel config
> accessors. Those don't check block_cfg_access so a read that races
> with a reset goes to the device mid-reset and can fail or return a bogus
> value.
>=20
> Use pcie_capability_user_read_{word,dword}() instead so the read waits for
> any pci_cfg_access_lock() holder (e.g. pci_reset_function()) to finish. F=
or
> max_link_width, this means inlining the pcie_get_width_cap() logic
> instead of creating an additional helper with this single calling locatio=
n.
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025000836.5829=
4-1-thepacketgeek@gmail.com?part=3D4

