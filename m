Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:39813 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847AbbHKACA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 20:02:00 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 11 Aug 2015 05:31:57 +0530
Date: Mon, 10 Aug 2015 17:17:22 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com
Subject: Re: [PATCH v6 00/42] powerpc/powernv: PCI hotplug suppport
Message-ID: <20150810071722.GA19068@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C83F34.9040306@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C83F34.9040306@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 10, 2015 at 04:05:40PM +1000, Alexey Kardashevskiy wrote:
>On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>The series of patches intend to support PCI slot for PowerPC PowerNV platform,
>>which is running on top of skiboot firmware. The patchset requires corresponding
>>changes from skiboot firmware, which is sent to skiboot@lists.ozlabs.org
>>for review. The PCI slots are exposed by skiboot with device node properties,
>>and kernel utilizes those properties to populated PCI slots accordingly.
>
>
>This does not apply on top of any actual trees I have - torvalds/master,
>powerpc/master, powerpc/next.
>
>The problem patches are (at least):
>powerpc/powernv: Enable M64 on P7IOC
>powerpc/powernv: Release PEs dynamically
>
>What did you base them on (sha1)? It is always worth mentioning.
>

The patchset bases on powerpc/next + below patches that will be merged
prior to this patchset, I think. I tried to avoid conflicts as much as
I can do:

e14f70b powerpc/powernv: compound PE for VFs				<<< EEH Support for VF - END
42f59ac powerpc/eeh: Support error recovery for VF PE
9c1c221 powerpc/powernv: Support PCI config restore for VFs
8ac2231 powerpc/powernv: Support EEH reset for VF PE
a636ce5 powerpc/eeh: Create PE for VFs
a4e56fc powerpc/powernv: EEH device for VF
2f02884 powerpc/eeh: Cache only BARs, not windows or IOV BARs
1888e95 powerpc/pci: Remove VFs prior to PF
0dab41d powerpc/pci: Cache VF index in pci_dn
fdc2d8a PCI: Add pcibios_bus_add_device() weak function
2bcc609 PCI/IOV: Rename and export virtfn_add/virtfn_remove		<<< EEH Support for VF - START
efde611 powerpc/eeh: Disable automatically blocked PCI config

All above patches can be found from linux-ppc mail archive.

Thanks,
Gavin

