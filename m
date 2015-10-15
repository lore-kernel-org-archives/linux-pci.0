Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <561F64CA.7060606@hisilicon.com>
Date: Thu, 15 Oct 2015 16:33:14 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>,
	"Wangkefeng (Kevin)" <wangkefeng.wang@huawei.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	qiujiang <qiujiang@huawei.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"gabriel.fernandez@linaro.org" <gabriel.fernandez@linaro.org>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"jason@lakedaemon.net" <jason@lakedaemon.net>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: Re: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com> <30775300.COZ4nEMWXC@wuerfel> <561E23EB.7050504@hisilicon.com> <5572871.GecUyqk59W@wuerfel>
In-Reply-To: <5572871.GecUyqk59W@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/15 5:56, Arnd Bergmann wrote:
> On Wednesday 14 October 2015 17:44:11 Zhou Wang wrote:
>> On 2015/10/14 17:06, Arnd Bergmann wrote:
>>> On Wednesday 14 October 2015 16:59:03 Zhou Wang wrote:
>>>>
>>>> Hi Arnd,
>>>>
>>>> In Hip05 PCIe host, it uses GITS_TRANSLATER's address to get TLP package
>>>> which contains MSI address and MSI data, and then combine BDF and MSI data
>>>> to a 32 bit data which will be writen to GITS_TRANSLATER register of ITS.
>>>>
>>>> I think maybe this is a defect of our PCIe controller.
>>>
>>> I'd consider it a bug in the firmware if this is not set up correctly
>>> before boot.
>>>
>>>>> I don't think what you do here is safe because the 'reg' property
>>>>> of the MSI controller might point to the address that is used for
>>>>> the message directly.
>>>>
>>>> I see your point, however we must get address of GITS_TRANSLATER and
>>>> set it to PCIe host. How about adding necessary comments here?
>>>
>>> This seems to just be static setup that should be done before Linux
>>> is even loaded. Any reason you can't do it that way?
>>>
>>
>> There are some ITSs in Hip05-D02 platform, in fact, we can use any of them
>> as a msi-controller,  which we can configure in dts. I am afraid that
>> hard-setting the value in BIOS would lead to restrictions in terms of flexibility,
>> as with the current implementation the same BIOS-driver can fit different
>> DTS structures.
> 
> The dtb generally should be expected to match whatever the firmware sets up,
> so if there is one reasonable setting here, I see no problem with hardcoding
> it that way. In particular on server systems, we usually expect the firmware
> to configure almost everything in advance and just tell us how it is
> configured, while on embedded systems we can't trust the bootload and
> usually set it all up in the kernel from scratch.
>

I see your point. Actually in order to support platforms without PCIe configuration
support BIOS we planned to have a further commit once the driver was upstreamed,
where we check if the link is already up, if not we would configure it in the kernel,
otherwise we would return silently.

Now about this patchset we can remove GITS_TRANSLATER address setting and do this
in BIOS together with link-up setup; then in the next commit for supporting platforms
without PCIe setup in UEFI, we can add this part back where we first check
if the link is already up (we can assume that if BIOS has configured link-up,
it has also setup the msi-parent address), if the link is up we skip reading
msi-parent address.

> What would be a reason to pick one ITS over another?

In fact, we set PCIe host and ITS binding in dts. I mean that PCIe host can
bind to any ITS nodes in system.

> 
> On a related note, don't you also need to describe in DT how PCI B/D/F
> function numbers get turned into addresses in the ITS? Does that also
> require configuration in the driver? I see this code here:

We don't need to describe this. we need only describe the relationship between
PCIe host and ITS, PCIe host will service PCIe devices which are connected to it.

> 
> 
> +       hisi_pcie_apb_writel(pcie, PCIE_MSI_ASID_ENABLE | PCIE_MSI_ASID_VALUE,
> +                            PCIE_SLV_MSI_ASID);
> +       hisi_pcie_apb_writel(pcie, PCIE_MSI_TRANS_ENABLE, PCIE_MSI_TRANS_REG);
> +       hisi_pcie_change_apb_mode(pcie, PCIE_SLV_DBI_MODE);
>

This code is to enable MSI support in PCIe host.

> plus all of hisi_pcie_config_context(). This looks like it will change
> the way the MSI is interpreted. This also seems like something that
> could be done in the firmware in advance, and just get reported in DT.

I think all hisi_pcie_config_context can be move to BIOS for this patchset,
however in order to support other BIOSs which have no PCIe setup we would plan
a future commit adding this back and working as explained above.

Thanks,
Zhou

> 
> 	Arnd
> 
> .
> 


