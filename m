Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162136;
	b=KRsm9m2DXLLEk5YAjYf8zwC/0VdBicEbDWjaeWWza3Sv7CX2aVtNvirUkaFyLv6FAlIx
	 TQJi6VhEhCko3h+NpNc/GUPcNV4Ecd+Lnq6layOQLVnyfX+J7Fqp6Ag6xQf5dDIoyhs67
	 jtUUqTBMFlQPY+eZxdZmDT7mhA+/k/Qt4eHB7A+wA2ZrUvuzk7mR8XSdLi/O8O1dOA6gX
	 hgCIiuKMPQmbM+qpKEHO97F7sfzeiETFDLQpb7xJd2eivm6rMd+0BJ6FU9TD8fI5RAuvq
	 Y1uwBNU2DwA1cxZTT/oZHWD673BikJNInZeGeKXeUU6e/HZrO/ubUpszkETtDRxsWvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162136;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4qbMDdkcsYRFuqp9UaIXueaXKOQQNanFOUl3rct7bo4=;
	b=1XnKWyeSDf1kMyFeMZxQQVqsXf9QwLvlWtCXq9uCJ2baz5xpQqXMSUtdytzhMP/KH6la
	 wD+J3ZhLOwhnDIKC5Z80ChqaCHk3VOScKkv9bxcq94CJXhFBsrT/NxytFdbZmPGyk7R3b
	 iyB5orcLlfYPl+qAJN+btAAurzzTAZReT3olU7/Y9Ye/jq01vkl6MPQXZ2PnQmYzzHkbL
	 7O5/nEXw7tZKUuuLXYV8wHO0OZ6Jsp74WqJcL6bjQ7BuHH3AMHwIarp/mSava/vTVum91
	 87w1JrjHab3e026gM+jtE4nuIY/2HtEJy3gy08D57GAYhTFdf8bQT0cdmkcCcvW934g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1aX+dMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CDF606A325
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1aX+dMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FC71F000D0;
	Fri, 20 Nov 2026 08:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162136;
	bh=4qbMDdkcsYRFuqp9UaIXueaXKOQQNanFOUl3rct7bo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N1aX+dMy5cNDFXvPsHuivEZSjskmaDkqT6cmGQnHzSVgGo0yReFyTFcBj83LvHk9e
	 ywAvQly5TG9Zv/Oob2TYGYnkvr8RlPvmjOw1Ok2f3Xj2PFBhWESEpnE4o3d1mO5x7k
	 NQAwXrbxoQE0JnYiCzsrHngyt5wypqw4DWZqQQRPe6appnOLz2sB5ll4aOngbIUGbv
	 n0tjIJ3umftSLfre8OAzOsv3Ep0pb3kOLHiq9L2To57DwRnQmY4uhozZhMhh1AaFri
	 6TMdobuqSvpsUi7QBvDB0YLDvYRbFyNY0UJLciXANTpQYAU981tvvZlB8AWd+uqi9T
	 5V7mY7U3ZEyaA==
Message-ID: <sashiko-outbox-224682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/IOV: Don't make sriov_numvfs reads wait while VFs
 are enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SW9udXQgTmVjaGl0YSAoV2luZCBSaXZlcik=?= <ionut.nechita@windriver.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120080143.56701-1-ionut.nechita@windriver.com>
References: <20261120080143.56701-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:08:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> Since commit 35ff867b7657 ("PCI/IOV: Serialize sysfs sriov_numvfs
> reads vs writes"), sriov_numvfs_show() takes the device lock so that a
> read does not return a stale num_VFs while sriov_numvfs_store() is
> enabling VFs and they are becoming visible. The store holds the device
> lock for the whole SR-IOV change, and disabling SR-IOV can hold it for
> a very long time: with vfio-pci, sriov_disable() waits for the VF
> driver unbind, which waits for the userspace driver to release the VF.
>=20
>   sriov_numvfs_store                       sriov_numvfs_show
>     device_lock(PF)                          device_lock(PF)  <-- waits
>     vfio_pci_core_sriov_configure
>       sriov_disable
>         pci_iov_remove_virtfn
> [ ... ]
> device lock while num_VFs is 0, can still be long. Make it
> interruptible, so that a reader can at least be killed.
>=20
> Fixes: 35ff867b7657 ("PCI/IOV: Serialize sysfs sriov_numvfs reads vs writ=
es")
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120080143.5670=
1-1-ionut.nechita@windriver.com?part=3D1

