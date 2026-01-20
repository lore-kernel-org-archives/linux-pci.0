Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177983A900F
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948267; cv=none; b=a8o2Nz2c3ACUeoK+qHHQ3S5tg4nLvcpPdr8m2dc4AI4ep2Xrok4MexX/ha1wjwfZfjrhFr+vrtXWh2ca3N1GdEB9pgsjofZ5sa7HMw0nR05bpd7lnxKwH4EYBBDzGbnCSXKwJIomxf4ChiXsoTZSc6rwuOsye5eyLWTyDwrkCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948267; c=relaxed/simple;
	bh=ilwDOQ+Ky9sEU+XAh3/6e2HFWyE4Td7xc2xIEIOQ8MQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kAK2PvXm3L1U0ZXXdaba3238P9HqvY4vBnsQaKZwgal3Pl4cMQoKM/yJy2f2ftcirNRqbgfQJ+QmX5XdlxcOQtC/oxeMqh+EfD6P8zvooV6qJ37H4IrRUoeXbpqrvN6MkLNGYPusDoOe1eNBGO9hZg7bBEzhuyjxUJJMoVChs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4i0dpOI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eijwNGU4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4i0dpOI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eijwNGU4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768948260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huUka6A3EtIZhdtjgUZphztIlPBAes0tkKFnp/8PKFc=;
	b=V4i0dpOIhbf7se4PM80Fkh3cMIFON7oSOLk77eXJTMEv4Nj7Or7fwdOzZtKIIlnZKKupzb
	51DMuKGKxd4VjBYpEKNDhz0VQ+912PuA3+ABHPxhZC2imlvi1vSBtSDbGT8G18rf2sQaIv
	PJrSx6jxM94jxw8QgHDATyfGdwRz6Bw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-Er7q3N9WOIm2i5M4C61cPA-1; Tue, 20 Jan 2026 17:30:59 -0500
X-MC-Unique: Er7q3N9WOIm2i5M4C61cPA-1
X-Mimecast-MFC-AGG-ID: Er7q3N9WOIm2i5M4C61cPA_1768948258
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c5296c7e57so2012842085a.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 14:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768948258; x=1769553058; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=huUka6A3EtIZhdtjgUZphztIlPBAes0tkKFnp/8PKFc=;
        b=eijwNGU4K4j+gnlL+9qCTG8EBtWfs0ZS0SGM2HgumoQ2nhM58x+k6iGgbqXLZzNWKU
         Hg3R3euZiSbRbudcja/HQoJlBwsUY1RARKavaH3HhrInpevPW52tbmhh69NcWwfoB0TJ
         7Rv2DKoQ4R+wZHdi/kRdQWdhBT8NYo53qucaq6ilx2VVIperkb7jSqT7cEHvRJ9Yq+9w
         j/luYLfurX2Mv8tiBxdpanq80499icz6ePJddtaPbJrDThHTjltCeE0yoRGBRM695hzX
         VZqPKfs1DLAdjtR2GFRxjrBrJ+09w6gHoUi1L8pCh+mPWI5F+P6QYO6ODL7b+ooJ2HZz
         La6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768948258; x=1769553058;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huUka6A3EtIZhdtjgUZphztIlPBAes0tkKFnp/8PKFc=;
        b=G7flLLZboKpSaFENfRJ5GFeb6RzvJ7szqCh80hVlDZheuQLpwC2KBLBbQl9IrQclzf
         TUG/NPw3sJmiOgb4Yrldm0PUX6cV7KSq/bLed4pxd8PDXejjCSQIxiZsnARej0mXejhV
         P3vlmkycypY1uRYe77/Z9XMTX1MuuRjnTBq6suQNQmfBqFvpklTx9l54Cpca4kokKOGl
         9QJIuxqXzSC/wy+HL1ErUXpzBk2ehrdS67rGrkrZLDtvMr06G2z5bLHgj4BU8dL4q/8L
         7aohC+vtsgLlp55vIGIGo4q7bBEPMus6h0UPp4KKM05tFxJ/QExxCW+lKrxteiOcAC40
         y78Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbIvz4NIEKdvX7bCqW/iTF8Ez2/0Tadfoa0B/zCOofpekKljqtfas7jcUXMFU3sUBMTdTRnQYEDh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYlon84INO1HJ2AmzIgOQdvjwcMpPMWHg/Td4F5OBdFqmGdxc
	jVSGuSe8S2Q8ihg6oBmQQyF+wM5dD009pdJZZZdAmdeyPN/R6NqQG0Md3hGNLGzC7nwLohekSmY
	vvnOFrmzNY/qxn7xoaUYHK64dKHgtdqw3r97/zM2F+hSGqjHS6GZf93xYXHYKOA==
