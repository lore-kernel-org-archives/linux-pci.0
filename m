Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:42669 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbbJ1BuU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 21:50:20 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 28 Oct 2015 07:20:18 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id B4F7F3940057
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2015 07:20:16 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9S1oGDx7864770
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2015 07:20:16 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9S1oF1V024143
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2015 07:20:15 +0530
Date: Wed, 28 Oct 2015 09:50:14 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 00/12] VF EEH on Power8
Message-ID: <20151028015014.GA17539@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20151027231113.GB5155@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151027231113.GB5155@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 27, 2015 at 06:11:13PM -0500, Bjorn Helgaas wrote:
>On Mon, Oct 26, 2015 at 11:15:50AM +0800, Wei Yang wrote:
>> This patchset enables EEH on SRIOV VFs. The general idea is to create proper
>> VF edev and VF PE and handle them properly.
>> ...
>
>> Gavin Shan (1):
>>   powerpc/eeh: Don't block PCI config on resetting VF PE
>> 
>> Wei Yang (11):
>>   PCI/IOV: Rename and export virtfn_add/virtfn_remove
>>   PCI: Add pcibios_bus_add_device() weak function
>>   powerpc/pci: Cache VF index in pci_dn
>>   powerpc/pci: Remove VFs prior to PF
>>   powerpc/eeh: Cache only BARs, not windows or IOV BARs
>>   powerpc/powernv: EEH device for VF
>>   powerpc/eeh: Create PE for VFs
>>   powerpc/powernv: Support EEH reset for VF PE
>>   powerpc/powernv: Support PCI config restore for VFs
>>   powerpc/eeh: Support error recovery for VF PE
>>   powerpc/eeh: Handle hot removed VF when PF is EEH aware
>> 
>>  arch/powerpc/include/asm/eeh.h               |  10 ++
>>  arch/powerpc/include/asm/pci-bridge.h        |   2 +
>>  arch/powerpc/kernel/eeh.c                    |  17 ++-
>>  arch/powerpc/kernel/eeh_cache.c              |   6 +-
>>  arch/powerpc/kernel/eeh_dev.c                |   1 +
>>  arch/powerpc/kernel/eeh_driver.c             | 130 ++++++++++++----
>>  arch/powerpc/kernel/eeh_pe.c                 |  13 +-
>>  arch/powerpc/kernel/pci-hotplug.c            |   2 +-
>>  arch/powerpc/kernel/pci_dn.c                 |  16 +-
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 220 ++++++++++++++++++++++++++-
>>  arch/powerpc/platforms/powernv/pci.c         |  18 +++
>>  drivers/pci/bus.c                            |   3 +
>>  drivers/pci/iov.c                            |  10 +-
>>  include/linux/pci.h                          |   8 +
>>  14 files changed, 408 insertions(+), 48 deletions(-)
>
>This really only affects powerpc, so I assume this series will go through
>the powerpc tree.  Let me know if you want me to do anything else.
>

Yep, as we talked about it, this will be merged in powerpc tree.

Have a good day :-)

>Bjorn

-- 
Richard Yang
Help you, Help me

