Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34500 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbbEJMyM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 May 2015 08:54:12 -0400
MIME-Version: 1.0
In-Reply-To: <553E9B9A.5090000@ti.com>
References: <553E9B9A.5090000@ti.com>
Date: Sun, 10 May 2015 18:24:11 +0530
Message-ID: <CAHM4w1krq0vHd6EMpKV-NhHGggDBrrDGZw=V3XLcQDZ7XsXbsQ@mail.gmail.com>
Subject: Re: [RFC] PCI: designware: missing *config* reg space
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Murali Karicheri <m-karicheri2@ti.com>,
	Jingoo Han <jg1.han@samsung.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, KISHON VIJAY <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit ST <mohit.kumar.dhaka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 28, 2015 at 1:57 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> All,
>
> I would like to take action to resolve the following print message thrown by
> PCI designware core driver when kernel boots up on Keystone.
>
> [    0.415778] keystone-pcie 21801000.pcie: missing *config* reg space
>
> As per DT documentation introduced by commit
> 4dd964df36d0e548e1806ec2ec275b62d4dc46e8 "PCI: designware: Look for
> configuration space in 'reg', not 'ranges'
>
> This is introduced to stop abusing the range property for defining resource
> for config space. However if the device binding doesn't have
> reg-name = "config" defined, this throws out an unnecessary log message
> at boot which seems to me not right. AFAIK, reg-names is not mandatory.
> config space address in Keystone case is defined using index. So for
> keystone this needs to be fixed.
>
> I propose to add the following check in the designware code to address
> this. Keystone uses an older version of the Designware IP and doesn't have
> the ATU support. So va_cfg0_base and va_cfg1_base are already set up in
> ks_dw_pcie_host_init() before calling dw_pcie_host_init() and points to the
> remote config space address (both same for keystone). I think for other DW
> drivers, these variables are NULL. So add a check and avoid this error
> message for Keystone. Any comments?
>

or may be just following one liner should do the job for you.

diff --git a/drivers/pci/host/pcie-designware.c
b/drivers/pci/host/pcie-designware.c
index 2e9f84fdd9ce..4ff5308f0cc6 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -371,7 +371,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
                addrp = of_get_address(np, index, NULL, NULL);
                pp->cfg0_mod_base = of_read_number(addrp, ns);
                pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
-       } else {
+       } else if (!pp->va_cfg0_base) {
                dev_err(pp->dev, "missing *config* reg space\n");
        }


~Pratyush
