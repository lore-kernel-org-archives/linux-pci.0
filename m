Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953Ab2IEBly (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 4 Sep 2012 21:41:54 -0400
Message-ID: <5046ADDC.8090707@redhat.com>
Date: Tue, 04 Sep 2012 21:41:48 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>, Jon Mason <jdmason@kudzu.us>,
	Jiang Liu <liuj97@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI mini-summit notes
References: <CAErSpo73r3yzzndUek-NJ3d0pDKtg8zTrnjk4ihudBE5gngBAA@mail.gmail.com> <503E39DE.7000109@gmail.com> <CAPoiz9yRzEr68=NB53SVXb5+nRmEa_J4Mtt6eGAAo5EWFbDbmQ@mail.gmail.com> <CAE9FiQWEE0aCPbM=aVfH4kYzWqpJ4orseh2isWuuGFj3yFxKqQ@mail.gmail.com> <CAErSpo60gh1Ph6jq5iWT6Vsc=UGW+4DFdGCZpL90-3vk+_H89g@mail.gmail.com> <5046ABE0.303@redhat.com>
In-Reply-To: <5046ABE0.303@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/04/2012 09:33 PM, Don Dutile wrote:
> On 08/30/2012 02:02 AM, Bjorn Helgaas wrote:
>> [removed cc ksummit-2012-discuss]
>>
>> On Wed, Aug 29, 2012 at 3:54 PM, Yinghai Lu<yinghai@kernel.org> wrote:
>>> On Wed, Aug 29, 2012 at 3:44 PM, Jon Mason<jdmason@kudzu.us> wrote:
>>>>> Hi Bjorn,
>>>>> One of my team member reported another corner case for SR-IOV. There's
>>>>> are two NIC cards in the system driven by the same driver, but one supports
>>>>> SR-IOV and the other doesn't. It runs into trouble if "max_vfs" parameter is
>>>>> set for the NIC driver.
>>>>> --Gerry
>>>>
>>>> I believe it was decided that a per-pf sysfs interface would be used
>>>> to replace the current module parameter that specifies the number of
>>>> vf's. This should enable different numbers of vf's for each physical
>>>> device. The driver interface that was discussed would introduce new
>>>> function pointers for handlers to setup/teardown the vf's. I believe
>>>> this will solve your problem once it has been implemented.
>>>
>>> now we have ixgbe.max_vfs=63
>>>
>>> so if change to per pci device (PF),
>>>
>>> how about having the driver built-in?
>>> what kind of kernel parameters will be passed?
>
> Having the driver built-in won't make a difference.
>
> The model is to have files under sys fs, i.e.,
> /sys/bus/pci/devices/0000:03:01.0/[sriov_vf_enable, sriov_vf_disable]
>
> where one echo's the number of vf's one wants to configure for a pf
> into the sriov_vf_enable file; if want to disable/deconfigure the vf's,
> one echo's a 1 to sriov_vf_disable (all or nothing disable).
>
> the pci core will be able to check & filter that the max num of vf's
> is not exceeded. Also looking to add a file like 'sriov_num_vfs' to
> indicate max number of vf's a PF supports. Whether the bus configuration
> supports it (enough mmio space, enough pci bus nums, etc.) won't be
> known until the enable count is written.
>
> I have the code down to create the sysfs files & report the num_vfs.
                   ^^^^ should be 'done' ...

> Hope to have the first enable/disable working within another week.
> The tough part is to re-factor a pf driver that enables/configures pf;
> I'm working with the igb(_main.c) driver right now.
>
> - Don

btw -- what we didn't resolve at summit, and I haven't taken a crack at it yet,
is a method to set the vf-enablement on a per-pf basis at boot time...
-- kernel cmdline (sounds knarly for large PCIe config)
-- /etc/module.d/sriov.conf ?
-- other ?

>>
>> I don't think we really discussed things at this level, and I
>> personally don't know enough about the current SR-IOV support to even
>> know what the possible strategies are. I think it's really up to the
>> person doing the implementation to figure out what makes sense given
>> the constraints of the SR-IOV specs and the current Linux support.
>>
>> Bjorn
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>

