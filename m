Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80493DDB1A
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193920; cv=pass; b=Muvu6BjajjWe7282T+pT3n4vIpHcENb+YQ9nZScwHG80I3/CNquPrcTPeI0YtRIJeXMsG1NAo5q79WD1yoEp7p5a3s7/AEM8L6boXSMuemFn6aQIxOj+sShtbjtpayzqvqEleyg5I2vSuJLQxXhiMqb6FAuX8Bdee1fhavXqDxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193920; c=relaxed/simple;
	bh=ITuNFS+ArqHs4uUYYrb1+XCchKlqpu7M5XSnVXxxFl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1q7aNniulybhjEv+zWGbWE0i/y2MkqPeGgSqyKZSmq99bZk3CwDn3/JT78rPQMXHX4VkYgfQkCkRf0ivBPs1CtkbYwoC0NHs5GcnY6pScmNGetv8rBD5lQH9jWdIyy9cL7U9zFSyfT3kanE4I0JMYWb1YdtNdfW4irtpjXHujQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/2tENGu; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/2tENGu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cab973140bso43642255ad.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 16:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785193918; cv=none;
        d=google.com; s=arc-20260327;
        b=XcnwwkMTYMR5q5Ov7RfGwVIu4cTE+wRnU9G5IXwSZhGi8117BkJvexZ3Smco0UV1Tn
         BYl7ncKqexzrtCkkoN2RlxhkFfsfIbRdk5pZAWbo4H/jYa84kbCDNgRjYFBRSzYTy/5y
         a774gheIHuaH4hAuSa8X1HEGj7QeTUFKLd8GflnSMZX4a/mRUQhIrTJ8ifIypecaJQgr
         mna4jv6kjaznQAFuwnhVmmq5nrVWuFJaa5GLO7b/7e+PvDtwNPx36sR3cYy/4wEZhE/k
         KBmxAT3OuLsRnl8OyIc4hYRLDJFrMbcjZsuv5A3gtvUhEpBXeY0kg/cb4CW1wcQl2Nn3
         xtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HKYX6MBNkON49Nh0xcO/b2fLDl151kQWhNZfLQTn9Bo=;
        fh=LXFk2sb6fLIlaF89/LOLvX+FiHFPtCIot4qboAFOiL8=;
        b=HEU4i6alvXPaJ/s65YYN3xIyztGSBhBALkBiNf0EGKpsIStnzIq86yS/kXisF0957Q
         d/z/g2ij454xZzPyHFZNlf0W6BcpYKWFbA1d3i9RRikfIzj+xx+FoEEdyBt91ZOsse0h
         0/WWUyt+V3cluWxDAT6Gb0bQBOOidz4T8RPccQefkWkUvFiwCulSZbhmNfuQjuz5e+b0
         YzDpAh+SLrwYWr5y5kYXe85NLFvt0mFLc1PRvF41eqnCFw35Kk60DoZDzpnSqhvWoEd+
         17p+IxJ5LdK0ilizyf7ZdTL/hTIhX49GL3tzILrNKivvRUEH72e7U5k2lS255Xb/l2W8
         3+uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785193918; x=1785798718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HKYX6MBNkON49Nh0xcO/b2fLDl151kQWhNZfLQTn9Bo=;
        b=B/2tENGuB2vw7wc1n05FQRtdFn1i70gV4Q/0fW8/qbRN3BxCXXtjuFV4NgBPLOTNac
         O0++uXafKzrgyA+KE3orZBeAviAoCe6QfV+FeODMocaRM5YT8j0Mpry1ZoAC5IbLPjd4
         GbZr/ghPm7gLsCJbEvSqdJFraGbsHrdDiWmplp4Ip8GqphxzyAC2NsuMwWwT0CQjT3tN
         nHn4j376PnYy61TcRcbeQ/Wxs96zI7jtoAi6cscnVMVAXFMMBkfN069ES1UokuUbbXji
         Goec3daupahLn31B5oMGFvRx8tkl0Z3DgfSGN4Gq9YJRZailiy5kFH461O5aF9TLZKyS
         26Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785193918; x=1785798718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HKYX6MBNkON49Nh0xcO/b2fLDl151kQWhNZfLQTn9Bo=;
        b=jzE9mXdfCFIyc97GFISdXd+HkwNpxuPOU5a+ig6lzzx3/2PnP1fFlbn45VoMM6Ps9D
         s9hanOF+cf0raqOcK/C+0rj4o7q+gjAVj8efhxr3bHjSInI5k2RuFg1f1F3C1FtlJyuz
         iU04QxTWyN5Ly910qRkNVeOJacsXW6wn8p3/BzdeBQwyIYw8KIykKZs4lELCdH87fY68
         Jgj8jreb9GAlj7oyZAXyuN/hH6eVhfk9U8koWD13ljBJ+/Of6vfrEZS2mGQij8q7N1p7
         LSHV1/++PMb2wIy3ihsZLc+w1rfyylSGGfmV75Fh975y1JOuQq/0F889nhzZ/2niHwNy
         mlfA==
