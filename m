Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F93A1684
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532125; cv=none; b=kyc2W9A/lP6Z7LXFsKONhLlFQ0IyhpRTzK2ZxMsD5y5/WuFx/W0imLGN45PCSHHPMEk3cq+n/0m4v/2ect9Ui2ZmyFEfVgsk3h8Ub7Cz0emfyFBjk6hw1oJ1Rz1F/w4l24mpGcAaXB5r6QIDEvRNguJE+fUUsFIeQ0qXa3VLCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532125; c=relaxed/simple;
	bh=KX1t3qfoTVj0TT7mumB5IwJikCtQ7tKr3wprQI4cPtI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MmzgAXHoY5aWBnkS3sgjzXAKGi8i1fjYfpwPRnkxQ8vDJWizAxLmuKfkRXw4IYzdSviRydELlO2ON6ZN9afCSUUq1Xb8QSDR9BXSFPgGtt6MHI2feOdvJV+6SMnYLCLxtsZG6Uxo6+yLdLnUVusczIozgFAwCubVi9qCnyfIM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cX9B/Gt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cX9B/Gt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7B91F000FF;
	Sun, 27 Sep 2026 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790532124;
	bh=eT+AJYL5DCmthnJ/xh7XYTqG4GbSMuE/D8YrU5qIapY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cX9B/Gt/jwa/cvTzS7wlaYxPnUmeamtJOGvQILdDlYYsebTZN2CB6Jlw/xh+X5cys
	 79WTkZozAnbSyFFrh3laZhDhAqM69nDqtXa1vGRo1VV1resMZche0FZXeemq0dKO7s
	 M9cvtFI7SBbdtojAFCUFpN0G2IOjQzJSGSdG65nvc+Oex6KuXiV1Gj8KB96QpY47ZK
	 wYsFpz1Pmqn7FufCRU3ircrQIfRa4HmkmSxhIvfMRmJCOY2kIUhviQb/L9MROaYpua
	 p/e1/oHCyCqC1/OsIc1akVc3V71gOV5hdnVf1DgvcyqhiEUDQShquOYsGM6QygE5jH
	 xlraJ9TxcQ2iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 1/5] PCI: Report surprise removal event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927175203.928270-2-abhinjoses@gmail.com>
References: <20260927175203.928270-1-abhinjoses@gmail.com>
 <20260927175203.928270-2-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:02:03 +0000
Message-Id: <20260927180204.2C7B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Michael S. Tsirkin" <mst@redhat.com>
>=20
> At the moment, in case of a surprise removal, the regular remove
> callback is invoked, exclusively.  This works well, because mostly,
> the cleanup would be the same.
>=20
> However, there's a race: imagine device removal was initiated by a user
> action, such as driver unbind, and it in turn initiated some cleanup
> and is now waiting for an interrupt from the device. If the device is
> now surprise-removed, that never arrives and the remove callback hangs
> forever.
>=20
> For example, this was reported for virtio-blk:
>=20
> 	1. the graceful removal is ongoing in the remove() callback,
> [ ... ]
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Link: https://lore.kernel.org/all/fba3d235e38c1c6fcef2a30ed083ad9e25b20fa=
3.1752094439.git.mst@redhat.com/
> [Abhin: adapted subject, serialize with a per-device spinlock]
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927175203.9282=
70-1-abhinjoses@gmail.com?part=3D1

