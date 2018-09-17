Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v4 0/6] PCI: imx: Initial imx7d suspend/resume support
Date: Mon, 17 Sep 2018 16:01:21 +0000
Message-ID: <16d68541fd499dfda88e79d4386be7ad6d0919d9.camel@nxp.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
 <20180917150941.GH7239@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180917150941.GH7239@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Anson Huang <anson.huang@nxp.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-09-17 at 16:09 +0100, Lorenzo Pieralisi wrote:
> On Tue, Aug 14, 2018 at 07:50:14PM +0300, Leonard Crestez wrote:

> > V4 adds 4 more patches with PME_Turn_Off support on top, using a new
> > reset bit. I generally try to keep series short but in this case some
> > planning might be needed to get patches into 4.20.
> > 
> > Since the new reset is treated as optional with old DTB there should be
> > again no problem if reset and pci are merged out of order.
> > 
> > Shawn/Philipp/Lorenzo: Would it make sense to merge this series through a
> > single specific tree, such as the one for imx?
> 
> This series is a bit of a mixture of multiple things hard to discern
> (actually I already merged patch 2 and patch 1 seems completely
> unrelated).
> 
> I would take the series through the PCI tree but I need an ACK for
> patches 5 and 6, please let me know how you want to handle it.

Patches 1 and 2 are already in, the rest need review. I can now just
resend patches 3-6 as a separate series, unless somebody complains
about spam.

Multiple separate patches are required because it touches reset + dt +
pci. I guess adding the include constant should be moved from the dts
patch to dt-bindings though.

Merging reset and pci out of order should be fine here and is required
by DT compatibility rules anyway.

--
Regards,
Leonard
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
