Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA23E5563
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453786; cv=pass; b=tOXACb8/KovUjkRc81x1QEbEGQqyP+Mff6Gc5CiLouBsAl/i5xPSWRf4J0nzG/j9E6zO5Kzb4yVo0+2d/04YJ/016wdZseon/A6DHW7TllPzj0leQYbG1QUuk8k9uBoV3bvfoI6GkFXINWa79jKIAOj5b/qI/M//DcGk9y4Kx1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453786; c=relaxed/simple;
	bh=SMw1jlxrpubfTnHEDlbO4rziVId8vc4wQCntfT4i+lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIvbLrslfjZAqgo1b0WMniDqCkM199KVjFtfa9B7s1FGAQy6xLkTAcvi2OOuHkNq6d+3seBJbvGGfAhG3RCpkEOSmpB1swjvdeALI3aueFgzvwPl52VHdIefi2+pmf/rXyWYrP0qllERCSBKHlR/hzRVb6572hM9Ev9KqGnTR/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NboHdeJy; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NboHdeJy"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-667f8794e97so11535480a12.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 08:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774453782; cv=none;
        d=google.com; s=arc-20240605;
        b=OBbu0lfuhFV4YRbs8b8/Qf1os4haHmj6KNsMwrRZEomzEZasKkC4ex7eKr/t4ZP5eP
         Piyvsvr27vLklWRR/iWwB1lH6QA6x7gi0btzUGsrVCCyjjt6iDM89vUaEqjTdD2QBrmD
         3KiiCDOTHSHiRfwMz4u26bfNImVnGTaCtwU95+TwapgAp+R+dJai2V6EVnxefYtALMA1
         2sPHTzkNbWAwt3EaJZe0c0sNtur4Atj6Q5+k7YXuzKYZqC1KyC/vYJRlIQg8rjQ0SZKG
         tu0Bd8OBAJHyO1kKloBb+0Jz+mRZnCE8fhXxCQr0IMqBrbpUZpHNo9WwTeacS1rcY6vK
         S5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PetZC3qxgw91I7G4PL1kgiG97oaIIgIA0g2FQ1jwb8M=;
        fh=uqcx9KELPaS9ATOmqLgyDt/kB+NutvqV9ZhLLtgNhks=;
        b=EQYvIlrPN1cLpT2Rpj25vt2mHnMTOyV0KKcWPCEg6EQC5lwf2+tRypx+A+iKNlMo5/
         Khe6C71oL5k75XTuQZzw1D0NFoYfVnWNT4HTwXn1GJ/FctKemnJUcJL35NMnbf7zgA/C
         NU49HO9++U0e3j/ItvucXwgxLqHnYPvdcyWaTNKqO2lRlU6FN3a/mFsYHA+6IJLWrOoC
         XeUMBiTUbs0SOpKfGpRLXNL6aukGshZCg6J887b3pmeXTmeF5Xx8XcKjPvmB5WgF28LF
         1CvBEFxQkdw9tiWRRARP880HTqXQJG4gb2rTNgtkKwr/pT0QhLXXcgH4YgyRT39yTwMg
         Sv8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774453782; x=1775058582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PetZC3qxgw91I7G4PL1kgiG97oaIIgIA0g2FQ1jwb8M=;
        b=NboHdeJy5rqGSnXILD9hwlr7QiyRU1LH/ue16iQyMsxCAyhZj1NvxCbm2HAeBhkudu
         FAC6KYzF734ktdTxcB05tjcgxJty3pUoyU98ok+Ks13UjLw2J/gcW0KyOTnXcKQ8J8Pj
         z7NS7clU2pMGlFojeHqUVytaEmqQv1dJrZPFe9yftZPIKqRgNksGlvqfhNgT5ECOdDRh
         BE6iuCGcvAbY68M752e+aCt2jMXMusBcxQa4WX3MHDvHjAXMRlM61xlzilZ6y0L6oFH1
         WbnrQej0rE3qZXSxCJgQsEOyjVsjFXAAMsviK8eGZMwQKl2Ly3HsBCplL72PGSQRPwT6
         tf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453782; x=1775058582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PetZC3qxgw91I7G4PL1kgiG97oaIIgIA0g2FQ1jwb8M=;
        b=We7OKs7ptv4mhI/xsGP1bLwMK+5eCPEKEvKtYYTZeYBLVC88Ea/HF5I6v+Pj/D6PNA
         j2krKLJQGY/mn9v0gdyJGtHoyeZITqWlmLVOw8jw6p/VC1f7UwULfnK7NKWDUWwxICzy
         9HdIim24ZWs4GRlCLvjLUCj2jqJsYjV3zc0M6ksYYflSEN1SeBkxIbloAvRZE8pmybSN
         81UPuZKTTD1QC7a6Wet6l8zhumlNylPiInETlZ+ey2NAxl9KEhPlldIbZVXAJKGAa09K
         k9PDv4pXpi6Yx3WR6aSl25eU2IzPTyW2ZklRyhnQwlIW4pSQbFtidvA/OmiMoMh95kXy
         aQvw==
