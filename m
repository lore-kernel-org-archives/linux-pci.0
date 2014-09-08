Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49038 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750845AbaIHEkk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Sep 2014 00:40:40 -0400
Date: Mon, 8 Sep 2014 10:10:14 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCIe: Designware: Extract struct pcie_port_info elements
 into struct pcie_port
Message-ID: <20140908044014.GC2464@pratyush-vbox>
References: <67297b465f1b531aec9f290246698b23aa994381.1407906240.git.pratyush.anand@st.com>
 <20140906000329.GN8080@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140906000329.GN8080@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 06, 2014 at 08:03:29AM +0800, Bjorn Helgaas wrote:
> On Sat, Aug 16, 2014 at 12:52:39PM +0530, Pratyush Anand wrote:
> > struct pcie_port_info elements are not containing any exclusive
> > information compared to other elements of struct pcie_port. So, keeping
> > a separate structure like struct pcie_port_info does not seem very
> > logical. Therefore remove this struct  and embed its elements directly
> > into struct pcie_port.
> >
> > Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> 
> Applied with Mohit's ack to pci/host-designware for v3.18, thanks!
> 
> I had to resolve some merge conflicts, so look it over and make sure I
> did it correctly.

Following diff need to be merged with the commit.
Let me know if I need to resend this patch rebased on top of
pci/host-designware ~ 1.

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 04a71093bf9a..5d720c21fdc0 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -520,7 +520,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
        }
 
        if (!pp->va_cfg1_base) {
-               pp->cfg1_base = pp->cfg.start + pp->config.cfg0_size;
+               pp->cfg1_base = pp->cfg.start + pp->cfg0_size;
                pp->va_cfg1_base = devm_ioremap(pp->dev, pp->cfg1_base,
                                                pp->cfg1_size);
                if (!pp->va_cfg1_base) {


~Pratyush
