Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, arnd@arndb.de, rafael@kernel.org, Lorenzo.Pieralisi@arm.com, tn@semihalf.com, wangzhou1@hisilicon.com, pratyush.anand@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com, gabriele.paoloni@huawei.com, charles.chenxin@huawei.com, hanjun.guo@linaro.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH V2 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers
Date: Thu, 01 Sep 2016 00:56:33 +0200
Message-ID: <2194589.LrAdKSkzcT@vostro.rjw.lan>
In-Reply-To: <1472644094-82731-4-git-send-email-liudongdong3@huawei.com>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com> <1472644094-82731-4-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 31, 2016 07:48:14 PM Dongdong Liu wrote:
> Add specific quirks for PCI config space accessors.This involves:
> 1. New initialization call hisi_pcie_acpi_init() to get RC config resource
> with hardcoded range address and setup ecam mapping.
> 2. New entry in common quirk array.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Well, what exactly is the ACPI support you're adding?  Is it the ECAM part only
or is there anything more to it?

Thanks,
Rafael
