Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6319D8A8
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743015; cv=none; b=RHLIlbCekYB7br1+stRw/peYRECbuhWUh7oXAzlHlcpSNwpUhrg+q01b5g9a1dinRnel+mciH/TrQisG4OhM3dZ8+Ne1k6Cl5sa7PN9tHk0+R7yfLRZKy6U5wyMb6n1xK0s2hjBdIu5ffvVgtz/3lzlGLunzIF+bA217G2seOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743015; c=relaxed/simple;
	bh=YgP9+fTgecFgrzXw8dHRwpuO3lAncIp2JSOfxz3HwEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dkc2EDjjsdBKo1ybZ++gCgb+/TFER4f4gucAwntIHK5KXzPlRdh/WYo22S2o4PrflowDqy5QKhJCf7adYP9dwYv+JbQUWNEWejz5M5WAH8hi78dNFmylfPgv4Pd33Xi0/v630XgAw14XHSDNSQd9zLI2YKGl+L4HzD/qDwBucMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlqTrz5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlqTrz5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EEE1F000E9;
	Mon, 25 May 2026 21:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779743014;
	bh=Obx03ptXsMDVoojnyPoqS8zgmoJh3G6KPhCnv2ycdFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jlqTrz5k2Tdiuxw7EolMDRm01NBmoNNOTSzjZIAtSHO5cLjnkcum92sziMwXZ1Fby
	 JW5skiipwGJkn45HrakIwOQUOK1l7ePVpq+hpA1xqx+mCDf3Z+iaE+qmqtLrreXYxS
	 yC/rQamYTtlSUWJgoFRv3fQAGG0S8ZtcCMW/esV806kgOexutcZwQ6NpqS831+ctg1
	 7mMt64urmLOaxa/SzEzzpL1lW6HGdbKz4c0EWSdgTmHxx64N7rn5xvC+CE9+zTQo3n
	 6zcuNcLYAF92qTfHsHqW7Spx4/9RsJFF42X0f6wHylPE3DHmtpBYYsxvNvD7GmMh1w
	 W4CDZpYKE1ZNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/24] rust: driver core: drop drvdata before devres
 release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260525202921.124698-6-dakr@kernel.org>
References: <20260525202921.124698-6-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:03:33 +0000
Message-Id: <20260525210333.D7EEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Use-After-Free vulnerability in devres cleanup sequence due to=
 premature Rust driver data destruction.
--

commit 7750f9ee9a8388dc1f41404481618c4bf5ae2148
Author: Danilo Krummrich <dakr@kernel.org>

rust: driver core: drop drvdata before devres release

This commit moves the post_unbind_rust callback before devres_release_all()
in device_unbind_cleanup(). This allows Rust driver structs to hold direct
references to devres-managed resources without dangling references.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -595,9 +595,9 @@ static DEVICE_ATTR_RW(state_synced);
> =20
>  static void device_unbind_cleanup(struct device *dev)
>  {
> -	devres_release_all(dev);
>  	if (dev->driver->p_cb.post_unbind_rust)
>  		dev->driver->p_cb.post_unbind_rust(dev);
> +	devres_release_all(dev);

[Severity: Critical]
Could moving the Rust post_unbind callback before devres_release_all()
trigger a use-after-free vulnerability?

If the driver data is dropped during post_unbind_rust(), but devres-managed
actions (such as shared interrupts or timer expirations) are still active,
can asynchronous events dereference the freed driver memory before
unregistration completes in devres_release_all()?

>  	arch_teardown_dma_ops(dev);
>  	kfree(dev->dma_range_map);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525202921.1246=
98-1-dakr@kernel.org?part=3D5
