Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V7 1/8] ACPI: I/O Remapping Table (IORT) initial support
To: Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com,
 tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net,
 bhelgaas@google.com, lorenzo.pieralisi@arm.com,
 robert.richter@caviumnetworks.com, shijie.huang@arm.com,
 Suravee.Suthikulpanit@amd.com
References: <1466420541-20101-1-git-send-email-tn@semihalf.com>
 <1466420541-20101-2-git-send-email-tn@semihalf.com>
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <372d3b78-2bc5-94d1-49f6-c9229affa65d@linaro.org>
Date: Tue, 21 Jun 2016 15:12:57 +0800
MIME-Version: 1.0
In-Reply-To: <1466420541-20101-2-git-send-email-tn@semihalf.com>
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

Hi Tomasz,

Sorry for jumping out late, just one comment below.

On 2016/6/20 19:02, Tomasz Nowicki wrote:
> IORT shows representation of IO topology for ARM based systems.
> It describes how various components are connected together on
> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
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
>   final translation
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/Kconfig  |   3 +
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/bus.c    |   2 +
>  drivers/acpi/iort.c   | 220 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iort.h  |  30 +++++++

[...]

> +static acpi_status
> +iort_match_node_callback(struct acpi_iort_node *node, void *context)
> +{
> +	struct device *dev = context;
> +
> +	switch (node->type) {
> +	case ACPI_IORT_NODE_NAMED_COMPONENT: {
> +		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };

ACPI_ALLOCATE_BUFFER is used here, so ...

> +		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
> +		struct acpi_iort_named_component *ncomp;
> +
> +		if (!adev)
> +			break;
> +
> +		ncomp = (struct acpi_iort_named_component *)node->node_data;
> +
> +		if (ACPI_FAILURE(acpi_get_name(adev->handle,
> +					       ACPI_FULL_PATHNAME, &buffer))) {
> +			dev_warn(dev, "Can't get device full path name\n");
> +			break;
> +		}
> +
> +		if (!strcmp(ncomp->device_name, (char *)buffer.pointer))
> +			return AE_OK;

... we need to kfree(buffer.pointer) before we return or break.

With this fixed,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

> +
> +		break;
> +	}

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
