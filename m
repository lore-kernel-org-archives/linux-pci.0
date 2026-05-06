Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75848167A;
	Wed,  6 May 2026 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089726; cv=none; b=ucY22/fzgGM8ez1fbFr0blysdAuAGiuP2b1VRzlVHKnb05+TpVPlifi2hpsxRTMh6gnBEKYvXJmEHOinqv1QOUYjlvUsizjH9jvx5BcOMGvZuglX6RQTJR3WWydoEE0Yjk6V1WeeJrGmcJR1mqDfhmTZ6o/PVJZVzfjZG8S0gig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089726; c=relaxed/simple;
	bh=cfE/nyxXJocKO1O7pZ91ACi5Q1vHGPeBdIDXW/fileA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nmEjRO36BAf68P8oktBHe86O6HcwAZLVKss9i9D3ivX+SgbRkupEuGBdRk2VW+mWNl7rDgonMlLmpWEFjsVuiMR9kT/vkheIS7RidDAkV8H7JLq5J3Sf4iRombn7qeHm1fH3w1c+NQNSWK90gox3/Qbow7zLxWXP4tt+BObBEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5WmSJSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5WmSJSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D173C2BCB0;
	Wed,  6 May 2026 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778089725;
	bh=cfE/nyxXJocKO1O7pZ91ACi5Q1vHGPeBdIDXW/fileA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=L5WmSJSgBp9CROV2OHCeUtlcnNEjgXbMK0hfQbxPLkKUINNC/rzw1xlJ1PO0ffzNW
	 e7Ge5gg6idpYzv2yCbE5KUtKsQqVyVLhMSEh6swycc/WtPoVTE8o4rKaBhShVuNW/t
	 97ivXP9yFXg7Z0dFnETVEEcnI7RsRCMNxJWfiU0p43hBnNUJGLBB6uOUJNEY5M844O
	 Qq14sClcFECoNJq0ev5P3miyBRH7rNgnuJZ9tgmUvWQh3aqHEAgfo0w62bxBlA5uge
	 Y/O1SIz0K8x6pDbegDm2H+X0iTQKOC2ewr7TH1zljvhgjB0pFIPyjl213/Wv0bj/Vn
	 DJQ4mmcoNDmxQ==
Date: Wed, 6 May 2026 12:48:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 24/24] PCI/sysfs: Limit BAR resize attribute scope to
 platforms with PCI mmap
Message-ID: <20260506174844.GA792825@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505231945.GB1410272@rocinante>

On Wed, May 06, 2026 at 08:42:00AM +0900, Krzysztof Wilczyński wrote:
> > > > The only platform without these aforementioned defines is Alpha, which is
> > > > conventional PCI only and cannot have ReBAR.  So this guard removes dead
> > > > sysfs code on platforms where it can never be executed.
> > > 
> > > Having a closer look:
> > > 
> > >   resource_resize_attr_is_visible()
> > >     pci_rebar_get_current_size()      <- returns -ENOTSUPP, so is_visible callback returns 0
> > >       pci_rebar_find_pos()
> > >         pos = pdev->rebar_cap         <- set to 0 on a conventional PCI
> > >         if (!pos)
> > >           return -ENOTSUPP            <- no ReBAR support
> > > 
> > > The pdev->rebar_cap is set during PCI enumeration:
> > > 
> > >   pci_init_capabilities()
> > >     pci_rebar_init()
> > >       pdev->rebar_cap = pci_find_ext_capability()
> > >         pci_find_next_ext_capability()
> > >           if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
> > >             return 0;                 <- dev->cfg_size set to 256 here for conventional PCI
> > > 
> > > The PCI_CFG_SPACE_SIZE is 256 here.
> > > 
> > > When the platform has support for PCI Express, the dev->cfg_size is then
> > > set to 4096.  On an architecture that supports conventional PCI only (such
> > > as Alpha), the pdev->rebar_cap will be set to 0, the is_visible callback
> > > will then return 0, and the resize sysfs attribute is never created, as
> > > such, the __resource_resize_store() callback will never be executed.
> > > 
> > > To make the connetion here to the #ifdef guards:
> > > 
> > > For the pci_rebar_get_current_size() to return >= 0, the device needs
> > > PCI Express and extended configuration space support.  As of today,
> > > every architecture with PCI Express support defines HAVE_PCI_MMAP or
> > > ARCH_GENERIC_PCI_MMAP_RESOURCE.
> > > 
> > > I hope the reasoning here works.
> > 
> > We're talking about this #ifdef:
> > 
> >   +#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
> >    static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
> >    ...
> >   +#endif
> > 
> > I follow the reasoning now but by next week I won't, so I think it
> > requires too much background knowledge.  Future changes involving
> > HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE could easily break
> > this.
> > 
> > IIUC it's basically doing what "#ifdef CONFIG_PCI_REBAR" or even
> > "#ifdef CONFIG_PCI_EXPRESS" would do, if we had such a thing.
> 
> We don't sadly have such guards at the moment, so using the guards like
> HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE would be the next best
> thing.  We already rely on these throughout the pci-sysfs.c already, and
> will also rely on either for the static sysfs attributes, so if there was
> some issues with either of these, if these "broke" somehow, then we would
> have other more severe problems.  Note, that architectures rely on these
> macros to let us know about what "feature" is expected to be enabled, so to
> speak, so I would imagine nobody would break this accidentally (famous last
> words) and perhaps with extreme caution would do it on purpose.
>
> > How terrible would it be if we just accepted this dead code on Alpha?
> 
> I would prefer not to build any dead code anywhere if it can be helped,
> especially with as little as two lines of code added.  Plus, most of the
> code setting up resources that are not specific to Alpha, would have been
> disabled using exactly the same guard as the one proposed to be added
> here, not like this sets any precedent or adds something new.

OK, let's leave it as-is.  It's confusing to read, but no more so than
other existing uses.
