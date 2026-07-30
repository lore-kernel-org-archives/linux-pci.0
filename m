Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0D3839A3
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425792; cv=pass; b=hL75gPRGh9fnwYbiZOhXJNI6KI7xIk/RVR2ugHvnvdAdf9UOd+lbv/o5Kvw1pkJDXHx2tl5a86xazKiGeKMXeJkWzkkCQXmTnEmrgo8jCD15aVRtRQLZ9D9LW9wlWDVpg3jEjo39KpY3vrgG40nMdWmd4/PM2jD0AggFQbwXyrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425792; c=relaxed/simple;
	bh=LZ4+47KxGHfh/I9RxUwKZfNWDREmNJkNKABTLS2EbQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJcd13Y3mCQQIzWMrIgaA2wvB4O/20RKwq5py4cXxYQwxf/xJIC6cBWZyxBYQxUXJ1MVTCyJwucEtknnuV25A8Llkud7XUI3xvcgC9eGhPdrl9T7GjTN7Pj0R4fn8e4YUZ+pQ7QrlmoOfu80vaYNC9wPgnKPWb2n4XytI9zuf5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj2LlC3E; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj2LlC3E"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66771ded50aso3004088d50.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 08:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785425789; cv=none;
        d=google.com; s=arc-20260327;
        b=S/cMFVyu5IoxnR5tzVKOXsjAma1CpJzmBCSvc7opZMqb8I1nUk7cIoChHCxVGIiDru
         SYul5y6DdGwHCyhdyX5e/ZizoNnTcVpBdcAB7gynwQVsa5o3UQTgnj0h0vdjf7iu9c70
         t6hQ7o1sJ2km5g/sAUCXNMO8eTfgzuL8SHSBGV3EmDtSLTEfZwnvFT/b0hOqMJgxEsnj
         iVAzBcVN508NGsDOdtfr+Eam1PjPuX0MTjAY5GjSz/IIoNex9F+oyXh9vAi3s6PTTCXq
         PfZ0AOBUnzNfiVHhln/KqdFZkSVLpJhKqLTk0gsOcm8gLJd+o9VJtVVm6bRZlkq/axzj
         kI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7onOd1zAQhPaoHYzRj7D8iUNHizgZs0IFJqm1SIBAcE=;
        fh=x51McLs2jOdiGz/qkNEV6kv5NjZxk4rkQybRzen3B4w=;
        b=q41PO3U4SjMxqPWmVrpEvbRekNyncL3LLBFl99mlW3m600AjYYI+cFYxznDbsi6tMQ
         cWQvq0TFXfFe0jv6YpzrlG+XrViTbSoDvAXrJopRSXNdtq/invLZuUnZyf/2DcOrov/8
         CKYpBxXvU1+tVUHesXtykgiPLEo7aat1bmmW/ZSG7rtWSfHVk6knIZnwsedl4m5WQsFU
         I+7HMJo2db2gz2p0z2WcRM7AHC7mVaRC8eJpfX+sHjFCkTvqNCqeCvY0k/s3pIEpBiss
         uyLe57qq9o1KxF2+7q++siIEVdEuXOkcimMbnPelg3eXLgz/BYn6Hr3hr+MCW2OpHHzs
         p7Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785425789; x=1786030589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7onOd1zAQhPaoHYzRj7D8iUNHizgZs0IFJqm1SIBAcE=;
        b=Yj2LlC3ELAm0VyOk9poTS0NRfyuYxDilEzw0ND6a/RdqK7pkoEL5uWWYsZKrLHDCis
         llKm/+zgNmfdkBBNnMyQ0/cEtq9/EQkaSG4DKmDvMytZDc7cTKtieQf9UoIo2rNdPCH3
         N86iI+1Y1CxMtKcIBEJxgIONLd84mekiDzd41wqi4eLq3ZbVDONIKIOK5L03XTriUwlo
         UpVsTkWp5KZoygFe1R5rcQtYZ0sVaFG1zG5AS78sT0Ve5qYBS8Hvh1QPEJNlbIZ5q9+q
         goXjUu3/GYeulrUGCUH73wDadggt+4PrM/gt+ZEHCSTgA/bydk9LYDH2CBinsd7m1EKQ
         q3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785425789; x=1786030589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7onOd1zAQhPaoHYzRj7D8iUNHizgZs0IFJqm1SIBAcE=;
        b=IFDAoNap6eCb40FN3obxBorD9g1ieNskRiuSrJbG+SBP9yvr6HxQKUv6PSz6vVoCiR
         RlvV+XRXK9Gt/mR/jrjKR5vILk+gMYiD5d7n9CD+wwLSE4ZDZrRPQ21zPoKkC5wWDb/i
         iHpd+ZcNh0T2bZoIkQoA681uc3nhsJpvE3AnPYhDelvsYz8HXpH3IBBJg0//1TG57Uts
         e3yqVD/r+yvdXAeohqk8s0GSrXt7orU9304243BhcibgFVmVwlWXN0dEr1Kq/M/V656s
         Xq5QvFQiNPa5farIKd0UXijm1j2hRfKIRD6tsxZwPufsPz4p3W0aSyfRFc7CN//6O9G7
         R5vQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKn80LNyGTL97nt+XjjNusMArarcKOX66dcXk+kUeIYIiz+YAaX/yE57g7d9sz8ir62yYOnvcyyhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6i1iN8A5DX5tH8zuziUC2sGlV1XpM62hVnqPWAq+nFS761Wq
	/jIfJgZ75XZVI43QG5TjYgwj+BG1zOaoUnKs2JwNUtshp7TgTfz1vOpoKZDFGqVYXS/2SLDSgqc
	jQwTno7q757D5PEPqY/UYyYvvkVlpFW8=
