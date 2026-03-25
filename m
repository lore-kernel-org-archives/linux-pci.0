Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90B329BDAD
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408106; cv=pass; b=JKBbbYcsnuGcK5612xkB20+YSTEKPWhAtavwHCBPWkwBLmdInufHQdAa+YRvCd/FxvWvAYOf/N/tXL4/bkP4HPWImQmkJBEnY/NH1G2MJgfUKR67NgVxEGGBOhlCuRhBI3zr6tVQI3J3mmk8oruf7UEHk362lrF9XlAgEki1uUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408106; c=relaxed/simple;
	bh=hJdcGCQ3mHxI4qcvqZp/CCaqOJ76l13MZ1DRKNMUyZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljqyTeWXLIhodDyMgT4w8I2jP4+tEkH6w2j8PpL3LZU+V84NSjrNpOAlR+CqYeMiu0SAa3jS6e6VoxEbbKzKnbijTQsfcWKAuJA3L9C67ZuyAXvPwjXOqho0EjuDvD6fSlU5p4xhWybNJV/OJIS/u3oCttx0NR1Bbiwc/LuN0DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsG2jCun; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsG2jCun"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-67df51b26ddso1079235eaf.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 20:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774408102; cv=none;
        d=google.com; s=arc-20240605;
        b=Yx9XgFkqrrcKiJ+B1ufw4uqfPnxQOsjep+eqDR4NS4iF4gkS5Dt/Q1IM8of7CEsS+d
         IKimEkD5O/yxCtifv/NuCV5Eyy5CxV+c1Yim6D7PgE68SDCeY0Jv6SjUIesshPor1Zu6
         WOb6cjRv3r3zoB3hVTTLaT/qNWZc70wNlKWN2EXzz7YsId2r4CrLA4ytYU2onMKJbYWh
         EyBB+bWIozK+xqo7MRfEvT7rglJ9rK/okstm0ty/KP/xzzRXGmru9d8Gr/djJXAWFUbl
         eYgOjJ8eI2QUE6CM8w0m/xFA/0615Q8LhaLnTsL/XoVxX5aBrzPiO0iA20maDT2J6Gg6
         u+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L1agqMYRVyCUyftxunjR/Gctujg8X1gDCx6TflvnIV4=;
        fh=cD+ACn2S2ulXpoyEoq4Pn2yUPs6zxOzHtFT73QQ4dcQ=;
        b=g61a/Xs6cH7pn8SNFJuvse5QclQYnrok2QxztpqaQaOAlQd0yREBR4Ep1wb5dqzmg3
         Fac/PQZ1k2QuGFX2uer/qajGlkoDSjuLTH4T0PzBV+5QQs1gx7MtkGv2jdO/8bdc5qhm
         zyuaGnnYkmsvffGBCfmbP12Tl4QzZ3XZsk5/RXBljqAFlXi5bBuzRqT5nU07BgQ2fT6g
         1L0yB+qxd9wYEk0Lo+WPuymFXCLty9n3V8B59UwJurUV3/moXXrcUsbxUtf99pxvAe6n
         8rtXLWugNpNNjjwGLHEHdMNXSX1gtR1ydp7qkxAIO/UYZ/mlL1m471mbanLu3dg0fJVg
         Ynqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774408102; x=1775012902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1agqMYRVyCUyftxunjR/Gctujg8X1gDCx6TflvnIV4=;
        b=QsG2jCunF6U9HFdPFtYk1Fvt12375/QhCCqZnpk7qBrUJDtwoPwbZG00Jxz3BLNAhH
         6yC6bntNmHyq7x7cP0+N6/uwrnu4b91f6kk14zUUgBqddni3wPt6K7GfK3VBO9vnm3J1
         z+WYSyue1n99gDpMq448CDF5siFzxJf5yHSUwcyJx6VhvxvHBUVIoZCA8J8lRlFVzyE+
         VVj1VO6NGN1ab9PiGjH0rUmDjcUZDFcwiB5b34LaaumYSy57XOpRmbzP5Qhozw3636yE
         ih5IVdoV+6OvYilULBnmHxgj0HuKO1k2K64kakQdkM8JMyQ6HNVTAAeXTM51wOpVMwzo
         g5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774408102; x=1775012902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L1agqMYRVyCUyftxunjR/Gctujg8X1gDCx6TflvnIV4=;
        b=Kw14OCHSfzbbxdd071BT6OSm/AVBiplGCeFKIKYxh+alzYGXHcbrMD/VW+fpHkoJAC
         ieQV51Y76Sc8KSN1lEh01JC7PftgWr6LMg2Tx5WyEbyAbSPwpYIhQQVHeUz6C5N9523p
         ZAALYFPS0t/DVNuCXTskUdDXn+lDF/nYTOlqbdTlWkMPNclK5bTnDc8RvDp6WXLa04Ve
         eEgRH7UBhIBgMWaSpMxi8GlGQ69xnjxPoJ9qn7sD1541hhaoz2Re/a8EQOxiER3+HGuL
         q6VGXlM/B/Rwk7b2gnF3h7hjI5ER1IAYC3Et2xrdMY0G1SLUfXUj7IMxFP7bNX/l/kcU
         7XGg==
