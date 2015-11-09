Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbbKILNT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Nov 2015 06:13:19 -0500
Message-ID: <56407FCE.3070201@redhat.com>
Date: Mon, 09 Nov 2015 06:13:18 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Mathias Krause <minipli@googlemail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH] PCI: Prevent out of bounds access in numa_node override
 - part 2
References: <1447003444-27108-1-git-send-email-minipli@googlemail.com>	<563FDAA6.1010305@redhat.com> <CA+rthh_7u7B5ftoqwaTKRXxt8vio+BRwCoyJ1mJqW5vBRmhiiA@mail.gmail.com>
In-Reply-To: <CA+rthh_7u7B5ftoqwaTKRXxt8vio+BRwCoyJ1mJqW5vBRmhiiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/09/2015 01:56 AM, Mathias Krause wrote:

> 
>> Can you point to the code that does node_states[pci_dev->numa_node] without
>> doing a bounds check?  IMO that's the code that is broken.
> 
> It's the node_state() inline for MAX_NUMNODES > 1.

In drivers/pci/pci-sysfs.c: numa_node_store()

	if (node >= MAX_NUMNODES || !node_online(node))

needs to be broken out into a range and separate online check.

	/* range check */
	if (node < NUMA_NO_NODE || node >= MAX_NUMNODES)
		return -EINVAL;

	/* Is the specific node online? */
	if (node != NUMA_NO_NODE && !node_online(node))
		return -EINVAL; /* perhaps -ENODEV ? */

which will fix the problem.

P.

> 
>>
>> FWIW: I think the idea of your patch is still correct.  Checking for -1 to
>> MAX_NUMNODES is not a bad idea.
> 
> It is. As it prevents userland from triggering the out of bounds read. ;)
> 
> 
> Thanks,
> Mathias
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
