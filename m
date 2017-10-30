Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: David Laight <David.Laight@ACULAB.COM>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "frowand.list@gmail.com"
 <frowand.list@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v10 0/9] LPC: legacy ISA I/O support
Date: Mon, 30 Oct 2017 11:32:14 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CAE73B@FRAEML521-MBX.china.huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <063D6719AE5E284EB5DD2968C1650D6DD00A6F5C@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00A6F5C@AcuExch.aculab.com>
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
 John Garry <john.garry@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "olof@lixom.net" <olof@lixom.net>,
 "brian.starkey@arm.com" <brian.starkey@arm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi David

[...]

> FWIW my thoughts on this are WTF!
> 
> Looks to me horribly over complicated and over generalised.
> 
> Surely is it could be done the same way that x86 does IO cycles?

No

> So you encode the information into the 'address' the driver passes
> to ioread16() (etc) to allow it to do either a normal bus cycle or
> the indirect cycle onto the external bus.

In order to do that you need to have a special PCI bridge that is able
to detect the special IO addresses and initiate such special IO cycles
on the external bus. This is not supported by our HW (and this why
we need the LPC accessors)

Gab

> 
> So you have one kernel option that makes these real functions.
> 
> 	David


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
