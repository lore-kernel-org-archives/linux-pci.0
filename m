Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Daniel Axtens <dja@axtens.net>
To: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/3] Split VGA default device handler out of VGA arbiter
In-Reply-To: <20170805065754.GA8509@wunner.de>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-3-dja@axtens.net> <20170805065754.GA8509@wunner.de>
Date: Mon, 07 Aug 2017 09:49:24 +1000
Message-ID: <87zibcqmt7.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, gabriele.paoloni@huawei.com, airlied@linux.ie,
 linux-pci@vger.kernel.org, will.deacon@arm.com,
 dri-devel@lists.freedesktop.org, z.liuxinliang@hisilicon.com,
 bhelgaas@google.com, alex.williamson@redhat.com, benh@kernel.crashing.org,
 zourongrong@gmail.com, daniel.vetter@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lukas,

Let me reply "back-to-front":

> Please cc dri-devel when proposing changes to vgaarb.c (see
> MAINTAINERS).

Sorry, will do in future.

> I'm missing some context as to the negative consequences you're
> experiencing on other arches (the cover letter merely refers to
> "quirks in ppc and concerns in arm land" and is missing links to
> archived versions of v1 and v2), but clearly legacy resources are
> x86-specific so any code dealing with them seems superfluous on
> other arches and should be marked as such.

Quirk/v1: https://www.spinics.net/lists/linux-pci/msg62865.html
Approach 2: https://www.spinics.net/lists/linux-pci/msg63092.html
            https://www.spinics.net/lists/linux-pci/msg63083.html

The quirk in powerpc land that I'm referring to is
arch/powerpc/kernel/pci-common.c::fixup_vga() which is a class enable
hook that marks the first VGA device it comes across as default if the
arbiter has not marked one.

The arm concerns are ventaliated in the threads I linked - they boil
down to "why do we need the arbiter at all on platforms without legacy
resources? Can't we do this more simply?"

> Would it be feasible to just sprinkle some "if (IS_ENABLED(CONFIG_X86))"
> over the portions of vgaarb.c that deal with legacy resources?

Yes and no. That would disable the unnecessary chunks of the VGA
arbiter, but we then still have to figure out how to mark devices as
default if not with the arbiter.

Regards,
Daniel

>
> Thanks,
>
> Lukas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
