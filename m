Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AE636CDF8
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258367; cv=none; b=B3g1P/pn5xX6JEUD6qZYVslKXzZh8cWY0o0EdalxZUhRXPexnKvO6cD5fUDH3qdvVQIckDq6TyLa4Ck+NtzspXnW24hPTQBvT3ANe57CArRVdV38nkaX4EcqVl8GMujavQGWILYXmCWXTxIJrHq8UDuuIIzKDHPVAg+ro+Z6YjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258367; c=relaxed/simple;
	bh=SOLKzv+AmVm2a5BbkMDcpA9ToWNsoEA9XZ+Is8H/26o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rUvy1ysMqXdlnD35q4Ui7zm+Pn7Fk/7yJbllHTSUxGLXUWeY2VusAQEGnTIrMWQbMSW79cKWWTZJaNKz5oyM/In+Bb2ZOh+SgIt6oA/ruliAvW+n4uQ1mJNeZXu/jCeuWHvte9YjJLPKep/mpYFLiTY9ArWRhTr0OsLIJhv0MnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYpYh0xP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYpYh0xP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6361F000E9;
	Tue, 28 Jul 2026 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258366;
	bh=SdsJEzWZmxkSCTar71zu4Z2o3Nn1lx2ko0LroJtCwLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YYpYh0xP0ijMcO15KVuSup/osEU2aXvPAk8nXkg+GSzCPa4D48d04ddqpfxgsKJZf
	 2yCUxStbUxsQ5vf8vpUNgZa3XleDIoDpu45mQLg7c7SvSyc6Wdt5LUtxF8+CZHv5Uy
	 DhuF3f0kClgrtRHG83BoOGyZOKvkxLlVS0VING1Le9SzJfPdQpuycrX8VrZveDyTmp
	 B4sakF3lCZFl9GapcnkQ9XNEQ5Cl62hPYeGnVW+AsKhRKK4FiElNl6N+qNutYwDWLY
	 oLoQvU+oAcksz5nEmubPiiMLSBOpcsM3ezaMALpMxGms8oU9KOlOlTJKyNET2E8aDI
	 rehCSscVGMsoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 5/8] i3c: master: Reject IBI requests from
 non-IBI-capable devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, Frank.Li@kernel.org
In-Reply-To: <20260728155308.142713-6-adrian.hunter@intel.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:06:05 +0000
Message-Id: <20260728170605.CA6361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Leaked workqueue in `i3c_dev_request_ibi_locked()` when `master->o=
ps->request_ibi()` fails.
--

--- Patch [5]: [PATCH V2 5/8] i3c: master: Reject IBI requests from non-IBI=
-capable devices ---
commit d69e542b87c33e0789e410767b2ee354fe000c28
Author: Adrian Hunter <adrian.hunter@intel.com>
i3c: master: Reject IBI requests from non-IBI-capable devices

This commit adds a check in i3c_device_request_ibi() to ensure a device
reports IBI support before attempting to set up IBI handling. If the device
does not advertise I3C_BCR_IBI_REQ_CAP, it now fails with -EOPNOTSUPP.

> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 101eaa77de686..307ca6dc04ca0 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -205,12 +205,14 @@ int i3c_device_request_ibi(struct i3c_device *dev,
>  		return ret;
> =20
>  	i3c_bus_normaluse_lock(dev->bus);
> -	if (dev->desc) {
> +	if (!dev->desc) {
> +		ret =3D -ENOENT;
> +	} else if (!(dev->desc->info.bcr & I3C_BCR_IBI_REQ_CAP)) {
> +		ret =3D -EOPNOTSUPP;
> +	} else {
>  		mutex_lock(&dev->desc->ibi_lock);
>  		ret =3D i3c_dev_request_ibi_locked(dev->desc, req);

[Severity: High]
This is a pre-existing issue, but does i3c_dev_request_ibi_locked() leak the
allocated workqueue if the master's request_ibi callback fails?

Looking at i3c_dev_request_ibi_locked() in drivers/i3c/master.c:

	ibi->wq =3D alloc_ordered_workqueue(dev_name(i3cdev_to_dev(dev->dev)),
					  WQ_MEM_RECLAIM);
	if (!ibi->wq) {
		kfree(ibi);
		return -ENOMEM;
	}
	...
	ret =3D master->ops->request_ibi(dev, req);
	if (ret) {
		kfree(ibi);
		dev->ibi =3D NULL;
	}

If master->ops->request_ibi() returns an error, the error path frees ibi
but doesn't call destroy_workqueue(ibi->wq).

If a device probe repeatedly fails at this step, could this result in a
workqueue and memory leak?

>  		mutex_unlock(&dev->desc->ibi_lock);
> -	} else {
> -		ret =3D -ENOENT;
>  	}
>  	i3c_bus_normaluse_unlock(dev->bus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728155308.1427=
13-1-adrian.hunter@intel.com?part=3D5
