Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33342 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbbKIG4c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2015 01:56:32 -0500
Received: by ykdv3 with SMTP id v3so160482547ykd.0
        for <linux-pci@vger.kernel.org>; Sun, 08 Nov 2015 22:56:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <563FDAA6.1010305@redhat.com>
References: <1447003444-27108-1-git-send-email-minipli@googlemail.com>
	<563FDAA6.1010305@redhat.com>
Date: Mon, 9 Nov 2015 07:56:31 +0100
Message-ID: <CA+rthh_7u7B5ftoqwaTKRXxt8vio+BRwCoyJ1mJqW5vBRmhiiA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Prevent out of bounds access in numa_node override -
 part 2
From: Mathias Krause <minipli@googlemail.com>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Sasha Levin <sasha.levin@oracle.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9 November 2015 at 00:28, Prarit Bhargava <prarit@redhat.com> wrote:
> On 11/08/2015 12:24 PM, Mathias Krause wrote:
>> Commit 1266963170f5 ("PCI: Prevent out of bounds access in numa_node
>> override") missed that the user provided node could also be negative.
>> Handle this case as well to really avoid out-of-bounds accesses to
>> the node_states[] array.
>
> No, this is incorrect.  More often than not, numa_node is -1 for NUMA_NO_NODE
> which is often interpreted in the kernel as "any numa node".
>
> [root@intel-brickland-04 pci0000:ff]# find ./ -name *numa_node* | xargs egrep ^
> | egrep "\-1" | wc -l
> 92

While this is correct, the patch does not hinder this. It just
prevents *changing* the value to a negative one using the sysfs
interface.

Looking at the initial patch, introducing that interface in commit
63692df103e9 ("PCI: Allow numa_node override via sysfs"), I suspect
it's meant to "fix" broken BIOSes by providing the correct NUMA
topology by hand by writing NUMA node numbers to the corresponding
numa_node sysfs files. Reverting back to 'no specific node' might be a
valid use case. I'll change the patch to allow -1, i.e. NUMA_NO_NODE,
too.

> Can you point to the code that does node_states[pci_dev->numa_node] without
> doing a bounds check?  IMO that's the code that is broken.

It's the node_state() inline for MAX_NUMNODES > 1.

>
> FWIW: I think the idea of your patch is still correct.  Checking for -1 to
> MAX_NUMNODES is not a bad idea.

It is. As it prevents userland from triggering the out of bounds read. ;)


Thanks,
Mathias
