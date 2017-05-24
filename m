Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 24 May 2017 12:16:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] PCI: imx6: fix downstream bus scanning
Message-ID: <20170524171652.GA14714@bhelgaas-glaptop.roam.corp.google.com>
References: <20170510175752.6519-1-l.stach@pengutronix.de>
 <20170522221346.GG19733@bhelgaas-glaptop.roam.corp.google.com>
 <CAOMZO5BgyMq0pMvnCAzG+bH9E6xX1NvX2vRy-FsQ1ojmAodrWA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BgyMq0pMvnCAzG+bH9E6xX1NvX2vRy-FsQ1ojmAodrWA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Tim Harvey <tharvey@gateworks.com>, patchwork-lst@pengutronix.de,
 Peter Senna Tschudin <peter.senna@collabora.com>,
 Sascha Hauer <kernel@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 07:11:26PM -0300, Fabio Estevam wrote:
> Hi Bjorn,
> 
> On Mon, May 22, 2017 at 7:13 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > Applied to for-linus for v4.12 with tested-by and acks from Fabio,
> > Peter, and Richard.  I updated the subject line to:
> >
> >   PCI: imx6: Fix config read timeout handling
> >
> > because I don't think this change is specific to bus scanning and I
> > wanted a hint that it's related to the config space mapping changes.
> >
> > In fact, I'd really like to include the specific commit that caused
> > this problem so that if the original commit is backported, there's a
> > hint that we should backport this one, too.  I *think* it might be
> > cc7b0d495589, so I updated the changelog to this:
> >
> >   Commit cc7b0d495589 ("PCI: designware: Update PCI config space remap
> >   function") made PCI configuration requests non-posted, which means we now
> >   get a synchronous abort when the CFG space read to probe for downstream
> >   devices times out.
> >
> >   Synchronous aborts need to be handled differently from the async aborts we
> >   were getting before, in particular the PC needs to be advanced when
> >   resolving the abort.  This is mostly a copy of what other PCI drivers do on
> >   ARM to handle those aborts.
> >
> >   [bhelgaas: changelog, "Fixes"]
> >   Fixes: cc7b0d495589 ("PCI: designware: Update PCI config space remap function")
> >
> > Please let me know if this is the wrong commit.
> 
> I just tested on a mx6q board and can confirm that this is the correct
> offending commit, thanks.

Thanks for checking this out, Fabio!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
