Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768E315D3B
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536239; cv=none; b=PzjhAtXVUsutovnx04WYWh4L1e0z+1IDdo9gnBGtrvsG35DLxXORg9rIi8wXVi1X3HfUzBKaLComPJuvwuP5tuO3ogRaZsXBvf9lf3DMA4mjoJJ4T3s23jKofv0bGi3p5IH/LXlZvjFFQFix/xpYs580OgbJojfwEEyUnMN9t5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536239; c=relaxed/simple;
	bh=vMhVuToLIag3bSMP5xMCZderMPeMrUpStjag0O75BxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKLr9B8cyaCoEpd0PWK8dI+TozU3rL8JPrpwAGcgQs88kGbA1yVW+rTaqsIqsjvW8e4e2w1qm6mFWKndIG/KDH22UvgZHbMEuMrRXX7ZeEVCt8yG6CdquSqD7MCn8rCyzCgY8Jsq8N7ZSsX3MAnOhny6mhjNGTsMo3NydaskVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz8wkdhf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz8wkdhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6BAC2BC9E
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769536239;
	bh=vMhVuToLIag3bSMP5xMCZderMPeMrUpStjag0O75BxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qz8wkdhfyK8A+2Af8FXEmFdvklwXjP2iLe3Umozm2CpLEnwER2YvfVqDrbkHiwPtk
	 TUYc3TrE2jppxdgPyfd1sLjvj0kn2pCd8AXOB5jmSXGFQlPS1l0GYg4mXDwezc0bah
	 VMwVy/1D/HpDRhb+fvYpRbhdaBdsrrLEU0F4i6GHQaiDphm7EPjUnsf7OxQLgFgcts
	 YDtrsRAqOqaJAQYuklEsYcdI7RyA1+xoNbS1h8CaP4cmo6XTfTLA2RUWr4V6+TZEbf
	 F8DEIqOMGBBtAK5iJ5QEk4REM3HnvL2DjYawDqxZLJ4BdaiaZIwoOicQOvK+S0nlbS
	 bVr6Iid+6WLew==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c87d82bd2so4023194b6e.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 09:50:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5n/6pcRVOOCWu6Vxt1rcCmwzG13dsCexEOUfLwa2vmp+HjQyUeHfgzmNq270ZqljQkpeFTuUSmOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rnBkLjGfHnfN/idPuQT28/Z6PEXW/Vn45xv33TdRlb69M/IH
	r3zNxwkZh1dYdjLbjwiKuix15E8pcLIWoYuZ3Z6IjtU29I1AZs1btu0byHqCIxPBwsN73zPuZzO
	4Q4yK33eN114bTgiTcgoNmmy14ThAlq4=
X-Received: by 2002:a05:6808:250a:b0:45e:dbc7:2cce with SMTP id
 5614622812f47-45efc4a9c66mr1563505b6e.7.1769536238219; Tue, 27 Jan 2026
 09:50:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0ixBFGHwvSEp3Ae_s0tyhK338Gju=1+vb+O3_pH2mHyGA@mail.gmail.com>
 <20260127172557.GA364754@bhelgaas>
In-Reply-To: <20260127172557.GA364754@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 18:50:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iZukqD0atbdfBnmZAxUzNB6sTcJ1YUeAo5a8NRn-emEg@mail.gmail.com>
X-Gm-Features: AZwV_QgiG--Rm2Nj4QEnZklC8c4MsqiqsLSdiwY26DiPpRQjB7sBwYL6cIEaQKo
Message-ID: <CAJZ5v0iZukqD0atbdfBnmZAxUzNB6sTcJ1YUeAo5a8NRn-emEg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: pci_root: Clear the acpi dependencies after PCI
 root bridge initialization on RISC-V
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, huyuye <huyuye812@163.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Robert Moore <robert.moore@intel.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, dai.hualiang@zte.com.cn, 
	deng.weixian@zte.com.cn, guo.chang2@zte.com.cn, liu.qingtao2@zte.com.cn, 
	wu.jiabao@zte.com.cn, lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn, 
	zhang.longxiang@zte.com.cn, zuo.jiang@zte.com.cn, li.kunpeng@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 6:26=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Jan 27, 2026 at 04:00:49PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM huyuye <huyuye812@163.com> wrot=
