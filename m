Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeASEVv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jan 2018 23:21:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 19 Jan 2018 09:51:50 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v5 4/4] PCI/DPC: Enumerate the devices after DPC trigger
 event
In-Reply-To: <20180119014310.GA12043@localhost.localdomain>
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
 <1516185438-31556-5-git-send-email-poza@codeaurora.org>
 <b255864b-1272-0626-f448-db2d9c3710c5@codeaurora.org>
 <20180118025615.GF7562@localhost.localdomain>
 <153733e36c151d2a549b814e4232c0df@codeaurora.org>
 <1629ca15-81f6-f5f4-8f9c-d0a575272dd6@codeaurora.org>
 <20180119014310.GA12043@localhost.localdomain>
Message-ID: <532771673b80ab147fada349d61b26f4@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-19 07:13, Keith Busch wrote:
> On Thu, Jan 18, 2018 at 11:35:59AM -0500, Sinan Kaya wrote:
>> On 1/18/2018 12:32 AM, poza@codeaurora.org wrote:
>> > On 2018-01-18 08:26, Keith Busch wrote:
>> >> On Wed, Jan 17, 2018 at 08:27:39AM -0800, Sinan Kaya wrote:
>> >>> On 1/17/2018 5:37 AM, Oza Pawandeep wrote:
>> >>> > +static bool dpc_wait_link_active(struct pci_dev *pdev)
>> >>> > +{
>> >>>
>> >>> I think you can also make this function common instead of making another copy here.
>> >>> Of course, this would be another patch.
>> >>
>> >> It is actually very similar to __pcie_wait_link_active in pciehp_hpc.c,
>> >> so there's some opprotunity to make even more common code.
>> >
>> > in that case there has to be a generic function in
>> > drives/pci.c
>> >
>> > which addresses folowing functions from
>> >
>> > pcie-dpc.c:
>> > dpc_wait_link_inactive
>> > dpc_wait_link_active
>> >
>> > drivers/pci/hotplug/pciehp_hpc.c
>> > pcie_wait_link_active
>> >
>> >
>> > all aboe making one generic function to be moved to drives/pci.c
>> >
>> > please let me know if this is okay.
>> 
>> Works for me. Keith/Bjorn?
> 
> Yep, I believe common solutions that reduce code is always encouraged
> in the Linux kernel.


okay, I will work on this.

Regards,
Oza.