X-Gm-Gg: AR+sD10ecQGtzlJTnJFW9ZxLo43HOclDMq1eeFS2Aou+565AEXOwhhQuXcstuaOPVgn
	LLFI3CnkgJFpqzsBUUSbeGONjaDvMR9+3h/g+g48UfPQMHbxtXfEKGwfOTX9zC67gqrnxRT0mkC
	vYhukeu80+NA4b6hgkZ4By3nMCS+tjiy7A0SMVZqK+WTRwWkWTi9jlqwHsTyQvDpXIyXMKF/5JO
	Ve7sW7mAHhU6fYI3dQB+7Mawe/wf9nhetPZybDcT4tyW0szv20ytm8fj2RjF4JjCtqU8M/nBzSE
	V4h1w0ii+CNrZE5JsY+u3IOdjpUniOIMt4hYWBx6VHKF9Ar9zHCJ+lfGzfD6/j1Vcsf0KAzjxA1
	KwShNqkSYfnjVhoqGEUjtQ0frP85ytBP1w3s=
X-Received: by 2002:a05:690e:804:20b0:667:9a97:2df0 with SMTP id
 956f58d0204a3-6692f6d1e7fmr1552313d50.66.1785425788692; Thu, 30 Jul 2026
 08:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
 <20260727052104.1026824-1-chandrashekar.devegowda@intel.com> <20260727155703.4536b6be@shazbot.org>
In-Reply-To: <20260727155703.4536b6be@shazbot.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Jul 2026 11:36:17 -0400
X-Gm-Features: AUfX_mwwpht7RBWW1_MFaewtO6-p4hAS2ry6yLL-121lBltQOgKw9jcZjK9-yHo
Message-ID: <CABBYNZ+=otGcq6H0WOJddPf13gnAArJCFCEH_P3JoUuArZUOLw@mail.gmail.com>
Subject: Re: [PATCH v6] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs
 for PLDR
To: Alex Williamson <alex@shazbot.org>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, 
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com, 
	kiran.k@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandru,

