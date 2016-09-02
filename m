Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
Subject: Re: [RFC PATCH V2 1/3] PCI: hisi: re-architect Hip05/Hip06
 controllers driver to preapare for ACPI
To: Arnd Bergmann <arnd@arndb.de>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com>
 <5913196.I3zIbc2qla@wuerfel> <57C822C1.9000203@huawei.com>
 <6532722.cVEMfv9Kqj@wuerfel>
CC: <helgaas@kernel.org>, <rafael@kernel.org>, <Lorenzo.Pieralisi@arm.com>,
        <tn@semihalf.com>, <wangzhou1@hisilicon.com>,
        <pratyush.anand@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jcm@redhat.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <hanjun.guo@linaro.org>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <57C8DDBD.5070103@huawei.com>
Date: Fri, 2 Sep 2016 10:02:37 +0800
MIME-Version: 1.0
In-Reply-To: <6532722.cVEMfv9Kqj@wuerfel>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

在 2016/9/1 22:02, Arnd Bergmann 写道:
>
>> 2. We need to backward compatible with the old dt way config access as below code,
>> so we have to call hisi_pcie_common_cfg_read() when accessing the RC config space.
>> For this, we have to call hisi_pcie_common_cfg_read().
>>
>> drivers/pci/host/pcie-hisi.c
>> static inline int hisi_pcie_cfg_read(struct pcie_port *pp, int where,
>> 		int size, u32 *val)
>> {
>> 	struct hisi_pcie *pcie = to_hisi_pcie(pp);
>>
>> 	return hisi_pcie_common_cfg_read(pcie->reg_base, where, size, val);
>> }
>>
>> static struct pcie_host_ops hisi_pcie_host_ops = {
>> 	.rd_own_conf = hisi_pcie_cfg_read,
>> 	.wr_own_conf = hisi_pcie_cfg_write,
>> 	.link_up = hisi_pcie_link_up,
>> };
>
> I think this would be easier if you separate the ACPI code from the
> DT code and not try to have a common file used for both.
>
> Sharing the config space accessors really isn't worth it when both
> variants are fairly simple to do, but they don't fit in a common
> model because one is called from the ACPI quirks and the other
> is called from the dw-pcie driver with completely different calling
> conventions.

I agree, many thanks.

Thanks
Dongdong
>
> 	ARnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>
