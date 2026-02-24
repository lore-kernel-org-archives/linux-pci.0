Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84294371061;
	Tue, 24 Feb 2026 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947348; cv=none; b=RD6QPTefvMDu+nO1EBAT5VaImAqM68TWjfz07dxBbUIqtlMECbhjf6ysr3iJGpYN7R22RjrmPhgc+rOaoFYbnyLdrY/WD+uKODR8/TgSam+YgNidDHyEPgic21oB9mVh7l7PPRmTNBP4Qd7uSlgzhNJaRGkMNKDBHOhtxh1+SL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947348; c=relaxed/simple;
	bh=WpwKlaebWR4y1cwdjQe0HmE8Po31GkU2s9iBWz5Mo3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXqn0kpmrclmAtdsZzSPeyhRd9jznuK98I8+BqM4DA8hceXHr3DIDcYHMnORMQzqKvxvTQmUZnOtSU5oaLd7GJHJ6isD0Kvgh0ji5VJL9jJGIkCXrGzp0IYrkrOXaH57knYSQj4Uhy93GUSg3iugsaapTv3h0DFY4frWAuvQVbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pb6SSlpU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pb6SSlpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82233C19424;
	Tue, 24 Feb 2026 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771947348;
	bh=WpwKlaebWR4y1cwdjQe0HmE8Po31GkU2s9iBWz5Mo3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pb6SSlpU/FL6ZiVfH47AMvEyY9JBb0VyStQ+G6W8MKza+URnRQ0MHEQykvKaP6rit
	 NMuoGmoQ9SyH7bfbRQXK3lg4bYynaIOdC5Od+jqR8FG5UPvN+Hi15IcEagJp/Mmn4f
	 54FgI+San7AQ0MJVJspyDaOM7+u5bvWW1X/Z9lqP9CMpp2sBzdGVItRmMx4Fgayqs2
	 P5Z6v4f8yFN7gEj3si80cEQlmcJ+0tWXQly38Qe6a4TGJA+j+GSt35y3H3IMJZhCd7
	 iJiTzEBEgU5ugXZyGeeVsX0qFymgKQz7uF8LUO5v1q76uPQHTx+uFU5d9VI0WzRqWx
	 vELZoAdVAGRYA==
Date: Tue, 24 Feb 2026 21:05:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 1/3] PCI: trace: Add PCI controller LTSSM transition
 tracepoint
Message-ID: <2sgfbgsgrbztqadhzz6wf6b7j2lmyzmhwugr3tycsjeaik5xdz@ncehsafpi2y5>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
 <1769047340-113287-2-git-send-email-shawn.lin@rock-chips.com>
 <7d195f03-978a-2d0d-acdf-e583e68377f2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d195f03-978a-2d0d-acdf-e583e68377f2@linux.intel.com>