X-Forwarded-Encrypted: i=1; AJvYcCVC58SpdWUzpxTzO6G+6SmrnzfPpXcWIJ3xxstsbbdxfkA4clFnU6WaunPnxf1fm39UKNlCP/oOZXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr3n6mZWZ4+JP2n0ZEG1hCyDtC4dzuZYSiXXqI920psQyUnRVc
	CZ3mFss4FEaDjoFlmcD+JV6bqgDS/5dS8echcwbnufOcUkhvNUUuXqJ8JPpMVS2xSl+/5/XyUzR
	qTdmCriO3F0OJSu6AOIzDgmAkx8nkTtAjRcqPxnGlhA==
X-Gm-Gg: ATEYQzztJQDHWlRPgARzrwp56VobPiCglq332yKWtOkQxXqXNSKZBwDaZs17UsFdkTF
	4sUeUXDLyKimnmxS6b6tWdKa6o2YzJXyESRSsCZLRuu4SgkP8dtzKLabr1b0XFjva+zjwpUfDBa
	Qnp5aq4vaIHLIhbRcUDjDifNtFwtTEx2UBbWaDadHKf8EyMSYCEx8nW5PrORCUfbR05HOpzPN+s
	6HhIBY+rLJKSoo/r9NWYUxhmeOWHRqFyi5pEta8JYjnkQv40sZmaScT9KB3PIDg+X6eE4yq3s8p
	3cumuyF7+IKHCCeUsHd/oLMNL9TmyuQ90pG7MYK2Aw==
X-Received: by 2002:a05:6402:3251:b0:668:368b:38d3 with SMTP id
 4fb4d7f45d1cf-66a82634560mr2196905a12.12.1774453782373; Wed, 25 Mar 2026
 08:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-8-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-8-dakr@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 25 Mar 2026 09:49:31 -0600
X-Gm-Features: AQROBzDaUkN0ZNcFR8HLoPUZ0UwwRolGugOyW2ifJVz-O5YTothUc8ZwonnT9P8
Message-ID: <CANLsYkyNx+e=QrSc=ZOqgMcOpwqdpCWsuhrvByJYcXLHPSHMUw@mail.gmail.com>
Subject: Re: [PATCH 07/12] rpmsg: use generic driver_override infrastructure
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
	Bjorn Andersson <andersson@kernel.org>, Vineeth Vijayan <vneethv@linux.ibm.com>, 
	Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, Holger Dengler <dengler@linux.ibm.com>, 
	Mark Brown <broonie@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-spi@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-arm-kernel@lists.infradead.org, Gui-Dong Han <hanguidong02@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Mar 2026 at 19:00, Danilo Krummrich <dakr@kernel.org> wrote:
>
> When a driver is probed through __driver_attach(), the bus' match()
> callback is called without the device lock held, thus accessing the
> driver_override field without a lock, which can cause a UAF.
>
> Fix this by using the driver-core driver_override infrastructure taking
> care of proper locking internally.
>
> Note that calling match() from __driver_attach() without the device lock
> held is intentional. [1]
>
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
> Fixes: e95060478244 ("rpmsg: Introduce a driver override mechanism")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/rpmsg/qcom_glink_native.c |  2 --