X-Gm-Gg: AY/fxX5LCltxeXlVTN0ceoO8JyOwTChlmPXtL/0b1ujKvbRCmV9kOu8s6V747T8R3gg
	rDxKI9xR9/ni8ZWMXGEDnNY19FBMkjUi4rKRW6oJ9cUuzYYVBxqKG3QkPnoHyCM8ISp5zybwQjC
	btmNh7AfajEJd5gL65Kwuopurqvw6juR8HGnu9oiZqjlDR8f38RM3TIo7O5QdprhXzrHD1IkJcR
	T0+OtnYMYfHKpGdEei/VTSCj+b4VrsxFMBu8DXRBYDF3mumuRhyG9BO+nx5jRMmQvGb/aUKnp6H
	Jswsqr2KhVo6yij9UlFVJHB7kGd/z0aGP2CFvnKOGTAAmgfY1JHvNKRNtdM8Td8xMpdkhOJA1LR
	y4eegjmY423ToiwYXQmNThUeexKvtIUwq+pisK9oyIMQo78IlH9NDr2XS/waC1c5aTyUfm2kaNS
	nWxA==
X-Received: by 2002:a05:620a:454d:b0:8a3:1b83:1036 with SMTP id af79cd13be357-8c6a6909e5emr2246459285a.29.1768948258381;
        Tue, 20 Jan 2026 14:30:58 -0800 (PST)
X-Received: by 2002:a05:620a:454d:b0:8a3:1b83:1036 with SMTP id af79cd13be357-8c6a6909e5emr2246453585a.29.1768948257850;
        Tue, 20 Jan 2026 14:30:57 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ab272sm1157948285a.2.2026.01.20.14.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:30:57 -0800 (PST)
Message-ID: <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
From: Radu Rendec <rrendec@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
  Manivannan Sadhasivam	 <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, Marek =?ISO-8859-1?Q?Beh=FAn?=	
 <kabel@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Jingoo Han	 <jingoohan1@gmail.com>,
 Brian Masney <bmasney@redhat.com>, Eric Chanudet	 <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas	
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,  "linux-tegra@vger.kernel.org"	
 <linux-tegra@vger.kernel.org>
Date: Tue, 20 Jan 2026 17:30:55 -0500
In-Reply-To: <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
	 <20251128212055.1409093-4-rrendec@redhat.com>
	 <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jon,

On Tue, 2026-01-20 at 18:01 +0000, Jon Hunter wrote:
> On 28/11/2025 21:20, Radu Rendec wrote:
> > Leverage the interrupt redirection infrastructure to enable CPU affinit=
y
> > support for MSI interrupts. Since the parent interrupt affinity cannot
> > be changed, affinity control for the child interrupt (MSI) is achieved
> > by redirecting the handler to run in IRQ work context on the target CPU=
.
> >=20
> > This patch was originally prepared by Thomas Gleixner (see Link tag
> > below) in a patch series that was never submitted as is, and only
> > parts of that series have made it upstream so far.
> >=20
> > Originally-by: Thomas Gleixner <tglx@linutronix.de>
> > Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
> > Signed-off-by: Radu Rendec <rrendec@redhat.com>
> > ---
> > =C2=A0 .../pci/controller/dwc/pcie-designware-host.c | 33 +++++++++++++=
+++---
> > =C2=A0 1 file changed, 28 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driver=
s/pci/controller/dwc/pcie-designware-host.c
> > index aa93acaa579a5..90d9cb45e7842 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -26,9 +26,27 @@ static struct pci_ops dw_pcie_ops;
> > =C2=A0 static struct pci_ops dw_pcie_ecam_ops;
> > =C2=A0 static struct pci_ops dw_child_pcie_ops;
> > =C2=A0=20
> > +#ifdef CONFIG_SMP
> > +static void dw_irq_noop(struct irq_data *d) { }
> > +#endif
> > +
> > +static bool dw_pcie_init_dev_msi_info(struct device *dev, struct irq_d=
omain *domain,
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct irq_domain *real_parent, struct=
 msi_domain_info *info)
