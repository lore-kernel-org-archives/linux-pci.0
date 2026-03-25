Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97B3B9611
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433906; cv=pass; b=RuEfnQK5JClm2/UYiM+/bdJjT+1bEq5pSAEB2Hhu+0s46m1H2BjlQtk3W1gSx/2EBbTeznv6zJfO3NxQ9vIif2iOEHVwyUbvo41nDJuMRUXjGxB7TN3pjJ+f9H+XZF2LRn723pcYeuzZgpaG/Lwejkx5RuP9obEoGpDNNFHV9RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433906; c=relaxed/simple;
	bh=1Uc6t1cwxW0MzD1dqSUvlR5rqITAHKLiUYzFlCfYbCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNDy520s+KY8aNdqFUH90DrQSp6um6IEfFtfdL74qWNFizcI8tx56UUn/YTlbTkyaLlQh7/MzA36VtSCC59ja+VZcGkMrveCOC7kHW9w7/8EvBeafVvuZxdwng4TYzNi8GAdcVkfvaaHirUnN05IlviP3dy//czxCNm7z1y8pRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHOZW0NK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k8c1JG5A; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHOZW0NK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k8c1JG5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774433902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBOh/aoPlGxYDPbqkk5UK0G4/ytz0Hu0GxFXOarsu9g=;
	b=jHOZW0NK4ph+nCIJtYbvMbiUxhKSecQKP3lRboTMJ/wC/susilImFdkTeVMDXxSLG97Nar
	W+vkI4YrRS5PUnC/g/l7L9/ukhyoOe+IvvcZPz/qLET2y2XH2OghLxBMNgbO9aN/8pxbXp
	AnPtpPyYDcfF17Ftp3L2xu1ISskNauM=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-AYy029FXNZiSS30P-SjwkA-1; Wed, 25 Mar 2026 06:18:21 -0400
X-MC-Unique: AYy029FXNZiSS30P-SjwkA-1
X-Mimecast-MFC-AGG-ID: AYy029FXNZiSS30P-SjwkA_1774433901
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64eb0bbab48so1713018d50.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 03:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774433901; cv=none;
        d=google.com; s=arc-20240605;
        b=D8zKfMDIwz6Rel9PZKwgQ5AwVtqmnRikuJOHDWf9VGakysHxAusn2wQhFc9f449M5d
         Lz7gKBEbHgaeZKHXs5vSDfzbccgrNKUQSvQHMMVE4aOc288ZU7NsV7D/pc+R0kbkTwlG
         Wd9WJl4te8kMbgXGl0kF8xlHiNX4sNBreyBhbuWRq4r3KEhC/jlFtitRRnH84wZkLG8K
         tJ0jFsqew43VbewQTyF8WipxZ5Fr/t8Oq4bOW3ltXtnJlvHzH6F+314MZlM8l6pcdm0u
         +kVJByOMtVOZZkWhF6+ZUQQ5cPvpO21FvjSwif+JSpCQvsDk0TF/n55tl5FPB274ar1A
         V8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HBOh/aoPlGxYDPbqkk5UK0G4/ytz0Hu0GxFXOarsu9g=;
        fh=5o3S3Y6goNCnnTVH0CporeYTfxMHiGp1BHiQ6LPWsCo=;
        b=Sqjy8wYZWJJ0qrCaWFW/pfHkcSYrp2KIyobHWbi5qCgyCy9zGH42XlLtkgXyNs1W0D
         piw3reIK/0J9KT2B6+MoP+tX6phYiTijm0uyBU2JI9CnaV0RFHiMfoW5DIBl+2P1Eyk9
         epF2KpsTOqxOmRzrx0WIq2j5sBezpOpjg2Xoc4Id4spIuGeEEJlExkl9G3pKOwJgyc3d
         8wqfg39ARcxXg2SUkyEQhewOh6CP9O5tr/M3dWv6p8I0OORijMVY0Uv2f/cUkgSLkzSY
         oL1jmaXhR1fPYhNXB4pWF2Ho1nfZc3+wTvZi5AgXI+eVgG0p/C101UxLNW4HyW0gkiby
         N2cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774433901; x=1775038701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBOh/aoPlGxYDPbqkk5UK0G4/ytz0Hu0GxFXOarsu9g=;
        b=k8c1JG5Agh13tecyye3G/dBXeSoWEHgyu20i/HK0WpMm2AFG9kpTvNrLWYqBP+O3s/
         tHypkdE43WwKBfjRLoJgSSwV99V4JVgUbpqe62RgAym0i/zybZ+6C3lcjyHkvG7RwgQV
         PSYmTY8cMZZt0Xn7dvJGsvFwP2eyWTLrNr2moqUqNvANKsHQ6NR1cr/Os+Cy+ynJGYDw
         skKrdXE3TqjJIYqbCLpwsU3qFBzYzIKuI/J5j+soiFmkxPqoSVGLWLwO9yH4op+BPHkK
         /I0y48bC3Rb0rQ4mZoKg4saqVxuUvkp8fvSXqRV6Fgz74WGfbQro9hKXX0jDY8tfid5y
         DELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774433901; x=1775038701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HBOh/aoPlGxYDPbqkk5UK0G4/ytz0Hu0GxFXOarsu9g=;
        b=jOYHbPFu+i5yE+7Ue+BM18wmW46qIiQueGMrX1jhfNMu/RXqnKzPxvzTrc8uEo2xfW
         CUx7QDtRSzzvXvib74TX+JvdBixi5iGxlnwicN9ZMBUyKnVJeF9mFXwIp83bAUyu2MTj
         NHfZgxhtkSfXoAV3kgF4WZa0eEw6QEaniSh8ZQSnGbZe5nwTvazDiswN9MStSJqKEEzK
         RofHnUCUZ8WsnZbuoQqFM6lvX7x5zlxxYM8UtqeQgLvLtdeAtOmV0akJvYWQgqIlGoxV
         AaHEIo9fgndsyXSH780zMl3TyY/y7a9bGma84VRfOOC9lowlozv2oh4/52PisXFWk+PZ
         kXtg==
