Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V7 1/8] ACPI: I/O Remapping Table (IORT) initial support
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
 rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
 robert.richter@caviumnetworks.com, shijie.huang@arm.com,
 Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
References: <1466420541-20101-2-git-send-email-tn@semihalf.com>
 <1466598909-27504-1-git-send-email-tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <576A873C.3050107@semihalf.com>
Date: Wed, 22 Jun 2016 14:40:28 +0200
MIME-Version: 1.0
In-Reply-To: <1466598909-27504-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: al.stone@linaro.org, graeme.gregory@linaro.org, Catalin.Marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, okaya@codeaurora.org,
 linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, linux-pci@vger.kernel.org,
 mw@semihalf.com, andrea.gallo@linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 22.06.2016 14:35, Tomasz Nowicki wrote:
> IORT shows representation of IO topology for ARM based systems.
> It describes how various components are connected together on
> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>
> Initial support allows to detect IORT table presence and save its
> root pointer obtained through acpi_get_table(). The pointer validity
> depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
> is not set while using IORT nodes we would dereference unmapped pointers.
>
> For the aforementioned reason call iort_table_detect() from acpi_init()
> which guarantees acpi_gbl_permanent_mmap to be set at that point.
>
> Add generic helpers which are helpful for scanning and retrieving
> information from IORT table content. List of the most important helpers:
> - iort_find_dev_node() finds IORT node for a given device
> - iort_node_map_rid() maps device RID and returns IORT node which provides
>    final translation
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

The updated patch incorporates fixes and addresses Lorenzo's comments.
The whole series is here:
https://github.com/semihalf-nowicki-tomasz/linux.git (its-acpi-v7.1)

Thanks,
Tomasz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