For the below files:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  drivers/rpmsg/rpmsg_core.c        | 43 +++++--------------------------
>  drivers/rpmsg/virtio_rpmsg_bus.c  |  1 -
>  include/linux/rpmsg.h             |  4 ---
>  4 files changed, 7 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
> index 9ef17c2e45b0..e9d1b2082477 100644
> --- a/drivers/rpmsg/qcom_glink_native.c
> +++ b/drivers/rpmsg/qcom_glink_native.c
> @@ -1623,7 +1623,6 @@ static void qcom_glink_rpdev_release(struct device *dev)
>  {
>         struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>
> -       kfree(rpdev->driver_override);
>         kfree(rpdev);
>  }
>
> @@ -1859,7 +1858,6 @@ static void qcom_glink_device_release(struct device *dev)
>
>         /* Release qcom_glink_alloc_channel() reference */
>         kref_put(&channel->refcount, qcom_glink_channel_release);
> -       kfree(rpdev->driver_override);
>         kfree(rpdev);
>  }
>
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 96964745065b..2b9f6d5a9a4f 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -358,33 +358,6 @@ rpmsg_show_attr(src, src, "0x%x\n");
>  rpmsg_show_attr(dst, dst, "0x%x\n");
>  rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
>
> -static ssize_t driver_override_store(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    const char *buf, size_t count)
> -{
> -       struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> -       int ret;
> -
> -       ret = driver_set_override(dev, &rpdev->driver_override, buf, count);
> -       if (ret)
> -               return ret;
> -
> -       return count;
> -}
> -
> -static ssize_t driver_override_show(struct device *dev,
> -                                   struct device_attribute *attr, char *buf)
> -{
> -       struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> -       ssize_t len;
> -
> -       device_lock(dev);
> -       len = sysfs_emit(buf, "%s\n", rpdev->driver_override);
> -       device_unlock(dev);
> -       return len;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>  static ssize_t modalias_show(struct device *dev,
>                              struct device_attribute *attr, char *buf)
>  {
> @@ -405,7 +378,6 @@ static struct attribute *rpmsg_dev_attrs[] = {
>         &dev_attr_dst.attr,
>         &dev_attr_src.attr,
>         &dev_attr_announce.attr,
> -       &dev_attr_driver_override.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(rpmsg_dev);
> @@ -424,9 +396,11 @@ static int rpmsg_dev_match(struct device *dev, const struct device_driver *drv)
>         const struct rpmsg_driver *rpdrv = to_rpmsg_driver(drv);
>         const struct rpmsg_device_id *ids = rpdrv->id_table;
>         unsigned int i;
> +       int ret;
>
> -       if (rpdev->driver_override)
> -               return !strcmp(rpdev->driver_override, drv->name);
> +       ret = device_match_driver_override(dev, drv);
> +       if (ret >= 0)
> +               return ret;
>
>         if (ids)
>                 for (i = 0; ids[i].name[0]; i++)
> @@ -535,6 +509,7 @@ static const struct bus_type rpmsg_bus = {
>         .name           = "rpmsg",
>         .match          = rpmsg_dev_match,
>         .dev_groups     = rpmsg_dev_groups,
> +       .driver_override = true,
>         .uevent         = rpmsg_uevent,
>         .probe          = rpmsg_dev_probe,
>         .remove         = rpmsg_dev_remove,
> @@ -560,11 +535,9 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>
>         device_initialize(dev);
>         if (driver_override) {
> -               ret = driver_set_override(dev, &rpdev->driver_override,
> -                                         driver_override,
> -                                         strlen(driver_override));
> +               ret = device_set_driver_override(dev, driver_override);
>                 if (ret) {
> -                       dev_err(dev, "device_set_override failed: %d\n", ret);
> +                       dev_err(dev, "device_set_driver_override() failed: %d\n", ret);
>                         put_device(dev);
>                         return ret;
>                 }
> @@ -573,8 +546,6 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
>         ret = device_add(dev);
>         if (ret) {
>                 dev_err(dev, "device_add failed: %d\n", ret);
> -               kfree(rpdev->driver_override);
> -               rpdev->driver_override = NULL;
>                 put_device(dev);
>         }
>
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 8d9e2b4dc7c1..e0dacb736ef9 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -373,7 +373,6 @@ static void virtio_rpmsg_release_device(struct device *dev)
>         struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>         struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>
> -       kfree(rpdev->driver_override);
>         kfree(vch);
>  }
>
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index fb7ab9165645..c2e3ef8480d5 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -41,9 +41,6 @@ struct rpmsg_channel_info {
>   * rpmsg_device - device that belong to the rpmsg bus
>   * @dev: the device struct
>   * @id: device id (used to match between rpmsg drivers and devices)
> - * @driver_override: driver name to force a match; do not set directly,
> - *                   because core frees it; use driver_set_override() to
> - *                   set or clear it.
>   * @src: local address
>   * @dst: destination address
>   * @ept: the rpmsg endpoint of this channel
> @@ -53,7 +50,6 @@ struct rpmsg_channel_info {
>  struct rpmsg_device {
>         struct device dev;
>         struct rpmsg_device_id id;
> -       const char *driver_override;
>         u32 src;
>         u32 dst;
>         struct rpmsg_endpoint *ept;
> --
> 2.53.0
>
