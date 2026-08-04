Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D06DDA9;
	Tue,  4 Aug 2026 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878280; cv=none; b=Mztyvj6e/oWBDBq3M7uxKsebm/nyMAhfaXiEubvSkj5A+29ARHo5+3QqyRAtNROiy3aA5+iREYERGrlum6F0ukwY2vr70CxIxEFx5HKcrIMyDtzmxDQliwbZlYTRIolBFjL1VA2IrHtqaOgKUxeX0YY1xfyL+exXixGuQXayfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878280; c=relaxed/simple;
	bh=+uxQVz9jZ0K4nTxCgsBfvyx21/GHrvr1dCNICfTR52g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QwdgJh5+RoM4tUSfuU/CgJs/hQwahOJPhWiSVw/n60vmp/2FZiJSj6BC1IASE6kIVTl31HjBNRyqDglj2duyzmuDT50oVVQBqSMpJPwHnj66ZLJwhSb6eibjoHj0gD4pPXHAkX0Z6slynS0iV/CvbhL86zBq5yv60yYV9fOHy34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYwAg0te; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYwAg0te"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0CC1F000E9;
	Tue,  4 Aug 2026 21:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785878278;
	bh=zInXWsYZop6MOqA1Jea68UbD+uK3ZrLZybcKPUeETww=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=dYwAg0teI19butiV68RAAYo4Ver3YCvkTrBL3sdf5qvYBOwbg3GPowTAdUbSOPaez
	 xN0UPCXQFVW0Nma+CN4PhwCExmof6WpYifltCgCAUHEIv2N0LGdmWwUVkqM11rP37r
	 Rig6dDxpOQ+IwI4DjSqaIcboifgtNRBmVYEjSfaf/HkNmd7MF6qSCdvOCwi3v8nzwO
	 Dc4i99vrOm6cRKXqYZcN9+PIONSOswMUuCW8KyJ0cjdD2xnu5jBujJa7Y31UTOOwUk
	 6jSBYeSFxPqsZ8INlt2DJmdayLNYs3UP179p4oYeKuKwp6GaUJXwm+Gx2gpVWpVfBM
	 uDyIakPhOlktQ==
Date: Tue, 4 Aug 2026 16:17:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, Takuma Fujiwara <t-fujiwara1@ti.com>,
	Hans Zhang <18255117159@163.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Manivannan Sadhasivam <mani@kernel.org>, Yao Zi <me@ziyao.cc>,
	Aksh Garg <a-garg7@ti.com>, Felix Gu <ustc.gu@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Manikandan K Pillai <mpillai@cadence.com>
Subject: Re: linux-next: Tree for Jul 30 (pci/controller/cadence/)
Message-ID: <20260804211756.GA1938423@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b99bef0f-7694-4aff-949e-d289d8ddb10e@infradead.org>

[+cc recent committers in drivers/pci/controller/cadence/]

On Fri, Jul 31, 2026 at 05:12:03PM -0700, Randy Dunlap wrote:
> On 7/31/26 2:41 PM, Bjorn Helgaas wrote:
> > On Thu, Jul 30, 2026 at 07:27:42PM -0500, Bjorn Helgaas wrote:
> >> [+cc authors of everything on pci/controller/cadence; I haven't
> >> triaged this at all, sorry, and don't have time right now to drop that
> >> branch from pci/next]

Thanks, Randy, I reproduced this problem on v7.1 in an x86_64 build
with the config-r1495.gz you posted at
https://lore.kernel.org/all/b99bef0f-7694-4aff-949e-d289d8ddb10e@infradead.org

Per MAINTAINERS, drivers/pci/controller/cadence/ is orphaned.  If
anybody cares about this, please take a look and fix this issue.

> >> On Thu, Jul 30, 2026 at 04:06:44PM -0700, Randy Dunlap wrote:
> >>>
> >>>
> >>> On 7/30/26 8:02 AM, Mark Brown wrote:
> >>>> Hi all,
> >>>>
> >>>> Changes since 20260729:
> >>>>
> >>>
> >>> (1) /usr/bin/ld.bfd: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
> >>> pcie-cadence-plat.c:(.text+0x2f8): undefined reference to `cdns_pcie_ep_setup'
> >>>
> >>> In this case, a builtin driver attempts to call into a loadable module:
> >>>
> >>> #
> >>> # Cadence-based PCIe controllers
> >>> #
> >>> CONFIG_PCIE_CADENCE=y
> >>> # CONFIG_PCIE_CADENCE_DEBUGFS is not set
> >>> CONFIG_PCIE_CADENCE_HOST=y
> >>> CONFIG_PCIE_CADENCE_EP=m
> >>> CONFIG_PCIE_CADENCE_PLAT=y
> >>> CONFIG_PCIE_CADENCE_PLAT_HOST=y
> >>> CONFIG_PCIE_CADENCE_PLAT_EP=m
> >>> # end of Cadence-based PCIe controllers
> > 
> > I was unable to reproduce this issue, so I didn't do anything.  I
> > didn't figure out how to make CONFIG_PCIE_CADENCE_EP=m; the config I
> > used was:
> > 
> >   CONFIG_PCIE_CADENCE=y
> >   # CONFIG_PCIE_CADENCE_DEBUGFS is not set
> >   CONFIG_PCIE_CADENCE_HOST=y
> >   CONFIG_PCIE_CADENCE_EP=y
> >   CONFIG_PCIE_CADENCE_PLAT=y
> >   CONFIG_PCIE_CADENCE_PLAT_HOST=y
> >   CONFIG_PCIE_CADENCE_PLAT_EP=m
> > 
> >>> (2) /usr/bin/ld.bfd: drivers/pci/controller/cadence/pcie-cadence-plat.o: in function `cdns_plat_pcie_probe':
> >>> pcie-cadence-plat.c:(.text+0x11f): undefined reference to `cdns_pcie_host_setup'
> >>>
> >>>
> >>> This is similar, just a different driver is =m in the failure case.
> >>>
> >>> #
> >>> # Cadence-based PCIe controllers
> >>> #
> >>> CONFIG_PCIE_CADENCE=y
> >>> CONFIG_PCIE_CADENCE_DEBUGFS=y
> >>> CONFIG_PCIE_CADENCE_HOST=m
> >>> CONFIG_PCIE_CADENCE_EP=y
> >>> CONFIG_PCIE_CADENCE_PLAT=y
> >>> CONFIG_PCIE_CADENCE_PLAT_HOST=m
> >>> CONFIG_PCIE_CADENCE_PLAT_EP=y
> 
> I have reproduced it several times in cases that were
> generated by 'make randconfig'.
> I am attaching the 2 failing randconfig files (both for x86_64
> and linux-next).
> 
> -- 
> ~Randy



