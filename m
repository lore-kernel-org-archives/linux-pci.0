Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:27770
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbaAIFpE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2014 00:45:04 -0500
Message-ID: <52CE3771.1040009@freescale.com>
Date: Thu, 9 Jan 2014 13:45:21 +0800
From: Lian Minghuan-b31939 <b31939@freescale.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>
CC: Minghuan Lian <Minghuan.Lian@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 02/12][v4] pci: fsl: add structure fsl_pci
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com> <1389157323-3088-2-git-send-email-Minghuan.Lian@freescale.com> <1389218288.25654.26.camel@snotra.buserror.net> <20140109001252.GA20070@google.com>
In-Reply-To: <20140109001252.GA20070@google.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

I am very sorry, The  mail was filtered to another directory, I did not 
notice update. The next versions will include these updates.

Thanks,
Minghuan

On 01/09/2014 08:12 AM, Bjorn Helgaas wrote:
> On Wed, Jan 08, 2014 at 03:58:08PM -0600, Scott Wood wrote:
>> On Wed, 2014-01-08 at 13:01 +0800, Minghuan Lian wrote:
>>> PowerPC uses structure pci_controller to describe PCI controller,
>>> but ARM uses structure pci_sys_data. In order to support PowerPC
>>> and ARM simultaneously, the patch adds a structure fsl_pci that
>>> contains most of the members of the pci_controller and pci_sys_data.
>>> Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
>>> be implemented in architecture-specific PCI controller driver to
>>> convert pci_controller or pci_sys_data to fsl_pci.
>>>
>>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>>> ---
>>> change log:
>>> v4:
>>> Added indirect type macro
>>> v1-v3:
>>> Derived from http://patchwork.ozlabs.org/patch/278965/
>>>
>>> Based on upstream master.
>>> Based on the discussion of RFC version here
>>> http://patchwork.ozlabs.org/patch/274487/
>>>
>>>   include/linux/fsl/pci-common.h | 48 ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 48 insertions(+)
>> Same comments on this patchset as last time.
> Minghuan, when you address Scott's comments, can you also add a
> MAINTAINERS update?
>
> Bjorn
>
>


