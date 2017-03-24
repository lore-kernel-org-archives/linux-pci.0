Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>, Arnd Bergmann
 <arnd@arndb.de>, Yuanzhichang <yuanzhichang@hisilicon.com>
Subject: RE: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices whose
 dependency has not met
Date: Fri, 24 Mar 2017 00:23:55 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E204B678C@FRAEML521-MBX.china.huawei.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
 <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
 <4600523.rWNiWKrYZC@aspire.rjw.lan> <58C9F6C6.4090700@hisilicon.com>
 <CAK8P3a2QZ_j9RQ0U=4MoAAcRcZyu0L5AiYM22QZkiRxh7Ca-iA@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E20492A4C@FRAEML521-MBX.china.huawei.com>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E20492A4C@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linuxarm <linuxarm@huawei.com>, Frank Rowand <frowand.list@gmail.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Corey Minyard <minyard@acm.org>, "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
 "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "kantyzc@163.com" <kantyzc@163.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-pci <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Zou Rongrong <zourongrong@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

> -----Original Message-----
> From: linuxarm-bounces@huawei.com [mailto:linuxarm-bounces@huawei.com]
> On Behalf Of Gabriele Paoloni
> Sent: 16 March 2017 16:14
> To: Arnd Bergmann; Yuanzhichang
> Cc: Mark Rutland; Benjamin Herrenschmidt; Rafael Wysocki; linux-pci;
> Will Deacon; Linuxarm; Frank Rowand; Lorenzo Pieralisi; ACPI Devel
> Maling List; linux-serial@vger.kernel.org; Catalin Marinas;
> devicetree@vger.kernel.org; Corey Minyard; liviu.dudau@arm.com; Rob
> Herring; Bjorn Helgaas; kantyzc@163.com; zhichang.yuan02@gmail.com;
> Linux ARM; Rafael J. Wysocki; Linux Kernel Mailing List; Zou Rongrong
> Subject: RE: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices
> whose dependency has not met
> 
> Hi Arnd
> 
> > -----Original Message-----
> > From: arndbergmann@gmail.com [mailto:arndbergmann@gmail.com] On
> Behalf
> > Of Arnd Bergmann
> > Sent: 16 March 2017 10:13
> > To: Yuanzhichang
> > Cc: Rafael J. Wysocki; Catalin Marinas; Will Deacon; Rob Herring;
> Frank
> > Rowand; Bjorn Helgaas; Rafael Wysocki; Mark Rutland; Linux ARM; ACPI
> > Devel Maling List; Lorenzo Pieralisi; Benjamin Herrenschmidt; Linux
> > Kernel Mailing List; Linuxarm; devicetree@vger.kernel.org; linux-pci;
> > linux-serial@vger.kernel.org; Corey Minyard; liviu.dudau@arm.com; Zou
> > Rongrong; John Garry; Gabriele Paoloni; zhichang.yuan02@gmail.com;
> > kantyzc@163.com; xuwei (O)
> > Subject: Re: [PATCH V7 5/7] ACPI: Delay the enumeration on the
> devices
> > whose dependency has not met
> >
> > On Thu, Mar 16, 2017 at 3:21 AM, zhichang.yuan
> > <yuanzhichang@hisilicon.com> wrote:
> > > Hi, Rafael,
> > >
> > > Thanks for your review!
> > >
> > > On 2017/3/14 5:24, Rafael J. Wysocki wrote:
> > >> On Monday, March 13, 2017 10:42:41 AM zhichang.yuan wrote:
> > >>> In commit 40e7fcb1929(ACPI: Add _DEP support to fix battery issue
> > on Asus
> > >>> T100TA), the '_DEP' was supported to solve the dependency of Asus
> > battery. But
> > >>> this patch is specific to Asus battery device.
> > >>> In the real world, there are other devices which need the
> > dependency to play the
> > >>> role on the enumeration order. For example, all the Hip06 LPC
> > >>> periperals(IPMI-BT, uart, etc) must be scanned after the LPC host
> > driver
> > >>> finished the probing. So, it makes sense to add a checking
> whether
> > the ACPI
> > >>> device meet all the dependencies during its enumeration slot, if
> > not, the
> > >>> enumeration will be delayed till all dependency master finish
> their
> > work.
> > >>>
> > >>> This patch adds the dependency checking in ACPI enumeration, also
> > the
> > >>> corresponding handling to retrigger the Hip06 LPC peripherals'
> > scanning.
> > >>
> > >> AFAICS, _DEP is generally abused in the wild and cannot be made
> > generic.  Sorry.
> > >>
> > >
> > > From the ACPI specification, _DEP is for operation region accesses.
> > > You are right...
> > >
> > > How about we add a ACPI handler for our LPC bus?? Just like amba.
> > > In this way, we also can solve the issue about LPC enumeration
> order.
> >
> > As far as I can tell, PCI and LPC have exactly the same requirement
> > here,
> > so whatever you end up doing for one should be used for the other as
> > well.
> 
> Well as you know PCI has got his own handler, identified by his own
> namespace id "PNP0A03".
> Now when you say "you end up doing for one should be used for the
> other"
> are you saying that we should introduce a new class of devices?
> i.e. should we have an ACPI namespace identifier for non-PCI IO Host
> Controllers?
> 
> Otherwise, if my understanding is correct, having a specific new ACPI
> handler for HiSilicon LPC would mean to adding another function_init()
> in the list of acpi handlers inits in acpi_scan_init().
> 
> But then every vendor would declare his own one...is this really
> correct?

Do you have any feedback on this?

Otherwise I think that maybe we could consider moving back to the
arch_initcall approach as proposed in V6:
https://lkml.org/lkml/2017/1/24/28

Thanks
Gab

> 
> Many Thanks
> Gab
> 
> >
> >       Arnd
> _______________________________________________
> linuxarm mailing list
> linuxarm@huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
