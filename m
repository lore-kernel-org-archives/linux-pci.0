Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC141D12B
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823426; cv=none; b=DeVv+Os8FwRh5HCL9ssrG22n88rcg8m5P20CoFzm+kRQrOD+cBz4jN5b2J5PWz/WiBNE5w5L48P6Zi/RpKN/uEtlC98kAfHoO6wOkuaKBBYmypvWY552jke3HOFAqOcYnt5UNHmdjp3/yTc0IWAnFJQ9d3gjckCzOC/99MVwcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823426; c=relaxed/simple;
	bh=rCtwS7n5XHt7WgdK70wVjYa8dvkRxEhw/PDLOxlE2kA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZjnvRr9rAGsKY453FmcuGAiBtqy8ZN99GPHklhSL8nPhGsutGiTSlAJ1We1VGL5nFx+kXnA5p1ppYP0IG9GojgK/PK+82iQ2IpfqHHoRyLpBYQDbfqrRvRO6BmxpepyCqrArW7s4YU01QdYNogMhiqx2jT4F3lqUMFWql3oELG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B869C1F000E9;
	Thu, 23 Jul 2026 16:17:04 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] PCI: Work around Pericom PI7C9X3G606GPC Port 4 BAR
 erratum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmoy Das" <nirmoyd@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260723161010.2638956-1-nirmoyd@nvidia.com>
References: <20260723161010.2638956-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 16:16:51 +0000
Message-Id: <20260723161704.B869C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Pericom PI7C9X3G606GPC PCIe switch has an erratum where downstream
> Port 4 retains a default MSI-X table and PBA decode when BAR 0 is zero.
> Memory reads that match this window are dropped with an Unsupported
> Request completion, which may cause the SoC to report a timeout.
>=20
> The workaround is to make Port 4 BAR 0 mirror BAR 0 of the immediate
> upstream port. Firmware may establish this at boot, but PCI resource
> assignment can move upstream BAR 0 without updating Port 4.
>=20
> For a 64-bit BAR, also mirror BAR 1 while memory decoding is disabled,
> matching the PCI core update sequence. Port 4 BAR 0 may read back as zero
> after a successful write, so do not use readback to validate the update.
>=20
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723161010.2638=
956-1-nirmoyd@nvidia.com?part=3D1

