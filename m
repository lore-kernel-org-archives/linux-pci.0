Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45780 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab2HOVZ2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 17:25:28 -0400
Received: by lbbgj3 with SMTP id gj3so1126490lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 14:25:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
References: <20120618050333.GA13469@ram-ThinkPad-T61> <CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Aug 2012 15:25:06 -0600
Message-ID: <CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
Subject: Re: [RFC PATCH] methods to access resources of a struct pci_dev
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ram Pai <linuxram@us.ibm.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 18, 2012 at 12:30 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sun, Jun 17, 2012 at 10:03 PM, Ram Pai <linuxram@us.ibm.com> wrote:
>> PCI: methods to access resources of struct pci_dev
>>
>> Currently pci_dev structure holds an array of 17 PCI resources; six base
>> BARs, one ROM BAR, four BRIDGE BARs, six sriov BARs.  This is wasteful.
>> A bridge device just needs the 4 bridge resources. A non-bridge device
>> just needs the six base resources and one ROM resource. The sriov
>> resources are needed only if the device has SRIOV capability.
>>
>> The pci_dev structure needs to be re-organized to avoid unnecessary
>> bloating.  However too much code outside the pci-bus driver, assumes the
>> internal details of the pci_dev structure, thus making it hard to
>> re-organize the datastructure.
>>
>> As a first step this patch provides generic methods to access the
>> resource structure of the pci_dev.
>>
>> Once this patch is accepted, I have another 40+ patches that modify all
>> the files that directly access the resource structure, to use the new
>> methods provided in the first step.
>>
>> Finally we can re-organize the resource structure in the pci_dev
>> structure and correspondingly update the methods.
>
> I have patchset on this, please check
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>  for-pci-for-each-res-addon

I don't like the pci_dev.resource[] table very well either, and I
don't like the fact that drivers access it directly.  So I do think we
need some sort of abstraction that lets us change the way we store the
resources without affecting the callers.

Both of these (Ram's patch:
http://marc.info/?l=linux-pci&m=133999604128815&w=2 and Yinghai's
patch: http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=cd192f0ed93203ef6bac2a44c138899190fb5793)
have a similar approach of adding many iterators.

Yinghai's adds:
    for_each_pci_dev_all_resource
    for_each_pci_dev_nobridge_resource
    for_each_pci_dev_base_resource
    for_each_pci_dev_base_norom_resource
    for_each_pci_dev_base_iov_norom_resource
    for_each_pci_dev_noiov_resource
    for_each_pci_dev_std_resource
    for_each_pci_dev_iov_resource
    for_each_pci_dev_bridge_resource
    for_each_pci_dev_addon_resource

Ram's adds:
    for_each_resource
    for_each_std_resource
    for_each_std_and_rom_resource
    for_each_sriov_resource
    for_each_bridge_resource

It seems like we have a combinatorial explosion of iterators based on
various orthogonal selectors (base, rom, iov, bridge window).  That
doesn't seem understandable or maintainable to me.

I wonder if we could get by with *one* iterator, and select the
resources of interest either by supplying a bitmask of things we care
about, or by doing similar filtering in the caller.

Bjorn
