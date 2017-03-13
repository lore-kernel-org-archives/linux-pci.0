Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, rafael@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        lorenzo.pieralisi@arm.com, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org, minyard@acm.org, liviu.dudau@arm.com,
        zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com
Subject: Re: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices whose  dependency has not met
Date: Mon, 13 Mar 2017 22:24:34 +0100
Message-ID: <4600523.rWNiWKrYZC@aspire.rjw.lan>
In-Reply-To: <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com> <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, March 13, 2017 10:42:41 AM zhichang.yuan wrote:
> In commit 40e7fcb1929(ACPI: Add _DEP support to fix battery issue on Asus
> T100TA), the '_DEP' was supported to solve the dependency of Asus battery. But
> this patch is specific to Asus battery device.
> In the real world, there are other devices which need the dependency to play the
> role on the enumeration order. For example, all the Hip06 LPC
> periperals(IPMI-BT, uart, etc) must be scanned after the LPC host driver
> finished the probing. So, it makes sense to add a checking whether the ACPI
> device meet all the dependencies during its enumeration slot, if not, the
> enumeration will be delayed till all dependency master finish their work.
> 
> This patch adds the dependency checking in ACPI enumeration, also the
> corresponding handling to retrigger the Hip06 LPC peripherals' scanning.

AFAICS, _DEP is generally abused in the wild and cannot be made generic.  Sorry.

Thanks,
Rafael

