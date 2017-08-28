Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 28 Aug 2017 17:51:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jan Luebbe <jlu@pengutronix.de>
Subject: Re: [RFC] ARM: Orion: Check DRAM window size
Message-ID: <20170828155135.GF10418@lunn.ch>
References: <20170828152517.24506-1-jlu@pengutronix.de>
 <20170828153039.27088-1-jlu@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20170828153039.27088-1-jlu@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Gregory Clement <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 28, 2017 at 05:30:39PM +0200, Jan Luebbe wrote:
> This is a corresponding change as "PCI: mvebu: Check DRAM window size" applied
> to the Orion PCIe driver. I don't have the relevant hardware myself, but the
> patch may still be useful for someone who has. This is completely untested.

Hi Jan

I've never seen one of these boards have more than 512M bytes of RAM.
So it is probably a non-issue.

   Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
