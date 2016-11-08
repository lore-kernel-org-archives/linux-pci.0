Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        gabriele.paoloni@huawei.com, benh@kernel.crashing.org,
        will.deacon@arm.com, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, xuwei5@hisilicon.com,
        linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, minyard@acm.org, marc.zyngier@arm.com,
        liviu.dudau@arm.com, john.garry@huawei.com, olof@lixom.net,
        robh+dt@kernel.org, bhelgaas@google.com, kantyzc@163.com,
        zhichang.yuan02@gmail.com, linux-kernel@vger.kernel.org,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>, zourongrong@gmail.com
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
Date: Tue, 08 Nov 2016 17:15:24 +0100
Message-ID: <36115245.zHVRydMfpb@wuerfel>
In-Reply-To: <13493313.OkuDZEY5WO@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <20161108120323.GC15297@leverpostej> <13493313.OkuDZEY5WO@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, November 8, 2016 5:09:59 PM CET Arnd Bergmann wrote:
> 
> I don't see a better alternative. I earlier suggested having these
> out of line so we don't grow the object code too much when it is
> enabled.
> 

On second look, I see that they are all done out of line, I would
just move around the BUILD_EXTIO macro to the file that uses it
and remove and open-code the DECLARE_EXTIO() as that makes it easier
to grep.

	Arnd
