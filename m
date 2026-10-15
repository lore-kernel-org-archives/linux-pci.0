Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31106497B96;
	Thu, 15 Oct 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063444; cv=none; b=WqmIL5GlFKO3mWLO7cOzpeeUSAdKZg3xFtLd1gsLD1X9jNL8rlYQTwh84YckTZ4vZEt7jqLaZFcavf9/h+VTyL/FgeKDeJYrR19lCk6ww/jUrroinWCVZEG6rDbk2CFVJuzfE8ZR9gkFDJdFA75gPjwhHH353ikFoMVvTWlmPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063444; c=relaxed/simple;
	bh=Q5xnp80LCCtqxb/BTmN3ReGpUb/jm61fbLzJpDYsW3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpQgoLaFadxFU0hThg0fi3r7A5Ec8pB8DQ1wT9nIFvEqVWpGOtSX7JWKOPZAEJ9t+94LLwWoMoEYJEwDBYOFnD8epZ+wGaaEni/xHvmYkZu+GRcISVf+izLpw46mKc1H/IHqoTpUuP4iPEHMQK4q54P9zDfwofm3CHO7tHNKEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqQFPzHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqQFPzHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B611F000C4;
	Thu, 15 Oct 2026 11:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792063442;
	bh=Zp/HM7BvSno9TLvrR+B/rk6kaDtHOtD7VLPYjEMCWvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KqQFPzHhkODI26XTi3g+5v8aF+6kCABIBtIZUN5sX5icGFTkErFC29nS+PZlkutXy
	 AksAvIUDyS2VVZl9LMvlvTIEI+6tWnWb0n77sdPkBI6dCkG0a34DP5IYhRdtgE0Uqe
	 HYjpiB0fJfrllNMy9uyqbbsQiaFOuxDsNIHg657LAbK5/LOV8ViSMdEFYXyw9IOdtm
	 O3ixAnYTNja2j1hr0slXkQ/kGh3gt9YF3Gcx7H20RLda9ZJT/KSjQ0LtvvVTUqYQlu
	 xq4x2bz+2sopM+ohSD+gRhs0IYpMfhREYCZ4hVV10+t//V6vho2TkTsXxhgJ5c6jtE
	 TekpiElXk+0yw==
Date: Thu, 15 Oct 2026 16:53:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-ID: <atC3sHlgcVo63d-4@debian>
References: <20261014071448.2473208-1-den@valinux.co.jp>
 <atBuBPXKlQJLnBXL@debian>
 <xva2fpj23ijtdzfm2kgmtsnhyzpmizprboisrxstx42vthleww@n6v5bjos2pkk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xva2fpj23ijtdzfm2kgmtsnhyzpmizprboisrxstx42vthleww@n6v5bjos2pkk>

On Thu, Oct 15, 2026 at 04:10:12PM +0900, Koichiro Den wrote:
> On Thu, Oct 15, 2026 at 11:44:46AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Oct 14, 2026 at 04:14:48PM +0900, Koichiro Den wrote:
> > > The control-region link status is currently updated only by
> > > COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> > > NTB link callbacks are empty. Consequently, the HOST can see the link as
> > > up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> > > leaves LINK_STATUS_UP set without notifying either NTB client.
> > > 
> > > ntb_netdev can hide this device-level state bug because ntb_transport uses
> > > a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
> > > device link state directly:
> > > 
> > > After bringing both sides up, start one waiter on each side:
> > > 
> > >   HOST# echo N > /sys/kernel/debug/ntb_tool/<H-device>/peer0/link_event
> > >   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/peer0/link_event
> > > 
> > > While both waiters are blocked, disable the link on the VHOST:
> > > 
> > >   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/link
> > > 
> > > Without this patch, the link-disable command succeeds, but peer0/link
> > > remains Y on both sides and neither waiter returns.
> > > 
> > > Track HOST and VHOST enablement separately and report the effective link
> > > as up only when both sides have enabled it, as pci-epf-ntb does for its
> > > two physical hosts. Both NTB clients observe this effective state, so
> > > notify both sides only when it changes, including the side whose request
> > > completes the transition. Serialize the two paths because HOST commands
> > > run from delayed work while the VHOST callbacks may run concurrently.
> > > 
> > > With this patch, peer0/link changes to N on both sides and both waiters
> > > return.
> > > 
> > > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > > Changes in v3:
> > >   - Rebase onto the latest pci/endpoint.
> > >   - Drop redundant dma_wmb(). (Frank)
> > >   - Retest using ntb_tool.
> > >   - Link to v2: https://lore.kernel.org/r/20260904162049.3432464-1-den@valinux.co.jp/
> > > 
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 90 +++++++++++++++----
> > >  1 file changed, 73 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 07ba338732d4..a11f9260ee86 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -41,6 +41,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/io.h>
> > >  #include <linux/module.h>
> > > +#include <linux/mutex.h>
> > >  #include <linux/slab.h>
> > >  
> > >  #include <linux/pci-ep-msi.h>
> > > @@ -147,7 +148,10 @@ struct epf_ntb {
> > >  	u16 vntb_pid;
> > >  	u16 vntb_vid;
> > >  
> > > -	bool linkup;
> > > +	/* Serialize HOST and VHOST link state changes. */
> > > +	struct mutex link_lock;
> > > +	bool host_linkup;
> > > +	bool vhost_linkup;
> > >  
> > >  	/*
> > >  	 * True when doorbells are interrupt-driven (MSI or embedded), false
> > > @@ -183,24 +187,54 @@ static struct pci_epf_header epf_ntb_header = {
> > >  	.interrupt_pin	= PCI_INTERRUPT_INTA,
> > >  };
> > >  
> > > +static void epf_ntb_update_link(struct epf_ntb *ntb)
> > > +{
> > > +	u16 link_status = READ_ONCE(ntb->reg->link_status);
> > > +
> > > +	/* The link is usable only after both sides have enabled it. */
> > 
> > I see a bit of ambiguity here and it is confusing. This comment says that both
> > host and vhost has to enable the link first. Yet, the variables are named as
> > '{host/vhost}_linkup'. Also, the functions setting these variables are named
> > as:
> > 
> > 	epf_ntb_link_up()
> > 	vntb_epf_set_link() 
> > 
> > Even though these two are doing the same thing but on different side, these two
> > functions are not symmetric. This needs to be fixed up.
> 
> That's indeed a fair point. How about the following renames?
> 
>        v3 (this rev)               v4 (next rev)
>   --   --------------------        ---------------------------
>   #1   epf_ntb::host_linkup   =>   epf_ntb::host_link_enabled
>   #2   epf_ntb::vhost_linkup  =>   epf_ntb::vhost_link_enabled
>   #3   epf_ntb_link_up()      =>   epf_ntb_set_link_enabled()
>   #4   vntb_epf_set_link()    =>   vntb_epf_set_link_enabled()
> 
> We might as well rename the 'link_up' argument to 'enabled' in both functions.
> 
> note:
> 
>   #3 : This is an existing function, but with this patch it records HOST
>        enablement, which does not necessarily mean the link is up. So I think
>        renaming it in this patch makes sense.
> 
>   #4 : For symmetry, I realized that the VHOST helper could use the same return
>        pattern:
> 
>        if (notify)
>            return epf_ntb_notify_link(ndev);
>        return 0;
> 
> If no objections, I'll respin accordingly.

LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
