Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 9 Jun 2016 11:19:21 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] PCI: host: new PCI host controller driver for
 Marvell Armada 3700
Message-ID: <20160609111921.11975627@free-electrons.com>
In-Reply-To: <3112077.0RPfokLCAs@wuerfel>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <3112077.0RPfokLCAs@wuerfel>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
 Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, Hanna Hawa <hannah@marvell.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Marcin Wojtas <mw@semihalf.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 02 Jun 2016 11:46:04 +0200, Arnd Bergmann wrote:

> > +	timeout = PCIE_LINKUP_TIMEOUT;
> > +	do {
> > +		val = advk_readl(pcie, CFG_REG);
> > +		ltssm_state = (val >> LTSSM_SHIFT) & LTSSM_MASK;
> > +		timeout--;
> > +	/* Use ltssm < LTSSM_L0 instead of ltssm != LTSSM_L0 */
> > +	} while (ltssm_state < LTSSM_L0 && timeout > 0);
> > +
> > +	return (timeout > 0);
> > +}  
> 
> Maybe wait for some amount of time to have passed here (using 
> time_before(jiffies, end)) rather than a number of retries,
> for robustness and determinism.

Will. There was another similar loop in the driver which was doing a
number of retries rather than a timeout-bounded loop, so I've fixed
that one as well.

> > +	/* Point PCIe unit MBUS decode windows to DRAM space. */
> > +	for (i = 0; i < 8; i++)
> > +		advk_pcie_set_ob_win(pcie, i, 0, 0, 0, 0, 0, 0, 0);  
> 
> Is this actually mbus based, or is the comment copied from some
> other Marvell driver?

No, it's not MBUS based, the address decoding logic is very different
from previous mvebu SoCs, I guess it's just a "familiar" name to say
that it's configuring address decoding. I'll remove the comment.

> What is the version of the GIC in the Armada 3700? If you have GICv3
> or GICv2m, could you use that instead of the built-in MSI logic?
> 
> We typically handle this using the msi-map or msi-parent properties
> pointing to either the gic or the PCI host, depending on which one
> you want to use, but either of them should work, and the GIC should
> be more efficient because you can distribute the interrupts of the
> PCI devices over all CPUs by workload, rather than having to
> multiplex all MSI through a single GIC interrupt.

There is a GIC-500, but Marcin told me that attempts to use MSI with it
have not been successful so far. There will be investigation on this
topic in the future, but for the moment, we'd like to have the MSI
functionality built into the PCIe driver supported. We can migrate
later to GIC-500 powered MSIs once working.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