X-Forwarded-Encrypted: i=1; AJvYcCU+eWatbbT5v2WxJbTAOnaw/r2mtFJ1EH3hS6t5PN2o7tHdbWRDn+1Wmq9l7gefG6w/JgaUgpxVMww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUUAjtEAEZW3Ee6RySCKqIQTO6vpU0etOOy6pDbwoND0epK2xB
	x7xPYyTfR1+a1qYfGuubGFmmFY/FUGc+5PjUkbtxtz2y3kD2LBgZb7DYJdSzp1UTw3GzendcFPC
	VQVWIPGOEGFsMIh7jEvYPARruohU5snYSZohr+jrLAbxwiM6liFcwhhBIM3fzplGCcbUVU6SkGB
	/tk81TZihvfMuM6IVWwS+Pur6iu79uJx3CFLnd
X-Gm-Gg: ATEYQzxPZtNv1RqcZWoG5FYNa4ug9KJFzS3SSa3plFTqZ7IQmRfqB8Qs+bFJZmz+Mtc
	yTznDlDAoKJw3kvxvGO4bHhJTNRJndbLQKkHwdt6cmaJbgr0wORGJ8YEsaz/B2bO6enImEf+0cH
	W8wbqU2goKfATGc/Og1A8vTMKQwa66SwZWg+UCVWIyHDuUoaHK0zGdC5umD2hwa1K6ZZM2+mdDt
	gO1Mg==
X-Received: by 2002:a53:acd1:0:20b0:64c:9f60:19d4 with SMTP id 956f58d0204a3-64ed77ef1ecmr4805271d50.8.1774433900735;
        Wed, 25 Mar 2026 03:18:20 -0700 (PDT)
X-Received: by 2002:a53:acd1:0:20b0:64c:9f60:19d4 with SMTP id
 956f58d0204a3-64ed77ef1ecmr4805242d50.8.1774433900219; Wed, 25 Mar 2026
 03:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-9-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-9-dakr@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 25 Mar 2026 11:17:43 +0100
