Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, tglx@linutronix.de, jason@lakedaemon.net, helgaas@kernel.org, rafael@kernel.org, will.deacon@arm.com, catalin.marinas@arm.com, hanjun.guo@linaro.org, shijie.huang@arm.com, robert.richter@caviumnetworks.com, mw@semihalf.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, andrea.gallo@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, al.stone@linaro.org, graeme.gregory@linaro.org, ddaney.cavm@gmail.com, okaya@codeaurora.org
Subject: Re: [UPDATE PATCH V10 1/8] ACPI: I/O Remapping Table (IORT) initial support
Date: Mon, 12 Sep 2016 15:43:52 +0200
Message-ID: <6844783.vEMDYH8fjO@vostro.rjw.lan>
In-Reply-To: <57D6A7DD.1060305@arm.com>
References: <1473152938-17388-2-git-send-email-tn@semihalf.com> <38e36eee-cece-75db-4781-5727dd11c93d@semihalf.com> <57D6A7DD.1060305@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Monday, September 12, 2016 02:04:29 PM Marc Zyngier wrote:
> On 12/09/16 13:37, Tomasz Nowicki wrote:
> > Hi Rafael,
> > 
> > On 09.09.2016 11:20, Lorenzo Pieralisi wrote:
> >> Hi Rafael,
> >>
> >> On Wed, Sep 07, 2016 at 01:56:52PM +0200, Tomasz Nowicki wrote:
> >>> IORT shows representation of IO topology for ARM based systems.
> >>> It describes how various components are connected together on
> >>> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
> >>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
> >>>
> >>> Initial support allows to detect IORT table presence and save its
> >>> root pointer obtained through acpi_get_table(). The pointer validity
> >>> depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
> >>> is not set while using IORT nodes we would dereference unmapped pointers.
> >>>
> >>> For the aforementioned reason call iort_table_detect() from acpi_init()
> >>> which guarantees acpi_gbl_permanent_mmap to be set at that point.
> >>>
> >>> Add generic helpers which are helpful for scanning and retrieving
> >>> information from IORT table content. List of the most important helpers:
> >>> - iort_find_dev_node() finds IORT node for a given device
> >>> - iort_node_map_rid() maps device RID and returns IORT node which provides
> >>>   final translation
> >>>
> >>> IORT support is placed under drivers/acpi/arm64/ new directory due to its
> >>> ARM64 specific nature. The code there is considered only for ARM64.
> >>> The long term plan is to keep all ARM64 specific tables support
> >>> in this place e.g. GTDT table.
> >>>
> >>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> >>> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>> ---
> >>
> >> Apart from the minor commit logs oversights we consider these two
> >> patches ready to go, please let us know if there is something you want
> >> changed since we are at risk of missing yet another merge window.
> >>
> >> It is ARM64 specific code, we created and moved the code to its
> >> ARM64 specific directory and we are happy to maintain it as such,
> >> we need your ACK to get this done so if there is something you
> >> want changed please let us know otherwise I would ask your ACK
> >> on these two patches to give Marc a go-ahead for -next and
> >> hopefully 4.9.
> > 
> > Kindly reminder. Is there anything we need to do more about these 
> > patches? Please let us know. Note this is the major thing for incoming 
> > IORT more advance feature.
> 
> May I convey a slight sense of urgency here? I'd like to cut the irqchip
> branch for 4.9 pretty soon (this week), in order to let it sink in -next
> for a few days at the very least.
> 
> It'd be a bit disappointing if these patches missed the boat this time
> again.

Both [1-2/8] are fine by me.

Please feel free to add my ACKs to those when you apply them.

Thanks,
Rafael