X-Forwarded-Encrypted: i=1; AJvYcCXRuvTBZOMDX0kE3xflgt8PHCc3rEDABj9W322UNaIHojBeeMjaSk7F+TOmlMgugLSRXuulTt95cv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMF1msP9l68Kejp6ugV/5vDg+xPYMjlPdcMvjo6GZP9NUnJpa
	ANm2La0W7MAMUK/9eLT/C2UNXV3F3xHDNeKXlpLsnmGQKfTfbDd550Y1Fo75oEGkRe7Fs+lK5Ru
	SwPizscZnh377/HgyAZSTtabbRGOlu4Q=
X-Gm-Gg: ATEYQzye06q4llWryUW3zA4lnTdr9uJGPt0uCEP7U8V1TGELvT6HpVm1A/Smnv2+NPA
	nJOXVXxMeO0CD2UzxvTj1LFFznkTPDCIFp7RvrEvTs6VMp9sgF/j0gL2rXbAjx3CnKURbRB0cTv
	wd2E5Xzw8L0ysO4xb3xytMOvP6YXwrdTTDkvcfhPnbLAAUx2RJLmy2nyPuBJbAMRR2a/WQDvTcV
	8TXI9bWEqGowCbrNCwUBRJVx1OUevjwT4ZMfx33wV2ekupgoShMV3rIv8YDLiNihcCw0Y9hHAw2
	ycRFrZ0yCy9XWOo7GEtVeTyTGevIh0qnCkDFNxWLtpjiNTDoTgoAgkIWF8vK0lchnYfF++0euB9
	QGmOa4A0=
X-Received: by 2002:a05:6820:1787:b0:67b:e203:6c8d with SMTP id
 006d021491bc7-67dff53efc8mr1216692eaf.52.1774408101668; Tue, 24 Mar 2026
 20:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-6-dakr@kernel.org>
