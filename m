Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630023D2A3
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544279; cv=none; b=ln8qFs8XS8e81fXqI8eSr159apO/RVRT+4WbUw6wKOm1zJBAeMCvUpG7xvDjkTGvc2E3gk0n+YhAkFST9wpcaShccwGS4qsufX+MVuTKw729XTSvVOkl5Kk2da5O2D3EZaQfFOdHA6QPgm1uelXZ0aj1EccNXU5VwGZ/jqJne3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544279; c=relaxed/simple;
	bh=jUUtUcVXRERiAsRJ9OwA/nKDSiKokoPY+D9aCIvylXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRjs+mQZKIp6OQ+90LdZzMF8G6lFOR9svGgfdzuLYBVGBFhfgrx1NsxFtONZoAbWAWqcsROEBPAcdHBoqeUmMTqWLWU90Q+v/UKpjR0Od4fjrBvsd28azeFoxtpOuMykr0B9+tlifTLiSUPeJBf3Vw308pecb2Pc84oa6RRcqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQHneNFT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQHneNFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6139C19425
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 20:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769544278;
	bh=jUUtUcVXRERiAsRJ9OwA/nKDSiKokoPY+D9aCIvylXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RQHneNFT8DagMfI3zRgS3fFX0jtx3XgKHGpaBUcycRlcLWcwNrDF8+iaQowgamVQ1
	 xXqXfBvm/BX3XSYQSTqEWvSHp1jyjymN+//hhAvPlu96mkbAVz7XCixPnQnnknFnsO
	 5qZEFNOflGyMAPa/ZKdIpT/bdoP5XVrwtW9IpZG7QhqKgrQlITxqvqHI38RVhq5EqQ
	 0GSwSHotr9nxM21o+9HHc+XxQpXaKR0Tuosza5N6TWCVlFYiiy9OP7GB15ghqYdBOu
	 EZLCSJ6jmfm2ihAH7mFex5VqwproBcl3VAthGrE2GgVJcYQ8+LpzhNtJ9yRWMO1NHy
	 lJAxYqWod4Blw==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45ca17ef16eso1748385b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 12:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhnNqFaA8el/Gx+jYP9XkdZR8ZlvjN6E1K66PF3k2xByis24ubaDNyY6bI4ZPSildLp3loqnaJ4f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnypFFG5ITUGfr/CFJN5Mnmnktd/04r2GU3hrdMFxtrlmcBK5
	IhMLup3UamUHWZyYQX9lcq9oawuaH7ZMuZeXJKEsaz+Eo4zonAc4GELATvzWdK7JJj3pNMSJShg
	v0cDvLZWLTUX/obgj5EODXFqScp/j5OY=
X-Received: by 2002:a05:6820:1a0c:b0:662:fabc:b115 with SMTP id
 006d021491bc7-662fabcb5f8mr147622eaf.3.1769544277656; Tue, 27 Jan 2026
 12:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iZukqD0atbdfBnmZAxUzNB6sTcJ1YUeAo5a8NRn-emEg@mail.gmail.com>
 <20260127194648.GA368841@bhelgaas>
In-Reply-To: <20260127194648.GA368841@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 21:04:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gXGXOEJpYSAsFiO_L+ek1o9mKT0k2gJe1SSYz0p1=RaA@mail.gmail.com>
X-Gm-Features: AZwV_QhJYNqSfxPIkL2EQRerz5kqNDyWsVWPfnCWR5f_Ug00YI2GuruF3_YUUIw
Message-ID: <CAJZ5v0gXGXOEJpYSAsFiO_L+ek1o9mKT0k2gJe1SSYz0p1=RaA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: pci_root: Clear the acpi dependencies after PCI
 root bridge initialization on RISC-V
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, huyuye <huyuye812@163.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dai.hualiang@zte.com.cn, deng.weixian@zte.com.cn, guo.chang2@zte.com.cn, 
	liu.qingtao2@zte.com.cn, wu.jiabao@zte.com.cn, lin.yongchun@zte.com.cn, 
	hu.yuye@zte.com.cn, zhang.longxiang@zte.com.cn, zuo.jiang@zte.com.cn, 
	li.kunpeng@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 8:46=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Jan 27, 2026 at 06:50:24PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 27, 2026 at 6:26=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Tue, Jan 27, 2026 at 04:00:49PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Jan 12, 2026 at 3:17=E2=80=AFPM huyuye <huyuye812@163.com> =
