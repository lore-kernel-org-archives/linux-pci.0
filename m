Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:62886 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbaIQFK2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Sep 2014 01:10:28 -0400
Received: by mail-pd0-f182.google.com with SMTP id w10so1331934pde.27
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2014 22:10:28 -0700 (PDT)
Date: Tue, 16 Sep 2014 23:10:24 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sachin Kamat <sachin.kamat@samsung.com>
Cc: linux-pci@vger.kernel.org, pratyush.anand@st.com,
	viresh.kumar@linaro.org, spk.linux@gmail.com, olof@lixom.net
Subject: Re: [PATCH 1/1] PCI: spear: Fix build error
Message-ID: <20140917051024.GA21020@google.com>
References: <1406892514-27996-1-git-send-email-sachin.kamat@samsung.com>
 <20140813172032.GA7298@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140813172032.GA7298@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 13, 2014 at 11:20:32AM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 01, 2014 at 04:58:34PM +0530, Sachin Kamat wrote:
> > We get the following error when built as a module. Though the general fix would
> > be in this case to export the below mentioned symbols, considering that
> > dw_pcie_host_init is marked with __init and other PCI drivers do not support
> > modular build, I have disabled building this driver as a module too.
> > 
> > ERROR: "dw_pcie_host_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> > ERROR: "dw_handle_msi_irq" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> > ERROR: "dw_pcie_msi_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> > ERROR: "dw_pcie_cfg_write" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> > ERROR: "dw_pcie_cfg_read" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> > ERROR: "dw_pcie_setup_rc" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> > ERROR: "dw_pcie_link_up" [drivers/pci/host/pcie-spear13xx.ko] undefined!
> > make[1]: *** [__modpost] Error 1
> > make: *** [modules] Error 2
> > 
> > Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> 
> Applied with ack and reviewed-by from Viresh and Jingoo to pci/spear for
> v3.17, thanks!

Sorry, I misplaced this somehow.  I did it again and it's now in my
for-linus branch, so it should still make it for v3.17.  Sorry about that.

> > ---
> >  drivers/pci/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index 8922c37..90f5cca 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -56,7 +56,7 @@ config PCI_HOST_GENERIC
> >  	  controller, such as the one emulated by kvmtool.
> >  
> >  config PCIE_SPEAR13XX
> > -	tristate "STMicroelectronics SPEAr PCIe controller"
> > +	bool "STMicroelectronics SPEAr PCIe controller"
> >  	depends on ARCH_SPEAR13XX
> >  	select PCIEPORTBUS
> >  	select PCIE_DW
> > -- 
> > 1.8.1.2
> > 
