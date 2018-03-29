Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 29 Mar 2018 16:21:58 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v4 2/6] PCI: aardvark: Fix logic in
 advk_pcie_valid_device()
Message-ID: <20180329162158.5ae5321e@windsurf>
In-Reply-To: <87605ft1gz.fsf@bootlin.com>
References: <20180329083946.25970-1-thomas.petazzoni@bootlin.com>
 <20180329083946.25970-3-thomas.petazzoni@bootlin.com>
 <87605ft1gz.fsf@bootlin.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 stable@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 29 Mar 2018 16:12:28 +0200, Gregory CLEMENT wrote:
> Hi Thomas,
>  
>  On jeu., mars 29 2018, Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:
> 
> > From: Victor Gu <xigu@marvell.com>
> >
> > The PCI configuration space read/write functions were special casing  
>                                                                 causing?
> else I don't get it

No, no it's really "special casing", i.e "making a special case". I
must admit I don't know if it's proper English, but clearly, "special
causing" doesn't make any sense, and "special casing" is what I wanted
to write.

> 
> > the situation where PCI_SLOT(devfn) != 0, and returned
> > PCIBIOS_DEVICE_NOT_FOUND in this case.
> >
> > However, while this is what is intended for the root bus, it is not
> > intended for the child busses, as it prevents discovering devices with  
>                          buses

Merriam-Webster says that both exists [1], though buses is apparently
more common. The kernel has 633 occurrences of busses, and 785
occurrences of buses.

[1] https://www.merriam-webster.com/words-at-play/plural-of-bus

So I'd say my commit log is good as-is :)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
