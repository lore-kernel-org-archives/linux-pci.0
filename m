Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 27 Mar 2018 14:57:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 0/6] PCI: aardvark: misc fixes and improvements
Message-ID: <20180327195723.GG7759@bhelgaas-glaptop.roam.corp.google.com>
References: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
 <20180327162016.7df5c684@windsurf.home>
MIME-Version: 1.0
In-Reply-To: <20180327162016.7df5c684@windsurf.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 27, 2018 at 04:20:16PM +0200, Thomas Petazzoni wrote:
> On Tue, 27 Mar 2018 16:08:06 +0200, Thomas Petazzoni wrote:
> 
> > This patch series brings a number of improvements to the aardvark
> > PCIe. Sorry for being so slow at sending the v3 after the v2 sent in
> > January. Hopefully this time around the series will be fine.
> 
> Sorry, I screwed up. I'm not sure how, but I did. The series was sent
> twice, and only the second iteration is correct, the first one lacked
> some Cc: to stable.
> 
> I have marked the bogus patches as Superseded in patchwork, so if you
> look at patchwork, you will only see the patches worth considering.
> 
> Let me know if you would like to resend anyway.

No worries, no need to resend for that.  And also no need to resend to
rebase them.

Lorenzo is out this week, but I'm sure he'll look at them when he
returns.  They all look pretty straightforward and obviously only
affect aardvark, so we may still be able to squeeze them in for v4.17.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
