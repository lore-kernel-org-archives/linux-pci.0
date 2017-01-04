Return-Path: <SRS0=VfY7=YS=comsys.rwth-aachen.de=Jan.Rueth@kernel.org>
Return-Path: <SRS0=VfY7=YS=comsys.rwth-aachen.de=Jan.Rueth@kernel.org>
Subject: Re: [PATCH] pci/aspm: Fix null pointer dereference during
 re-enumeration of PCI bus in pcie_aspm_init_link_state even though ASPM is
 off
To: Bjorn Helgaas <helgaas@kernel.org>
References: <4cec62c2-218a-672b-8c12-d44e8df56aae@comsys.rwth-aachen.de>
 <20170103205350.GC25398@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>
From: =?UTF-8?B?SmFuIFLDvHRo?= <rueth@comsys.rwth-aachen.de>
Message-ID: <122cc4bb-d95e-2b08-a1a4-6725361bfa14@comsys.rwth-aachen.de>
Date: Wed, 4 Jan 2017 12:41:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170103205350.GC25398@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>



On 03/01/2017 21:53, Bjorn Helgaas wrote:
> On Tue, Jan 03, 2017 at 09:04:36AM +0100, Jan Rüth wrote:
>> This patch fixes a null pointer dereference during PCI bus enumeration
>> when ASPM is off. On an IBM x3850 8664 this bug causes the kernel to
>> halt, this behavior did not appear in 3.10, so this is a regression.
>>
>> pcie_aspm_sanity_check should only be called if ASPM is on.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=187731
> 
>> Signed-off-by: Jan Rueth <rueth@comsys.rwth-aachen.de>
>> ---
>>  drivers/pci/pcie/aspm.c | +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index f981129..e758b56 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -552,11 +552,12 @@ static struct pcie_link_state
>> *alloc_pcie_link_state(struct pci_dev *pdev)
>>  void pcie_aspm_init_link_state(struct pci_dev *pdev)
>>  {
>>         struct pcie_link_state *link;
>> -       int blacklist = !!pcie_aspm_sanity_check(pdev);
>> -
>> +       int blacklist;
>>         if (!aspm_support_enabled)
>>                 return;
>>
>> +       blacklist = !!pcie_aspm_sanity_check(pdev);
>> +
>>         if (pdev->link_state)
>>                 return;
> 
> For some reason this doesn't apply for me (complains about a malformed
> patch), but I can apply it by hand easily enough.
> 
> However, this path is a little obtuse, and I'd like to understand
> what's going on better.  We currently have:
> 
>   pci_scan_slot
>     if (bus->self && nr)
>       pcie_aspm_init_link_state(bus->self)
>         pcie_aspm_sanity_check
> 	  list_for_each_entry(child, &pdev->subordinate->devices, ...)
> 
> I assume the null pointer is pdev->subordinate, so maybe we're calling
> pcie_aspm_init_link_state() for a bridge where we weren't able to
> create a child bus ("pdev->subordinate")?

At the time when I debugged it could trace it back to the loop but I
can't remember which part actually broke. But I can add some debug
output and crash it again.
> 
> I think it's legal to have a bridge device where we haven't set
> pdev->subordinate, but it does seem unusual.
> 
> I don't see a log with the actual null pointer dereference in the
> bugzilla.  Do you have any more details about which device blows up
> here and why it's unusual?

If you need it, I can boot an unpatched kernel again and post the actual
nullpointer dereference. The device in question is an ethernet card:
Intel Corporation 82576
Here is also a lspci -tv if that is of any help:

-+-[0000:19]---00.0-[1a-1d]----00.0-[1b-1d]--+-02.0-[1c]--+-00.0  Intel
Corporation 82576 Gigabit Network Connection
 |                                           |            \-00.1  Intel
Corporation 82576 Gigabit Network Connection
 |                                           \-04.0-[1d]--+-00.0  Intel
Corporation 82576 Gigabit Network Connection
 |                                                        \-00.1  Intel
Corporation 82576 Gigabit Network Connection
 +-[0000:14]---00.0-[15-18]--
 +-[0000:0f]---00.0-[10-13]--
 +-[0000:0a]---00.0-[0b-0e]--
 +-[0000:06]---00.0  IBM Calgary PCI-X Host Bridge
 +-[0000:02]---00.0  IBM Calgary PCI-X Host Bridge
 +-[0000:01]-+-00.0  IBM Calgary PCI-X Host Bridge
 |           +-01.0  Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
 |           +-01.1  Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet
 |           \-02.0  Adaptec AAC-RAID
 \-[0000:00]-+-00.0  IBM Calgary PCI-X Host Bridge
             +-01.0  Advanced Micro Devices, Inc. [AMD/ATI] RV100
[Radeon 7000 / Radeon VE]
             +-03.0  NEC Corporation OHCI USB Controller
             +-03.1  NEC Corporation OHCI USB Controller
             +-03.2  NEC Corporation uPD72010x USB 2.0 Controller
             +-0f.0  Broadcom CSB6 South Bridge
             +-0f.1  Broadcom CSB6 RAID/IDE Controller
             \-0f.3  Broadcom GCLE-2 Host Bridge

> 
> Part of the reason I'm curious is that I'd like to identify the commit
> that introduced the problem so we can figure out where the fix might
> need to be backported.  I suspected b7206cbf024d ("PCI ASPM: support
> partial aspm enablement") because it moved the
> pcie_aspm_sanity_check() call before the checks for aspm_disabled, but
> that's been around since 2.6 days, and the problem you're seeing
> didn't happen until after 3.10.

The distribution I tested where it ran with a 3.10 kernel was a CentOS
(the machines were once certified for REHL so I figured there might be
something special). I'm not 100% sure anymore but I think I used a
CentOS 6.5 and updated the kernel to 3.10 there and it worked. (I think
I followed this guide:
http://bicofino.io/2014/10/25/install-kernel-3-dot-10-on-centos-6-dot-5/)
So I guess it could be that the patch that introduces the fix was just
not pulled into the CentOS 3.10 kernel?

> 
> Bjorn
> 

Best
 Jan
