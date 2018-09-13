Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 13 Sep 2018 18:38:40 +0100
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: io: Fix ioport_map() for
 !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
Message-ID: <20180913173840.GB20290@arm.com>
References: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
 <CAK8P3a27Qx=A9zNheYNF2oZaRUQm-4h_8nPUF2xTdL+kqFrV5g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a27Qx=A9zNheYNF2oZaRUQm-4h_8nPUF2xTdL+kqFrV5g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, jean-philippe.brucker@arm.com,
 dann.frazier@canonical.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 andrew.murray@arm.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 13, 2018 at 04:00:54PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 13, 2018 at 2:48 PM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
> > prevent users from making I/O accesses outside the expected I/O range -
> > however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
> > contradictory to its other users.
> >
> > The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
> > amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
> > mangling the given port rather than capping it.
> >
> > We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
> > implementation of ioport_map by using the comparison operator and
> > returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
> > we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
> > we don't break existing buggy drivers that somehow rely on this masking.
> >
> > Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
> > Reported-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> 
> Looks good to me,
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Can you take this through the arm64 tree?

Yup, I'll queue it up as a fix.

Cheers,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
