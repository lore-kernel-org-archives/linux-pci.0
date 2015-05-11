Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43411 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbbEKSMX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 14:12:23 -0400
Message-ID: <5550F0EA.7010906@ti.com>
Date: Mon, 11 May 2015 14:11:54 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Pratyush Anand <pratyush.anand@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>
CC: Lucas Stach <l.stach@pengutronix.de>, KISHON VIJAY <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit ST <mohit.kumar.dhaka@gmail.com>
Subject: Re: [RFC] PCI: designware: missing *config* reg space
References: <553E9B9A.5090000@ti.com> <CAHM4w1krq0vHd6EMpKV-NhHGggDBrrDGZw=V3XLcQDZ7XsXbsQ@mail.gmail.com>
In-Reply-To: <CAHM4w1krq0vHd6EMpKV-NhHGggDBrrDGZw=V3XLcQDZ7XsXbsQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/10/2015 08:54 AM, Pratyush Anand wrote:
> On Tue, Apr 28, 2015 at 1:57 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>> All,
>>
>> I would like to take action to resolve the following print message thrown by
>> PCI designware core driver when kernel boots up on Keystone.
>>
>> [    0.415778] keystone-pcie 21801000.pcie: missing *config* reg space
>>
>> As per DT documentation introduced by commit
>> 4dd964df36d0e548e1806ec2ec275b62d4dc46e8 "PCI: designware: Look for
>> configuration space in 'reg', not 'ranges'
>>
>> This is introduced to stop abusing the range property for defining resource
>> for config space. However if the device binding doesn't have
>> reg-name = "config" defined, this throws out an unnecessary log message
>> at boot which seems to me not right. AFAIK, reg-names is not mandatory.
>> config space address in Keystone case is defined using index. So for
>> keystone this needs to be fixed.
>>
>> I propose to add the following check in the designware code to address
>> this. Keystone uses an older version of the Designware IP and doesn't have
>> the ATU support. So va_cfg0_base and va_cfg1_base are already set up in
>> ks_dw_pcie_host_init() before calling dw_pcie_host_init() and points to the
>> remote config space address (both same for keystone). I think for other DW
>> drivers, these variables are NULL. So add a check and avoid this error
>> message for Keystone. Any comments?
>>
> or may be just following one liner should do the job for you.
>
> diff --git a/drivers/pci/host/pcie-designware.c
> b/drivers/pci/host/pcie-designware.c
> index 2e9f84fdd9ce..4ff5308f0cc6 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -371,7 +371,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                  addrp = of_get_address(np, index, NULL, NULL);
>                  pp->cfg0_mod_base = of_read_number(addrp, ns);
>                  pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
> -       } else {
> +       } else if (!pp->va_cfg0_base) {
>                  dev_err(pp->dev, "missing *config* reg space\n");
>          }
Yes. That will work. I will post a patch for this.

Murali
>
> ~Pratyush
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Murali Karicheri
Linux Kernel, Keystone

