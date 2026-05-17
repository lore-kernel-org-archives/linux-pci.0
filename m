Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6E194AE6
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778978247; cv=none; b=PeY/egw9VzU6wWNriw3oZfuf2GB5OjMDjvbpSs6EGlf9XwEF7+IDOAF3m34/6c59exPgk9oyPMr+YN5fdZ9uA8bry+u5QfQOv1keCizYtk9LXGGu2wybnRcJ0EGHowZueIaew652vIB1bIrtksMlgkPWQPyV45zk0iXmeg5Xd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778978247; c=relaxed/simple;
	bh=6af3TVwIWJxSLiuDG/PMKOR+kezaTBO/gp03QFSEDgU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ky75WWV+sWhu87625lvIHru9Du9RNYUH9PyGWqTTnElLSK9fqSXW/jX0dZUqNpqtKklwO7W18p0k7GHSP8bmelels4pXb7kyE81Ll3lpxGNnFS1V8TwOB9zzGQghw3RtIAUIrbm9hkQ73S8Pul6TXlWv5qUQ0AFhmgY4Ws3rHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyQuUNuD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyQuUNuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880B5C19425;
	Sun, 17 May 2026 00:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778978246;
	bh=6af3TVwIWJxSLiuDG/PMKOR+kezaTBO/gp03QFSEDgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XyQuUNuDvkqUFL0i0DqujHLTqhbTxEQPVOEBiHZZWGbicbLtCFvoXtK+5qjGRsf6l
	 79ZosBh+rAbRRK7Eigros1uAXOcE90h0h7UP1yC/xmAkKJ/qAjv9z/54hmClN60gaB
	 Htbtf9bbF1MmsAP619w5BQAYMemsb4WlggWcvhkp2Gh80aHGh+oYmVCN/j23X84/Ye
	 e2RGxz1Ij64keTfJkhn1V9i6VBLQoDAcg0MfmD/nNO8a5EhAKc+RIWEUB9YcqwYf3i
	 0DEGrecloszR9It5R9olyPjY93wAyUZ6MPhN+Rnj7yHuiQucBe2Mo7XZUf/CGMXjCT
	 CLwu3inRityZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/27] rust: driver core: drop drvdata before devres
 release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260517000149.3226762-5-dakr@kernel.org>
References: <20260517000149.3226762-5-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:37:26 +0000
Message-Id: <20260517003726.880B5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Moving `post_unbind_rust()` before `devres_release_all()` subv=
erts the LIFO devres teardown order, leading to a Use-After-Free (UAF) when=
 devm-managed resources are accessed after driver data is dropped.
--

commit b146fb08eba0390797844ff1665d36d951226d10
Author: Danilo Krummrich <dakr@kernel.org>

rust: driver core: drop drvdata before devres release

This commit moves the execution of the Rust-specific post_unbind_rust
callback to occur before devres_release_all() in device_unbind_cleanup().
It aims to allow Rust driver structs to hold direct references to
devres-managed resources by ensuring the private data is dropped before
devres actions are released.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 5799a60fd0585..be59d2e13a157 100644
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

Does this regression subvert the devres teardown order, potentially leading
to a use-after-free?

The devres framework enforces a last-in, first-out teardown order. Device
drivers typically allocate their private driver data first, then register
active endpoints like devm_request_irq, multifunction child devices, or
sysfs attributes.

By moving the destruction of the driver's private data before
devres_release_all(), any devm-managed resource will remain active and
exposed to hardware interrupts or userspace after the driver's data has
already been freed.

Additionally, dev_set_drvdata(dev, NULL) is only called later in this
function. If an external event occurs between post_unbind_rust() and
devres_release_all(), or if a devm action callback internally retrieves
the context using dev_get_drvdata(), could this dereference a dangling
pointer to the already-freed driver data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D4
