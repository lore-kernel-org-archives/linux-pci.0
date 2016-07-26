Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V7 1/8] ACPI: I/O Remapping Table (IORT) initial support
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1466420541-20101-2-git-send-email-tn@semihalf.com>
 <1466598909-27504-1-git-send-email-tn@semihalf.com>
 <576A91CC.3000101@arm.com> <576A9824.1060400@semihalf.com>
 <576AA603.3080505@arm.com> <576B3CBD.60309@huawei.com>
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <57976353.7080500@codeaurora.org>
Date: Tue, 26 Jul 2016 09:19:15 -0400
MIME-Version: 1.0
In-Reply-To: <576B3CBD.60309@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Catalin.Marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org,
 Hanjun Guo <guohanjun@huawei.com>, andrea.gallo@linaro.org,
 lorenzo.pieralisi@arm.com, al.stone@linaro.org,
 Tomasz Nowicki <tn@semihalf.com>, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, linux-pci@vger.kernel.org,
 shijie.huang@arm.com, jason@lakedaemon.net, ddaney.cavm@gmail.com,
 bhelgaas@google.com, tglx@linutronix.de, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, graeme.gregory@linaro.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
 Suravee.Suthikulpanit@amd.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

On 06/22/2016 09:34 PM, Hanjun Guo wrote:
> On 2016/6/22 22:51, Marc Zyngier wrote:
>> On 22/06/16 14:52, Tomasz Nowicki wrote:
>>> On 22.06.2016 15:25, Marc Zyngier wrote:
>>>> On 22/06/16 13:35, Tomasz Nowicki wrote:
>>>>> IORT shows representation of IO topology for ARM based systems.
>>>>> It describes how various components are connected together on
>>>>> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
>>>>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>>>>>
>>>>> Initial support allows to detect IORT table presence and save its
>>>>> root pointer obtained through acpi_get_table(). The pointer validity
>>>>> depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
>>>>> is not set while using IORT nodes we would dereference unmapped pointers.
>>>>>
>>>>> For the aforementioned reason call iort_table_detect() from acpi_init()
>>>>> which guarantees acpi_gbl_permanent_mmap to be set at that point.
>>>>>
>>>>> Add generic helpers which are helpful for scanning and retrieving
>>>>> information from IORT table content. List of the most important helpers:
>>>>> - iort_find_dev_node() finds IORT node for a given device
>>>>> - iort_node_map_rid() maps device RID and returns IORT node which provides
>>>>>    final translation
>>>>>
>>>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>>>> ---
>>>>>   drivers/acpi/Kconfig  |   3 +
>>>>>   drivers/acpi/Makefile |   1 +
>>>>>   drivers/acpi/bus.c    |   2 +
>>>>>   drivers/acpi/iort.c   | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>   include/linux/iort.h  |  30 +++++++
>>>>>   5 files changed, 253 insertions(+)
>>>>>   create mode 100644 drivers/acpi/iort.c
>>>>>   create mode 100644 include/linux/iort.h

> I tracked Marc's tree on git.kernel.org, it's  acpi_os_free(buffer.pointer) there so
> my worry is gone :)

Do you plan on submitting this during the 4.8 merge window?

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