On Mon, Jul 27, 2026 at 5:57=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Mon, 27 Jul 2026 10:51:02 +0530
> Chandrashekar Devegowda <chandrashekar.devegowda@intel.com> wrote:
>
> > Add a read-write sysfs entry at /sys/bus/pci/devices/<BDF>/vendor_reset
> > to allow userspace to trigger PLDR (Product Level Device Reset).
> > Reading the attribute displays supported reset types. Writing
> > integer 0 triggers PLDR. Any other input is rejected with
> > -EINVAL and a warning log.
> >
> > Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.c=
om>
> > ---
> > Changes in v6:
> >   - Fixed .driver.dev_groups -> .dev_groups on struct pci_driver
> >     (__pci_register_driver overwrites .driver.dev_groups with .dev_grou=
ps)
> >   - Removed unrelated schedule_work() failure handling from
> >     btintel_pcie_request_reset() that caused CI context mismatch
> >
> > Changes in v5:
> >   - Renamed sysfs from vendor_rst to vendor_reset (reviewer feedback)
> >   - Switched from device_create_file() to driver dev_groups for
> >     automatic race-free sysfs lifecycle management
> >   - Added ABI doc at Documentation/ABI/testing/sysfs-bus-pci-drivers-bt=
intel_pcie
> >   - Added WiFi impact description to ABI documentation
> >   - Added MAINTAINERS F: entry for ABI doc
> >   - v5: https://lore.kernel.org/all/20260723063520.1149474-1-chandrashe=
kar.devegowda@intel.com/
> >
> > Changes in v4:
> >   - Rebased on latest bluetooth-next to fix CI apply failure
> >   - v4: https://lore.kernel.org/all/20260722012158.813793-1-chandrashek=
ar.devegowda@intel.com/
> >
> > Changes in v3:
> >   - Dropped reset_type parameter approach from hdev->reset()
> >   - Directly call btintel_pcie_request_reset() instead of manual
> >     flag manipulation and schedule_work()
> >   - Accept only integer 0 for PLDR trigger
> >   - v3: https://lore.kernel.org/all/20260722001434.804931-1-chandrashek=
ar.devegowda@intel.com/
> >
> > Changes in v2:
> >   - Added reset_type parameter to hdev->reset() callback (1/2)
> >   - vendor_rst sysfs used reset_type to select PLDR (2/2)
> >   - v2: https://lore.kernel.org/all/20260618085016.9173-1-chandrashekar=
.devegowda@intel.com/
> >
> > Changes in v1:
> >   - Initial implementation
> >   - v1: https://lore.kernel.org/all/20260612012832.2395034-1-chandrashe=
kar.devegowda@intel.com/
> >  .../sysfs-bus-pci-drivers-btintel_pcie        | 15 ++++++++
> >  MAINTAINERS                                   |  1 +
> >  drivers/bluetooth/btintel_pcie.c              | 38 +++++++++++++++++++
> >  3 files changed, 54 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-drivers-bti=
ntel_pcie
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pc=
ie b/Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
> > new file mode 100644
> > index 000000000000..cceec6ac96bc
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
> > @@ -0,0 +1,15 @@
> > +What:                /sys/bus/pci/devices/<BDF>/vendor_reset
>
> Nit, domain is present too, not just BDF.
>
> > +Date:                22-Jul-2026
> > +KernelVersion:       6.17

This needs fixing.

> Kernel 6.17 was 10 months ago.
>
> > +Contact:     linux-bluetooth@vger.kernel.org
> > +Description: This read-write attribute allows userspace to trigger a
> > +             Product Level Device Reset (PLDR) on Intel PCIe Bluetooth
> > +             controllers. Reading the attribute displays the supported
> > +             reset type. Writing integer 0 triggers PLDR. Any other
> > +             input is rejected with -EINVAL.
>
> This is opposite of /sys/bus/pci/devices/<BDF>/reset for no apparent
> reason and seems like it infringes on the namespace of sysfs-bus-pci.

Meaning this should write 1 to reset, right?

