Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1873B05A3;
	Tue,  1 Sep 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273331; cv=none; b=DSa5nnIA1coJW0G4NRJueHZQdyo4wLBfxXwLp4ePIGra4i3xNlHufjRQEuyD5YIQKCB8TN88QA/OKAwaDlGLgjU77IzYuSwHrjhQiNjELwaEMZWqwZ5SaXc+mQyaNbezdjsOljOCeJ3pD4ZlundMdLPiXT3KToMhtv82F2ueb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273331; c=relaxed/simple;
	bh=vufRXJ01BTUJlLwmXt4PlX/hW7twEPT3z39AfLUnXMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu01QFU+eJNW3Z2dYbnlmRY/vah/x3tX7pWS+f8969TuLmL3wp0Er9PkjkbF/5u/3roVPiFfUX5gq0oChUtw+BUXehIR6G1tw8DBAFJdEpaxyYqPQQ8lUqHz1zSPB9+Hzy5tPI8s+oKs5uZss1cah+ODDIBX9SnRe+yoYHtCuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYnuXRbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYnuXRbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944D61F00A3D;
	Tue,  1 Sep 2026 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273329;
	bh=Hx37cjE67OI773W79ogB4Hh5MXNOEETSnbXyWOUlMVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oYnuXRbZ1cPaxiyS8r6G07kFiP0Bafl+nijzXo738e1IBWUljRd8TncTasjS6+fLO
	 QX0GY3d00VhQ/0QL+8AO3ulpfVKaoIQW1PK9OqEawMmn4HnPMpXJbjW1MyqED3g99G
	 wv6I8Ut7d7Pe9rl4ZbrOxbJuiAX/PMN2K2v+dKJnd2dv9qInH574t1uuWq3cZsSUwZ
	 HGwBSeKfEXCPWo2dzIzYA1Zr8CKKtJmx7AteAkRi0kqv6V1kQat8Jk8ASqU/8LsIYq
	 ieykBFfA5IzE/9gXiekpnMk8wdh/WnKJbqJEOncDwE7GsFVksye+XJ3Miovnp6uNYq
	 nKffGYN6UPR/w==
Date: Tue, 1 Sep 2026 16:35:18 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.Li@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/15] PCI: endpoint: Add pci-ep-dma helper for exported
 DMA ABI v1
Message-ID: <bgzesn4sqdlqdb3n3djkyed6g7l3ebi6ljbteqhirk2ip2ieou@t4xsvdmcjhdv>
References: <20260312165005.1148676-1-den@valinux.co.jp>
 <20260312165005.1148676-10-den@valinux.co.jp>
 <3ef3b7wdwpf364teperxcjc2leycxwke77cejjfzd5w4pnbmik@vlcbizvbxv4m>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ef3b7wdwpf364teperxcjc2leycxwke77cejjfzd5w4pnbmik@vlcbizvbxv4m>

On Sat, Aug 22, 2026 at 12:41:32AM +0900, Koichiro Den wrote:
> On Fri, Mar 13, 2026 at 01:49:59AM +0900, Koichiro Den wrote:
> > Add a generic helper that packages controller-owned DMA resources into a
> > peer-visible BAR slice described by exported DMA ABI v1.
> > 
> > pci_epf_alloc_dma() queries EPC auxiliary resources, delegates the
> > requested DMA read channels, builds an ABI header in coherent memory,
> > and assembles the BAR region list covering the header, controller
> > register window, and per-channel descriptor windows. If the controller
> > control window is not already BAR-backed, map it into the exported slice
> > so the peer still sees a self-contained layout.
> > 
> > The first ABI is designed based on the DesignWare unrolled eDMA model,
> > but it is intended to be vendor-neutral. It exports delegated READ
> > channels only, which are the channels the host uses to send data from
> > host memory into the endpoint.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/Makefile     |   2 +-
> >  drivers/pci/endpoint/pci-ep-dma.c | 342 ++++++++++++++++++++++++++++++
> >  include/linux/pci-ep-dma.h        | 130 ++++++++++++
> >  3 files changed, 473 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/pci/endpoint/pci-ep-dma.c
> >  create mode 100644 include/linux/pci-ep-dma.h
> > 
> > diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> > index b4869d52053a..94824f3ed5a1 100644
> > --- a/drivers/pci/endpoint/Makefile
> > +++ b/drivers/pci/endpoint/Makefile
> > @@ -5,5 +5,5 @@
> >  
> >  obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
> >  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
> > -					   pci-epc-mem.o functions/
> > +					   pci-epc-mem.o pci-ep-dma.o functions/
> >  obj-$(CONFIG_PCI_ENDPOINT_MSI_DOORBELL)	+= pci-ep-msi.o
> > diff --git a/drivers/pci/endpoint/pci-ep-dma.c b/drivers/pci/endpoint/pci-ep-dma.c
> > new file mode 100644
> > index 000000000000..2a996f9b1424
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/pci-ep-dma.c
> 
> ---[snip]---
> 
> > diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
> > new file mode 100644
> > index 000000000000..0ef6f9eb8593
> > --- /dev/null
> > +++ b/include/linux/pci-ep-dma.h
> 
> Hi Mani, (Cc: Frank, Niklas)
> 
> Perhaps it's time to reincarnate this series, with much of it reworked.
> 
> Following the discussion here:
> https://lore.kernel.org/r/fg7cma2ccvdgjgcref7qa4q7ocvvume5dteekedikszebkq7rd@uhrjfp3nmmwh/
> I am now thinking of dropping the generic pci-ep-dma helper and
> include/linux/pci-ep-dma.h altogether, as I understand the direction is to keep
> the DMA export within the vNTB/ntb_hw_epf path *as much as possible*.
> 
> The old wire layout was consumed by pci-epf-vntb.c, ntb_hw_epf.c, and
> dw-edma-aux.c (see patch 13). That is why I put pci-ep-dma.h under
> include/linux/. For the rework, I am thinking ntb_hw_epf should decode it and
> pass only the resulting resources to dw-edma-aux. This keeps the wire format
> between pci-epf-vntb and ntb_hw_epf. At that point, defining the same small
> layout in both files might even be preferable to adding another shared header in
> include/linux/.
> 
> Mani, does this direction look acceptable to you? I would also appreciate your
> view on the linked discussion when you have a chance.
> 

Sounds good to me. My only concern is exposing the remote DMA functionality as a
new EPF driver. As long as you keep the changes within the NTB drivers, I'm fine
with it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
