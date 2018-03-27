Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:4896
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752008AbeC0RRh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Mar 2018 13:17:37 -0400
Subject: Re: [PATCH next V3 3/5] PCI: Print PCI device link status in kernel
 log
To: Bjorn Helgaas <helgaas@kernel.org>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>
References: <1520856370-15404-1-git-send-email-talgi@mellanox.com>
 <1520856370-15404-4-git-send-email-talgi@mellanox.com>
 <20180320140527.GL77194@bhelgaas-glaptop.roam.corp.google.com>
 <c513c09c-69d6-3a01-b183-496622daebdc@mellanox.com>
 <20180321194758.GC38649@bhelgaas-glaptop.roam.corp.google.com>
 <02874ECE860811409154E81DA85FBB5882D020D9@ORSMSX115.amr.corp.intel.com>
 <20180321201017.GD38649@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <5b3394b0-fd8a-176f-d522-ec756b663628@mellanox.com>
Date: Tue, 27 Mar 2018 20:17:26 +0300
MIME-Version: 1.0
In-Reply-To: <20180321201017.GD38649@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/21/2018 10:10 PM, Bjorn Helgaas wrote:
> On Wed, Mar 21, 2018 at 07:59:21PM +0000, Keller, Jacob E wrote:
>>> -----Original Message-----
>>> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>>> Sent: Wednesday, March 21, 2018 12:48 PM
>>> To: Tal Gilboa <talgi@mellanox.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>; Linux PCI <linux-
>>> pci@vger.kernel.org>; Tariq Toukan <tariqt@mellanox.com>; Keller, Jacob E
>>> <jacob.e.keller@intel.com>
>>> Subject: Re: [PATCH next V3 3/5] PCI: Print PCI device link status in kernel log
>>>
>>> On Wed, Mar 21, 2018 at 09:43:48AM +0200, Tal Gilboa wrote:
>>>> On 3/20/2018 4:05 PM, Bjorn Helgaas wrote:
>>>>> [+cc Jacob]
>>>>>
>>>>> On Mon, Mar 12, 2018 at 02:06:08PM +0200, Tal Gilboa wrote:
>>>>>> Add pcie_print_link_status() function for querying and verifying
>>>>>> a PCI device link status. The PCI speed and width are reported
>>>>>> in kernel log.
>>>>>> This provides a unified method for all PCI devices to
>>>>>> report status and issues, instead of each device reporting in a
>>>>>> different way, using different code.
> 
>>>> So let's see if we agree on the steps:
>>>> 1. my_speed_cap, my_width_cap <- calculate device PCIe caps
>>>> 2. avail_bw, limiting_dev <- calculate PCIe chain bandwidth
>>>> 3. my_bw <- my_speed_cap * my_width_cap
>>>> 4. If avail_bw == my_bw print available bandwidth + PCIe caps
>>>> 5. Else print available bandwidth + limited by + capable bandwidth + PCIe
>>>> caps
>>>>
>>>> What do you think?
>>>
>>> Steps 2 and 3 might need to be smart enough to apply the effect of
>>> encoding differences between generations.
>>>
>>> In step 2, we don't have any current user of the "limiting_dev"
>>> information, so I'd omit it until we have somebody who wants it.
>>>
>>> In step 5, we don't know the "limited by" part (unless you want to add
>>> that).
>>
>> It might be useful to have the limited by information printed, even
>> if no driver yet bothered to do it today.
> 
> I wouldn't object to printing that information (although it increases
> the challenge of making the message pithy), and it's basically free to
> collect it.
> 

Coding done, currently under internal review. Will submit right after.
I'm having some trouble printing the limiting device bus. Any 
recommendations on which format to use? dev->bus->name gives me the 6 
first digits (e.g. "0000:07"). How do I get the last 3 (e.g. "00.0")? 
dev->bus->primary and dev->bus->number seem like good candidates but the 
actual values I get seem off.
