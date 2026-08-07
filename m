Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E04746D1
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116392; cv=none; b=hWapsVuLpYcarkPXKVfAna3d43VoeFI58rLB7ZyiEjIdHbl83fC0mpMUu4wgV/IebNFIoOXnNnHcrTB0RpFk6LEyahOsCfJhRMKEcThrRG+XVZ23F4WplzR5IZOFiJOcggCwtuN/lvSjz3TRuPF3Eu6IookEFFEct1eKSA7DtCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116392; c=relaxed/simple;
	bh=G6J3Ndg1kFBv52FfRUS84XSWUqMErFPDXCG4jDj4Uss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aUDL80hTarufQYMzRQXhgWmIJYAJ5nMpRpqzTqybM1gxjockllzO28LN/eP9lxEaXhhkgr2i1zdYyTgRK1mZYwNVaMFrRaKxmK6zso2arH1Eir45Ba0Ex4kulpwfKARlJL0MbYvojW93ckYh5I2oun9v9LaA46ZCIRUxzYzCJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6EW6s51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6EW6s51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94091F00A3A;
	Fri,  7 Aug 2026 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116391;
	bh=fddBzK07EXdLO26iWtIly/YQlLIdZ6U70YGNNqJfWQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6EW6s510slvrpFWGN0sCaG0ekBbkcpapVOOtmj+aR7jVvzIxthsHvdJfogKi0rCa
	 9rRVtBV6wu1x6OSCKITXb2BoBCLO91g5cO9MYR4D5pGHtAFOz1P6gd1EqBTEtkFmPL
	 Lcb7NCur2Emg8Tu0H7fzDus9ixhCYFuU4h8zE0jWVfCgJ4+C5MjPf85tntmX3vNS0B
	 4cX9CABxTL3TKVZfsZfveAEu1KnnA+WcQtyZTa8YrtoFtblmgyr+aLpc37NmPv9j6T
	 HMRbo2nTPdk3oMWhgUqeoQryHd9/H6n5fcjO/taxt5xeTDVfLa9MMigQSK0hHWRX0c
	 YRqjitVq7KbpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 11/14] i3c: master: Reject IBI requests from
 non-IBI-capable devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-i3c@lists.infradead.org, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260807145638.168865-12-adrian.hunter@intel.com>
References: <20260807145638.168865-1-adrian.hunter@intel.com>
 <20260807145638.168865-12-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:26:30 +0000
Message-Id: <20260807152630.C94091F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Workqueue memory and rescuer thread leak on the error path of i3c_=
dev_request_ibi_locked.
--

--- Patch [11]: [PATCH V5 11/14] i3c: master: Reject IBI requests from non-=
IBI-capable devices ---
commit d6c55123f731ff15725d89d2f9b3fef0f879efa9
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Reject IBI requests from non-IBI-capable devices

This patch checks if a device advertises IBI support before attempting to
set up IBI handling. It adds a check for I3C_BCR_IBI_REQ_CAP in
i3c_device_request_ibi() and returns -EOPNOTSUPP if not supported.

> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
[ ... ]
> @@ -204,12 +204,14 @@ int i3c_device_request_ibi(struct i3c_device *dev,
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
This is a pre-existing issue, but looking at the error path of
i3c_dev_request_ibi_locked() in drivers/i3c/master.c, does it leak the
workqueue and its rescuer thread if the hardware driver fails the request?

drivers/i3c/master.c:i3c_dev_request_ibi_locked() {
    ...
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

	return ret;
}

When a device driver requests an IBI and the bus controller fails the
request, the ibi struct is freed but destroy_workqueue() is never called.
Since the workqueue is created with WQ_MEM_RECLAIM, wouldn't this leak a
kernel task and its associated memory on every failure?

>  		mutex_unlock(&dev->desc->ibi_lock);
> -	} else {
> -		ret =3D -ENOENT;
>  	}
>  	i3c_bus_normaluse_unlock(dev->bus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145638.1688=
65-1-adrian.hunter@intel.com?part=3D11
