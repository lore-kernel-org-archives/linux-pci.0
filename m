Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790837A842
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023310; cv=none; b=OxC43tWATaC0EltJDjVZZ9XFcf42TYU0egDRGNd6k9tEsPfmsXumFSDFbbIjBPw9bp76xeIKeWPQBkXYrPS+eRXoCjYUyi/QmqivZsh0Aa+vjsmR/3IDGjp9h3S+GTj5RLdw7jRjg2SCzlMGqn+8JnxqByJUgp2NOt6D4Jd5ypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023310; c=relaxed/simple;
	bh=tVN6Lg/7gDcZn2dy6ZHPcbLlzBc9+RvHEcpwLhvbNwo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kCSjWniyYmcmC3CQDClDth+a4hlwQO6CRTkI6D3U+KEeQIMraDimKUxZRybQJ8T1kbjkzsTFq3oRQEkdCFLOcX1kKKdzWuUNq2aECE4gJ333KwBK3HoH4sUDVfh8pyHVd2Mzt2WEEdgnQcV6Igyn1w+qOLBAEG6OwIAgl7lKr1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7eo68U0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7eo68U0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CD71F000E9;
	Thu,  6 Aug 2026 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023299;
	bh=eSTahQFiGawpJrIHysO4AKbSXM1xLzQuYdVbmxtMzZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a7eo68U0gh5n6deT4Fd25/V7ej4jTCHy5MCttIduU+V4yFH5ZpauNUid2kuohjIVw
	 jQDYDJOMbot2uJt5O1HBp2LlSFZaw3p4X1XrA5glQclf190VXVI8403LSB1Y5lnEqN
	 eBxvvudiYKkAF+/1JKlYJpNLqvnVWnHdZye1dDRKEPMIq1sPyhc/fblXz8BholJBFw
	 rHe8KKhDJgJdG+ed9gDy4RST0F4ESMNhdjjzDf8kRy3XWPJ34x7DhGsFSfRstfmtWQ
	 opaSGpppk/nbUzmsc40B1c8FNkj2N6a8gtrPcgJqsGPgDrKHcBsW+qPISDeIxPBySs
	 FJVGOv5UzNJbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 06/14] i3c: master: Fix potential UAF in
 i3c_device_uevent()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org
In-Reply-To: <20260806131857.119830-7-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:34:58 +0000
Message-Id: <20260806133459.39CD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> i3c_device_uevent() dereferences i3cdev->desc without holding the bus
> normal-use lock.  Since the descriptor pointer can be replaced
> concurrently, including when a uevent is generated from sysfs, this can
> result in dereferencing a stale descriptor and lead to a use-after-free.
>=20
> Use i3c_device_get_info() instead, which protects access to the
> descriptor with the normal-use lock.
>=20
> Commit 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling
> i3c_device_get_info() to avoid deadlock") replaced the accessor with a
> direct descriptor dereference because i3c_device_get_info() would
> recursively acquire bus->lock during device registration.
>=20
> This change depends on "i3c: master: Fix recursive locking during device
> registration", which moves device registration out from under bus->lock
> and removes the possibility of that deadlock.  Without that change,
> restoring the i3c_device_get_info() call would reintroduce the deadlock.
>=20
> Fixes: 6cf7b65f7029 ("i3c: Use i3cdev->desc->info instead of calling i3c_=
device_get_info() to avoid deadlock")
> Cc: stable@vger.kernel.org # requires "i3c: master: Fix recursive locking=
 during device registration"
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D6

