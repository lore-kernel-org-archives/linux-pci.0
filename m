Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: Re: [RESEND] PCI: imx: Initial imx7d pm support
Date: Mon, 3 Sep 2018 13:52:13 +0000
Message-ID: <29a8f58b4efe3e3671eec1ee78b566d69034db61.camel@nxp.com>
References: <d577303de61fb060aa428898f5df1d0bc9be89b8.1535369231.git.leonard.crestez@nxp.com>
 <20180828100758.GA27217@e107981-ln.cambridge.arm.com>
 <efcb160f08bb53620ba0570e55dbb9190275aeb0.camel@nxp.com>
 <20180828145511.GA32352@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180828145511.GA32352@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Anson Huang <anson.huang@nxp.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, dl-linux-imx <linux-imx@nxp.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-08-28 at 15:55 +0100, Lorenzo Pieralisi wrote:
> On Tue, Aug 28, 2018 at 01:00:02PM +0000, Leonard Crestez wrote:
> > On Tue, 2018-08-28 at 11:07 +0100, Lorenzo Pieralisi wrote:
> > > On Mon, Aug 27, 2018 at 02:28:37PM +0300, Leonard Crestez wrote:
> > > > On imx7d the pcie-phy power domain is turned off in suspend and this can
> > > > make the system hang after resume when attempting any read from PCI.
> > > > 
> > > > Fix this by adding minimal suspend/resume code from the nxp internal
> > > > tree. This will prepare for powering down on suspend and reset the block
> > > > on resume.
> > > > 
> > > > Code is only for imx7d but a very similar sequence can be used for
> > > > other socs.
> > > > 
> > > > The original author is mostly Richard Zhu <hongxing.zhu@nxp.com>, this
> > > > patch adjusts the code to the upstream imx7d implemention using reset
> > > > controls and power domains.
> > > 
> > > I will add a Suggested-by: replacing this paragraph, it is always better
> > > to add proper tags rather than credit hidden in commit logs messages.
> > 
> > Isn't "Originally-by:" a better tag for this?
> 
> We can add that, yes or add Richard as patch author, as you prefer to
> give him credit.

I think "Originally-by:" is a better fit because there is no
clear correspondence with patches from the vendor tree.

--
Regards,
Leonard
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