X-Forwarded-Encrypted: i=1; AHgh+RooaHSmk9OCDHmzAhVgu12qBB2lq9xp0n9LUyd8MYH1M6ZWSOOP28ZNOzLf+CFwICDuF5t4q3UQrRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeA/2TX9xgEFdsdPZJRVEiGJXiCjGBCvyvHYAnXv2MBAnUUYr
	+rTlV18wEJju9dvr+/flUzBlT2G+++1T3+V+4k6QcrO/Q46Lrm9m43vXIiFwjSDKPnqBc/IFQN1
	3mquhRg9oVO80Ig0AdcnUjkMQ1LnrVju6xYTYGEjj
X-Gm-Gg: AR+sD11ZINo/hBBWCNjqH2xHGhP1be127a0jrxKfhIoczKVeWNxgsOlxwkNG97dTN9B
	wLBRvtWby4Q3wOY2QOWIErCP0flE5OyNikonqb2F8pMBPMEwd8BwbuV2qRctqag1RegRKVjy7Ae
	Vb4FgeFBDtWwKV9Z6fzzunWUx5v6D3012MJ3jYz1xuOOQD2cUhdKyTEv3EUQBDboz+zkQv5ioBb
	29DX/TAMmRyFkD+lUHwRhTipQJXR0VcIkvIZEdXp+kyDDEVW270G4bccLBh3A==
X-Received: by 2002:a05:6a20:1602:b0:3c3:a140:9380 with SMTP id
 adf61e73a8af0-3c67da110cbmr9254089637.16.1785193917231; Mon, 27 Jul 2026
 16:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-9-dmatlack@google.com> <20260727225400.GA1268182@bhelgaas>
