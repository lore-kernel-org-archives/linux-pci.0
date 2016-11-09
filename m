Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
Date: Wed, 09 Nov 2016 22:33:17 +0100
Message-ID: <2939462.W2yy62pjEE@wuerfel>
In-Reply-To: <6dee9821-5145-2113-e391-6317e4533c06@huawei.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <2479288.4UmF9SBrq1@wuerfel>
 <6dee9821-5145-2113-e391-6317e4533c06@huawei.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, gabriele.paoloni@huawei.com,
 linux-pci@vger.kernel.org, liviu.dudau@arm.com, linuxarm@huawei.com,
 lorenzo.pieralisi@arm.com, xuwei5@hisilicon.com, linux-serial@vger.kernel.org,
 benh@kernel.crashing.org, devicetree@vger.kernel.org, minyard@acm.org,
 Will Deacon <will.deacon@arm.com>, John Garry <john.garry@huawei.com>,
 olof@lixom.net, robh+dt@kernel.org, bhelgaas@google.com, kantyzc@163.com,
 zhichang.yuan02@gmail.com, linux-kernel@vger.kernel.org,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>, zourongrong@gmail.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 9, 2016 11:29:46 AM CET John Garry wrote:
> On 08/11/2016 22:35, Arnd Bergmann wrote:
> > On Tuesday, November 8, 2016 4:49:49 PM CET Will Deacon wrote:
> >> On Tue, Nov 08, 2016 at 04:33:44PM +0000, John Garry wrote:
> >>> On 08/11/2016 16:12, Will Deacon wrote:
> >>>> On Tue, Nov 08, 2016 at 11:47:07AM +0800, zhichang.yuan wrote:
> >
> >>>> Is there no way to make this slightly more generic, so that it can be
> >>>> re-used elsewhere? For example, if struct extio_ops was common, then
> >>>> you could have the singleton (which maybe should be an interval tree?),
> >>>> type definition, setter function and the BUILD_EXTIO invocations
> >>>> somewhere generic, rather than squirelled away in the arch backend.
> >>>>
> >>> The concern would be that some architecture which uses generic higher-level
> >>> ISA accessor ops, but have IO space, could be affected.
> >>
> >> You're already adding a Kconfig symbol for this stuff, so you can keep
> >> that if you don't want it on other architectures. I'm just arguing that
> >> plumbing drivers directly into arch code via arm64_set_extops is not
> >> something I'm particularly fond of, especially when it looks like it
> >> could be avoided with a small amount of effort.
> >
> > Agreed, I initially suggested putting this into arch/arm64/, but there isn't
> > really a reason why it couldn't just live in lib/ with the header file
> > bits moved to include/asm-generic/io.h which we already use.
> >
> 
> Right, Zhichang will check the logistics of this. The generic io.h is 
> quite clean, so as long as you don't mind new build switches of this 
> nature being added, it should be ok; and we'll plan on moving extio.h 
> into include/asm-generic as well.

I think all we need is an #ifdef CONFIG_something around the existing
defintion, with the alternative being "extern" declarations, after that
all the interesting logic can sit in a file in lib/.

	Arnd


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
