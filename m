Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445640;
	b=LYnellqeSLTx4qxiT1k0ASW2JlZJoKGfJGOjXAW0ZACIo7mjZNxB3gicZy4uYUgxGB7X
	 tj67LZD6WmhWdDfGO5EJvaVBbFOmHphNIq5xtk92oZA1MZfU89JBG9s7aYC6qF2P7JKXI
	 PzmvKFl9o6dxL39+fFVJBJ9hdtUjtHuJbiXdksXeaMqEhBY0/LaLqTdrMZf64101ZUPbv
	 IfcjEd/F+Mnc/KD4fjQEHahijX7KKoY0eSmiyuojY8Ntg9AK31ueehEMYUzOBsF3DXhC6
	 lI7qyhNRQMVx5dfkwQZvGT+/GnGlUdRmEw6QMILd+oMOJjCmzWwP+9VKff7yhqS8wPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445640;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p4gcYViUT/rR83NAGTYh0OexBVN3tLBNAn50ToO4dxU=;
	b=HGMnJugg5/THRHXiRVLx8TyT/i5J+PMOc/WtDbUE9lhz8ApYlRs6Hh9aBMZoSyL+lnxK
	 APJn6ZcaL0ZfeM+HDx4mPEviycDeKAJsEKAjxWkjlPbt0QuLSJEotChyqT8ruSddtgmB2
	 25j5kKLHHdFbvKfXFtBCLhC4VDP4AEcd7LfnkUGnPRdo6OOIk/tD59GVM2XzrvABDatBA
	 nHLL0LaNNCr7+p+3rIYE4zrpFaI3aiVO1ZRJP1TDSHLpAA9J1bPby1naI2ZneLsGr+QEs
	 qF8Zl4rqMwCf3XbFeN9ydxje0MA8SrtSsI+Wy+jT2u1BvJy5lhaatUuhZfB4OE9KExw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7DRKGmC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2464606A31C;
	Thu, 12 Nov 2026 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7DRKGmC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0EF1F00A05;
	Thu, 12 Nov 2026 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445640;
	bh=p4gcYViUT/rR83NAGTYh0OexBVN3tLBNAn50ToO4dxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S7DRKGmCWIKvTK9Uq6DLvRlhmbnHDAaClMT9Gb+zNRcDAPNxh1/bNEdzuEuU5NdYA
	 uyyjLr4Zg+hVXmPne42VJi1Hy68wNroG3nfZ6LnLLHd+K8VuaSQrkcn7xm3vGZHQUD
	 aE+B+l5hCmC5efi6Sl/89LtdsO7WItSNVkAsXM9053mFHneGZsND5jGF+Gy0DvI7Nz
	 9GQeBJism2wI5kSeAR+Zd6Ta9uYvgonN7gSfrUWVofC+gOg0pfTtKBtb7+1oFLvb8x
	 LDqU7sqLB7vCDW6vlbfIfJc6BKn2aYHkhEbbX0FkpleKhhaN6DmWneb93uih3J6Lya
	 Y3NkH1LvyjSRQ==
Message-ID: <sashiko-outbox-210038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] rust: platform: remove the unbind() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20261112005455.1224352-3-dakr@kernel.org>
References: <20261112005455.1224352-1-dakr@kernel.org>
 <20261112005455.1224352-3-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:07:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The driver model uses native Rust lifetimes to let driver data retain
> device resources and a Device<Bound> reference for the duration of the
> binding. Both remain accessible from the destructor, so a separate
> unbind() callback is no longer needed.
>=20
> Remove platform::Driver::unbind() and the adapter's remove callback and
> document that device teardown belongs in Drop or PinnedDrop.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112005455.1224=
352-1-dakr@kernel.org?part=3D2

