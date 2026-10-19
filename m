Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448364;
	b=pLFcbDadZVX7BJMonpAMQLi3GCzDOvUo09Tz2sXcRUrNbM2ghhs7XVOiLaVNRv8Mjbdu
	 kCT7bdGmrIcdW08Y5es0VuNvgzjDsVu0ydstTwgsaN7bFOKPpgsOBLXNUn0yismRvUBK2
	 FSXoz+M1behB9iZ8683pOinCDviHxEO6+/ShiOHhm3Y29QuJn3fyDZEXWiL6SYo9GoXmQ
	 J/hmgHsQ/b//AwNQaidSVWALuU4pw9A/h8lMMEVDxZQYEChURDN9DoX5/WLozOSQp5/kt
	 K8CsmaISHKDPGCsTilOzDmzYgagV7Rh2lmkBp+DI8T59VQC4YNXCeC/B4o0oEG/Khng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448364;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wWC3BH4/cWXsuzoVyhQyHpYGPRVcQltrEpBHrAWJKKs=;
	b=x+Tw0rqXpGZtP2cltOM8TCozngiZqKFgMV2ynvJQ8tBeELfqQ8AbdQeCqonpC5KbChc8
	 S7tMqnLlSU/9ZVBswIgIRRrZ+4GP5Ho/mUzFFX0JYCz1XGfrl3XEHoGagpXH2ZlbHSixX
	 2TCHBluPTvPEIZERu8pv+A3IYRlEJtumeh1LyqDbS0lMHzz6evQDH9/hMcXsoYL5xvXPv
	 A0fg1SJuUVHUo7m5k7l5WK4cOit3c0Mo08A9sbnostcJrZj6af+uJZMT77qSO5x9lJylo
	 h6m4q+zbtPypkOvXwCLAs5ZuJT7x/SgxUui9QRKPvvlaapkA3kCE3BczUCwXANyxLAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTvO1QY1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7803606A319;
	Mon, 19 Oct 2026 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTvO1QY1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1731F000C5;
	Mon, 19 Oct 2026 22:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448363;
	bh=wWC3BH4/cWXsuzoVyhQyHpYGPRVcQltrEpBHrAWJKKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=iTvO1QY1bsW2g2qybhLxqMhYde4lg3yiDwQEGJcKC/orAHO5J5SDY7xhAy230dGfG
	 SpxKfvrQs8NYF6j7S6f/l1RJqFXv9xz/hW3E1nxY4lrNUxijKXKQHOEs5ORWl+KoB3
	 P1WY0M+WK1LUo3nloxvxs+ye1W0V1xw5bmuaLAQJaZMcqfqxUpB92qED8ccCDUuEuQ
	 t3PcSJ3OF/BkuytNzo+aJSfZGISpl8ZHhVPAP1kXIMkEP2kqfuqWGZGLR4co/GAQo+
	 /tyY1u841ODG5ON9OJQXEkT1+dtW1g0TIvsdBGRgMZf6HfmO0tgE+4302qR38UcQpV
	 E+OccXZja9EYg==
Date: Mon, 19 Oct 2026 17:19:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
	simona@ffwll.ch, bhelgaas@google.com,
	Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Gate VFCT bus fallback on pci=realloc
Message-ID: <20261019221922.GA2275522@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4284d6d4-244d-4d49-bbdb-f1bda89fc1e8@amd.com>

On Thu, Oct 15, 2026 at 03:25:17PM -0500, Mario Limonciello wrote:
> On 10/15/26 14:48, Bjorn Helgaas wrote:
> > [+cc Alex, Ilpo, Lukas, linux-acpi]
> > 
> > On Thu, Oct 15, 2026 at 07:48:42AM -0500, Mario Limonciello wrote:
> > > The soft filter system introduced by commit 11c141672045f ("drm/amdgpu:
> > > Fix VFCT bus number matching with soft filter") has a deficiency that
> > > it won't work when there are multiple GPUs of the exact same model.
> > > 
> > > As it was introduced specifically to help the case of pci=realloc, gate
> > > it to only run when that's in use.
> > > 
> > > Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
> > > Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> > > Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 15 ++++++++-------
> > >   drivers/pci/setup-bus.c                  |  5 +++++
> > >   include/linux/pci.h                      |  1 +
> > >   3 files changed, 14 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > > index 08ed1eb695586..75af9a59671ae 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > > @@ -384,12 +384,10 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
> > >    * @vhdr: VFCT image header to check
> > >    *
> > >    * VFCT entries contain the PCI bus number as recorded during BIOS POST.
> > > - * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
> > > - * resource conflicts), the runtime bus number may differ from the POST
> > > - * value.  Match by device identity (vendor + device + function) and use
> > > - * the bus number as a preference: exact bus match is preferred, but when
> > > - * the bus numbers disagree we accept the entry if the device identity
> > > - * matches.
> > > + * On systems where the user requested PCI resource reallocation, the
> > > + * runtime bus number may differ from the POST value. Match by device
> > > + * identity (vendor + device + function), but only treat the bus number as
> > > + * a preference when pci=realloc was explicitly requested.
> > 
> > This is a generic problem, isn't it?
> > 
> > I think any table from firmware that has PCI bus numbers in it could
> > trip over issues like this.  Seems like we need a more generic
> > solution.
> 
> Yeah; it's a generic issue which was triggered by pci=realloc which is why I
> did a soft filter in 11c141672045f.
> 
> But this causes problems when you have two (or more) of the exact same
> device.  You might match the wrong thing.
> 
> > >    *
> > >    * Returns: 0 on match, -ENODEV on no match
> > >    */
> > > @@ -409,7 +407,10 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
> > >   	if (vhdr->PCIBus == adev->pdev->bus->number)
> > >   		return 0;
> > > -	/* Bus mismatch but device identity matches (PCI renumbering case) */
> > > +	/* Allow bus renumbering only when the user requested pci=realloc. */
> > > +	if (!pci_realloc_enabled_by_user())
> > > +		return -ENODEV;
> > > +
> > >   	dev_notice(adev->dev,
> > >   		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
> > >   		   vhdr->PCIBus, adev->pdev->bus->number,
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index ed16ef7c26fa7..d9450585082c0 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -1799,6 +1799,11 @@ static bool pci_realloc_enabled(enum enable_type enable)
> > >   	return enable >= user_enabled;
> > >   }
> > > +bool pci_realloc_enabled_by_user(void)
> > > +{
> > > +	return pci_realloc_enable == user_enabled;
> > > +}
> > 
> > I don't like this.  I think the same bus renumbering can happen in the
> > "auto_enabled" case, and I don't think we set pci_realloc_enable in
> > that case.
> > 
> > But more generally, I think ultimately the PCI core should be able to
> > reassign bus numbers arbitrarily to accommodate hotplugs (given the
> > appropriate driver support to tolerate that, of course).
> 
> Could we keep track of the original perhaps?  Then drivers can know
> what it was reassigned from?

I think the only thing that can change is the bus number, and saving
the original bus number in a struct pci_bus or similar might be
practical?
