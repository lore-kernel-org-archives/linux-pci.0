Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B82EEE8C
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533909; cv=none; b=nQvJmkAc9Q5pCQJBJTT8uXyVEi8EOPv2Mbsn/W7WxydCvZNdc2Ec0gvczHFHzO9CHkTBrAzc/wBTeEQzJDsqk67T5LdU9EH1eF8YZpSy1RA2bQeMQIZ84YxlJjAM3i9IV0zxz//QFa+nFtMCYnvFa4KFVnUXHMgcRphFDFGHq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533909; c=relaxed/simple;
	bh=VZBcNtoYFuYJ2HVaUWLYg8JjtxJy2IoGy2mgrUePjoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ASmny2Ad5NSoIE3X25UtOfvaBZJb+GXDnOn4DhR+wV+OwiAkSCNuJx30BcUpY6wBH7MQbJO+mF11yGxajphgNMDwXKhycJ2Z3+hL7BjgSQKFjSThES9XfbF5ZWrhJUzFDbCA76RbKegNn9DG4PhSHsC+As2NpyPoPC6eUvTNSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDlkZXmn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDlkZXmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6E81F000FF;
	Sun, 27 Sep 2026 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533908;
	bh=eN15eBM9DXdGtM3fZREGRk/natByr+uS+PDFHJaGaoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDlkZXmnPy7K55veFTQXgfR491qxY0zmj0oE84vXPgaawgYTrR0PY0Y7G2MQqBPZd
	 YdZK4vVqosrOxFgczKsj4BmtSDWFb9n9hP4ryzjgqj1qwFxzScJK6JnFYv134nAuf2
	 nNfQaFaTJ4movGonpqCyad+8UwZAAerV3FAvaS6FHzi9hMwwS8vOSiagtixA+Cese4
	 sgvXsNkFag01okcz5TPeBmf6HwvBOEdY1vjLNdUukne+fIlhVhqoZjZIXL8Bh83He/
	 av+S6455vmaQ04DDWCKiQFxW08vl2N6YZYnKBfXXaI8g8pb8zGWGr52nZ8+GEzOQL9
	 vep1i9jUNo/EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 1/5] PCI: Report surprise removal event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927182017.938565-2-abhinjoses@gmail.com>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
 <20260927182017.938565-2-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:31:47 +0000
Message-Id: <20260927183148.3B6E81F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182017.9385=
65-1-abhinjoses@gmail.com?part=3D1

