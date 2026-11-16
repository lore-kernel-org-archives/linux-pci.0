Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794867083;
	b=mvts2sOchJVCvN+DvzPZmXhwO4/K0e1UX71VPwSVB2hKILeWOuQL+6KfkrI+9+Y/en5M
	 kqp8CEyVzozyaeQ3TzqRQtATAO2NqcVgFEmzwr9cvARscHlApVCvs4rhD2ZeB/wOD1Lwz
	 cAKoZsyYYwNG8wL+pQSbMiTBzBOtNzkbCjZFraIJuRqAb1qAEeNlUnl0FeafZR8klXIs0
	 XtRco8qGBDo0iE8HNhred+W8rWaQMFeh7/t/LwnJam+e/ypwJ1MP75SM2Dl3xPQXJn+3H
	 PE/T6tjkk8lxl3lZbvY7VaPHtch4QS4WDx426j8UIdXD2P5HSq1sopzUaOGBaW17NSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794867083;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=Fo3ujoH6Oj/JIrJMyCN/iO32s/QLUquuvqXiBzy+HAg=;
	b=e0bKSL764/DiDLtGVENqvqZ6iYtfgyN7aQZFINzyHe0r6pZ9odhXJ2MiZQJLOKgkI7nl
	 NRzeBwdxgBN3U/6z3Hs9BX8TWKSvhVh0LA2g4BTyDvdSeFnnALf5qchQuZ07FRo6zVsL+
	 Uf+6OpVjwfJ3qMjkbWhaLnwMoGdvv5+S/fLP0szF1sj/LQ9Z+RIHdEmRsXPC9nVx43x4L
	 ipkBQakDstFvCzYS0qW1o3To5qfcuDW7jrsn3/lxaOSoA5Lq9q20naQVLskMa+pOgKz5q
	 iaw8m2plV6r0iePp8mkdHCwG0fpLLd76Kk/2heFasKzZqQ7fbmFAcVjkRloBei0Swfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L1BPQ1TT;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A7606A331;
	Mon, 16 Nov 2026 22:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E7A7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L1BPQ1TT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794867083; x=1826403083;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3sHjWaedFUq6Hhd20VqomB0qhf6g4lXVGRkoydlRMLk=;
  b=L1BPQ1TTtZPGZwjHTOxwJktoqYi9pPcEKeh8cTjxotKMANmy9DaC4TXX
   pk2QnZShqrj4zn6VIjz4LrL21ABB1cXK355D3ozYdCAx2ias3T5aZ9r6R
   RuDXmkh3f1+Y/7Jd1/kiulXkWT/H8XtRTDEqWprncq9JGAeS9uyHWV1cm
   MEu2aJ3CbKq90uxDeqlIX4DV7IoDY8CZr/l4VIiuaCEHSA6Kx+WMbWltS
   f4/wOO07HNl2kX+1bL+GVEhLK7jMmDpvWsaE4RflqqDhWIsXXa5meRtE1
   ZImcUYmhVmXe6xSk0tv520UmOiRdHrAXNmZq6ZhXkoJgrxyGPAoJNxOkU
   A==;
X-CSE-ConnectionGUID: QsiM1QD0TNOOUaTav+VOyA==
X-CSE-MsgGUID: xJ6QVNK1Ry2oNVL8pYC/Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3511348"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3511348"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 14:11:22 -0800
X-CSE-ConnectionGUID: wf5btbBWRESk5LR5yePfiA==
X-CSE-MsgGUID: GlzEjufLTwe7mPppwTs3fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9730092"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 14:11:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Nov 2026 00:11:14 +0200 (EET)
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
In-Reply-To: <87011375-bec3-5c38-3a37-a43a1de93fa6@linux.intel.com>
Message-ID: <f54a994b-d711-00f7-393c-1875eef773fc@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com> <20261116152403.2672-3-ilpo.jarvinen@linux.intel.com> <CA+=Fv5SkcpskpFUCP-qDmP1vWqDiqO8FgSJJ92UvX6jGRfaGLQ@mail.gmail.com> <87011375-bec3-5c38-3a37-a43a1de93fa6@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1372809281-1794867074=:1056"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1372809281-1794867074=:1056
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 16 Nov 2026, Ilpo J=C3=A4rvinen wrote:

