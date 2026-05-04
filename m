Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683E201004;
	Mon,  4 May 2026 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911738; cv=none; b=VMSkF3JtR9rB2Z8+2Rcyt5x/qrtKV5YKgAxz0nCs4+JGfrQkkgRxKDndeULQJUs5iLnEEXyDDKirxHLzxoi8CtzgiHEVtIAZjm4n59bvgzr3aik2Hqi8IjQqrYRdSnSJ1nLYc+wjS/iccGf7zl9zq9tmSiVl+vPf4tWGLjJXTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911738; c=relaxed/simple;
	bh=EFoXaA7QN5/lEL3hMBDIvrwajwBU482e1LM6bLAGR6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T7QOnwnOAmx4noM3fb+NBOGZVlAapAQLfLiEcmagwJcXFMZ+WOPUlPoKke7b8mXsS2zPBnqGRMF6bFVofU8SXF/ncZhHlW3aBZO4meLlGJ9RO0gAA+1s6zLxe+36LYq7kFzQ+Dv/ixn8N3zjScJBDolMtv5B0sJDCqV0h+iRWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN+aLVGq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN+aLVGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57194C2BCB8;
	Mon,  4 May 2026 16:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777911737;
	bh=EFoXaA7QN5/lEL3hMBDIvrwajwBU482e1LM6bLAGR6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NN+aLVGqB10/VoaP3mPs6rZ+vE1MCrbRPJEj64vcRhSyfVfJHbTI2riAUNJdqkF7Y
	 tRJxnREeO28XyVFDr3Kxcr2BqGjEfb0EyRCEslWsEdAcQGLLKDeNMRN3PAGJ4U+B6v
	 NHgaxIMa59DvrK2Qccnk9KQyL9r9bOJcVPoCAldzWAcW6vFOBCg89j/TWw+jVC2yjV
	 UREFpiAXxRiUys5jTlIb9qxHgyNZju5DcD042BB5VWiw9yclv7wSDjk8+XugRnMZZc
	 KaD5FVr4eu0kkSvgf9bWwnhB9L2980ddBQkWwM94m7DKGOEMFxga7v46wogsQV5Dkh
	 3M+rremsnfPzg==
Date: Mon, 4 May 2026 11:22:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	vigneshr@ti.com, robh@kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: cadence: Ensure that
 cdns_pcie_host_wait_for_link() waits 100 ms after link up
Message-ID: <20260504162216.GA646395@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce5574b7-1c0d-4b46-b92e-e8f7ddbd8ef0@163.com>

