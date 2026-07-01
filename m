Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DBF3AEF3B
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938000; cv=none; b=eLeiP3bBwE0KJ/THu2s+rDaCMTPP2ogFDPADF1osFExmErs9VPONA1QrYXt4P571uRWh6s3rpbcTtiabT9X4Ezi5POi7Vyc2ZWpdA6llysVFESi8b/saLCKHrlRSMYOC7x8BbrSpeCLTReJGITmZQVlrlsg5KuAotBnK3NGsRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938000; c=relaxed/simple;
	bh=6mD35oTyshqzR7lmzBvJK35M+/uVOmiCnaaI/RdynPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=doXa5gake4kCJdL/0wivMFnQnWnNTmEsbP9LA6upjnQCZrrE8i/xbmO/FRc9PnAigtCnEhb+NnTzV7RuLPoApBA24SI9fWxwC4iFzPunAdScl2nhLywsTBN+5j+AFhEw2xV1q1oml8IXuq2KYCL4H+3PbZH8Nd1JJixbwdyNDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmlRcEvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmlRcEvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6114A1F000E9;
	Wed,  1 Jul 2026 20:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782937995;
	bh=S9iJhbgMVUVi++yBye3lwbwqTW4EHy3M8xvme7yGP/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmlRcEvMW/ud8fyA72/UY5MvPJwoHDM3fvn+PALZLzDMvm4usR5o3rQZUfEc8ikn3
	 uE6N4NzCbDTjxHGh+BC9tBKS9pyV9pLK3bc13hCphDaHjdOq2HXcaPqgn8cdpMdSs0
	 FB81Lzgtp8RgpeK31B3FMvpnm/8mgbKJdL6bZkP8S8p2yxT30OkKEJNGtnXLUv4rom
	 HcHeDInJBk781fKOKXaysxY80N3E1M5LSPytRdb5lselw83bMGhBZAJ8RXGE3v8nrj
	 9W7v1Ke2+lwnPsaQTvY5TO4U3y+e8twU2CcVNWp91jxTAhrv8a9Gbjn1OHjZMY4iZE
	 8Mw2tjB8SYXTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC RESEND 3/7] i3c: master: Add helper to query bus
 wakeup requirements
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org
In-Reply-To: <20260701201533.220818-4-adrian.hunter@intel.com>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
 <20260701201533.220818-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:33:14 +0000
Message-Id: <20260701203315.6114A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Concurrent execution between `i3c_master_any_wakeup_enabled()` and=
 the device registration worker causes data races on `desc->dev` because bo=
th paths use a read-side lock.

Pre-existing issues:
- [High] The `i3c_master_any_wakeup_enabled()` helper can dereference a dan=
gling `desc->dev` pointer if a previous I3C device registration failed.
--

commit 3ed97d097ea9f23fefcb772811737adab713eb66
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Add helper to query bus wakeup requirements

This commit adds i3c_master_any_wakeup_enabled(), which iterates over the
devices on an I3C bus and reports whether any of them are enabled for system
wakeup. Controller drivers can use this helper to determine whether wakeup
support must remain available while the system is suspended.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index a36f9b617cbf7..979457e635bd9 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c

[ ... ]

> +bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master)
> +{
> +	struct i3c_dev_desc *desc;
> +	bool wakeup =3D false;
> +
> +	i3c_bus_normaluse_lock(&master->bus);

[Severity: High]
Does this code risk a data race with the device registration worker?

Looking at i3c_master_reg_work_fn(), it allocates and initializes desc->dev
while holding this same read-side lock (i3c_bus_normaluse_lock). If the PCI
controller runtime suspends and calls this helper while the registration wo=
rk
is executing, they can run concurrently since both only hold a read-side
lock.

Can this lead to a use-before-initialization if device_may_wakeup() is
called while the memory is still being initialized?

> +	i3c_bus_for_each_i3cdev(&master->bus, desc) {
> +		if (desc->dev && device_may_wakeup(&desc->dev->dev)) {

[Severity: High]
This is a pre-existing issue, but could this check trigger a use-after-free
if a previous device registration failed?

In i3c_master_register_new_i3c_devs(), if device_register() fails, the error
path drops the reference with put_device(&desc->dev->dev). This frees the
underlying memory, but desc->dev is never set to NULL.

If that happens, won't this loop observe a dangling non-NULL desc->dev
pointer and unconditionally dereference it during suspend?

> +			wakeup =3D true;
> +			break;
> +		}
> +	}
> +	i3c_bus_normaluse_unlock(&master->bus);
> +
> +	return wakeup;
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_any_wakeup_enabled);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701201533.2208=
18-1-adrian.hunter@intel.com?part=3D3
