Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: xilinx: Add check for MSI interrupt flag before
 handling as INTx
To: Bjorn Helgaas <bhelgaas@google.com>,
	Russell Joyce <russell.joyce@york.ac.uk>
References: <1436288059-22925-1-git-send-email-russell.joyce@york.ac.uk>
 <20150721154000.GA21967@google.com>
CC: michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	sthokal@xilinx.com, jiang.liu@linux.intel.com, arnd@arndb.de,
	tglx@linutronix.de, wangyijing@huawei.com, wsa@the-dreams.de,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <55AE73F3.8050600@xilinx.com>
Date: Tue, 21 Jul 2015 18:31:47 +0200
MIME-Version: 1.0
In-Reply-To: <20150721154000.GA21967@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 07/21/2015 05:40 PM, Bjorn Helgaas wrote:
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
> 
> Applied to pci/host-xilinx for v4.3, thanks.
> 
> Xilinx guys, speak up if there's any issue with this.


I had 2 weeks off and still catching on emails. I will try to test this
and let you know if there is any problem.

Thanks,
Michal
