Return-Path: <SRS0=fJCO=GD=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=fJCO=GD=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 13 Mar 2018 11:42:31 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linuxarm@huawei.com, charles.chenxin@huawei.com,
	linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH] ARM64/PCI: Set dev->irq=0 before calling
 acpi_pci_irq_enable()
Message-ID: <20180313114231.GA11786@red-moon>
References: <1520650692-62705-1-git-send-email-liudongdong3@huawei.com>
 <20180313001830.GA60197@bhelgaas-glaptop.roam.corp.google.com>
 <f5d23376-42d1-7fec-dc1c-45e419acb678@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f5d23376-42d1-7fec-dc1c-45e419acb678@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 13, 2018 at 07:20:10PM +0800, Dongdong Liu wrote:

[...]

> >It sounds like you're saying HIP07 doesn't provide _PRT?  Per the PCI
> >Firmware Spec, r3.0, sec 4.4, _PRT is required under all PCI host
> >bridges.  So I think you're saying HIP07 doesn't comply with the spec,
> 
> Yes, It does not support to use _PRT on the Hip07.

Hip07 firmware will be updated to support _PRT because that's what
the ACPI specifications enforce.

Thanks,
Lorenzo