In-Reply-To: <20260727225400.GA1268182@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Jul 2026 16:11:30 -0700
X-Gm-Features: AUfX_mzLbM8Xvip4BocV7H9dzt38_o2cBqJVqu1U8PQ6CB7g5t10t9WIgEeI5do
Message-ID: <CALzav=ddQN3RQjmjZk=FpuuzxJMHzO8wK8yDgGn+=LTiTnZG2w@mail.gmail.com>
Subject: Re: [PATCH v7 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:54=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 10, 2026 at 09:26:11PM +0000, David Matlack wrote:
> > Inherit Access Control Services (ACS) flags on all incoming preserved
> > devices (endpoints and upstream bridges) during a Live Update.
> >
> > Inheriting ACS flags avoids changing routing rules while memory
> > transactions are in flight from preserved devices. This is also strictl=
y
> > necessary to ensure that IOMMU group assignments do not change across
> > a Live Update for preserved devices, as changing ACS configurations can
> > split or merge IOMMU groups.
> >
> > Cache the inherited ACS controls established by the previous kernel in
> > struct pci_dev so that ACS controls do not change after a reset
> > (pci_restore_state() calls pci_enable_acs()).
> >
> > To simplify ACS inheritance, reject preserving any devices that require
> > quirks to enable ACS as those quirks would also have to take Live Updat=
e
> > into account.
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/liveupdate.h       | 11 ++++++
> >  drivers/pci/pci.c              |  6 +++
> >  drivers/pci/pci.h              |  5 +++
> >  drivers/pci/quirks.c           |  7 ++++
> >  include/linux/pci_liveupdate.h |  6 +++
> >  6 files changed, 103 insertions(+)
> >
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 7f7710cb1da0..a95bfe5eff77 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -71,6 +71,9 @@
> >   *
> >   *  * The device cannot be a Virtual Function (VF).
> >   *
> > + *  * The device cannot require device-specific quirks to enable Acces=
s
> > + *    Control Services (ACS).
> > + *
> >   * Driver Binding
> >   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   *
> > @@ -113,6 +116,18 @@
> >   * This enables the PCI core and any drivers bound to the bridge to pa=
rticipate
> >   * in the Live Update so that preserved endpoints can continue issuing=
 memory
> >   * transactions during the Live Update.
> > + *
> > + * Handling Preserved Devices
> > + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > + *
> > + * The PCI core treats preserved devices differently than non-preserve=
d devices.
> > + * This section enumerates those differences.
> > + *
> > + *  * The PCI core inherits all ACS flags enabled on incoming preserve=
d devices
> > + *    rather than assigning new ones. This ensures that TLPs are route=
d the same
> > + *    way after Live Update and ensures that IOMMU groups do not chang=
e. Note
> > + *    that a device will use its inherited ACS flags for the lifetime =
of its
> > + *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> >   */
> >
> >  #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
> > @@ -128,6 +143,7 @@
> >  #include <linux/slab.h>
> >
> >  #include "liveupdate.h"
> > +#include "pci.h"
> >
> >  /**
> >   * struct pci_liveupdate_global - Global state for PCI Live Update sup=
port
> > @@ -374,6 +390,16 @@ static int __pci_liveupdate_preserve_device(struct=
 pci_flb_outgoing *outgoing, s
> >  {
> >       struct pci_dev_ser *dev_ser;
> >
> > +     /*
> > +      * Do not preserve devices that rely on device-specific ACS equiv=
alents
> > +      * (for now) since that would complicate keeping ACS constant acr=
oss
> > +      * Live Update.
> > +      */
> > +     if (pci_need_dev_specific_enable_acs(dev)) {
> > +             pci_warn(dev, "Refusing to preserve device that relies on=
 ACS quirks\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       dev_ser =3D pci_get_empty_or_append(outgoing);
> >       if (IS_ERR(dev_ser))
> >               return PTR_ERR(dev_ser);
> > @@ -655,6 +681,7 @@ void pci_liveupdate_setup_device(struct pci_dev *de=
v)
> >
> >       pci_info(dev, "Device was preserved by previous kernel across Liv=
e Update\n");
> >       dev->liveupdate.incoming =3D dev_ser;
> > +     dev->liveupdate.was_preserved =3D true;
> >
> >       /*
> >        * Hold the ref on the incoming FLB until pci_liveupdate_finish()=
 so
> > @@ -748,6 +775,47 @@ void pci_liveupdate_finish(struct pci_dev *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
> >
> > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > +{
> > +     guard(rwsem_read)(&pci_liveupdate.rwsem);
> > +
> > +     if (!dev->acs_cap || !dev->liveupdate.incoming)
> > +             return;
> > +
> > +     pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->live=
update.acs_ctrl);
>
> This is called from pci_acs_init(), which is called from
> pci_init_capabilities() when we first enumerate a device, so it
> captures PCI_ACS_CTRL at boot-time, which is before any
> pci_enable_acs() calls.  I don't think it will include the effect of
> pci_std_enable_acs() (if an IOMMU driver called pci_request_acs() and
> there was no device-specific quirk) or any command-line parameters
> ("pci=3Dconfig_acs=3D").
>
> I thought you would want to save the
> PCI_ACS_CTRL value at the time of the liveupdate?
>
> I'm having a hard time parsing pci_enable_acs(), so I'm sure I'm
> missing something here.

Since dev->liveupdate.incoming is non-NULL (see check prior to the
pci_read_config_word()), this device was preserved by the previous
kernel. The intent of the pci_read_config_word() here is to capture
the value of PCI_ACS_CTRL that was established by the previous kernel,
so that it can continue to be used in this kernel whenever this kernel
needs to re-enable ACS controls (e.g. pci_restore_state() ->
pci_enable_acs()).

>
> > +}
> > +
> > +int pci_liveupdate_enable_acs(struct pci_dev *dev)
> > +{
> > +     u16 acs_ctrl =3D dev->liveupdate.acs_ctrl;
> > +     u16 acs_cap =3D dev->acs_cap;
> > +
> > +     /*
> > +      * Use liveupdate.was_preserved instead of liveupdate.incoming si=
nce the
> > +      * device's ACS controls should not change even after the device =
is
> > +      * finished participating in the Live Update.
> > +      */
> > +     if (!dev->liveupdate.was_preserved)
> > +             return -EINVAL;
>
> I don't quite understand what's going on here.
>
> Partly it's because the function name and return values don't seem
> obvious to me.  I guess returning 0 means "this device was preserved
> across a liveupdate and we restored its previous ACS CTRL value, so
> pci_enable_acs() doesn't need to do anything else."
>
> Anything else means "device has not been preserved across a liveupdate
> (or it was preserved but the new kernel added a device-specific ACS
> quirk for it)."
>
> But more fundamentally, after a liveupdate has completed, why does
> pci_enable_acs() need to work differently than it would if there had
> never been a liveupdate?
>
> Maybe it's the comment that's confusing me.  Returning -EINVAL means
> pci_enable_acs() will continue on and potentially update ACS CTRL.
> The comment suggests "ACS controls shouldn't change even after
> liveupdate completes", but if we don't want pci_enable_acs() to do
> anything, wouldn't we return 0 here?
>
> I guess this part will be exercised by pci_restore_state(), e.g.,
> during resume after suspend.  I can't remember why we use
> pci_enable_acs() there instead of saving ACS state in pci_save_state()
> and then restoring it.

I think that's it. Instead of saving and restoring the ACS controls,
pci_restore_state() calls pci_enable_acs().

If we did not cache the ACS controls established by the previous
kernel in pci_liveupdate_init_acs() (during pci_acs_init()), and then
the device later goes through pci_restore_state() (e.g. reset) then
the device will get whatever ACS controls _this_ kernel decides it
should have, which may not match what the previous kernel established.
Since ACS controls affect things link IOMMU groups, I don't think it's
safe to change them.

So the intent of this patch is to ensure that the ACS controls
established by the previous kernel are preserved in the next.

>
> > +     /*
> > +      * The previous kernel should not have preserved any devices that
> > +      * require device-specific quirks to enable ACS, but if such a de=
vice is
> > +      * detected (e.g. new device-specific ACS quirk in the current ke=
rnel),
> > +      * log a big warning and fall back to the normal enable ACS path.
> > +      */
> > +     if (pci_need_dev_specific_enable_acs(dev)) {
> > +             pci_warn(dev, "Device-specific quirk required to enable A=
CS!\n");
> > +             WARN_ON_ONCE(true);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (acs_cap)
> > +             pci_write_config_word(dev, acs_cap + PCI_ACS_CTRL, acs_ct=
rl);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * pci_liveupdate_is_incoming() - Check if a device is incoming-preser=
ved
> >   * @dev: The PCI device to check
> > diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> > index c763255a8de4..4e8a01bcb4bb 100644
> > --- a/drivers/pci/liveupdate.h
> > +++ b/drivers/pci/liveupdate.h
> > @@ -16,6 +16,8 @@ void pci_liveupdate_cleanup_device(struct pci_dev *de=
v);
> >  bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_=
dev *dev,
> >                                     int pass);
> >  void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
> > +void pci_liveupdate_init_acs(struct pci_dev *dev);
> > +int pci_liveupdate_enable_acs(struct pci_dev *dev);
> >  #else
> >  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
> >  {
> > @@ -35,6 +37,15 @@ static inline bool pci_liveupdate_scan_bridge_begin(=
struct pci_bus *bus,
> >  static inline void pci_liveupdate_scan_bridge_end(struct pci_dev *dev,=
 int pass)
> >  {
> >  }
> > +
> > +static inline void pci_liveupdate_init_acs(struct pci_dev *dev)
> > +{
> > +}
> > +
> > +static inline int pci_liveupdate_enable_acs(struct pci_dev *dev)
> > +{
> > +     return -EINVAL;
> > +}
> >  #endif
> >
> >  #endif /* DRIVERS_PCI_LIVEUPDATE_H */
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 77b17b13ee61..739ecaab2e76 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -34,6 +34,8 @@
> >  #include <linux/aer.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/suspend.h>
> > +
> > +#include "liveupdate.h"
> >  #include "pci.h"
> >
> >  DEFINE_MUTEX(pci_slot_mutex);
> > @@ -1008,6 +1010,9 @@ void pci_enable_acs(struct pci_dev *dev)
> >       bool enable_acs =3D false;
> >       int pos;
> >
> > +     if (!pci_liveupdate_enable_acs(dev))
> > +             return;
> > +
> >       /* If an iommu is present we start with kernel default caps */
> >       if (pci_acs_enable) {
> >               if (pci_dev_specific_enable_acs(dev))
> > @@ -3689,6 +3694,7 @@ void pci_acs_init(struct pci_dev *dev)
> >
> >       pci_read_config_word(dev, pos + PCI_ACS_CAP, &dev->acs_capabiliti=
es);
> >       pci_disable_broken_acs_cap(dev);
> > +     pci_liveupdate_init_acs(dev);
> >  }
> >
> >  /**
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 4469e1a77f3c..988a18b3204a 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -1047,6 +1047,7 @@ void pci_acs_init(struct pci_dev *dev);
> >  void pci_enable_acs(struct pci_dev *dev);
> >  #ifdef CONFIG_PCI_QUIRKS
> >  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
> > +bool pci_need_dev_specific_enable_acs(struct pci_dev *dev);
> >  int pci_dev_specific_enable_acs(struct pci_dev *dev);
> >  int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
> >  void pci_disable_broken_acs_cap(struct pci_dev *pdev);
> > @@ -1057,6 +1058,10 @@ static inline int pci_dev_specific_acs_enabled(s=
truct pci_dev *dev,
> >  {
> >       return -ENOTTY;
> >  }
> > +static inline bool pci_need_dev_specific_enable_acs(struct pci_dev *de=
v)
> > +{
> > +     return false;
> > +}
> >  static inline int pci_dev_specific_enable_acs(struct pci_dev *dev)
> >  {
> >       return -ENOTTY;
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 7ac39ec2843e..99b819f38e49 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5473,6 +5473,13 @@ static const struct pci_dev_acs_ops *pci_dev_acs=
_ops_get(struct pci_dev *dev)
> >       return NULL;
> >  }
> >
> > +bool pci_need_dev_specific_enable_acs(struct pci_dev *dev)
> > +{
> > +     const struct pci_dev_acs_ops *p =3D pci_dev_acs_ops_get(dev);
> > +
> > +     return p && p->enable_acs;
> > +}
> > +
> >  int pci_dev_specific_enable_acs(struct pci_dev *dev)
> >  {
> >       const struct pci_dev_acs_ops *p =3D pci_dev_acs_ops_get(dev);
> > diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupd=
ate.h
> > index 2be98819e313..2446c6d237ca 100644
> > --- a/include/linux/pci_liveupdate.h
> > +++ b/include/linux/pci_liveupdate.h
> > @@ -17,14 +17,20 @@
> >   * struct pci_liveupdate - PCI Live Update state for a struct pci_dev
> >   * @outgoing: State preserved for the next kernel.
> >   * @incoming: State preserved by the previous kernel.
> > + * @acs_ctrl: ACS features established by the previous kernel.
> >   * @inherit_buses: True if the PCI core should inherit the secondary a=
nd
> >   *                 subordinate bus numbers assigned to this device due=
 to
> >   *                 an ongoing Live Update.
> > + * @was_preserved: True if this struct pci_dev was preserved by the pr=
evious
> > + *                 kernel. Unlike @incoming, this field is not cleared=
 after
> > + *                 the device is finished participating in Live Update=
.
> >   */
> >  struct pci_liveupdate {
> >       struct pci_dev_ser *outgoing;
> >       struct pci_dev_ser *incoming;
> > +     u16 acs_ctrl;
> >       bool inherit_buses;
> > +     bool was_preserved;
> >  };
> >
> >  struct pci_dev;
> > --
> > 2.55.0.795.g602f6c329a-goog
> >
