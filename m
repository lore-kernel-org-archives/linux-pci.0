Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38688 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964827AbbGQKlq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 06:41:46 -0400
Received: by wicmv11 with SMTP id mv11so39159569wic.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 03:41:45 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] PCI: xilinx: Add check for MSI interrupt flag before handling as INTx
From: Russell Joyce <russell.joyce@york.ac.uk>
In-Reply-To: <20150714222440.GO24416@google.com>
Date: Fri, 17 Jul 2015 11:41:43 +0100
Cc: michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	sthokal@xilinx.com, jiang.liu@linux.intel.com, arnd@arndb.de,
	tglx@linutronix.de, wangyijing@huawei.com, wsa@the-dreams.de,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <E5601A3C-EB97-4DF9-8888-138C5C7C2E49@york.ac.uk>
References: <1436288059-22925-1-git-send-email-russell.joyce@york.ac.uk> <20150714222440.GO24416@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Of the PCIe cards I have tried, only one (an Intel SSD 750 Series) causes the problem, where both INTx and MSI interrupt flags are set shortly after the device is enabled during boot.
For reference, I am using the latest 2015.2 Xilinx tools with version 2.6 (rev. 1) of the AXI PCIe Bridge core in root port mode on a ZedBoard Mini-ITX.

The documentation for the core does not say that the interrupt type flags are mutually exclusive, and the interrupt message type (XILINX_PCIE_RPIFR1_MSI_INTR) is already checked before handling MSI interrupts, so it makes sense that it should also be checked before handling INTx interrupts.


> On 14 Jul 2015, at 23:24, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> On Tue, Jul 07, 2015 at 05:54:19PM +0100, Russell Joyce wrote:
>> Occasionally both MSI and INTx bits in the interrupt decode register are
>> set at once by the Xilinx AXI PCIe Bridge, so the MSI flag in the
>> interrupt message should be checked to ensure that the correct handler is
>> used.
>> 
>> If this check is not in place and the interrupt message type is MSI, the
>> INTx handler will be used erroneously when both type bits are set.
>> This will also be followed by a second read of the message FIFO, which can
>> result in the function returning early and the interrupt decode register
>> not being cleared if the FIFO is now empty.
>> 
>> Signed-off-by: Russell Joyce <russell.joyce@york.ac.uk>
>> ---
>> drivers/pci/host/pcie-xilinx.c | 19 +++++++++++--------
>> 1 file changed, 11 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
>> index f1a06a0..dcb9b57 100644
>> --- a/drivers/pci/host/pcie-xilinx.c
>> +++ b/drivers/pci/host/pcie-xilinx.c
>> @@ -449,14 +449,17 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>> 			return IRQ_HANDLED;
>> 		}
>> 
>> -		/* Clear interrupt FIFO register 1 */
>> -		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
>> -			   XILINX_PCIE_REG_RPIFR1);
>> -
>> -		/* Handle INTx Interrupt */
>> -		val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
>> -			XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
>> -		generic_handle_irq(irq_find_mapping(port->irq_domain, val));
>> +		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
>> +			/* Clear interrupt FIFO register 1 */
>> +			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
>> +				   XILINX_PCIE_REG_RPIFR1);
>> +
>> +			/* Handle INTx Interrupt */
>> +			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
>> +				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
>> +			generic_handle_irq(irq_find_mapping(port->irq_domain,
>> +							    val));
> 
> Xilinx folks, any comments?
> 
> Russell, is there a good way to reproduce this so others can verify the
> problem and the fix?
> 
>> +		}
>> 	}
>> 
>> 	if (status & XILINX_PCIE_INTR_MSI) {
>> -- 
>> 2.1.4

