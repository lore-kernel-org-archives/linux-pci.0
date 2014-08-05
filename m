Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27208 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbaHEBWM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Aug 2014 21:22:12 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N9T00HC87SYCZ50@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 05 Aug 2014 10:22:10 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Viresh Kumar' <viresh.kumar@linaro.org>,
	'Sachin Kamat' <sachin.kamat@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Sachin Kamat' <spk.linux@gmail.com>, olof@lixom.net,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1406892514-27996-1-git-send-email-sachin.kamat@samsung.com>
 <CAKohpo=tbN5UXz8C+c=EJbRdxUfkWpSUQHSi8YT0RduDsNTFFg@mail.gmail.com>
In-reply-to: <CAKohpo=tbN5UXz8C+c=EJbRdxUfkWpSUQHSi8YT0RduDsNTFFg@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: spear: Fix build error
Date: Tue, 05 Aug 2014 10:22:09 +0900
Message-id: <001901cfb04b$adc50600$094f1200$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, August 04, 2014 4:09 PM, Sachin Kamat wrote:
> On 1 August 2014 16:58, Sachin Kamat <sachin.kamat@samsung.com> wrote:
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

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

In order to use PCI host drivers as the module, we need to
do additional works. Actually, it was already discussed in
other threads. However, it is not sure that who will do this
work. Thanks!

Best regards,
Jingoo Han

> > ---
> >  drivers/pci/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index 8922c37..90f5cca 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -56,7 +56,7 @@ config PCI_HOST_GENERIC
> >           controller, such as the one emulated by kvmtool.
> >
> >  config PCIE_SPEAR13XX
> > -       tristate "STMicroelectronics SPEAr PCIe controller"
> > +       bool "STMicroelectronics SPEAr PCIe controller"
> >         depends on ARCH_SPEAR13XX
> >         select PCIEPORTBUS
> >         select PCIE_DW
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

