Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:47792 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161270AbbKSTWm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2015 14:22:42 -0500
Subject: Re: [PATCH 4/5] PCI: iproc: Add iProc PCIe MSI support
To: Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>
References: <1447806715-30043-1-git-send-email-rjui@broadcom.com>
 <1447806715-30043-5-git-send-email-rjui@broadcom.com>
 <20151118084845.49ba6304@arm.com> <6698299.zIsv0CNpOi@wuerfel>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <564E2176.70008@broadcom.com>
Date: Thu, 19 Nov 2015 11:22:30 -0800
MIME-Version: 1.0
In-Reply-To: <6698299.zIsv0CNpOi@wuerfel>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 11/18/2015 1:50 AM, Arnd Bergmann wrote:
> On Wednesday 18 November 2015 08:48:45 Marc Zyngier wrote:
>>> +static inline u32 iproc_msi_read_reg(struct iproc_msi *msi,
>>> +				     enum iproc_msi_reg reg,
>>> +				     unsigned int eq)
>>> +{
>>> +	struct iproc_pcie *pcie = msi->pcie;
>>> +
>>> +	return readl(pcie->base + msi->reg_offsets[eq][reg]);
>>
>> Do you need the extra barrier implied by readl? readl_relaxed should be
>> enough.
>
> I suspect this is the one place where it's needed for a lot of
> drivers: when the PCI device sends DMA data followed by the MSI
> message, the device driver can safely assume that the DMA data
> has arrived in memory even without doing another readl() from
> the device itself.
>
> It really depends on how the MSI implementation here interacts
> with the memory controller, and we should probably have a comment
> to explain this either way.
>
>>> +static inline void iproc_msi_write_reg(struct iproc_msi *msi,
>>> +				       enum iproc_msi_reg reg,
>>> +				       int eq, u32 val)
>>> +{
>>> +	struct iproc_pcie *pcie = msi->pcie;
>>> +
>>> +	writel(val, pcie->base + msi->reg_offsets[eq][reg]);
>>
>> Same here for writel vs writel_relaxed.
>
> We probably want writel_relaxed() when calling this from
> iproc_msi_handler(), but not when calling from
> iproc_msi_enable(), which should default to a normal
> writel(), so we can be sure it's actually configured right
> at the time we return from iproc_msi_init(). You could
> try to prove that using writel_relaxed is correct here, but
> using writel makes it so much easier.
>
> 	Arnd
>

I need to think through the logic in iproc_msi_handler to make sure the 
correct accesses are used at the right place. The iproc_msi_handler 
needs to be re-written to support multiple MSI vectors per wired interrupt.

Thanks,

Ray
