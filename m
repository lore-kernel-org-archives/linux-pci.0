Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V4 0/5] PCIe Xilinx generic driver for Microblaze and
To: Bjorn Helgaas <helgaas@kernel.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
References: <1455208091-15556-1-git-send-email-bharatku@xilinx.com>
 <20160308203444.GA27132@localhost>
CC: <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
	<paul.burton@imgtec.com>, <yinghai@kernel.org>,
	<wangyijing@huawei.com>, <robh@kernel.org>,
	<russell.joyce@york.ac.uk>, <sorenb@xilinx.com>,
	<jiang.liu@linux.intel.com>, <arnd@arndb.de>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Bharat Kumar Gogada <bharatku@xilinx.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <56E05A00.9030506@xilinx.com>
Date: Wed, 9 Mar 2016 18:14:40 +0100
MIME-Version: 1.0
In-Reply-To: <20160308203444.GA27132@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8.3.2016 21:34, Bjorn Helgaas wrote:
> On Thu, Feb 11, 2016 at 09:58:06PM +0530, Bharat Kumar Gogada wrote:
>> This patch series does modifications to pcie-xilinx.c, to support common
>> driver on both Zynq and Microblaze architectures.
>> Microblaze pci-common.c has been modified to support generic driver.
>>
>> Bharat Kumar Gogada (5):
>>   PCI: xilinx: Removing xilinx_pcie_parse_and_add_res function
>>   PCI: xilinx: Removing struct hw_pci structure.
>>   PCI: xilinx: Modifying AXI PCIe Host Bridge driver to work on both
>>      Zynq and Microblaze
>>   PCI: xilinx: Updating Zynq PCI binding documentation with 
>>     Microblaze node.
>>   Microblaze: Modifying microblaze PCI subsytem to support  generic
>>     Xilinx  AXI PCIe Host Bridge IP driver
>>
>>  .../devicetree/bindings/pci/xilinx-pcie.txt        |  32 +++-
>>  arch/microblaze/Kconfig                            |   3 +
>>  arch/microblaze/pci/pci-common.c                   |  56 ++----
>>  drivers/pci/host/Kconfig                           |   2 +-
>>  drivers/pci/host/pcie-xilinx.c                     | 191 +++------------------
>>  5 files changed, 66 insertions(+), 218 deletions(-)
> 
> I applied this series to my pci/host-xilinx branch for v4.6.
> 
> Michal, you only explicitly acked the last patch, but that only makes
> sense if I apply the whole series, so I applied your ack to all the
> patches.

No problem.

Thanks,
Michal
