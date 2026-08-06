Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4543BB4A
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023717; cv=none; b=FMU8vSD17qOQqTLyWV6BqNtYig7Qn6dD+Pqd5rn3KzIPYh3lKwwpruzX4Pim94h5RFNhw4YuC/ltA7dljHHw+vtmmIDY5hWK/mcvlj/mW5l5BdetpGL6nh/amYrkjJcEn+5UCYNxk9QV9T8UQi6J9uwxCUeo4GMKOj/Xt5LFAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023717; c=relaxed/simple;
	bh=hoSMRcfNF/B+1xVZgjAMpEMagfESbV62m/eDgKxvqOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PtP0t/DVGAsbQt+kwNKpZRRrkccSPb2vRIeuMN0mi+m88gcySKq/R5iSGADykvQb/CYZMOfpoAH90QTadSv7EZQs1T1pzM5X94mXGnCgs+wivAslAh9HFAznQVeAZ7ELuig0h5xoS4lXgWmw0MYcID3ZWY004tm/+n+N46YmqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO7xWQ6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO7xWQ6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA381F000E9;
	Thu,  6 Aug 2026 13:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023715;
	bh=Qhr++JzfsbPhsJGaP3LCSgpnbC7usMJ6KiEXWXen0us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PO7xWQ6z4mfAv2CTr+s2otvmMBsYk1qkUT9ilrDktQYnWbG6Faes7SO8pjTVAgSxl
	 yF2q5m/bgdD9T75HQZR8sscTbhxWSrRkItu40y1SO8pFVO0YgiSdXZJlbGU1iAwLHZ
	 OWvDNE+Jyqr12XsWxsTGpvWCXLqSLyFWAUtW2gtgQj8JNK0rAdekOrEkUQcF369Rec
	 YH+kLLApJAEondYbKZebvFvPa+7u7yxdpEsD4Lu9zglkc82RmA/rINQwDLPWELSIUf
	 XQLsTk9+cAgb7JSakdnQvEoCx+A6mX8fhMjf1RSJp0v63oRQmqg/eq0DnIDXQ0eBaV
	 nFCiowid9HT8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 11/14] i3c: master: Reject IBI requests from
 non-IBI-capable devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, Frank.Li@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260806131857.119830-12-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-12-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:41:54 +0000
Message-Id: <20260806134155.6AA381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Workqueue and rescue thread leak in error path of i3c_dev_request_=
ibi_locked().
--

--- Patch [11]: [PATCH V4 11/14] i3c: master: Reject IBI requests from non-=
IBI-capable devices ---
commit cc9c665c421a1d987949a06269af6968afd5a89d
Author: Adrian Hunter <adrian.hunter@intel.com>
Subject: i3c: master: Reject IBI requests from non-IBI-capable devices

This commit adds a capability check before allowing devices to set up IBI
requests. It fails with -EOPNOTSUPP if the device does not advertise IBI
support, ensuring consistency with other IBI features.

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
This isn't a bug introduced by this patch, but does the error path in
i3c_dev_request_ibi_locked() leak the workqueue?

When master->ops->request_ibi() fails, the previously allocated workqueue
appears to be orphaned:

drivers/i3c/master.c:i3c_dev_request_ibi_locked() {
    ...
	ibi->wq =3D alloc_ordered_workqueue(dev_name(...), WQ_MEM_RECLAIM);
	if (!ibi->wq) {
        ...
	}
    ...
	ret =3D master->ops->request_ibi(dev, req);
	if (ret) {
		kfree(ibi);
		dev->ibi =3D NULL;
	}
    ...
}

Can this leave the wq and its associated rescue worker thread permanently
leaked since destroy_workqueue() is never called before kfree(ibi)?

>  		mutex_unlock(&dev->desc->ibi_lock);
> -	} else {
> -		ret =3D -ENOENT;
>  	}
>  	i3c_bus_normaluse_unlock(dev->bus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D11