On Tue, Feb 24, 2026 at 05:22:35PM +0200, Ilpo Järvinen wrote:
> On Thu, 22 Jan 2026, Shawn Lin wrote:
> 
> > Some platforms may provide LTSSM trace functionality, recording historical
> > LTSSM state transition information. This is very useful for debugging, such
> > as when certain devices cannot be recognized or link broken during test.
> > Implement the pci controller tracepoint for recording LTSSM and rate.
> > 
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> > 
> > Changes in v4:
> > - use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
> >   and export pci_ltssm_tp_enabled() for host drivers to use
> > 
> > Changes in v3:
> > - add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)
> > 
> > Changes in v2: None
> > 
> >  drivers/pci/trace.c                   | 20 ++++++++++++
> >  include/linux/pci.h                   |  4 +++
> >  include/trace/events/pci_controller.h | 57 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 81 insertions(+)
> >  create mode 100644 include/trace/events/pci_controller.h
> > 
> > diff --git a/drivers/pci/trace.c b/drivers/pci/trace.c
> > index cf11abc..d351a51 100644
> > --- a/drivers/pci/trace.c
> > +++ b/drivers/pci/trace.c
> > @@ -9,3 +9,23 @@
> >  
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/pci.h>
> > +#include <trace/events/pci_controller.h>
> > +
> > +static atomic_t pcie_ltssm_tp_enabled = ATOMIC_INIT(0);
> > +
> > +bool pci_ltssm_tp_enabled(void)
> > +{
> > +	return atomic_read(&pcie_ltssm_tp_enabled) > 0;
> > +}
> > +EXPORT_SYMBOL(pci_ltssm_tp_enabled);
> > +
> > +int pci_ltssm_tp_reg(void)
> > +{
> > +	atomic_inc(&pcie_ltssm_tp_enabled);
> > +	return 0;
> > +}
> > +
> > +void pci_ltssm_tp_unreg(void)
> > +{
> > +	atomic_dec(&pcie_ltssm_tp_enabled);
> > +}
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index e7cb527..ac25a3e 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2770,6 +2770,10 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_TRACING
> > +bool pci_ltssm_tp_enabled(void);
> > +#endif
> > +
> >  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns);
> >  bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
> >  int pci_for_each_dma_alias(struct pci_dev *pdev,
> > diff --git a/include/trace/events/pci_controller.h b/include/trace/events/pci_controller.h
> > new file mode 100644
> > index 0000000..db4a960
> > --- /dev/null
> > +++ b/include/trace/events/pci_controller.h
> > @@ -0,0 +1,57 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM pci_controller
> 
> I find putting this into "pci_controller" little odd as LTSSM is related 
> to PCIe links/ports. To me looks something that belongs to the existing 
> include/trace/events/pci.h.
> 

I suggested 'pci_controller.h' since these tracepoints are only going to be used
by the controller drivers. Putting it under 'pci.h' will imply that these can be
used by the client drivers also.

- Mani

> > +#if !defined(_TRACE_HW_EVENT_PCI_CONTROLLER_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_HW_EVENT_PCI_CONTROLLER_H
> > +
> > +#include <uapi/linux/pci_regs.h>
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_DEFINE_ENUM(PCIE_SPEED_2_5GT);
> > +TRACE_DEFINE_ENUM(PCIE_SPEED_5_0GT);
> > +TRACE_DEFINE_ENUM(PCIE_SPEED_8_0GT);
> > +TRACE_DEFINE_ENUM(PCIE_SPEED_16_0GT);
> > +TRACE_DEFINE_ENUM(PCIE_SPEED_32_0GT);
> > +TRACE_DEFINE_ENUM(PCIE_SPEED_64_0GT);
> > +TRACE_DEFINE_ENUM(PCI_SPEED_UNKNOWN);
> > +
> > +extern int pci_ltssm_tp_reg(void);
> > +extern void pci_ltssm_tp_unreg(void);
> > +
> > +TRACE_EVENT_FN(pcie_ltssm_state_transition,
> > +	TP_PROTO(const char *dev_name, const char *state, u32 rate),
> > +	TP_ARGS(dev_name, state, rate),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(dev_name, dev_name)
> > +		__string(state, state)
> > +		__field(u32, rate)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(dev_name);
> > +		__assign_str(state);
> > +		__entry->rate = rate;
> > +	),
> > +
> > +	TP_printk("dev: %s state: %s rate: %s",
> > +		__get_str(dev_name), __get_str(state),
> > +		__print_symbolic(__entry->rate,
> > +			{ PCIE_SPEED_2_5GT,  "2.5 GT/s" },
> > +			{ PCIE_SPEED_5_0GT,  "5.0 GT/s" },
> > +			{ PCIE_SPEED_8_0GT,  "8.0 GT/s" },
> > +			{ PCIE_SPEED_16_0GT, "16.0 GT/s" },
> > +			{ PCIE_SPEED_32_0GT, "32.0 GT/s" },
> > +			{ PCIE_SPEED_64_0GT, "64.0 GT/s" },
> > +			{ PCI_SPEED_UNKNOWN, "Unknown" }
> 
> Why are these done inline instead of using EM/EMe()? Or simply with
> pci_speed_string()?
> 
> 
> Unrelated to this, sadly I failed to notice Shuai's version of 
> pcie_link_event() did not translate link speeds (my own version used 
> pci_speed_string()).
> 
> > +		)
> > +	),
> > +
> > +	pci_ltssm_tp_reg, pci_ltssm_tp_unreg
> > +);
> > +
> > +#endif /* _TRACE_HW_EVENT_PCI_CONTROLLER_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > 
> 
> -- 
>  i.
> 

-- 
மணிவண்ணன் சதாசிவம்
