Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il> <20180912231050.GX30658@n2100.armlinux.org.uk>
From: Baruch Siach <baruch@tkos.co.il>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
In-reply-to: <20180912231050.GX30658@n2100.armlinux.org.uk>
Date: Thu, 13 Sep 2018 06:19:54 +0300
Message-ID: <87y3c63wyt.fsf@tkos.co.il>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jan =?utf-8?Q?Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Russell,

Russell King - ARM Linux writes:
> On Wed, Sep 12, 2018 at 09:49:41PM +0300, Baruch Siach wrote:
>> I reproduced the same Oops on Clearfog Base without any taint:
>> 
>> [    1.476401] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
> ...
>> [    1.855954] Code: e2844004 e5972000 e3520000 0affffee (e7f001f2)
>
> That is a BUG().  Please turn on verbose bug reporting to get more
> information about the cause.
>
> There are two possibilities:
>
>         BUG_ON(addr >= end);
>
> and
>
>                 BUG_ON(!pte_none(*pte));
>
> It's probably the latter - the region is probably already mapped, that
> being the PCI IO region.

That is the one. Enabling CONFIG_DEBUG_BUGVERBOSE shows:

[    1.481927] kernel BUG at lib/ioremap.c:72!
[    1.486118] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    1.491269] CPU: 0 PID: 1246 Comm: kworker/0:2 Not tainted 4.19.0-rc3 #146
...

baruch

> The original driver was setup to call pci_ioremap_io() as the very
> last thing - and as the driver is non-removable, we were guaranteed
> to never tear down this mapping (which is sensible, it's published
> to userspace.)
>
> However, the current code calls pci_ioremap_io() much earlier, in
> a path where probe failures can occur.  This breaks pci_ioremap_io()'s
> requirements - it must not be called more than once.  So:
>
> ee1604381a37 ("PCI: mvebu: Only remap I/O space if configured")
>
> is basically incorrect - pci_ioremap_io() needs to move back to a
> place where it is only called in a path which will never fail.
> However, looking at the generic host bits, I'm not sure such a place
> exists in the new effort to make stuff more generic.

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
