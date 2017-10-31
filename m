Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:46556 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdJaVGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2017 17:06:38 -0400
Subject: Re: [PATCH v2 06/17] PCI: designware-ep: Add generic function for
 raising MSI irq
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20171030124221.20690-1-niklas.cassel@axis.com>
 <20171030124221.20690-7-niklas.cassel@axis.com>
 <c0ec56ba-1896-c3be-33a9-4650921a433a@ti.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <3504bd0d-7e96-a9ac-2d9e-e0e81797eb19@axis.com>
Date: Tue, 31 Oct 2017 22:06:24 +0100
MIME-Version: 1.0
In-Reply-To: <c0ec56ba-1896-c3be-33a9-4650921a433a@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2017 07:22 AM, Kishon Vijay Abraham I wrote:

(snip)

>> --- a/drivers/pci/dwc/pcie-designware.h
>> +++ b/drivers/pci/dwc/pcie-designware.h
>> @@ -106,6 +106,8 @@
>>  #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)
>>  #define MSI_MESSAGE_ADDR_L32		0x54
>>  #define MSI_MESSAGE_ADDR_U32		0x58
>> +#define MSI_MESSAGE_DATA_32		0x58
> 
> Does ADDR_U32 and DATA_32 share the same offset? (in dra7xx MSI_64_EN is
> hardwired to 1 so I can't know this for sure.)
> 

Hello Kishon,

Yes, they do.
The information in the register depends on if the bit MSI_64_EN
is set or not.

There exists defines for this also in the generic uapi header pci_regs.h,
however, utilizing that header would be a separate patch.

$ grep -E "MSI_DATA|MSI_MASK" include/uapi/linux/pci_regs.h
#define PCI_MSI_DATA_32         8       /* 16 bits of data for 32-bit devices */
#define PCI_MSI_MASK_32         12      /* Mask bits register for 32-bit devices */
#define PCI_MSI_DATA_64         12      /* 16 bits of data for 64-bit devices */
#define PCI_MSI_MASK_64         16      /* Mask bits register for 64-bit devices */

Regards,
Niklas