> On Mon, 16 Nov 2026, Magnus Lindholm wrote:
> > On Mon, Nov 16, 2026 at 4:24=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > To serialize bridge window sizing and resource assignment, PCI core
> > > needs to hold locks across both phases. Alpha nautilus PCI code calls
> > > pci_bus_size_bridges() and pci_bus_assign_resources() separately
> > > because it needs to do special resource alignment and setup after the
> > > window sizes have been calculated. At least the former would seem to
> > > belong to some existing __weak pcibios_*() hook but the latter might
> > > need yet another pcibios_*() hook just for this single use.
> > >
> > > The nautilus code runs during init, so nothing is likely to race with
> > > it. Converting it is mainly about consolidating the sizing and
> > > assignment entry points of PCI core, which eventually allows removing
> > > pci_bus_assign_resources().
> > >
> > > Instead of trying to do a complex rework of the code, which is risky
> > > without the ability to test on the hardware, simply convert
> > > pci_bus_assign_resources() to pci_bus_size_and_assign_resources(). Th=
is
> > > adds a small bit of extra work by performing the sizing step again, b=
ut
> > > the calculations should yield the same sizes, so it seems safe
> > >
> >=20
> > Agreed. By the second pass irongate_mem has been request_resource()d, s=
o
> > pbus_size_mem() skips it as assigned, and ioport_resource is never pick=
ed
> > as a window (find_bus_resource_of_type()). Only the AGP bridge's
> > unassigned windows are sized again, from the same inputs.
> >=20
> > That does rely on the assigned check, though: if your follow-up series
> > starts sizing assigned windows,
>=20
> Yes, it will start to do that then.
>=20
> > nautilus' relocated root window
> > (size_windows =3D 1) must stay untouched by the second pass.
>=20
> If the same size is calculated (during init, I see no reason why the=20
> sizing results would change), there should be no change even when it=20
> starts to assign windows.
>=20
> I'm bit worried though when it comes to the extra alignment done by this=
=20
> nautilus code as that can change the size from the original but I don't=
=20
> think there is anything that would allow shrinking the window even with
> that so it looks okay to me even after the upcoming series.
>=20
> But it might be easiest to just set IORESOURCE_PCI_FIXED flag after the=
=20
> resource has been added to the tree. That should keep the usual sizing=20
> and assignment from touching it at all.

For the record, I realized this won't be necessary because nothing in the=
=20
fitting and assignment algorithm can change the resource once it has been=
=20
assigned.

All direct resource changes are (or should be) blocked for assigned=20
resources to not corrupt the resource tree and root bus resources don't=20
have bus->self so they never go into lists that need bus->self=20
(add_list/realloc_head and the upcoming bridge_win_list).

> > It builds at every patch for the generic and Nautilus configs. I have a
> > UP1100 (Nautilus), but it doesn't start up at the moment; if I get it
> > running again I'll give this a boot. But for the Alpha part of this ser=
ies:
>=20
> Oh, that would potentially make it possible to actually try to refactor=
=20
> this to happen in pcibios_*() code, which I certainly dare not without=20
> ability test the change.
>=20
> > Acked-by: Magnus Lindholm <linmag7@gmail.com>
>=20
> Thanks a lot for taking a look and all the insight, it's really=20
> appreciated.
>=20
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  arch/alpha/kernel/sys_nautilus.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys=
_nautilus.c
> > > index 13b79960b4b9..23a74fd4a83f 100644
> > > --- a/arch/alpha/kernel/sys_nautilus.c
> > > +++ b/arch/alpha/kernel/sys_nautilus.c
> > > @@ -263,7 +263,7 @@ nautilus_init_pci(void)
> > >         if ((IRONGATE0->dev_vendor >> 16) > 0x7006)     /* Albacore? =
*/
> > >                 IRONGATE0->pci_mem =3D pci_mem;
> > >
> > > -       pci_bus_assign_resources(bus);
> > > +       pci_bus_size_and_assign_resources(bus);
> > >         pci_bus_add_devices(bus);
> > >  }
> > >
> > > --
> > > 2.47.3
> > >
> >=20
>=20
>=20

--=20
 i.

--8323328-1372809281-1794867074=:1056--