On Mon, May 04, 2026 at 02:23:34PM +0800, Hans Zhang wrote:
> On 5/4/26 13:08, Siddharth Vadapalli wrote:
> > On 03/05/26 21:16, Hans Zhang wrote:
> > > On 5/2/26 13:18, Siddharth Vadapalli wrote:
> > > > On 01/05/26 21:05, Hans Zhang wrote:
> > > > > As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports
> > > > > Link speeds
> > > > > greater than 5.0 GT/s, software must wait a minimum of 100
> > > > > ms after Link
> > > > > training completes before sending a Configuration Request.
> > > > > 
> > > > > Add a new 'max_link_speed' field in struct cdns_pcie to record the
> > > > > maximum supported (or currently configured) link speed of
> > > > > the controller.
> > > > > 
> > > > > In cdns_pcie_host_wait_for_link(), after the link is reported as up,
> > > > > insert a 100 ms delay if max_link_speed > 2 (i.e., > 5 GT/s). This
> > > > > implements the required delay at the common Cadence host layer.
> > > > > 
> > > > > Currently max_link_speed is zero-initialized, so the delay is not yet
> > > > > active. Glue drivers must set max_link_speed appropriately to enable
> > > > > the delay. This matches the approach taken for the Synopsys DWC
> > > > > controller in commit 80dc18a0cba8d ("PCI: dwc: Ensure that
> > > > > dw_pcie_wait_for_link() waits 100 ms after link up").
> > > > > 
> > > > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > > > ---
> > > > >   .../pci/controller/cadence/pcie-cadence-host-common.c    |
> > > > > 9 +++++ ++++
> > > > >   drivers/pci/controller/cadence/pcie-cadence.h            | 2 ++
> > > > >   2 files changed, 11 insertions(+)
> > > > > 
> > > > > diff --git
> > > > > a/drivers/pci/controller/cadence/pcie-cadence-host- common.c
> > > > > b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > > > index 2b0211870f02..d4ae762f423f 100644
> > > > > --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > > > +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > > > @@ -14,6 +14,7 @@
> > > > >   #include "pcie-cadence.h"
> > > > >   #include "pcie-cadence-host-common.h"
> > > > > +#include "../../pci.h"
> > > > >   #define LINK_RETRAIN_TIMEOUT HZ
> > > > > @@ -55,6 +56,14 @@ int cdns_pcie_host_wait_for_link(struct
> > > > > cdns_pcie *pcie,
> > > > >       /* Check if the link is up or not */
> > > > >       for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> > > > >           if (pcie_link_up(pcie)) {
> > > > > +            /*
> > > > > +             * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
> > > > > +             * supports Link speeds greater than 5.0 GT/s, software
> > > > > +             * must wait a minimum of 100 ms after Link training
> > > > > +             * completes before sending a Configuration Request.
> > > > > +             */
> > > > > +            if (pcie->max_link_speed > 2)
> > > > > +                msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > > > 
> > > > I think the above could be moved to cdns_pcie_host_start_link()
> > > > as follows:
> > > > 
> > > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-
> > > > common.c b/
> > > > drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > > index 2b0211870f02..0f885dcbdb12 100644
> > > > --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > > +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> > > > @@ -115,6 +115,15 @@ int cdns_pcie_host_start_link(struct
> > > > cdns_pcie_rc *rc,
> > > >       if (!ret && rc->quirk_retrain_flag)
> > > >           ret = cdns_pcie_retrain(pcie, pcie_link_up);
> > > > 
> > > > +    /*
> > > > +     * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
> > > > +     * supports Link speeds greater than 5.0 GT/s, software
> > > > +     * must wait a minimum of 100 ms after Link training
> > > > +     * completes before sending a Configuration Request.
> > > > +     */
> > > > +    if (!ret && pcie->max_link_speed > 2)
> > > > +        msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > > > +
> > > >       return ret;
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(cdns_pcie_host_start_link);
> > > > 
> > > > This will avoid an additional and unnecessary delay when
> > > > 'cdns_pcie_retrain()' retrains the link.
> > > > 
> > > > Instead of checking for the link being up using
> > > > "pcie_link_up(pcie)", checking for 'ret' being zero should also
> > > > work (ret being zero indicates that the link is up).
> > > > 
> > > > Since configuration space accesses will not be performed until
> > > > cdns_pcie_host_start_link() completes executing, it should be
> > > > safe to switch to the above implementation.
> > > 
> > > Hi Siddharth,
> > > 
> > > I think this is applicable to LGA IP as per the method you
> > > mentioned. However, for HPA IP, additional repetitive code needs to
> > > be added in the following code.
> > 
> > Yes, additional code is required as you rightly pointed out, but the
> > problem I was trying to address with your patch is the following:
> >      cdns_pcie_host_start_link()
> >        calls cdns_pcie_host_wait_for_link()
> >          Link is Up and we wait for 100 ms here
> >        calls cdns_pcie_retrain()
> >            calls cdns_pcie_host_wait_for_link() a second time
> >              Link is Up again after retraining and we wait and
> >              we wait an additional 100 ms here.
> > 
> > Instead, it will be sufficient if we could wait just once after
> > cdns_pcie_retrain() returns.
> 
> Hi Siddharth,
> 
> Yes, I looked at the code and indeed it works this way.
> 
> Because of the abundance of redundant comments. I'm wondering if it's
> possible to encapsulate a helper function in the file
> drivers/pci/controller/pci-host-common.c, so that controller drivers like
> dwc and cadence can call this API. Or do you know where it would be
> appropriate to place it?
> 
> Hello, Bjorn and Mani, I wonder what your opinions are.

Make a proposal.  Sounds fine to remove redundant comments if they
cause confusion.  Adding a helper to make things more consistent
across drivers also sounds fine, but it would be better to have a
straw-man proposal to respond to.

Bjorn
