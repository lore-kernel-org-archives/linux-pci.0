Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Thomas Petazzoni'" <thomas.petazzoni@free-electrons.com>,
 "'Joao Pinto'" <jpinto@synopsys.com>,
 "'Bjorn Helgaas'" <bhelgaas@google.com>,
 "'Pratyush Anand'" <pratyush.anand@gmail.com>, <linux-pci@vger.kernel.org>
References: <1472561830-20932-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160830172447.65d10772@free-electrons.com>
In-Reply-To: <20160830172447.65d10772@free-electrons.com>
Subject: Re: [PATCH 0/3] pcie-designware: support for external MSI controller
Date: Tue, 30 Aug 2016 11:46:13 -0400
Message-ID: <000c01d202d5$a3809bd0$ea81d370$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: 'Mark Rutland' <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 'Yehuda Yitschak' <yehuday@marvell.com>, 'Jason Cooper' <jason@lakedaemon.net>,
 'Pawel Moll' <pawel.moll@arm.com>,
 'Ian Campbell' <ijc+devicetree@hellion.org.uk>,
 'Marc Zyngier' <marc.zyngier@arm.com>, 'Nadav Haklai' <nadavh@marvell.com>,
 'Rob Herring' <robh+dt@kernel.org>, 'Andrew Lunn' <andrew@lunn.ch>,
 'Kumar Gala' <galak@codeaurora.org>,
 'Gregory Clement' <gregory.clement@free-electrons.com>,
 'Shadi Ammouri' <shadi@marvell.com>, linux-arm-kernel@lists.infradead.org,
 'Sebastian Hesselbarth' <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, August 30, 2016 11:25 AM, Thomas Petazzoni wrote:
> 
> Hello,
> 
> On Tue, 30 Aug 2016 14:57:07 +0200, Thomas Petazzoni wrote:
> 
> > Thomas Petazzoni (3):
> >   dt-bindings: designware-pcie: document optional msi-parent property
> >   pci: pcie-designware: add support for external MSI controller
> >   arm64: dts: marvell: enable MSI for PCIe on Armada 7K/8K
> 
> Please discard this patch series, it's just pure crap. No changes at all
> are needed on the pcie-designware driver, using the msi-parent property
> already works, and my new code does nothing good.
> 
> The of_pci_find_msi_chip_by_node() API is on its way to being removed, and
> it doesn't return anything useful.
> 
> Only PATCH 3/3 is needed, which I'll resubmit separately.
> 
> Sorry for the noise.

Oh, good.
The support for External MSI controller is really necessary.
Thank you for your patch!

Best regards,
Jingoo Han

> 
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
