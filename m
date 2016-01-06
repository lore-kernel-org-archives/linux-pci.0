Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([125.16.236.8]:35850 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbcAFJ6f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2016 04:58:35 -0500
Received: from localhost
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Wed, 6 Jan 2016 15:28:32 +0530
Subject: Re: [RFC PATCH v2 3/3] vfio-pci: Allow to mmap MSI-X table if EEH is
 supported
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org
References: <1451551844-11732-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1451551844-11732-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1451941655.6585.8.camel@redhat.com>
 <1451943775.12575.6.camel@kernel.crashing.org>
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
	paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <568CE52F.8030407@linux.vnet.ibm.com>
Date: Wed, 6 Jan 2016 17:58:07 +0800
MIME-Version: 1.0
In-Reply-To: <1451943775.12575.6.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/1/5 5:42, Benjamin Herrenschmidt wrote:
> On Mon, 2016-01-04 at 14:07 -0700, Alex Williamson wrote:
>> On Thu, 2015-12-31 at 16:50 +0800, Yongji Xie wrote:
>>> Current vfio-pci implementation disallows to mmap MSI-X
>>> table in case that user get to touch this directly.
>>>
>>> However, EEH mechanism can ensure that a given pci device
>>> can only shoot the MSIs assigned for its PE. So we think
>>> it's safe to expose the MSI-X table to userspace because
>>> the exposed MSI-X table can't be used to do harm to other
>>> memory space.
>>>
>>> And with MSI-X table mmapped, some performance issues which
>>> are caused when PCI adapters have critical registers in the
>>> same page as the MSI-X table also can be resolved.
>>>
>>> So this patch adds a Kconfig option, VFIO_PCI_MMAP_MSIX,
>>> to support for mmapping MSI-X table.
>>>
>>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>> ---
>>>   drivers/vfio/pci/Kconfig    |    4 ++++
>>>   drivers/vfio/pci/vfio_pci.c |    6 ++++--
>>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>>> index 02912f1..67b0a2c 100644
>>> --- a/drivers/vfio/pci/Kconfig
>>> +++ b/drivers/vfio/pci/Kconfig
>>> @@ -23,6 +23,10 @@ config VFIO_PCI_MMAP
>>>   	depends on VFIO_PCI
>>>   	def_bool y if !S390
>>>   
>>> +config VFIO_PCI_MMAP_MSIX
>>> +	depends on VFIO_PCI_MMAP
>>> +	def_bool y if EEH
>> Does CONFIG_EEH necessarily mean the EEH is enabled?  Could the
>> system
>> not support EEH or could EEH be disabled via kernel commandline
>> options?
> EEH is definitely the wrong thing to test here anyway. What needs to be
> tested is that the PCI Host bridge supports filtering of MSIs, so
> ideally this should be some kind of host bridge attribute set by the
> architecture backend.

So do you mean this attribute can be added in pci_host_bridge like this:

--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -412,6 +412,7 @@ struct pci_host_bridge {
  	void (*release_fn)(struct pci_host_bridge *);
  	void *release_data;
  	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
+	unsigned int msix_filtered:1;	/* support filtering of MSIs */
  	/* Resource alignment requirements */
  	resource_size_t (*align_resource)(struct pci_dev *dev,
  			const struct resource *res,

I can surely do it if there is no objection from PCI folks. Thanks.

Regards,
Yongji Xie

> This can happen with or without CONFIG_EEH and you are right,
> CONFIG_EEH can be enabled and the machine not support it.
>
> Any IODA bridge will support this.
>
> Cheers,
> Ben.
>

