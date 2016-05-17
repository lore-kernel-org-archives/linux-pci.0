Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [PATCH V7 07/11] pci, acpi: Handle ACPI companion assignment.
To: Dongdong Liu <liudongdong3@huawei.com>, helgaas@kernel.org,
 arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
 rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com,
 okaya@codeaurora.org, jchandra@broadcom.com
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <1462893601-8937-8-git-send-email-tn@semihalf.com>
 <573A8BED.7030908@huawei.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com,
 Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 dhdang@apm.com, jeremy.linton@arm.com, cov@codeaurora.org,
 Linuxarm <linuxarm@huawei.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <573B204F.9040001@semihalf.com>
Date: Tue, 17 May 2016 15:44:47 +0200
MIME-Version: 1.0
In-Reply-To: <573A8BED.7030908@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 17.05.2016 05:11, Dongdong Liu wrote:
> Hi Tomasz
>
> I used the patchset and added "PATCH V6 11/13 specic quirks", tested on
> HiSilicon D02 board but met the below problem.
>
> [    2.614115] [<ffffff80083b13bc>] hisi_pcie_init+0x6c/0x1ec
> [    2.619571] [<ffffff80083ab060>] pci_ecam_create+0x130/0x1ec
> [    2.625209] [<ffffff80083f3764>] pci_acpi_scan_root+0x160/0x218
> [    2.631096] [<ffffff80083d1f6c>] acpi_pci_root_add+0x36c/0x42c
> [    2.636897] [<ffffff80083ce36c>] acpi_bus_attach+0xe4/0x1a8
> [    2.642438] [<ffffff80083ce3d8>] acpi_bus_attach+0x150/0x1a8
> [    2.648066] [<ffffff80083ce3d8>] acpi_bus_attach+0x150/0x1a8
> [    2.653693] [<ffffff80083ce55c>] acpi_bus_scan+0x64/0x74
> [    2.658975] [<ffffff8008ae665c>] acpi_scan_init+0x5c/0x19c
> [    2.664429] [<ffffff8008ae6408>] acpi_init+0x280/0x2a4
> [    2.669538] [<ffffff80080829e8>] do_one_initcall+0x8c/0x19c
> [    2.675080] [<ffffff8008ac3af8>] kernel_init_freeable+0x14c/0x1ec
> [    2.681139] [<ffffff80087a8438>] kernel_init+0x10/0xfc
> [    2.686248] [<ffffff8008085e10>] ret_from_fork+0x10/0x40
>
> In hisi_pcie_init, I used "struct acpi_device *device =
> ACPI_COMPANION(dev);".
> I found the reason is V7 lack the below code. I added the below code, it
> worked ok.
>
> [PATCH V6 01/13] pci, acpi, x86, ia64: Move ACPI host bridge device
> companion assignment to core code.
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -564,6 +564,11 @@ static int acpi_pci_root_add(struct acpi_device
> *device,
>           }
>       }
>
> +    /*
> +     * pci_create_root_bus() needs to detect the parent device type,
> +     * so initialize its companion data accordingly.
> +     */
> +    ACPI_COMPANION_SET(&device->dev, device);
>
> This code will be upstreamed with the "PATCH V6 11/13 specic quirks" in
> next time after the patchset is accepted.
> Right ?

We had that patch in previous series to retrieve PCI domain nicely. But 
that has bad implication to userspace. See:
https://lkml.org/lkml/2016/5/9/918

I understand that:
[PATCH V6 01/13] pci, acpi, x86, ia64: Move ACPI host bridge device 
companion assignment to core code.
helps to get firmware specific info in hisi_pcie_init but we need to 
figure out something better for quirk handling too.

Tomasz
