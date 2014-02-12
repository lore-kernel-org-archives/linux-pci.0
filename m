Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:41445 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbaBLUdm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 15:33:42 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so11669791oag.12
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2014 12:33:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1545472.qN7M5OiOyA@wuerfel>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <2006726.HhIT01YuXY@wuerfel> <20140212194313.GA17248@obsidianresearch.com> <1545472.qN7M5OiOyA@wuerfel>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Feb 2014 13:33:22 -0700
Message-ID: <CAErSpo52jJ1EN18v0Z_3rJapsY2G_Uxwhwfe1cWYa4tKN1dD1g@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 12, 2014 at 1:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 12 February 2014 12:43:13 Jason Gunthorpe wrote:
>> On Tue, Feb 11, 2014 at 11:42:52AM +0100, Arnd Bergmann wrote:
>>
>>
>> Still missing release_region..
>>
>> Thoughts on upstreamining these bits?
>
> Upstreaming them would be great. Patches look correct by inspection as well.
>
>> > Since the mvebu_pcie_setup() function seems very generic at this,
>> > we should probably try to factor out that code into a common
>> > helper, at least for arm64, but ideally shared with arm32
>> > as well.
>>
>> Yah, especially since people are not getting it completely right..
>>
>> But some of the trouble here is a lack of a generic pci host driver
>> structure, eg I have to pull the domain number out of the ARM32
>> specific structure ..
>
> I'm sure that Bjorn also has some plans of his own, but I think
> we should have a generic host driver structure and gradually move
> stuff into it from the architecture specific structs.

I don't have plans in this area right now, but I would definitely like
to migrate things like the domain, NUMA node, etc., into a generic
structure.

> Now there is a 'struct pci_host_bridge' that is used on some
> architectures already but not on ARM. It also contains a list
> of resource windows plus offsets, and there is a set of functions
> associated with it:
>
> pci_create_root_bus()
> pcibios_root_bridge_prepare()
>
> etc.
>
> Maybe all that's needed is to actually start using those on arm32?
>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
