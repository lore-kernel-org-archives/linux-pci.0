Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794860131;
	b=NGD+U4GKgMywUHn7NtrtJO/n+cYz2rna1NxuMhF07XtkopxxZfbqUW9fcKVgm6eDYCpG
	 ZQ/9PXyTwCxPc0b3VUA8HMwNRO7PAtes4ilzpVy5fsZ8OgdE1XjwIXuMCPmSMZEk4/tlX
	 KVZVLXwPGafhS749ha9JLQGmGB+WotHCiEQtXhyyNg+OGM/qhQlxzc36rKRBG3B2w/XR5
	 7oPN3vOFxZGaVSqB2kZGXTecRwqHxjTAmJV7CIj2NZmHzLgZndLKltlf28vXrjna16TCT
	 UQCeb/vAzaVCn/j+UzphMSCXy+BnUtmJMeA4VimJzzhHzmUf0gYsAFEJ8bLvUoFvXOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860131;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=5DvBID7NhGtKnGppEI26jIaivJUl1a5YPN2oWeq8o7Y=;
	b=ANydu6lQB6uiMaRXMqdbWgLUmz1zxTVKyZQr0Itytze9IDqIJhpUOp6IS8v7HV7K/B8g
	 AQNEJY9ItzM6HbjG1nqWiLB4Ku+6DAAxypphFnKmJwfVvtpgGNStlL6riv4EWDo4yyHgF
	 /OuRm4kda5OwHVh8VYnEWNpJjB+mWW/DOC9ABxEH5RsPOnAmqnvsjIaQH59PG5ydKFrtN
	 svmIjgU5LIZA4LDpk49GlrLwebNqZeuHq/MRccxUd+DlNJUoulcfzesjX6ym44WCWcgE6
	 Js8HBOihNxJhT5CsEWWqjvF0owo+A9bsd5GO3V82DM2hxIMlikRFfQSyc1Sx28qPRgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XPTdIfq4;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03BB606A32A;
	Mon, 16 Nov 2026 20:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C03BB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XPTdIfq4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794860131; x=1826396131;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AFl6AZiCWsMcaE/h4nmHNGw5H7f/Pg2F05REN8KucNM=;
  b=XPTdIfq4qq7P/5aPFLi32HqsTC3c6UZgOb6urGlzZRxTDcXEWi0dajrj
   J5HoNsOGViIcMBKTGWM6JmhdhztApmzZrGrpJ5kti5bsBTlPiPuBXXyis
   yUamAdOzNipxZtRqYEgUyB/8EOVKGMiwEMePkIh4jyn/YyemXDG71ZCMX
   LSaQj7tgemhVgvvOPKgf2A3C1zWECApIo+IcwvAIvfx96nr95Q+XoNiEl
   9FO85RVk6U/q8RwV9yFVY+AJ9d+iqWHgyPDV5J7xdAYpnroGplSc6L9vV
   nWStN/qW4nNbNKAgQBk2WkbrY7ufYhJ7yPGTdT+0fI0hCbtc5d1NM/CNx
   g==;
X-CSE-ConnectionGUID: IimUbBZ4Tzy6eJhFAIie+A==
X-CSE-MsgGUID: jtjHAT7OT3uJXg7n1j3HDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3502125"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3502125"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 12:15:30 -0800
X-CSE-ConnectionGUID: 9qreVo3QSFmJnnG7OpuSOQ==
X-CSE-MsgGUID: kBFAzvJqQFGCI4YbBVWzXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9468839"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 12:15:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Nov 2026 22:15:23 +0200 (EET)
To: Magnus Lindholm <linmag7@gmail.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13] alpha/PCI: Convert to
 pci_bus_size_and_assign_resources()
In-Reply-To: <CA+=Fv5SkcpskpFUCP-qDmP1vWqDiqO8FgSJJ92UvX6jGRfaGLQ@mail.gmail.com>
Message-ID: <87011375-bec3-5c38-3a37-a43a1de93fa6@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com> <20261116152403.2672-3-ilpo.jarvinen@linux.intel.com> <CA+=Fv5SkcpskpFUCP-qDmP1vWqDiqO8FgSJJ92UvX6jGRfaGLQ@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-737568478-1794860123=:1056"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-737568478-1794860123=:1056
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 16 Nov 2026, Magnus Lindholm wrote:
> On Mon, Nov 16, 2026 at 4:24=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > To serialize bridge window sizing and resource assignment, PCI core
> > needs to hold locks across both phases. Alpha nautilus PCI code calls
> > pci_bus_size_bridges() and pci_bus_assign_resources() separately
> > because it needs to do special resource alignment and setup after the
> > window sizes have been calculated. At least the former would seem to
> > belong to some existing __weak pcibios_*() hook but the latter might
> > need yet another pcibios_*() hook just for this single use.
> >
> > The nautilus code runs during init, so nothing is likely to race with
> > it. Converting it is mainly about consolidating the sizing and
> > assignment entry points of PCI core, which eventually allows removing
> > pci_bus_assign_resources().
> >
> > Instead of trying to do a complex rework of the code, which is risky
> > without the ability to test on the hardware, simply convert
> > pci_bus_assign_resources() to pci_bus_size_and_assign_resources(). This
> > adds a small bit of extra work by performing the sizing step again, but
> > the calculations should yield the same sizes, so it seems safe
> >
>=20
> Agreed. By the second pass irongate_mem has been request_resource()d, so
> pbus_size_mem() skips it as assigned, and ioport_resource is never picked
> as a window (find_bus_resource_of_type()). Only the AGP bridge's
> unassigned windows are sized again, from the same inputs.
>=20
> That does rely on the assigned check, though: if your follow-up series
> starts sizing assigned windows,

Yes, it will start to do that then.

> nautilus' relocated root window
> (size_windows =3D 1) must stay untouched by the second pass.

If the same size is calculated (during init, I see no reason why the=20
sizing results would change), there should be no change even when it=20
starts to assign windows.

I'm bit worried though when it comes to the extra alignment done by this=20
nautilus code as that can change the size from the original but I don't=20
think there is anything that would allow shrinking the window even with
that so it looks okay to me even after the upcoming series.

But it might be easiest to just set IORESOURCE_PCI_FIXED flag after the=20
resource has been added to the tree. That should keep the usual sizing=20
and assignment from touching it at all.

> It builds at every patch for the generic and Nautilus configs. I have a
> UP1100 (Nautilus), but it doesn't start up at the moment; if I get it
> running again I'll give this a boot. But for the Alpha part of this serie=
s:

Oh, that would potentially make it possible to actually try to refactor=20
this to happen in pcibios_*() code, which I certainly dare not without=20
ability test the change.

> Acked-by: Magnus Lindholm <linmag7@gmail.com>

Thanks a lot for taking a look and all the insight, it's really=20
appreciated.

> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  arch/alpha/kernel/sys_nautilus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_n=
autilus.c
> > index 13b79960b4b9..23a74fd4a83f 100644
> > --- a/arch/alpha/kernel/sys_nautilus.c
> > +++ b/arch/alpha/kernel/sys_nautilus.c
> > @@ -263,7 +263,7 @@ nautilus_init_pci(void)
> >         if ((IRONGATE0->dev_vendor >> 16) > 0x7006)     /* Albacore? */
> >                 IRONGATE0->pci_mem =3D pci_mem;
> >
> > -       pci_bus_assign_resources(bus);
> > +       pci_bus_size_and_assign_resources(bus);
> >         pci_bus_add_devices(bus);
> >  }
> >
> > --
> > 2.47.3
> >
>=20

--=20
 i.

--8323328-737568478-1794860123=:1056--
