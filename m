Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
To: Kishon Vijay Abraham I <kishon@ti.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han
 <jingoohan1@gmail.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com> <58BE42B2.20305@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <02461be2-268d-485a-2bc4-3b148726d37d@synopsys.com>
Date: Tue, 7 Mar 2017 11:10:09 +0000
MIME-Version: 1.0
In-Reply-To: <58BE42B2.20305@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


Hi Kishon,

=C0s 5:18 AM de 3/7/2017, Kishon Vijay Abraham I escreveu:
> Hi Joao,
> =

> On Friday 17 February 2017 10:50 PM, Joao Pinto wrote:
>> =C0s 9:50 AM de 2/17/2017, Kishon Vijay Abraham I escreveu:
>>> Add endpoint mode support to designware driver. This uses the
>>> EP Core layer introduced recently to add endpoint mode support.
>>> *Any* function driver can now use this designware device
>>> in order to achieve the EP functionality.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  drivers/pci/dwc/Kconfig              |    5 +
>>>  drivers/pci/dwc/Makefile             |    1 +
>>>  drivers/pci/dwc/pcie-designware-ep.c |  342 ++++++++++++++++++++++++++=
++++++++
>>>  drivers/pci/dwc/pcie-designware.c    |   51 +++++
>>>  drivers/pci/dwc/pcie-designware.h    |   72 +++++++
>>>  5 files changed, 471 insertions(+)
>>>  create mode 100644 drivers/pci/dwc/pcie-designware-ep.c
>>>
> =

> <snip>
> =

>>> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-d=
esignware.c
>>> index 686945d..49b28c8 100644
>>> --- a/drivers/pci/dwc/pcie-designware.c
>>> +++ b/drivers/pci/dwc/pcie-designware.c
>>> @@ -173,6 +173,57 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci=
, int index, int type,
>>>  	dev_err(pci->dev, "iATU is not being enabled\n");
>>>  }
>>>  =

>>> +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
>>> +			     u64 cpu_addr, enum dw_pcie_as_type as_type)
>>> +{
>>> +	int type;
>>> +	void __iomem *base =3D pci->dbi_base;
>>> +
>>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
>>> +			  PCIE_ATU_REGION_INBOUND | index);
>>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
>>> +			  lower_32_bits(cpu_addr));
>>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
>>> +			  upper_32_bits(cpu_addr));
>>> +
>>> +	switch (as_type) {
>>> +	case DW_PCIE_AS_MEM:
>>> +		type =3D PCIE_ATU_TYPE_MEM;
>>> +		break;
>>> +	case DW_PCIE_AS_IO:
>>> +		type =3D PCIE_ATU_TYPE_IO;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
>>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4, PCIE_ATU_ENABLE |
>>> +			  PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
>>> +	return 0;
>>> +}
>>> +
>>
>> This Atu programming is for PCI Cores <=3D 4.70. Please follow the same =
approach as:
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_cg=
it_linux_kernel_git_helgaas_pci.git_tree_drivers_pci_dwc_pcie-2Ddesignware.=
c-3Fh-3Dpci_host-2Ddesignware-23n95&d=3DDwID-g&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=
=3Ds2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=3DMqqHFJBR0jj9ZQILcUJEd-CQ=
kTihuOSf69e-XxZJvRs&s=3DfY5N7Mt9iszsAI04DPm-cSC6cSE5P2axHUFQ9GOx-2A&e=3D =

> =

> Can you provide PCIE_GET_ATU_INB_UNR_REG_OFFSET (similar to
> PCIE_GET_ATU_OUTB_UNR_REG_OFFSET)?

Yes of course, I will send you the definition soon.

Thanks,
Joao

> =

> Thanks
> Kishon
> =



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
