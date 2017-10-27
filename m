Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Gabriele Paoloni' <gabriele.paoloni@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v10 0/9] LPC: legacy ISA I/O support
Date: Fri, 27 Oct 2017 16:45:58 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00A6F5C@AcuExch.aculab.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "minyard@acm.org" <minyard@acm.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "john.garry@huawei.com" <john.garry@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "olof@lixom.net" <olof@lixom.net>,
 "brian.starkey@arm.com" <brian.starkey@arm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Gabriele Paoloni
> Sent: 27 October 2017 17:11
> This patchset supports the IPMI-bt device attached to the Low-Pin-Count
> interface implemented on Hisilicon Hip06/Hip07 SoC.
>                         -----------
>                         | LPC host|
>                         |         |
>                         -----------
>                              |
>                 _____________V_______________LPC
>                   |                       |
>                   V                       V
>                                      ------------
>                                      |  BT(ipmi)|
>                                      ------------
> 
> When master accesses those peripherals beneath the Hip06/Hip07 LPC, a specific
> LPC driver is needed to make LPC host generate the standard LPC I/O cycles with
> the target peripherals'I/O port addresses. But on curent arm64 world, there is
> no real I/O accesses. All the I/O operations through in/out accessors are based
> on MMIO ranges; on Hip06/Hip07 LPC the I/O accesses are performed through driver
> specific accessors rather than MMIO.
> To solve this issue and keep the relevant existing peripherals' drivers untouched,
> this patchset:
>    - introduces a generic I/O space management framework, LIBIO, to support I/O
>      operations on host controllers operating either on MMIO buses or on buses
>      requiring specific driver I/O accessors;
>    - redefines the in/out accessors to provide a unified interface for both MMIO
>      and driver specific I/O operations. Using LIBIO, th call of in/out() from
>      the host children drivers, such as ipmi-si, will be redirected to the
>      corresponding device-specific I/O hooks to perform the I/O accesses.
> 
>  Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC peripherals can
>  be supported without any changes on the existing ipmi-si driver.

FWIW my thoughts on this are WTF!

Looks to me horribly over complicated and over generalised.

Surely is it could be done the same way that x86 does IO cycles?
So you encode the information into the 'address' the driver passes
to ioread16() (etc) to allow it to do either a normal bus cycle or
the indirect cycle onto the external bus.

So you have one kernel option that makes these real functions.

	David


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
