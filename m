Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49988 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933023AbbKFRyK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2015 12:54:10 -0500
Subject: Re: ECRC and Max Read Request Size
To: Bjorn Helgaas <helgaas@kernel.org>
References: <56310B34.6000102@codeaurora.org>
 <20151106172205.GA1002@localhost>
Cc: linux-pci@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <563CE93F.5060209@codeaurora.org>
Date: Fri, 6 Nov 2015 12:54:07 -0500
MIME-Version: 1.0
In-Reply-To: <20151106172205.GA1002@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/6/2015 12:22 PM, Bjorn Helgaas wrote:
> Hi Sinan,
>
> On Wed, Oct 28, 2015 at 01:51:48PM -0400, Sinan Kaya wrote:
>> I'm seeing two problems with the current PCI framework when it comes
>> to end-to-end CRC (ECRC) and Max Read Request Size.
>>
>> The problem with ECRC is that it blindly enables ECRC generation on
>> devices without checking if it is supported by the entire bus with
>> ECRC=on option.
>>
>> ECRC check can be enabled on all devices but ECRC generation on the
>> root complex and switches needs to be set only if all devices
>> support ECRC checking.
>>
>> I'm thinking of making changes in this area to cover this gap with
>> ECRC=safe option.
>
> Sometimes they can't be avoided, but I'm generally not in favor of
> adding command line parameters because they require too much of our
> users and they introduce code paths that are rarely exercised.
>
> What specific ECRC problem are you seeing?  Do you have devices that
> don't operate correctly with the current code?  Or do you want to add
> some new functionality, e.g., to enable ECRC in cases where we don't
> enable it today?

ECRC is an optional PCIe feature. Even ECRC support has some flavors

- A card can support ECRC checking.
- A card can support ECRC checking and generation.

Right now, the code is enabling both without checking if they are 
supported at all.

I have some legacy PCIe cards that don't support ECRC completely even 
though the host bridge supports it. If ECRC checking and generation is 
enabled under this situation, I have problems communicating to the endpoint.

I would like to be able to turn on this feature all the time and not 
think about if things will break or not.

Maybe, I can fix the code and enable it only when the entire bus 
supports it instead of adding a new feature if nobody objects.


>
>> The other problem I'm seeing is about the maximum read request size.
>> If I choose the PCI bus performance mode, maximum read request size
>> is being limited to the maximum payload size.
>>
>> I'd like to add a new mode where I can have bigger read request size
>> than the maximum payload size.
>
> I've never been thrilled about the way Linux ties MRRS and MPS
> together.  I don't think the spec envisioned MRRS being used to
> control segment size on the link.  My impression is that the purpose
> of MRRS is to limit the amount of time one device can dominate a link.
>
> I am sympathetic to the idea of having MRRS larger than MPS.  The
> question is how to accomplish that.  I'm not really happy with the
> current set of "pcie_bus_tune_*" parameters, so I'd hesitate to add
> yet another one.  They feel like they're basically workarounds for the
> fact that Linux can't optimize MPS directly itself.
>
> Can you give any more specifics of your MRRS/MPS situation?  I guess
> you hope to improve bandwidth to some device by reducing the number of
> read requests?  Do you have any quantitative estimate of what you can
> gain?

I talked to our performance team. They are saying that max read request 
does not gain you much compared to max payload size single direction but 
it helps tremendously if you are moving data forth and back between the 
card. I don't have real numbers though.

They asked me to work on adding this feature. Most of the endpoints I 
have seen seem to support something around 4k for max read request size.

I have one directly connected card to my system. I'd like to give the 
maximum bandwidth to the card including maximum payload size and maximum 
read request size which is much bigger than the payload size.

Another opinion is let the firmware do its magic before the OS starts 
but there is no way to apply the same settings after a hot-plug insertion.

>
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
