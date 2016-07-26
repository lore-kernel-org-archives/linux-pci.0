Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 26 Jul 2016 15:48:49 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Christopher Covington <cov@codeaurora.org>
Cc: Hanjun Guo <guohanjun@huawei.com>,
	Tomasz Nowicki <tn@semihalf.com>, <tglx@linutronix.de>,
	<jason@lakedaemon.net>, <rjw@rjwysocki.net>, <bhelgaas@google.com>,
	<lorenzo.pieralisi@arm.com>, <robert.richter@caviumnetworks.com>,
	<shijie.huang@arm.com>, <Suravee.Suthikulpanit@amd.com>,
	<hanjun.guo@linaro.org>, <al.stone@linaro.org>, <mw@semihalf.com>,
	<graeme.gregory@linaro.org>, <Catalin.Marinas@arm.com>,
	<will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ddaney.cavm@gmail.com>,
	<okaya@codeaurora.org>, <andrea.gallo@linaro.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH V7 1/8] ACPI: I/O Remapping Table (IORT) initial support
Message-ID: <20160726154849.350d9c1c@arm.com>
In-Reply-To: <57976353.7080500@codeaurora.org>
References: <1466420541-20101-2-git-send-email-tn@semihalf.com>
	<1466598909-27504-1-git-send-email-tn@semihalf.com>
	<576A91CC.3000101@arm.com>
	<576A9824.1060400@semihalf.com>
	<576AA603.3080505@arm.com>
	<576B3CBD.60309@huawei.com>
	<57976353.7080500@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 26 Jul 2016 09:19:15 -0400
Christopher Covington <cov@codeaurora.org> wrote:

Hi Christopher,

> Hi Marc,
> 
> On 06/22/2016 09:34 PM, Hanjun Guo wrote:
> > On 2016/6/22 22:51, Marc Zyngier wrote:  
> >> On 22/06/16 14:52, Tomasz Nowicki wrote:  
> >>> On 22.06.2016 15:25, Marc Zyngier wrote:  
> >>>> On 22/06/16 13:35, Tomasz Nowicki wrote:  
> >>>>> IORT shows representation of IO topology for ARM based systems.
> >>>>> It describes how various components are connected together on
> >>>>> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
> >>>>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
> >>>>>
> >>>>> Initial support allows to detect IORT table presence and save its
> >>>>> root pointer obtained through acpi_get_table(). The pointer validity
> >>>>> depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
> >>>>> is not set while using IORT nodes we would dereference unmapped pointers.
> >>>>>
> >>>>> For the aforementioned reason call iort_table_detect() from acpi_init()
> >>>>> which guarantees acpi_gbl_permanent_mmap to be set at that point.
> >>>>>
> >>>>> Add generic helpers which are helpful for scanning and retrieving
> >>>>> information from IORT table content. List of the most important helpers:
> >>>>> - iort_find_dev_node() finds IORT node for a given device
> >>>>> - iort_node_map_rid() maps device RID and returns IORT node which provides
> >>>>>    final translation
> >>>>>
> >>>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >>>>> ---
> >>>>>   drivers/acpi/Kconfig  |   3 +
> >>>>>   drivers/acpi/Makefile |   1 +
> >>>>>   drivers/acpi/bus.c    |   2 +
> >>>>>   drivers/acpi/iort.c   | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>   include/linux/iort.h  |  30 +++++++
> >>>>>   5 files changed, 253 insertions(+)
> >>>>>   create mode 100644 drivers/acpi/iort.c
> >>>>>   create mode 100644 include/linux/iort.h  
> 
> > I tracked Marc's tree on git.kernel.org, it's  acpi_os_free(buffer.pointer) there so
> > my worry is gone :)  
> 
> Do you plan on submitting this during the 4.8 merge window?

Short of having received the necessary Ack from the ACPI maintainer,
the answer is unfortunately negative. I'm hoping that the new split
ACPI maintenance between generic code and arm64 will help getting
things moving for 4.9.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
