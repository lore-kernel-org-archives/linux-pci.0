Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6042CAF2
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354532; cv=none; b=cm1OhQDqlCdS7xjBiX89ZCzrwNfScnOSX00LxZxQ0GQJQtloDE8czG5zFF2+7ZiXTTYzPE8+n9GcF74pxRcQGomrDYgpTMYD6aIzUJ8dJiUVLA3CJ6Ac0cbxQgYDTbUVn9l7hfglkkR4TpLYB/aWRcHkjkNL60hmETh9RSpuIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354532; c=relaxed/simple;
	bh=tgwKXIKrYi4l0ZJT+IaTX9zuij/8kSls4dZRwPaqYAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfWmkAqholbB3AItUHQKvxkIYoUdlmycoSDLXbi/nyruPfiwOmpenIMZNOW1gO++kgMdMibSpwfJ2+T/kTK5MJu0RcPLkpmEtu7EZY0ocRjl5CEBwpJglQP+S5Nd9S6eowpKsZcz2c+6WxsJMGRraB2pyP+ZBlgMRKlZTwuAfFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4yfNpLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4yfNpLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8A81F000E9;
	Mon,  6 Jul 2026 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783354531;
	bh=TRkTuvAl7JY1VzzwZN5psgc31sIHyscaRBHK4EqX+R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n4yfNpLhKMdJhffuF64yE204P83/MkNo4xB7czBNb/HtUhLZ5DWbypQSisNCP6SiQ
	 oZDKosqtd/86f2nSovHN3u1embkp05nkDaOziw9fRuePj8uLnwahG7O1YoaO39JQWC
	 3sNkQV4Z8bC5hWEtDOiUpUWi8l4WPu5vceF3Of4fsqX0vB/bgGblljr2961Y4nLNjq
	 wmRsh6yqqjIvALoNSi2/Ro3jfe/zXMSF9fikGYS0q8B5j5g0T3SezyS/zz2jKIeKWW
	 7d2gMLMYNggRq3nsjQpvNit+FSMbBE9hfYZ3H9ePxTWkbDAhHdDaB9b4slAmb/fBwO
	 MmPU0E/AY7XFQ==
Date: Mon, 6 Jul 2026 18:15:23 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, nirmal.patel@intel.com, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, robh@kernel.org, 
	lpieralisi@kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] PCI: vmd: Only assign _OSC features in bare metal OS.
Message-ID: <wxvpwuyypm6ouixb6dy6zjf7fzyko532ke6chdinj5kiid7bp2@l6qqxeijjn3u>
References: <20260629170243.269830-1-nirmal.patel@linux.intel.com>
 <20260630171003.GA143656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630171003.GA143656@bhelgaas>

On Tue, Jun 30, 2026 at 12:10:03PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 29, 2026 at 05:02:43PM +0000, Nirmal Patel wrote:
> > From: Nirmal Patel <nirmal.patel@intel.com>
> > 
> > Copy valid _OSC flags from root bridge only when OS can provide correct
> > values. In virtual machine, all of the control features are disabled as
> > hypervisor will not passthrough root bridge information to VM.
> > 
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > Reviewed-by:  Andy Shevchenko <andriy.shevchenko@intel.com>
> > ---
> >  drivers/pci/controller/vmd.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index d4ae250d4bc6..f9e38f2f926a 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -910,8 +910,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >  		return -ENODEV;
> >  	}
> >  
> > -	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> > -				   to_pci_host_bridge(vmd->bus->bridge));
> > +	/* Don't copy _OSC control flags in VM, it disables features.*/
> > +	if (!offset[0] || !offset[1])
> 
> Drop period in subject line.
> 
> Replace period in comment with space.
> 
> Kind of a weird way to check for VM. 

It is indeed very weird. I see a few x86 driver using
'if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))' check to test whether the
driver is running inside a VM or not. Can this driver use a similar check?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
