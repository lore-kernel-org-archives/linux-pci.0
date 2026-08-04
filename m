Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8C366DA3
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853722; cv=none; b=D5dPaCK+LHht7FyamOKn6OAZul2xfH26yNRRlY+z8AB7U04gsW/HAWqA643PAT7VTFm/lsRaF/lRDiLal6H0Z5IkzNBsKHxvHypGM/jQH5cG8MEpIt0S7kT3DEZcdQTnKySqhj7YajUfgM2G4cVLwO6Cze2Ldd0/ZfC4Hpy3d9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853722; c=relaxed/simple;
	bh=Lxb/CVs4WIYImAfPjCnra7UVNPvjAOOfLJNQdJqhDLo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zym1S+U0nUpZxNqFAXZZVbxNvLW+lu1Py2AydnOPdv4bDnaxFBXuIH1stUp8nNYPWo849mqmkShin0TyLZeP61TK2Kbmyc/AdEJiQqggs8xnt19Kl3/26YMRVtfkAyXZxbwWfmtCYWb/FO1C47i4gJqZ2pE3/Yz4zlp24xe/5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUj9gTIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUj9gTIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE161F000E9;
	Tue,  4 Aug 2026 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785853707;
	bh=9ZZbAUDdkbkhQ6Bfhe4gIxp363KvKJ5EJ+Fv+MnmzPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUj9gTIpThE3nedctiUFR87gOs1YVejcqrXW2J+7JWhM1vQHEmwj8sUEQfSiBiffu
	 8D7150OCAyunZ0or1/ZVcVtWkHk4ZRZSHrZRyGtklU0bG8Wy6B1mIgSUEP1FzKRGvC
	 3GfC3Z5l09r0JH6fih3gviSDIl7kLRfNnEX+FKiEqNabUJZnWFkWikhY2IRadHageO
	 FKIe/53M99h8fefQjSdWQQtL/8ViuiVNZmC0kkgC0YfmgswyAd0ZL/wDcDgtLsnIZv
	 yD9g/lenaY6dsOvsfyag3KSWg7n9r5TeTjOdXFV98Y6zlmESXjSUFDN3ZrPFoz/wxo
	 E2IbzQ6ATnt/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 11/14] i3c: master: Reject IBI requests from
 non-IBI-capable devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org
In-Reply-To: <20260804133810.184905-12-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-12-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 14:28:26 +0000
Message-Id: <20260804142826.BBE161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The workqueue `ibi->wq` is leaked on the error path if `master->op=
s->request_ibi(dev, req)` fails.
--

--- Patch [11]: [PATCH V3 11/14] i3c: master: Reject IBI requests from non-=
IBI-capable devices ---
commit a4ace89706edbc3219fece43aaef4d3c3e594148
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Reject IBI requests from non-IBI-capable devices

This commit updates i3c_device_request_ibi() to verify that a device
advertises IBI support before attempting to set up IBI handling. If the
device lacks the I3C_BCR_IBI_REQ_CAP capability, it now returns early
with -EOPNOTSUPP.

> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 5e6df6de02834..f1ba363b22a17 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
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
This is a pre-existing issue, but since this patch interacts closely with I=
BI
request error handling, I noticed a potential resource leak in the underlyi=
ng
i3c_dev_request_ibi_locked() function.

Does this code leak the newly allocated workqueue if the request fails?

drivers/i3c/master.c:i3c_dev_request_ibi_locked() {
    ...
    ibi->wq =3D alloc_ordered_workqueue(dev_name(i3cdev_to_dev(dev->dev)), =
WQ_MEM_RECLAIM);
    ...
    ret =3D master->ops->request_ibi(dev, req);
    if (ret) {
        kfree(ibi);
        dev->ibi =3D NULL;
    }
   =20
    return ret;
}

Should destroy_workqueue(ibi->wq) be called before kfree(ibi) on this error
path to prevent leaking the workqueue if a driver repeatedly fails to reque=
st
an IBI?

>  		mutex_unlock(&dev->desc->ibi_lock);
> -	} else {
> -		ret =3D -ENOENT;
>  	}
>  	i3c_bus_normaluse_unlock(dev->bus);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D11
