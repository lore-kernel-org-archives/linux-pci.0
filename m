Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42955 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaBYBzK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2014 20:55:10 -0500
Received: by mail-ob0-f181.google.com with SMTP id wp4so6159390obc.40
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2014 17:55:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
	<CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
Date: Mon, 24 Feb 2014 17:55:09 -0800
Message-ID: <CAE9FiQUvU=BqPXDHC+B=zC7ZGarimLDdvHsDbVL8t8qnZLJpzw@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 24, 2014 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Rajat]
>
> On Mon, Feb 24, 2014 at 4:59 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On system with 16 PCI express hotplug slots, customer complain every slot
>> will report "Command not completed in 1000 msec" during initialization.
>>
>> Intel says that we should only wait command complete only for
>>            Electromechanical Interlock Control
>>            Power Controller Control
>>            Power Indicator Control
>>            Attention Indicator Control
>
> Is there something in the spec that says this?  I'm looking at section
> 6.7.3.2.  It says "If command completed events are supported, then
> software must wait for a command to complete before issuing the next
> command."  It's obvious that this is conditional on the "No Command
> Completed Support" bit, but I don't see anything about a connection
> with the other bits you mentioned.

others told me that other os does not check command complete
when enabling notification.

>
> Is this related to an erratum in the Intel/AMD/Nvidia chipsets?  If
> so, we need at least a comment about that in the source, and
> preferably, some sort of quirk for these chipsets.

Vendor does not agree that is silicon problem.
But will update EDS to state that CC will be only set when those four
control bits are handled.

>
> This is similar to the issue Rajat is working on with
> http://patchwork.ozlabs.org/patch/322387/ .  I haven't merged that
> yet, but I probably will.  Is there any connection between that patch
> and this issue?  Does this issue still happen even with Rajat's patch
> applied?

looks like other way.

The issue still happen with Rajat's patch.

Thanks

Yinghai