wrote:
> > > > >
> > > > > Hi Rafael,
> > > > > Thank you for your thorough review and valuable comments on v1.
> > > > > I've updated the patch as follows:
> > > > > 1. Removed the redundant #ifdef CONFIG_ACPI and if (!acpi_disable=
d)
> > > > > guard as you pointed out. The entire code block indeed already de=
pends
> > > > > on CONFIG_ACPI at a higher level, making the inner guard unnecess=
ary.
> > > > > 2. Moved acpi_dev_clear_dependencies to RISC-V specific architect=
ure
> > > > > code (driver/acpi/riscv/acpi_pci.c). This ensures that ACPI depen=
dency
> > > > > clearing is handled within the appropriate architectural context.
> > > > >
> > > > > Best regards
> > > > > Signed-off-by: huyuye <huyuye812@163.com>
> > > > > ---
> > > > >  drivers/acpi/pci_root.c       |  6 ++++++
> > > > >  drivers/acpi/riscv/Makefile   |  2 +-
> > > > >  drivers/acpi/riscv/acpi_pci.c | 11 +++++++++++
> > > > >  include/acpi/acpi_bus.h       |  1 +
> > > > >  4 files changed, 19 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 drivers/acpi/riscv/acpi_pci.c
> > > > >
> > > > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > > > index 9d7f85dadc48..a16eb9097cdc 100644
> > > > > --- a/drivers/acpi/pci_root.c
> > > > > +++ b/drivers/acpi/pci_root.c
> > > > > @@ -30,6 +30,11 @@ static int acpi_pci_root_add(struct acpi_devic=
e *device,
> > > > >                              const struct acpi_device_id *not_use=
d);
> > > > >  static void acpi_pci_root_remove(struct acpi_device *device);
> > > > >
> > > > > +
> > > > > +void __weak arch_acpi_pci_root_add_clear_dep(struct acpi_device =
*device)
> > > > > +{
> > > > > +}
> > > > > +
> > > > >  static int acpi_pci_root_scan_dependent(struct acpi_device *adev=
)
> > > > >  {
> > > > >         acpiphp_check_host_bridge(adev);
> > > > > @@ -760,6 +765,7 @@ static int acpi_pci_root_add(struct acpi_devi=
ce *device,
> > > > >         pci_lock_rescan_remove();
> > > > >         pci_bus_add_devices(root->bus);
> > > > >         pci_unlock_rescan_remove();
> > > > > +       arch_acpi_pci_root_add_clear_dep(device);
> > > >
> > > > Actually, this could be as simple as
> > > >
> > > >        if (IS_ENABLED(CONFIG_RISCV))
> > > >               acpi_dev_clear_dependencies(device);
> > > >
> > > > with a brief comment explaining why it is needed.
> > > >
> > > > Bjorn, any thoughts?
> > >
> > > The justification ("If a host bridge B depends on host bridge A (via
> > > _DEP), this call allows bridge B to proceed with enumeration after
> > > bridge A is fully initialized") doesn't sound specific to RISC-V.
> >
> > But there are no _DEP dependencies between host bridgers on other
> > architectures in practice.
> >
> > acpi_dev_clear_dependencies() could be called unconditionally here,
> > but it would be useless overhead if no such dependencies existed.
> >
> > > For that matter, it doesn't sound specific to host bridges either.
> >
> > No, it is not specific to host bridges.
> >
> > > The _DEP spec language is a bit vague.  ACPI r6.6, sec 6.5.8, says:
> > >
> > >   _DEP evaluates to a package and designates device objects that OSPM
> > >   should assign a higher priority in start ordering due to
> > >   dependencies between devices (for example, related to future
> > >   operation region accesses).
> > >
> > > I don't know what "device start" means.  It sounds like this alludes
> > > to the order in which OSPM runs some device start method?  _INI?
> > > Should acpi_dev_clear_dependencies() be done at the point where that
> > > device start method is run?
> >
> > Not really.
> >
> > acpi_dev_clear_dependencies() is related to the way Linux uses _DEP
> > which is to defer the enumeration of dependent devices until the
> > devices they depend on are ready.
> >
> > So by calling acpi_dev_clear_dependencies() the driver basically
> > allows other drivers to bind to devices.
>
> I assumed the dependency expressed by _DEP would be satisfied by the
> execution of some other ACPI method.  E.g., the dependency might be
> satisfied when a _REG method makes an opregion available (although the
> spec seems to suggest that's only one of the possible dependencies).
>
> But in this case it sounds like RISC-V is using _DEP not because of
> any ACPI-related ordering requirement, but simply to enforce the OS
> enumeration order (and therefore naming).  I guess this refers to PCI
> device naming, so I suppose that dependency is on
> pci_acpi_scan_root().
>
> I thought udev was supposed to be the real solution for consistent
> naming.  Is this sort of a workaround to accomplish the same end?

IIUC, the enumeration ordering enforcement on RISC-V is related to a
functional dependency, but admittedly I'm unfamiliar with the details.

> In any case, your IS_ENABLED(CONFIG_RISCV) proposal seems fine to me.
> I think it's nice if we can avoid adding another __weak function.

OK, thanks!

I would also like to get some feedback on this from the RISC-V side.
Specifically on the reasons why the _DEP in question is used in the
firmware.
