Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:46328 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932456AbbENMPc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2015 08:15:32 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 14 May 2015 17:45:29 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id C8FD2E005A
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2015 17:48:26 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4ECFOcw42139758
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2015 17:45:24 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4ECFNpf002756
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2015 17:45:24 +0530
Date: Thu, 14 May 2015 22:15:17 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3 9/9] powerpc/eeh: handle VF PE properly
Message-ID: <20150514121516.GA12847@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-10-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150513011630.GA8973@gwshan>
 <20150514093531.GA12847@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150514093531.GA12847@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 14, 2015 at 05:35:31PM +0800, Wei Yang wrote:
>On Wed, May 13, 2015 at 11:16:30AM +1000, Gavin Shan wrote:
>>On Mon, May 04, 2015 at 03:07:38PM +0800, Wei Yang wrote:
>>
>>	if (!edev->physfn) {
>>		pr_warn("%s: EEH dev %04x:%02x:%02x:%01x not for VF\n",
>>			edev->phb->global_number, pdn->busno,
>>			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
>>		return NULL;
>>	}
>>
>>>+
>>>+	driver = eeh_pcid_get(dev);
>>>+	if (driver) {
>>>+		eeh_pcid_put(dev);
>>>+		if (driver->err_handler)
>>>+			return NULL;
>>>+	}
>>
>>dev and driver are NULL for those VFs that have been unplugged. For those
>>VFs weren't unplugged, driver and err_handler should be valid. The code
>>looks correct. However, for consistence, please use EEH_DEV_DISCONNECTED
>>that has been marked to those EEH devices which were unplugged. Do you
>>think it would be better?
>>
>>	if (!(dev->flags & EEH_DEV_DISCONNECTED))
>>		return NULL;
>>
>
>
>I think this is a nice idea, while this may not work.
>
>We mark the DISCONNECTED flag when remove a PCI device, while before we do the
>hot plug we will detach it from the tree and remove this flag in
>eeh_pe_detach_dev().
>
>This will leads to the VF not be hot plugged.
>

Ok, the following way, with the original idea improved for a bit, would
work for you:

- Don't clear DISCONNECTED flag in eeh_pe_detach_dev().
- Use the flag for your case.
- Clear DISCONNECTED flag after the hogplug is done, right before
  eeh_pe_state_clear(pe, EEH_PE_KEEP) in eeh_reset_device().

Thanks,
Gavin


