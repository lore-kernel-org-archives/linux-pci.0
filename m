Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 7 Mar 2018 11:54:38 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ilya Ledvich <ilya@compulab.co.il>
Subject: Re: [PATCH v3] PCI: imx6: Add PHY reference clock source support
Message-ID: <20180307115438.GA15139@e107981-ln.cambridge.arm.com>
References: <CAOMZO5AFC9dxhsQjmRrDA7Z3KMkEemryKOBmQhXm19NXKxHkKQ@mail.gmail.com>
 <1515073977-10153-1-git-send-email-ilya@compulab.co.il>
 <1515408232.12538.7.camel@pengutronix.de>
 <498e20c0-7b86-0f86-7555-64a012b85b9e@compulab.co.il>
MIME-Version: 1.0
In-Reply-To: <498e20c0-7b86-0f86-7555-64a012b85b9e@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 10, 2018 at 03:43:41PM +0200, Ilya Ledvich wrote:
> Hi Lucas,
> 
> On 01/08/2018 12:43 PM, Lucas Stach wrote:
> >Am Donnerstag, den 04.01.2018, 15:52 +0200 schrieb Ilya Ledvich:
> >>i.MX7D variant of the IP can use either Crystal Oscillator input
> >>or internal clock input as a Reference Clock input for PCIe PHY.
> >>Add support for an optional property 'fsl,pcie-phy-refclk-internal'.
> >>If present then an internal clock input is used as PCIe PHY
> >>reference clock source. By default an external oscillator input
> >>is still used.
> >>
> >>Verified on Compulab SBC-iMX7 Single Board Computer.
> >
> >Sorry to get in late here, but I would rather have the external clock
> >input modeled as a real clock and only use the internal clock if that
> >isn't present.
> >
> 
> I tried to follow the logic described in the iMX7 TRM, where external
> oscillator is a default option. Additionally, the external clock input model
> you've suggested, requires additional changes in the iMX7 SabreSD board (and
> probably other boards which use an external input too) devicetree files.
> 
> >Are you even sure that the i.MX7 clock you mention isn't the already
> >documented "pcie_bus" clock? This one is also allowed to be sourced
> >externally on the i.MX6.
> 
> To the best of my understanding it's not the pcie_bus clock, but I'm
> absolutely sure. Could anybody from the BSP team guys elaborate on this
> issue? Thanks a lot!

I have marked this with "Changes Requested" according to Lucas'
feedback, please send a new version or let me know what I should
do with it, thanks.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
