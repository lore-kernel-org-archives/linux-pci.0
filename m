Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:51706 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab3IICLF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Sep 2013 22:11:05 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 9 Sep 2013 07:32:49 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4E2373940057
	for <linux-pci@vger.kernel.org>; Mon,  9 Sep 2013 07:40:48 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r892CxeM39845970
	for <linux-pci@vger.kernel.org>; Mon, 9 Sep 2013 07:42:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r892B0cf021774
	for <linux-pci@vger.kernel.org>; Mon, 9 Sep 2013 07:41:00 +0530
Date: Mon, 9 Sep 2013 10:10:59 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: Use spec name for the comment of PCIe
 capability field
Message-ID: <20130909021059.GB6953@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1378431958-7874-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <20130906231243.GD12956@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130906231243.GD12956@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 06, 2013 at 05:12:43PM -0600, Bjorn Helgaas wrote:
>On Fri, Sep 06, 2013 at 09:45:57AM +0800, Wei Yang wrote:
>> According to the PCIe specification, bit 7:4 of PCI Express Capabilities
>> Register in a PCI Express Capability Structure is used to identify the
>> Device/Port type. If this field equals to 0x7, this PCIe device is a PCI
>> Express to PCI/PCI-X Bridge. While the comment of this value in the code
>> does not comply with the specification.
>> 
>> This patch changes the comment to "PCIE to PCI/PCI-X Bridge" instead of
>> "PCI/PCI-X Bridge", which comply with the specification.
>> 
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>>  include/uapi/linux/pci_regs.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index c3cc01d..b82b2ff 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -421,7 +421,7 @@
>>  #define  PCI_EXP_TYPE_ROOT_PORT 0x4	/* Root Port */
>>  #define  PCI_EXP_TYPE_UPSTREAM	0x5	/* Upstream Port */
>>  #define  PCI_EXP_TYPE_DOWNSTREAM 0x6	/* Downstream Port */
>> -#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCI/PCI-X Bridge */
>> +#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCIE to PCI/PCI-X Bridge */
>>  #define  PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIE Bridge */
>>  #define  PCI_EXP_TYPE_RC_END	0x9	/* Root Complex Integrated Endpoint */
>>  #define  PCI_EXP_TYPE_RC_EC	0xa	/* Root Complex Event Collector */
>> -- 
>> 1.7.1
>> 
>
>A similar change is already in Linus' tree:
>
>http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/pci_regs.h?id=fbf501c347b2eea8451a615bd823b6b91a1a8eed
>
>I guess several of us found that comment confusing :)

Thanks, I didn't notice this :-)

-- 
Richard Yang
Help you, Help me