In-Reply-To: <20260324005919.2408620-6-dakr@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 25 Mar 2026 11:08:11 +0800
X-Gm-Features: AQROBzD64p8E8k4KuR51RUiYotZVMtC9NAESBq-7RvJsmuQyKbQ4KJC_uWmm37s
Message-ID: <CALbr=La3gV5VmoXauF-fkmXveoJGtTvef1d1nrLtUZNHx2eF+w@mail.gmail.com>
Subject: Re: [PATCH 05/12] PCI: use generic driver_override infrastructure
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
	linux-arm-kernel@lists.infradead.org, Wang Jiayue <akaieurus@gmail.com>, 
	Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:00=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
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
> Fixes: 782a985d7af2 ("PCI: Introduce new device binding path using pci_de=
v.driver_override")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Tested on QEMU PCI with multiple debug configs enabled. The original
PoCs run cleanly without triggering the issue.

Thanks Danilo.

Tested-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Gui-Dong Han <hanguidong02@gmail.com>

> ---
>  drivers/pci/pci-driver.c           | 11 +++++++----
>  drivers/pci/pci-sysfs.c            | 28 ----------------------------
>  drivers/pci/probe.c                |  1 -
>  drivers/vfio/pci/vfio_pci_core.c   |  5 ++---
>  drivers/xen/xen-pciback/pci_stub.c |  6 ++++--
>  include/linux/pci.h                |  6 ------
>  6 files changed, 13 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index dd9075403987..d10ece0889f0 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -138,9 +138,11 @@ static const struct pci_device_id *pci_match_device(=
struct pci_driver *drv,
>  {
>         struct pci_dynid *dynid;
>         const struct pci_device_id *found_id =3D NULL, *ids;
> +       int ret;
>
>         /* When driver_override is set, only bind to the matching driver =
*/
> -       if (dev->driver_override && strcmp(dev->driver_override, drv->nam=
e))
> +       ret =3D device_match_driver_override(&dev->dev, &drv->driver);
> +       if (ret =3D=3D 0)
>                 return NULL;
>
>         /* Look at the dynamic ids first, before the static ones */
> @@ -164,7 +166,7 @@ static const struct pci_device_id *pci_match_device(s=
truct pci_driver *drv,
>                  * matching.
>                  */
>                 if (found_id->override_only) {
> -                       if (dev->driver_override)
> +                       if (ret > 0)
>                                 return found_id;
>                 } else {
>                         return found_id;
> @@ -172,7 +174,7 @@ static const struct pci_device_id *pci_match_device(s=
truct pci_driver *drv,
>         }
>
>         /* driver_override will always match, send a dummy id */
> -       if (dev->driver_override)
> +       if (ret > 0)
>                 return &pci_device_id_any;
>         return NULL;
>  }
> @@ -452,7 +454,7 @@ static int __pci_device_probe(struct pci_driver *drv,=
 struct pci_dev *pci_dev)
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
>  {
>         return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprob=
e ||
> -               pdev->driver_override);
> +               device_has_driver_override(&pdev->dev));
>  }
>  #else
>  static inline bool pci_device_can_probe(struct pci_dev *pdev)
> @@ -1722,6 +1724,7 @@ static const struct cpumask *pci_device_irq_get_aff=
inity(struct device *dev,
>
>  const struct bus_type pci_bus_type =3D {
>         .name           =3D "pci",
> +       .driver_override =3D true,
>         .match          =3D pci_bus_match,
>         .uevent         =3D pci_uevent,
>         .probe          =3D pci_device_probe,
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 16eaaf749ba9..a9006cf4e9c8 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -615,33 +615,6 @@ static ssize_t devspec_show(struct device *dev,
>  static DEVICE_ATTR_RO(devspec);
>  #endif
>
> -static ssize_t driver_override_store(struct device *dev,
> -                                    struct device_attribute *attr,
> -                                    const char *buf, size_t count)
> -{
> -       struct pci_dev *pdev =3D to_pci_dev(dev);
> -       int ret;
> -
> -       ret =3D driver_set_override(dev, &pdev->driver_override, buf, cou=
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
> -       struct pci_dev *pdev =3D to_pci_dev(dev);
> -       ssize_t len;
> -
> -       device_lock(dev);
> -       len =3D sysfs_emit(buf, "%s\n", pdev->driver_override);
> -       device_unlock(dev);
> -       return len;
> -}
> -static DEVICE_ATTR_RW(driver_override);
> -
>  static struct attribute *pci_dev_attrs[] =3D {
>         &dev_attr_power_state.attr,
>         &dev_attr_resource.attr,
> @@ -669,7 +642,6 @@ static struct attribute *pci_dev_attrs[] =3D {
>  #ifdef CONFIG_OF
>         &dev_attr_devspec.attr,
>  #endif
> -       &dev_attr_driver_override.attr,
>         &dev_attr_ari_enabled.attr,
>         NULL,
>  };
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd79..b4707640e102 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2488,7 +2488,6 @@ static void pci_release_dev(struct device *dev)
>         pci_release_of_node(pci_dev);
>         pcibios_release_device(pci_dev);
>         pci_bus_put(pci_dev->bus);
> -       kfree(pci_dev->driver_override);
>         bitmap_free(pci_dev->dma_alias_mask);
>         dev_dbg(dev, "device released\n");
>         kfree(pci_dev);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index d43745fe4c84..460852f79f29 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifier_bl=
ock *nb,
>             pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>                 pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_overri=
de\n",
>                          pci_name(pdev));
> -               pdev->driver_override =3D kasprintf(GFP_KERNEL, "%s",
> -                                                 vdev->vdev.ops->name);
> -               WARN_ON(!pdev->driver_override);
> +               WARN_ON(device_set_driver_override(&pdev->dev,
> +                                                  vdev->vdev.ops->name))=
;
>         } else if (action =3D=3D BUS_NOTIFY_BOUND_DRIVER &&
>                    pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>                 struct pci_driver *drv =3D pci_dev_driver(pdev);
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback=
/pci_stub.c
> index e4b27aecbf05..79a2b5dfd694 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -598,6 +598,8 @@ static int pcistub_seize(struct pci_dev *dev,
>         return err;
>  }
>
> +static struct pci_driver xen_pcibk_pci_driver;
> +
>  /* Called when 'bind'. This means we must _NOT_ call pci_reset_function =
or
>   * other functions that take the sysfs lock. */
>  static int pcistub_probe(struct pci_dev *dev, const struct pci_device_id=
 *id)
> @@ -609,8 +611,8 @@ static int pcistub_probe(struct pci_dev *dev, const s=
truct pci_device_id *id)
>
>         match =3D pcistub_match(dev);
>
> -       if ((dev->driver_override &&
> -            !strcmp(dev->driver_override, PCISTUB_DRIVER_NAME)) ||
> +       if (device_match_driver_override(&dev->dev,
> +                                        &xen_pcibk_pci_driver.driver) > =
0 ||
>             match) {
>
>                 if (dev->hdr_type !=3D PCI_HEADER_TYPE_NORMAL
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..57e9463e4347 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -575,12 +575,6 @@ struct pci_dev {
>         u8              supported_speeds; /* Supported Link Speeds Vector=
 */
>         phys_addr_t     rom;            /* Physical address if not from B=
AR */
>         size_t          romlen;         /* Length if not from BAR */
> -       /*
> -        * Driver name to force a match.  Do not set directly, because co=
re
> -        * frees it.  Use driver_set_override() to set or clear it.
> -        */
> -       const char      *driver_override;
> -
>         unsigned long   priv_flags;     /* Private flags for the PCI driv=
er */
>
>         /* These methods index pci_reset_fn_methods[] */
> --
> 2.53.0
>
