Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V6 11/13] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
To: "liudongdong (C)" <liudongdong3@huawei.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-12-git-send-email-tn@semihalf.com>
 <5714C6F6.8050600@huawei.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <5714D165.4020606@semihalf.com>
Date: Mon, 18 Apr 2016 14:21:57 +0200
MIME-Version: 1.0
In-Reply-To: <5714C6F6.8050600@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18.04.2016 13:37, liudongdong (C) wrote:
> Hi Tomasz
>
> I merged my patchset to branch topci-acpi-v6.
> The patchset is used for Hisilicon DO2 PCIe ACPI support.
> I found some compile errors. The log as below.
> drivers/pci/host/pcie-hisi-acpi.c: In function 'hisi_pcie_init':
> drivers/pci/host/pcie-hisi-acpi.c:130:6: error: 'struct acpi_pci_root'
> has no member named 'sysdata'
>    root->sysdata = reg_base;
>
> In your PATCH V5, add "sysdata" for strcut acpi_pci_root, but PATCH V6
> has not add it.
> In my patch, I used root->sysdata which will be available along
> read/write accessor.
> I want to know the reason this v6 patchset does not add "sysdata". I
> need this.

We are handling this different way. You can now use "struct 
pci_config_window" -> priv, see pci-thunder-pem.c driver.

Tomasz