> > +{
> > + if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> > + return false;
> > +
> > +#ifdef CONFIG_SMP
> > + info->chip->irq_ack =3D dw_irq_noop;
> > + info->chip->irq_pre_redirect =3D irq_chip_pre_redirect_parent;
> > +#else
> > + info->chip->irq_ack =3D irq_chip_ack_parent;
> > +#endif
> > + return true;
> > +}
> > +
> > =C2=A0 #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS | \
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MSI_FLAG_USE_DEF_CHIP_OPS | \
> > - =C2=A0=C2=A0=C2=A0 MSI_FLAG_NO_AFFINITY | \
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MSI_FLAG_PCI_MSI_MASK_PARENT)
> > =C2=A0 #define DW_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI | \
> > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 MSI_FLAG_PCI_MSIX | \
> > @@ -40,9 +58,8 @@ static const struct msi_parent_ops dw_pcie_msi_parent=
_ops =3D {
> > =C2=A0=C2=A0 .required_flags =3D DW_PCIE_MSI_FLAGS_REQUIRED,
> > =C2=A0=C2=A0 .supported_flags =3D DW_PCIE_MSI_FLAGS_SUPPORTED,
> > =C2=A0=C2=A0 .bus_select_token =3D DOMAIN_BUS_PCI_MSI,
> > - .chip_flags =3D MSI_CHIP_FLAG_SET_ACK,
> > =C2=A0=C2=A0 .prefix =3D "DW-",
> > - .init_dev_msi_info =3D msi_lib_init_dev_msi_info,
> > + .init_dev_msi_info =3D dw_pcie_init_dev_msi_info,
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 /* MSI int handler */
> > @@ -63,7 +80,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
> > =C2=A0=C2=A0 continue;
> > =C2=A0=20
> > =C2=A0=C2=A0 for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
> > - generic_handle_domain_irq(pp->irq_domain, irq_off + pos);
> > + generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
> > =C2=A0=C2=A0 }
> > =C2=A0 }
> > =C2=A0=20
> > @@ -140,10 +157,16 @@ static void dw_pci_bottom_ack(struct irq_data *d)
> > =C2=A0=20
> > =C2=A0 static struct irq_chip dw_pci_msi_bottom_irq_chip =3D {
> > =C2=A0=C2=A0 .name =3D "DWPCI-MSI",
> > - .irq_ack =3D dw_pci_bottom_ack,
> > =C2=A0=C2=A0 .irq_compose_msi_msg =3D dw_pci_setup_msi_msg,
> > =C2=A0=C2=A0 .irq_mask =3D dw_pci_bottom_mask,
> > =C2=A0=C2=A0 .irq_unmask =3D dw_pci_bottom_unmask,
> > +#ifdef CONFIG_SMP
> > + .irq_ack =3D dw_irq_noop,
> > + .irq_pre_redirect =3D dw_pci_bottom_ack,
> > + .irq_set_affinity =3D irq_chip_redirect_set_affinity,
> > +#else
> > + .irq_ack =3D dw_pci_bottom_ack,
> > +#endif
> > =C2=A0 };
> > =C2=A0=20
> > =C2=A0 static int dw_pcie_irq_domain_alloc(struct irq_domain *domain, u=
nsigned int virq,
>=20
>=20
> I am seeing another issue with this patch. On the Tegra194 AGX Xavier
> platform suspend is failing and reverting this patch fixes the problem.
>=20
> Unfortunately the logs don't tell me much. In a bad case I see ...
>=20
> =C2=A0 PM: suspend entry (deep)
> =C2=A0 Filesystems sync: 0.000 seconds
> =C2=A0 Freezing user space processes
> =C2=A0 Freezing user space processes completed (elapsed 0.002 seconds)
> =C2=A0 OOM killer disabled.
> =C2=A0 Freezing remaining freezable tasks
> =C2=A0 Freezing remaining freezable tasks completed (elapsed 0.001 second=
s)
> =C2=A0 tegra-xusb 3610000.usb: Firmware timestamp: 2020-09-11 16:55:03 UT=
C
> =C2=A0 dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
> =C2=A0 tegra194-pcie 14100000.pcie: Link didn't transition to L2 state
> =C2=A0 Disabling non-boot CPUs ...
>=20
> It appears to hang here. In a good case I see ...
>=20
> =C2=A0 PM: suspend entry (deep)
> =C2=A0 Filesystems sync: 0.000 seconds
> =C2=A0 Freezing user space processes
> =C2=A0 Freezing user space processes completed (elapsed 0.002 seconds)
> =C2=A0 OOM killer disabled.
> =C2=A0 Freezing remaining freezable tasks
> =C2=A0 Freezing remaining freezable tasks completed (elapsed 0.001 second=
s)
> =C2=A0 tegra-xusb 3610000.usb: Firmware timestamp: 2020-09-11 16:55:03 UT=
C
> =C2=A0 dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
> =C2=A0 tegra194-pcie 14100000.pcie: Link didn't transition to L2 state
> =C2=A0 Disabling non-boot CPUs ...
> =C2=A0 psci: CPU7 killed (polled 0 ms)
> =C2=A0 psci: CPU6 killed (polled 4 ms)
> =C2=A0 psci: CPU5 killed (polled 0 ms)
> =C2=A0 psci: CPU4 killed (polled 4 ms)
> =C2=A0 psci: CPU3 killed (polled 4 ms)
> =C2=A0 psci: CPU2 killed (polled 0 ms)
> =C2=A0 psci: CPU1 killed (polled 0 ms)
> =C2=A0 ...
> =C2=A0 Enabling non-boot CPUs ... (resume starts)
>=20
> So it looks like it is hanging when disabling the non-boot CPUs. So far=
=20
> it only appears to happen on Tegra194.
>=20
> Let me know if you have any suggestions.

Ouch. I'm afraid this is going to be much harder to figure out than the
previous one, especially since I can't get access easily to a board to
test on. I will try to reserve a board and reproduce the bug.

Meanwhile, if you (or someone else in your team) can spare a few cycles,
could you please try to reproduce the bug again with the debug patch
below applied, and a few other changes:
 * enable debug messages in kernel/irq/cpuhotplug.c;
 * save the contents of /proc/interrupts to a file before suspending;
 * add "no_console_suspend" to the kernel command line (although it
   looks like you already have it).

It will be much more verbose during suspend but hopefully we can at
least figure out how far along it goes and how it's related to the MSI
affinity configuration.

Thanks,
Radu

---

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 84cc4bea773c0..62ae76661f26d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1492,6 +1492,8 @@ int irq_chip_redirect_set_affinity(struct irq_data *d=
ata, const struct cpumask *
 {
 struct irq_redirect *redir =3D &irq_data_to_desc(data)->redirect;
=20
+ pr_info("%s: irq %u mask 0x%*pb\n", __func__, data->irq, cpumask_pr_args(=
dest));
+
 WRITE_ONCE(redir->target_cpu, cpumask_first(dest));
 irq_data_update_effective_affinity(data, dest);
=20
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index cd5689e383b00..d8c62547f9d06 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -59,6 +59,8 @@ static bool migrate_one_irq(struct irq_desc *desc)
 bool brokeaff =3D false;
 int err;
=20
+ pr_info("%s: irq %u cpu %u\n", __func__, d->irq, smp_processor_id());
+
 /*
 * IRQ chip might be already torn down, but the irq descriptor is
 * still in the radix tree. Also if the chip has no affinity setter,
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 3fe6b0c99f3d8..94bd7ad64c9b7 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -227,6 +227,7 @@ static int multi_cpu_stop(void *data)
 stop_machine_yield(cpumask);
 newstate =3D READ_ONCE(msdata->state);
 if (newstate !=3D curstate) {
+ pr_info("%s: cpu %d entering state %d\n", __func__, cpu, newstate);
 curstate =3D newstate;
 switch (curstate) {
 case MULTI_STOP_DISABLE_IRQ:

