Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8710F1
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778202986; cv=none; b=XQoA8cK6Vu59rlbyT9zSKZWFxWjEkzCL1MuWS+2G4gd68Oi6xFITA/oViERe+rShB81VWWXV1bO+eaR1OHLV7DUCZKs7Jh5lO9E9yrCMG+gTH4TRuYNKRprxXPpc7xOfZ0XMNDdKRZ4xjCf6Q/9zbcP5FLL29uAEqhPEjJ0Ro64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778202986; c=relaxed/simple;
	bh=erbGxiBNHmYaiasJ0zEvOjFsdhmkSXpMNO3QgXG9AW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xu6IvOhsqrbuJ17kOyuQ74Qn38PWunA3aPw4/HzEuT3WXgYMK0FNIbXE12ipNXJd++TOI998jkpdH/MrX0moey1xRhFv3wJmzm5UpsP0W9WH0hw6pHSBaZTTTyTMIEtID7tXxK2aiHDhXWcU+rUA3SHCVzsM2HILBY7xf54Ml4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKNNaJjm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKNNaJjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A275C2BCB2;
	Fri,  8 May 2026 01:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778202986;
	bh=erbGxiBNHmYaiasJ0zEvOjFsdhmkSXpMNO3QgXG9AW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KKNNaJjmc/EjWZWo0Mf/rWLyBupVre40XwlIfv+GKrUJ55mSWbPrOEd42UXAvgDGG
	 NHCMtVuuxmhPHAppbDu0+XrcyciTF86AZ1y65QYGyuJJfei+AXX5hf6OyWSaLJqoCG
	 /Q9K+VhTJmDS7021LqysRx/NJB/Zk0NvjRTET6YBDDGvT2Bqh5u3RgrQD6j+jbOkEE
	 xo7TsOtu7j69QKEIN+A/jnWIhLw5V71RdyRPdxwDIQsxG5J8TkCqRKNKbl1iL9wdzV
	 8RFE7oPKoGq+MwttIgoNcD0eQ9yMcz+TG2qye2OLc44AQCBjhxB+ouL3lM/PnmfBm4
	 DN8FDp20JvM4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] power: sequencing: Add an API to return the
 pwrseq device's 'dev' pointer
Reply-To: sashiko@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507-pwrseq-m2-bt-v2-8-1740bd478539@oss.qualcomm.com>
References: <20260507-pwrseq-m2-bt-v2-8-1740bd478539@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 01:16:25 +0000
Message-Id: <20260508011626.3A275C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Exposing the internal `struct device` breaks abstraction boundarie=
s and bypasses subsystem locks, leading to a Use-After-Free on the device's=
 `fwnode`.
- [Medium] The API returns `NULL` when disabled or passed a `NULL` descript=
or, causing a null pointer dereference in property querying APIs.
--

commit 92d97440cc414d34602dcddead25760951c5cdce
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

power: sequencing: Add an API to return the pwrseq device's 'dev' pointer

This commit adds a new pwrseq_to_device() API to retrieve the underlying
device pointer from a power sequencing descriptor. The intent is to allow
consumers to query the power sequencer's device tree node for specific
properties.

> diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/c=
ore.c
> index 4dff71be11b60..96ad557297f5b 100644
> --- a/drivers/power/sequencing/core.c
> +++ b/drivers/power/sequencing/core.c
> @@ -965,6 +965,15 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
>  }
>  EXPORT_SYMBOL_GPL(pwrseq_power_off);
> =20
> +struct device *pwrseq_to_device(struct pwrseq_desc *desc)
> +{
> +	if (!desc)
> +		return NULL;
> +
> +	return &desc->pwrseq->dev;

Does exposing the internal device pointer bypass the subsystem locks and
registration checks?

The power sequencing framework internally protects device teardown by
wrapping device accesses in rw_lock and checking device_is_registered(),
such as in pwrseq_power_off():

	guard(rwsem_read)(&pwrseq->rw_lock);
	if (!device_is_registered(&pwrseq->dev))
		return -ENODEV;

If a consumer queries properties on the returned device directly, they might
do so concurrently with or after provider unregistration. In
pwrseq_device_unregister(), device_del() is called, which drops the
reference to the parent device. If the parent is subsequently freed, its
fwnode can be destroyed, leaving pwrseq->dev.fwnode as a dangling pointer.

To safely allow property queries without exposing the raw device pointer,
could the framework provide a dedicated wrapper function like
pwrseq_property_present() that internally holds the lock and checks
registration?

> +}
> +EXPORT_SYMBOL_GPL(pwrseq_to_device);

[ ... ]

> diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consu=
mer.h
> index 7d583b4f266e6..3c907c9e1885d 100644
> --- a/include/linux/pwrseq/consumer.h
> +++ b/include/linux/pwrseq/consumer.h

[ ... ]

> @@ -51,6 +53,11 @@ static inline int pwrseq_power_off(struct pwrseq_desc =
*desc)
>  	return -ENOSYS;
>  }
> =20
> +static inline struct device *pwrseq_to_device(struct pwrseq_desc *desc)
> +{
> +	return NULL;

Will returning NULL here cause a NULL pointer dereference in consumers?

The commit message notes this API is intended for checking the existence of
specific properties on the device. However, functions like
device_property_present() do not accept a NULL device pointer and will
unconditionally dereference it (e.g., when calling __dev_fwnode_const()).

If a consumer uses optional power sequencers or dummy configurations when
CONFIG_POWER_SEQUENCING is disabled, passing the result to
device_property_present() could crash the kernel.

> +}
> +
>  #endif /* CONFIG_POWER_SEQUENCING */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-pwrseq-m2-=
bt-v2-0-1740bd478539@oss.qualcomm.com?part=3D8
