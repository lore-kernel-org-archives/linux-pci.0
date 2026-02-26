Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4691A9F8C;
	Thu, 26 Feb 2026 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772085139; cv=none; b=oelfnhrciQZ6bHXn3/AMbt3fakplcF0bxze4diRLSpJ55Z1DiLFoHu4TPqYFwQXizUXcyP3/M6g8NLORFTTQEC5xRABKpldXuPzEfpbNRoVlZEb3pYWNdJRPlzzeNqCn+R1ahy3bIUe+a9lypbXf0SyB/ar3ER4DyL75HRI9lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772085139; c=relaxed/simple;
	bh=KJv+KhOnQPzjrl203LIV1OUF3j0V8ZAYp8XdN+w9afY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pen+u+CjFsiCC28l7SNj+ddNu1Aw644+oHVRzPG2KNYKmGQFqXZZQnMNbFDPeRBVZWUZ6SKYhKN3vkrdOxY9xJtUeKaWfO3jB3jXTr3CSJSBhrNZ8GispFn2s6x/5fDEOUGbdbfvvccrBssviCBlZ0PNtUlC1R5TaDGdQ+kKsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mThmtI+g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mThmtI+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB41C19422;
	Thu, 26 Feb 2026 05:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772085139;
	bh=KJv+KhOnQPzjrl203LIV1OUF3j0V8ZAYp8XdN+w9afY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mThmtI+gwjJhcciDiC8TN1Z8Gg0cCauuK0uyyi4+j8M5XXq+SaUJ4hDGHT95yM5Uz
	 2Ohi0Sx5XNUENimeuJIbN2rUY4pSQut6vQXvMOdmGjneqNZTXgI32Aab8Vso4uVE3G
	 vBJEgcZi0JQKhiMlr55aRQx26lSJSVZHU7h92LErLE3wQtO0xQVlhA98oxhljGkHNz
	 j5dLIM0CRfeT3/Zi+my6JaFt8xwUINDqTTGsDvK4vRzAIZ+eLFzcOIMrtk0+ewuPVY
	 PdwYJJruPOLtM13Pzei2NjAXiQed6yxOOUO7jRPIcTzudttokqonY2QA61/XjPjkKq
	 COxxWpfq7EXrg==
Date: Thu, 26 Feb 2026 11:22:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 1/3] PCI: trace: Add PCI controller LTSSM transition
 tracepoint
Message-ID: <3jdg3jgekf4xrdzr2yg7ufa6anllvlebnkgbwfcchicz7ww6tk@zrm5hn5x4dxz>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
 <1769047340-113287-2-git-send-email-shawn.lin@rock-chips.com>
 <7d195f03-978a-2d0d-acdf-e583e68377f2@linux.intel.com>
 <2sgfbgsgrbztqadhzz6wf6b7j2lmyzmhwugr3tycsjeaik5xdz@ncehsafpi2y5>
 <75b206bb-7fcd-2f59-4181-1839ba5aa8e4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75b206bb-7fcd-2f59-4181-1839ba5aa8e4@linux.intel.com>

On Tue, Feb 24, 2026 at 05:46:29PM +0200, Ilpo Järvinen wrote:
> On Tue, 24 Feb 2026, Manivannan Sadhasivam wrote:
> 
> > On Tue, Feb 24, 2026 at 05:22:35PM +0200, Ilpo Järvinen wrote:
> > > On Thu, 22 Jan 2026, Shawn Lin wrote:
> > > 
> > > > Some platforms may provide LTSSM trace functionality, recording historical
> > > > LTSSM state transition information. This is very useful for debugging, such
> > > > as when certain devices cannot be recognized or link broken during test.
> > > > Implement the pci controller tracepoint for recording LTSSM and rate.
> > > > 
> > > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > > ---
> > > > 
> > > > Changes in v4:
> > > > - use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
> > > >   and export pci_ltssm_tp_enabled() for host drivers to use
> > > > 
> > > > Changes in v3:
> > > > - add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)
> > > > 
> > > > Changes in v2: None
> > > > 
> > > >  drivers/pci/trace.c                   | 20 ++++++++++++
> > > >  include/linux/pci.h                   |  4 +++
> > > >  include/trace/events/pci_controller.h | 57 +++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 81 insertions(+)
> > > >  create mode 100644 include/trace/events/pci_controller.h
> > > > 
> > > > diff --git a/drivers/pci/trace.c b/drivers/pci/trace.c
> > > > index cf11abc..d351a51 100644
> > > > --- a/drivers/pci/trace.c
> > > > +++ b/drivers/pci/trace.c
> > > > @@ -9,3 +9,23 @@
> > > >  
> > > >  #define CREATE_TRACE_POINTS
> > > >  #include <trace/events/pci.h>
> > > > +#include <trace/events/pci_controller.h>
> > > > +
> > > > +static atomic_t pcie_ltssm_tp_enabled = ATOMIC_INIT(0);
> > > > +
> > > > +bool pci_ltssm_tp_enabled(void)
> > > > +{
> > > > +	return atomic_read(&pcie_ltssm_tp_enabled) > 0;
> > > > +}
> > > > +EXPORT_SYMBOL(pci_ltssm_tp_enabled);
> > > > +
> > > > +int pci_ltssm_tp_reg(void)
> > > > +{
> > > > +	atomic_inc(&pcie_ltssm_tp_enabled);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +void pci_ltssm_tp_unreg(void)
> > > > +{
> > > > +	atomic_dec(&pcie_ltssm_tp_enabled);
> > > > +}
> > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > index e7cb527..ac25a3e 100644
> > > > --- a/include/linux/pci.h
> > > > +++ b/include/linux/pci.h
> > > > @@ -2770,6 +2770,10 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
> > > >  }
> > > >  #endif
> > > >  
> > > > +#ifdef CONFIG_TRACING
> > > > +bool pci_ltssm_tp_enabled(void);
> > > > +#endif
> > > > +
> > > >  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns);
> > > >  bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
> > > >  int pci_for_each_dma_alias(struct pci_dev *pdev,
> > > > diff --git a/include/trace/events/pci_controller.h b/include/trace/events/pci_controller.h
> > > > new file mode 100644
> > > > index 0000000..db4a960
> > > > --- /dev/null
> > > > +++ b/include/trace/events/pci_controller.h
> > > > @@ -0,0 +1,57 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#undef TRACE_SYSTEM
> > > > +#define TRACE_SYSTEM pci_controller
> > > 
> > > I find putting this into "pci_controller" little odd as LTSSM is related 
> > > to PCIe links/ports. To me looks something that belongs to the existing 
> > > include/trace/events/pci.h.
> > 
> > I suggested 'pci_controller.h' since these tracepoints are only going to be used
> > by the controller drivers. Putting it under 'pci.h' will imply that these can be
> > used by the client drivers also.
> 
> PCIe r7 spec has Flit Performance Measurement Extended Capability that 
> seems to have something for LTSSM tracking and those seem more generic 
> than just for controllers (I've not spent much time on trying to fully 
> understand those capabilities, just recalled seeing them earlier).
> 

Even so, we don't know how that is going to look until someone implements it. So
I'd prefer we put this in pci_controller.h in the meantime to avoid confusion.
We can always come back later when the Flit based LTSSM tracing patch appears in
the list.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
