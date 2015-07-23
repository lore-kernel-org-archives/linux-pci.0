Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40732 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbbGWOwo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jul 2015 10:52:44 -0400
Message-ID: <55B0FFB8.3030506@arm.com>
Date: Thu, 23 Jul 2015 15:52:40 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v5 04/19] PCI/MSI: Add hooks to populate the msi_domain
 field
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com> <1437643598-19795-5-git-send-email-marc.zyngier@arm.com> <20150723130637.GR21967@google.com>
In-Reply-To: <20150723130637.GR21967@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 23/07/15 14:06, Bjorn Helgaas wrote:
> On Thu, Jul 23, 2015 at 10:26:23AM +0100, Marc Zyngier wrote:
>> In order to be able to populate the device msi_domain field,
>> add the necessary hooks to propagate the host bridge msi_domain
>> across secondary busses to devices.
>>
>> So far, nobody populates the initial msi_domain.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
>> +static void pci_set_msi_domain(struct pci_dev *dev)
>> +{
>> +	/*
>> +	 * If no domain has been set through the pcibios callback,
>> +	 * inherit the default from the bus device.
> 
> Nit: there isn't a pcibios callback anymore.

There is actually one, in pci_add_device:

	[...]
	ret = pcibios_add_device(dev);
	WARN_ON(ret < 0);

	/* Setup MSI irq domain */
	pci_set_msi_domain(dev);
	[...]

pcibios_add_device is the one I was referring to. I'll clarify the comment.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
