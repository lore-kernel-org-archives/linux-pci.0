Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26073 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752894AbeA3Qpn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 11:45:43 -0500
Date: Tue, 30 Jan 2018 09:45:42 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mj@ucw.cz" <mj@ucw.cz>
Subject: Re: [PATCH] Fix Vector table and PBA addresses print output
Message-ID: <20180130094542.1457e2fd@w520.home>
In-Reply-To: <80372960-864f-0f7d-db04-c2cb49631f63@synopsys.com>
References: <998ca55d1a2b9a7f6912dcff69bc57d31b690fb0.1517308416.git.gustavo.pimentel@synopsys.com>
        <20180130070718.335deb52@w520.home>
        <80372960-864f-0f7d-db04-c2cb49631f63@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 30 Jan 2018 16:08:07 +0000
Gustavo Pimentel <gustavo.pimentel@synopsys.com> wrote:

> Hi Alex,
> 
> On 30/01/2018 14:07, Alex Williamson wrote:
> > On Tue, 30 Jan 2018 10:34:08 +0000
> > Gustavo Pimentel <gustavo.pimentel@synopsys.com> wrote:
> >   
> >> Lack of 3-bit rotation to the right was leading to erroneous display of the
> >> vector table and PBA.
> >>
> >> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> >> ---
> >>  ls-caps.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/ls-caps.c b/ls-caps.c
> >> index 507771a..cd13a37 100644
> >> --- a/ls-caps.c
> >> +++ b/ls-caps.c
> >> @@ -1104,10 +1104,10 @@ cap_msix(struct device *d, int where, int cap)
> >>  
> >>    off = get_conf_long(d, where + PCI_MSIX_TABLE);
> >>    printf("\t\tVector table: BAR=%d offset=%08x\n",
> >> -	 off & PCI_MSIX_BIR, off & ~PCI_MSIX_BIR);
> >> +	 off & PCI_MSIX_BIR, (off & ~PCI_MSIX_BIR) >> 3);
> >>    off = get_conf_long(d, where + PCI_MSIX_PBA);
> >>    printf("\t\tPBA: BAR=%d offset=%08x\n",
> >> -	 off & PCI_MSIX_BIR, off & ~PCI_MSIX_BIR);
> >> +	 off & PCI_MSIX_BIR, (off & ~PCI_MSIX_BIR) >> 3);
> >>  }
> >>  
> >>  static void  
> > 
> > 
> > The code is correct as is, the register contains bits 31:3 of the
> > offset.  The spec states (PCI rev 3.0, 6.8.2.4, 6.8.2.5):  
> 
> I have just downloaded now the rev 3.0 (PCI_Express_Base_r3.0_10Nov10.pdf,
> November 10, 2010) from PCI-SIG and the chapters that you refer don't match with
> the downloaded version, can you confirm the doc date?

I'm referencing the PCI Local Bus Specification Rev 3.0, Feb 3, 2004.
MSI-X is compatible between PCI and PCIe, in fact my copy of the PCIe
3.1a spec refers to the PCI spec for these registers.

> > 
> >   The lower 3 Table BIR bits are masked off (set to zero) by software
> >   to form a 32-bit QWORD -aligned offset.
> > 
> >   The lower 3 PBA BIR bits are masked off (set to zero) by software to
> >   form a 32-bit QWORD-aligned offset.
> >  
> 
> Yes, I understand the meaning but for the user the value printed should not
> include (in my perspective) the offset provide by the Table BIR field or the PBA
> BIR field.

The offset is the value with the BIR field masked, shifting the value
results in the (offset/8), which is not a useful thing.
 
> > Shifting is incorrect, the mask operation fills the lower 3 bits.  
> The spec defines:
>        | 31         24 | 23         16 | 15         8 | 7        3 | 2     0 |
>   +00h |           Msg Ctrl Reg        |    PNext ID  |       CapID          |
>   +04h |                        Table offset                       | Tb BIR  |
>   +08h |                        PBA offset                         | PBA BIR |
>   +0Ch |            Reserved           |         Msg Data Reg                |
> 
> Let's apply a real example here, using the info from config space:
>        | 31         24 | 23         16 | 15         8 | 7                  0 |
> 0b+00h |      00       |      20       |      00      |         11           |
> 0b+04h |      00       |      00       |      00      |         00           |
> 0b+08h |      00       |      00       |      18      |         00           |
> 0b+0Ch |      00       |      00       |      00      |         00           |
> 
> If I decode manually the info from config space, I get for each field the
> following value:
> 
> Msg Ctrl Reg = 0x20
> PNext ID = 0x0
> CapID = 0x11
> Table offset = 0x0
> Table BIR = 0x0
> Table offset = 0x300

Correction, Table offset[31:3] = 0x300, the actual offset is 0x1800

> Table BIR = 0x0
> Msg Data Reg = 0x0
> 
> Using lspci, I get:
> ...
>     Capabilities: [b0] MSI-X: Enable+ Count=33 Masked-
>         Vector table: BAR=0 offset=00000000
>         PBA: BAR=0 offset=00001800

Which is correct

> ...
> In my perspective should be like:
> 
>     Capabilities: [b0] MSI-X: Enable+ Count=33 Masked-
>         Vector table: BAR=0 offset=00000000
>         PBA: BAR=0 offset=00000300

Which is a meaningless and misleading value.  The PBA lives at offset
0x1800 into BAR0 MMIO space, why is anything other than that relevant
to present to the user?  By your logic we should also present
count as 32 and let the user figure out that it's encoded as N-1.
Thanks,

Alex