e:
> > >
> > > Hi Rafael,
> > > Thank you for your thorough review and valuable comments on v1.
> > > I've updated the patch as follows:
> > > 1. Removed the redundant #ifdef CONFIG_ACPI and if (!acpi_disabled)
> > > guard as you pointed out. The entire code block indeed already depend=
s
> > > on CONFIG_ACPI at a higher level, making the inner guard unnecessary.
> > > 2. Moved acpi_dev_clear_dependencies to RISC-V specific architecture
> > > code (driver/acpi/riscv/acpi_pci.c). This ensures that ACPI dependenc=
y
> > > clearing is handled within the appropriate architectural context.
> > >
> > > Best regards
> > > Signed-off-by: huyuye <huyuye812@163.com>
> > > ---
> > >  drivers/acpi/pci_root.c       |  6 ++++++
> > >  drivers/acpi/riscv/Makefile   |  2 +-
> > >  drivers/acpi/riscv/acpi_pci.c | 11 +++++++++++
> > >  include/acpi/acpi_bus.h       |  1 +
> > >  4 files changed, 19 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/acpi/riscv/acpi_pci.c
> > >
> > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > index 9d7f85dadc48..a16eb9097cdc 100644
> > > --- a/drivers/acpi/pci_root.c
> > > +++ b/drivers/acpi/pci_root.c
> > > @@ -30,6 +30,11 @@ static int acpi_pci_root_add(struct acpi_device *d=
evice,
> > >                              const struct acpi_device_id *not_used);
> > >  static void acpi_pci_root_remove(struct acpi_device *device);
> > >
> > > +
> > > +void __weak arch_acpi_pci_root_add_clear_dep(struct acpi_device *dev=
ice)
> > > +{
> > > +}
> > > +
> > >  static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
> > >  {
> > >         acpiphp_check_host_bridge(adev);
> > > @@ -760,6 +765,7 @@ static int acpi_pci_root_add(struct acpi_device *=
device,
> > >         pci_lock_rescan_remove();
> > >         pci_bus_add_devices(root->bus);
> > >         pci_unlock_rescan_remove();
> > > +       arch_acpi_pci_root_add_clear_dep(device);
> >
> > Actually, this could be as simple as
> >
> >        if (IS_ENABLED(CONFIG_RISCV))
> >               acpi_dev_clear_dependencies(device);
> >
> > with a brief comment explaining why it is needed.
> >
> > Bjorn, any thoughts?
>
> The justification ("If a host bridge B depends on host bridge A (via
> _DEP), this call allows bridge B to proceed with enumeration after
> bridge A is fully initialized") doesn't sound specific to RISC-V.

But there are no _DEP dependencies between host bridgers on other
architectures in practice.

acpi_dev_clear_dependencies() could be called unconditionally here,
but it would be useless overhead if no such dependencies existed.

> For that matter, it doesn't sound specific to host bridges either.

No, it is not specific to host bridges.

> The _DEP spec language is a bit vague.  ACPI r6.6, sec 6.5.8, says:
>
>   _DEP evaluates to a package and designates device objects that OSPM
>   should assign a higher priority in start ordering due to
>   dependencies between devices (for example, related to future
>   operation region accesses).
>
> I don't know what "device start" means.  It sounds like this alludes
> to the order in which OSPM runs some device start method?  _INI?
> Should acpi_dev_clear_dependencies() be done at the point where that
> device start method is run?

Not really.

acpi_dev_clear_dependencies() is related to the way Linux uses _DEP
which is to defer the enumeration of dependent devices until the
devices they depend on are ready.

So by calling acpi_dev_clear_dependencies() the driver basically
allows other drivers to bind to devices.
