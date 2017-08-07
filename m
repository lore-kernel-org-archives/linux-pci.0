Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] powerpc: replace vga_fixup() with generic code
In-Reply-To: <20170804102033.27731-4-dja@axtens.net>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-4-dja@axtens.net>
Date: Mon, 07 Aug 2017 17:18:12 +1000
Message-ID: <87efsnq217.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: gabriele.paoloni@huawei.com, airlied@linux.ie, catalin.marinas@arm.com,
 will.deacon@arm.com, z.liuxinliang@hisilicon.com, bhelgaas@google.com,
 alex.williamson@redhat.com, zourongrong@gmail.com,
 Brian King <brking@linux.vnet.ibm.com>, daniel.vetter@intel.com,
 Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Daniel Axtens <dja@axtens.net> writes:

> Currently, we do a PCI fixup to mark a default card so that Xorg
> autoconfiguration works.
>
> There is a new generic method to do this sort of vga fixup, and
> it occurs by default.
>
> Drop our old method.
>
> This method is different:
>  - it will only mark a card as default if a driver is bound
>  - the marking will happen at late_initcall time, or even later
>    if a card is enabled later on (via an ENABLE hook). Currently
>    things are enabled in a FINAL hook.
>
> This *does* change behaviour under some circumstances.
>
> For example, pseries_le_defconfig doesn't have DRM drivers for
> many of the qemu GPU models, including the 'standard' vga.

Should we enable them/it?

cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