X-Gm-Features: AaiRm50qMzjkKEJ7Fkr-Roi7I1a_DrzOw3E963yu_3LAy7xQt4ygKXGG9Px12Pc
Message-ID: <CAJaqyWeuvD+XntgE9q4epQELpYYTOs1CznFn_tuOxeh_LurrcA@mail.gmail.com>
Subject: Re: [PATCH 08/12] vdpa: use generic driver_override infrastructure
To: Danilo Krummrich <dakr@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Vineeth Vijayan <vneethv@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Alex Williamson <alex@shazbot.org>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
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
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 2:00=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
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
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kern=
el.org/ [1]
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
> Fixes: 539fec78edb4 ("vdpa: add driver_override support")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/vdpa/vdpa.c  | 48 +++++---------------------------------------
>  include/linux/vdpa.h |  4 ----
>  2 files changed, 5 insertions(+), 47 deletions(-)
>

Consolidate this logic is great, thanks!

> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 34874beb0152..caf0ee5d6856 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -67,57 +67,20 @@ static void vdpa_dev_remove(struct device *d)
>
>  static int vdpa_dev_match(struct device *dev, const struct device_driver=
 *drv)
>  {
> -       struct vdpa_device *vdev =3D dev_to_vdpa(dev);
> +       int ret;
>
>         /* Check override first, and if set, only use the named driver */
> -       if (vdev->driver_override)
> -               return strcmp(vdev->driver_override, drv->name) =3D=3D 0;
> +       ret =3D device_match_driver_override(dev, drv);
> +       if (ret >=3D 0)
> +               return ret;
>
>         /* Currently devices must be supported by all vDPA bus drivers */
>         return 1;

Nit: Maybe all of this can be replaced by
abs(device_match_driver_override(dev,drv))? Or maybe we're putting too
much in the same line.

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!




>  }
>
> -static ssize_t driver_override_store(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    const char *buf, size_t count)
> -{
> -       struct vdpa_device *vdev =3D dev_to_vdpa(dev);
> -       int ret;
> -
> -       ret =3D driver_set_override(dev, &vdev->driver_override, buf, cou=
nt);
> -       if (ret)
> -               return ret;
> -
> -       return count;
> -}
> -
> -static ssize_t driver_override_show(struct device *dev,
> -                                   struct device_attribute *attr, char *=
buf)
> -{
> -       struct vdpa_device *vdev =3D dev_to_vdpa(dev);
> -       ssize_t len;
> -
> -       device_lock(dev);
> -       len =3D sysfs_emit(buf, "%s\n", vdev->driver_override);
> -       device_unlock(dev);
> -
> -       return len;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
> -static struct attribute *vdpa_dev_attrs[] =3D {
> -       &dev_attr_driver_override.attr,
> -       NULL,
> -};
> -
> -static const struct attribute_group vdpa_dev_group =3D {
> -       .attrs  =3D vdpa_dev_attrs,
> -};
> -__ATTRIBUTE_GROUPS(vdpa_dev);
> -
>  static const struct bus_type vdpa_bus =3D {
>         .name  =3D "vdpa",
> -       .dev_groups =3D vdpa_dev_groups,
> +       .driver_override =3D true,
>         .match =3D vdpa_dev_match,
>         .probe =3D vdpa_dev_probe,
>         .remove =3D vdpa_dev_remove,
> @@ -132,7 +95,6 @@ static void vdpa_release_dev(struct device *d)
>                 ops->free(vdev);
>
>         ida_free(&vdpa_index_ida, vdev->index);
> -       kfree(vdev->driver_override);
>         kfree(vdev);
>  }
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 2bfe3baa63f4..782c42d25db1 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -72,9 +72,6 @@ struct vdpa_mgmt_dev;
>   * struct vdpa_device - representation of a vDPA device
>   * @dev: underlying device
>   * @vmap: the metadata passed to upper layer to be used for mapping
> - * @driver_override: driver name to force a match; do not set directly,
> - *                   because core frees it; use driver_set_override() to
> - *                   set or clear it.
>   * @config: the configuration ops for this device.
>   * @map: the map ops for this device
>   * @cf_lock: Protects get and set access to configuration layout.
> @@ -90,7 +87,6 @@ struct vdpa_mgmt_dev;
>  struct vdpa_device {
>         struct device dev;
>         union virtio_map vmap;
> -       const char *driver_override;
>         const struct vdpa_config_ops *config;
>         const struct virtio_map_ops *map;
>         struct rw_semaphore cf_lock; /* Protects get/set config */
> --
> 2.53.0
>

