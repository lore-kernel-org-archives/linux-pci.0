Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9862030A
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408629; cv=none; b=OGdYBWCxf4HVOxThriV+TkJFPV3CXDUOC4LXzAHJrE8o4L1H5/CcRmMwNNP1V2zyoDXf2HTj0nGlDalDY+rkzSOO4qKgj/fTCL2eEiWvL6KeCy4C6asg/tQkHUqw5lv7HvdsgK86nUCpla9PUNMx9DY70/QVLu7t+Fc7paoKVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408629; c=relaxed/simple;
	bh=VLBBTilbdmkiDgJGsBvkXZ305XnKEDlPB+OVaWKd1Q8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FpIgsLAd7IDuodvreEn5RNNwGiKy6jEkdJRMB8Jp0I7ZBLTvg0klFNmQ9wq8beaIDdkbwLYPa+EZG+d7NzNYWWLTqYAkjn6RGxBw6Gem4ryrfOj1oNoulgeTosHz6C04/8o81PpXeGE9n17hL23Nbpxi5ogDN7bePWiriLPrsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpHs8l3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpHs8l3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EC91F000E9;
	Fri, 22 May 2026 00:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779408628;
	bh=tAya/5Z5qciDetKwlwm5Oj2ytMjq6x2cpViCnJ4DIFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VpHs8l3vZrs1StyjWPnz7Hpy6+lqlozLpwowAQSMJfGPMN0KGOP6NaYaQngKvKsoW
	 OI3I1efQMG2VojQ0hKkDWLNWS9+x/VDESbgx2rXauUR+pHPtrspmQmjvyGphkgiDrC
	 2CELGLrjgLbeP2qriAS8XS5cwdy+rkBNVulU8IjmwamSNd7yeo/h0GdktbXDa+z/kU
	 1NHGO745DsOiOZ99BnldJA309bv1ydhFbAS4b/Pn+Py4utKTbV7cNklLqSr/pciP0m
	 OyvqKouGIrs42yYISx5aHwz2XBuZxCmK4EqdcDsYMhhD0wf2GKjomWsmQk4sLwgqYt
	 6BN58fKgegidA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/27] rust: driver core: drop drvdata before devres
 release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260521233501.1191842-5-dakr@kernel.org>
References: <20260521233501.1191842-5-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:10:27 +0000
Message-Id: <20260522001027.C7EC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Reordering `post_unbind_rust` before `devres_release_all` viol=
ates LIFO resource management and introduces a critical Use-After-Free (UAF=
) vulnerability for drivers.
--

commit 13c328caac1fcbff52dab3f760a99e254b3f15b9
Author: Danilo Krummrich <dakr@kernel.org>

rust: driver core: drop drvdata before devres release

This commit moves the post_unbind_rust callback before devres_release_all()
in device_unbind_cleanup(). This allows Rust driver structs to hold direct
references to devres-managed resources by ensuring the driver's device
private data is dropped before devres actions are released.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -593,9 +593,9 @@ static DEVICE_ATTR_RW(state_synced);
> =20
>  static void device_unbind_cleanup(struct device *dev)
>  {
> -	devres_release_all(dev);
>  	if (dev->driver->p_cb.post_unbind_rust)
>  		dev->driver->p_cb.post_unbind_rust(dev);
> +	devres_release_all(dev);

[Severity: Critical]
Does this reordering introduce a use-after-free for devres cleanup actions
or active interrupts?

By executing post_unbind_rust() and freeing the driver data before
devres_release_all() is called, devm-managed resources are still active
while the driver data is gone. If a hardware interrupt or timer fires in
this window, or if a custom devm_add_action cleanup callback relies on a
context pointer to the driver data, won't it attempt to access freed memory?

To safely accommodate the lifetime requirements, should the driver data
instead be modeled as a devres resource itself so it is dropped at the
correct point in the unbind sequence?

>  	arch_teardown_dma_ops(dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D4
