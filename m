Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6443846E
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248043; cv=none; b=rROp8IZ0AMS+jsYfG0h4wLToN9Va0AJOLpKeNDVLuvnQvZGY47QsvxEr+mrKm1JB2RUGS9OzLvpD+BCcK2jPuQIe5MHVxQigcTUsTILZ6ZY/VlWn5UEYLDj/lyNFdyyUAKL7KU+on5fg81IOmKphOTjfaaYjOCfyQmIx7GCp8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248043; c=relaxed/simple;
	bh=Cpye+z7RjWYHu6tKBxGDIrNOtY/JUNOksuYckdyF7jU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XETr2nvDLVH+Oq0xAyhIrlXzxcNFhg8C2zbOctInCzimUx4gDZbRDTlv/lwZRUYfusUgxIrtoRuS64GVMW9vqzAdmKTLWxEEJ3OCSndAzpK9BaYQVxytFiwtsyrEPfGoS6jo0J64PIFw+2yW2xd/WsPmZK9otdc/UJuU6IsCmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUOKHPFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUOKHPFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052341F000E9;
	Tue,  1 Sep 2026 07:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788248042;
	bh=Cpye+z7RjWYHu6tKBxGDIrNOtY/JUNOksuYckdyF7jU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CUOKHPFPTYEVbl42bm5ET4jp51eqRysfVGPbB99x4AdkAOi0pi5dCZCZDoMWt4TvW
	 l/ttJal92u6r00Wiqoe1MDSQnQGKy5YLH96AqVzbTntNlXWvS9FcUUMWTcI3IeVt8K
	 5DOwGJYqC5LIx1ksqdQWTN9Xe9AtiWzC1RXBcC8VD5R1/+oHUbb7+Qqd2CluSiLWrF
	 uJlNfS8P4MzZ1uY6hVy8uAeQFU6XUEq8Tvk36T+xwsReITOSE0Vr8fhqyjx6y+BQXy
	 YiwZlq/1s12RCWxZ9gRmukQV5tr8xsomeRU9zuu5eFyAAwg1LsrzYNYmr7af3LOjY2
	 sCCg+FJNe7MUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] pci_ids: Add Hygon Family 0x18 DF F3/F4 device
 IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lin Wang" <wanglin@open-hieco.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260901071700.3255382-2-wanglin@open-hieco.net>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-2-wanglin@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 07:34:01 +0000
Message-Id: <20260901073402.052341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Hygon Family 0x18 node discovery identifies Data Fabric misc (F3) and
> link (F4) functions by PCI ID rather than a fixed PCI slot.
>=20
> Models 0x04 use 0x1463/0x1464, with 0x1493/0x1494 on the mixed-silicon
> variant. Models 0x05 through 0x08 use 0x14b3/0x14b4.
>=20
> Some IDs have the same numeric values as AMD DF devices. PCI identity
> also includes the vendor, so Hygon-prefixed names keep the two vendors'
> definitions independent.
>=20
> Signed-off-by: Lin Wang <wanglin@open-hieco.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901071700.3255=
382-1-wanglin@open-hieco.net?part=3D1

