Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40987 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbeFAP3i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jun 2018 11:29:38 -0400
Subject: Re: [PATCH v2] PCI: Check for PCIe downtraining conditions
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180601150129.10486-1-mr.nuke.me@gmail.com>
 <CAHp75VfzqbXmoEKE791gCPzg9Sn+Anb9evzfuocbO+F2XJVomw@mail.gmail.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <6fabb0e8-0de8-ab74-94f3-8990033f9658@gmail.com>
Date: Fri, 1 Jun 2018 10:29:36 -0500
MIME-Version: 1.0
In-Reply-To: <CAHp75VfzqbXmoEKE791gCPzg9Sn+Anb9evzfuocbO+F2XJVomw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/01/2018 10:12 AM, Andy Shevchenko wrote:
> On Fri, Jun 1, 2018 at 6:01 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>> PCIe downtraining happens when both the device and PCIe port are
>> capable of a larger bus width or higher speed than negotiated.
>> Downtraining might be indicative of other problems in the system, and
>> identifying this from userspace is neither intuitive, nor straigh
>> forward.
>>
>> The easiest way to detect this is with pcie_print_link_status(),
>> since the bottleneck is usually the link that is downtrained. It's not
>> a perfect solution, but it works extremely well in most cases.
> 
>> +static void pcie_check_upstream_link(struct pci_dev *dev)
>> +{
> 
>> +
> 
> This is redundant, but...

Hmm. I thought it's not safe to call pci_pcie_type() on non-pcie devices.

I see the pci_is_pcie() check followed by pci_pcie_type() is not
uncommon. I didn't think it would be an issue, as long as it's
consistent with the rest of the code.

>> +       if (!pci_is_pcie(dev))
>> +               return;
>> +
>> +       /* Look from the device up to avoid downstream ports with no devices. */
>> +       if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +           (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
>> +           (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
>> +               return;
> 
> ...wouldn't be better
> 
> int type = pci_pcie_type(dev);
> 
> ?

An extra local variable when the compiler knows how to optimize it out?
To me, it doesn't seem like it would improve readability, but it would
make the code longer.

> But also possible, looking at existing code,
> 
> static inline bool pci_is_pcie_type(dev, type)
> {
>   return pci_is_pcie(dev) ? pci_pcie_type(dev) == type : false;
> }

	return pci_is_pcie(dev) && (pci_pcie_type(dev) == type);

seems cleaner. Although this sort of cleanup is beyond the scope of this
change.

Thanks,
Alex
