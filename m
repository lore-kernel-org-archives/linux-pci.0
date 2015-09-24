Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36433 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbbIXAeS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 20:34:18 -0400
Message-ID: <56034505.1080301@gmail.com>
Date: Wed, 23 Sep 2015 17:34:13 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: "Sean O. Stalley" <sean.stalley@intel.com>
CC: bhelgaas@google.com, yinghai@kernel.org, rajatxjain@gmail.com,
	mst@redhat.com, zajec5@gmail.com, gong.chen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: Add support for PCI Enhanced Allocation "BARs"
References: <1443047264-4003-1-git-send-email-sean.stalley@intel.com>
In-Reply-To: <1443047264-4003-1-git-send-email-sean.stalley@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sean,

Thanks for doing this, I think we will use it for Cavium ThunderX.  A 
couple of questions...


On 09/23/2015 03:27 PM, Sean O. Stalley wrote:
> PCI Enhanced Allocation is a new method of allocating MMIO & IO
> resources for PCI devices & bridges. It can be used instead
> of the traditional PCI method of using BARs.
>
> EA entries are hardware-initialized to a fixed address.
> Unlike BARs, regions described by EA are cannot be moved.
> Because of this, only devices which are permanently connected to
> the PCI bus can use EA. A removable PCI card must not use EA.
>
> This patchset adds support for using EA entries instead of BARs
> on Root Complex Integrated Endpoints.
>
> The Enhanced Allocation ECN is publicly available here:
> https://www.pcisig.com/specifications/conventional/ECN_Enhanced_Allocation_23_Oct_2014_Final.pdf
>
>
> Changes from V1:
> 	- Use generic PCI resource claim functions (instead of EA-specific functions)
> 	- Only add support for RCiEPs (instead of all devices).

Why not all devices?  The spec. allows for EA on devices behind bridges.


> 	- Removed some debugging messages leftover from early testing.
>
>
> Sean O. Stalley (2):
>    PCI: Add Enhanced Allocation register entries
>    PCI: Add support for Enhanced Allocation devices
>
>   drivers/pci/pci.c             | 174 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/pci/pci.h             |   1 +
>   drivers/pci/probe.c           |   3 +
>   include/uapi/linux/pci_regs.h |  40 +++++++++-
>   4 files changed, 217 insertions(+), 1 deletion(-)
>