> > +
> > +             PLDR resets the entire on-chip platform shared between
> > +             Bluetooth and WiFi. This means any driver attached to
> > +             the WiFi device that shares hardware with this Bluetooth
> > +             device will be released, the platform will be reset, and
> > +             both the Bluetooth and WiFi devices will be re-probed.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index eb8cdcc76324..39d390f1ceb4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4625,6 +4625,7 @@ S:      Supported
> >  W:   http://www.bluez.org/
> >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth.git
> >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth-next.git
> > +F:   Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
> >  F:   Documentation/devicetree/bindings/net/bluetooth/
> >  F:   drivers/bluetooth/
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btint=
el_pcie.c
> > index ef42b8d11d4d..005c77a4f5eb 100644
> > --- a/drivers/bluetooth/btintel_pcie.c
> > +++ b/drivers/bluetooth/btintel_pcie.c
> > @@ -2790,6 +2790,43 @@ static void btintel_pcie_hci_reset(struct hci_de=
v *hdev)
> >       btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
> >  }
> >
> > +static ssize_t vendor_reset_store(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               const char *buf, size_t count)
> > +{
> > +     unsigned int val;
> > +     struct pci_dev *pdev =3D to_pci_dev(dev);
> > +     struct btintel_pcie_data *data =3D pci_get_drvdata(pdev);
> > +
> > +     if (!data || !data->hdev)
> > +             return -ENODEV;
> > +
> > +     if (kstrtouint(buf, 10, &val) || val !=3D 0) {
> > +             bt_dev_warn(data->hdev, "PLDR rejected: invalid input");
> > +             return -EINVAL;
> > +     }
> > +
> > +     bt_dev_info(data->hdev, "PLDR triggered via sysfs");
> > +     btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR);
>
> This is pretty scary on its own, scanning for specific wifi device IDs,
> finding the first match and releasing the driver for it while holding
> pci_lock_rescan_remove().  So an attribute on one device that unbinds
> the driver for another device (or worse, maybe reset it anyway if the
> SKUs are out of sync), and the reset happens asynchronously at some
> point in the future.  If the wifi device happens to be in use by
> vfio-pci, that delay is unbounded as it relies on a userspace driver or
> VM to release the device.

@ChandraShekar Please clarify. I guess we have no option since there
is no parent device to abstract the combo Wifi/BT design. This should
only be used when both Wifi and Bluetooth need a reset, so at that
point they shouldn't be operational. That said, maybe we should check
if control has been handed over to a VM, in which case we probably
need to reject resetting it.

> > +
> > +     return count;
> > +}
> > +
> > +static ssize_t vendor_reset_show(struct device *dev,
> > +                              struct device_attribute *attr, char *buf=
)
> > +{
> > +     return sysfs_emit(buf, "0 - PLDR\n");
>
> It seems like this is implying an enumerable list of resets, but the
> API is committing to zero/-EINVAL.  The string also isn't very sysfs
> compliant.  Thanks,

I guess you will need to explain what a 'compliant' sysfs read would
be; is this supposed to just return the current value (e.g. "0")?

> Alex
>
> > +}
> > +
> > +static DEVICE_ATTR_RW(vendor_reset);
> > +
> > +static struct attribute *btintel_pcie_attrs[] =3D {
> > +     &dev_attr_vendor_reset.attr,
> > +     NULL,
> > +};
> > +
> > +ATTRIBUTE_GROUPS(btintel_pcie);
> > +
> >  static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
> >  {
> >       struct btintel_pcie_dev_recovery *rec;
> > @@ -3250,6 +3287,7 @@ static struct pci_driver btintel_pcie_driver =3D =
{
> >       .probe =3D btintel_pcie_probe,
> >       .remove =3D btintel_pcie_remove,
> >       .driver.pm =3D pm_sleep_ptr(&btintel_pcie_pm_ops),
> > +     .dev_groups =3D btintel_pcie_groups,
> >  #ifdef CONFIG_DEV_COREDUMP
> >       .driver.coredump =3D btintel_pcie_coredump
> >  #endif
>


--=20
Luiz Augusto von Dentz
