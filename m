Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:36598 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751392Ab3LEGsi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2013 01:48:38 -0500
Date: Thu, 5 Dec 2013 12:18:22 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Jay Agarwal <jagarwal@nvidia.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	"'yinghai@kernel.org'" <yinghai@kernel.org>,
	Stephen Warren <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Subject: Re: [Discussion]: ARM: PCIE: Setup bridges not happening with
 portbus driver enabled
Message-ID: <20131205064822.GB2298@pratyush-vbox>
References: <C79B248886DD134989C8FF6B096A91AB92139701C7@BGMAIL01.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <C79B248886DD134989C8FF6B096A91AB92139701C7@BGMAIL01.nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 05, 2013 at 01:44:53PM +0800, Jay Agarwal wrote:
> Hi All,
> 
> I am seeing below issue on an ARM platform with CONFIG_PCIEPORTBUS enabled in kernel
> 
> ISSUE:  Any memory access by devices fails
> 
> FINDINGS:
> 
> 1. No bridge windows like below are setup and probably this is not allowing any memory access by devices

Does your RC driver calls pci_assign_unassigned_resources after
pci_common_init?

Regards
Pratyush

> [    1.280324] pci 0000:00:00.0:   bridge window [mem 0xXXX00000-0xXXXfffff]
> [    1.280350] pci 0000:00:00.0:   bridge window [mem 0xXXX00000-0xXXXfffff pref]
> 
> 2. On debugging, I see pci_enable_bridge(setup-bus.c) is not called because pci_is_enabled returns true. This is because pci_enable_device is already called for this bridge by portbus driver in pcie_port_device_register(portdrv_core.c).
> 3. Below patch is resolving this issue without any visible side effects. In fact, I verified AER(which needs PORTBUS) also with this.
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c index 64a7de2..9b67fff 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1200,8 +1200,7 @@ void __ref __pci_bus_assign_resources(const struct pci_bus *bus,
>  
>                 switch (dev->class >> 8) {
>                 case PCI_CLASS_BRIDGE_PCI:
> -                       if (!pci_is_enabled(dev))
> -                               pci_setup_bridge(b);
> +                       pci_setup_bridge(b);
>                         break;
>  
>                 case PCI_CLASS_BRIDGE_CARDBUS:
> 
> 3. This patch works without PORTBUS enabled also.
> 
> QUESTIONS:
> 1. Does anybody see any problem with this patch? Any reason for pci_is_enabled check above?
> 
> With best,
> Jay
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
