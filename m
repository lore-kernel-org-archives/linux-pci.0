Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38189 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbbGWPhQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 11:37:16 -0400
Received: by wibxm9 with SMTP id xm9so155349891wib.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 08:37:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55B0FFB8.3030506@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-5-git-send-email-marc.zyngier@arm.com> <20150723130637.GR21967@google.com>
 <55B0FFB8.3030506@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Jul 2015 10:36:54 -0500
Message-ID: <CAErSpo5DgUMB4FYrjLXnLf8KFx-KPpd_bCnogSv_nsADuV0tjA@mail.gmail.com>
Subject: Re: [PATCH v5 04/19] PCI/MSI: Add hooks to populate the msi_domain field
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 23, 2015 at 9:52 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 23/07/15 14:06, Bjorn Helgaas wrote:
>> On Thu, Jul 23, 2015 at 10:26:23AM +0100, Marc Zyngier wrote:
>>> In order to be able to populate the device msi_domain field,
>>> add the necessary hooks to propagate the host bridge msi_domain
>>> across secondary busses to devices.
>>>
>>> So far, nobody populates the initial msi_domain.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>>> +static void pci_set_msi_domain(struct pci_dev *dev)
>>> +{
>>> +    /*
>>> +     * If no domain has been set through the pcibios callback,
>>> +     * inherit the default from the bus device.
>>
>> Nit: there isn't a pcibios callback anymore.
>
> There is actually one, in pci_add_device:
>
>         [...]
>         ret = pcibios_add_device(dev);
>         WARN_ON(ret < 0);
>
>         /* Setup MSI irq domain */
>         pci_set_msi_domain(dev);
>         [...]
>
> pcibios_add_device is the one I was referring to. I'll clarify the comment.

Oh, right!  I thought you were referring to
pcibios_set_host_bridge_msi_domain(), which got removed, but of course
that wouldn't even make sense.
