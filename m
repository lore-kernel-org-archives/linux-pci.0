Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 27 Jun 2017 14:58:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: next-20170621 build: 1 failures 7 warnings (next-20170621)
Message-ID: <20170627195815.GA17844@bhelgaas-glaptop.roam.corp.google.com>
References: <E1dNcMp-0005RN-1w@optimist>
 <20170621100440.vcaxagg4yjca2cv4@sirena.org.uk>
 <1498209196.26313.71.camel@mtkswgap22>
 <20170623094356.GA5337@red-moon>
MIME-Version: 1.0
In-Reply-To: <20170623094356.GA5337@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Ryder Lee <ryder.lee@mediatek.com>,
 "kernel-build-reports@lists.linaro.org"
 <kernel-build-reports@lists.linaro.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 23, 2017 at 10:43:56AM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 23, 2017 at 05:13:16PM +0800, Ryder Lee wrote:
> > Sorry for late reply, 
> > 
> > +Lorenzo
> > 
> > On Wed, 2017-06-21 at 18:04 +0800, Mark Brown wrote:
> > > On Wed, Jun 21, 2017 at 10:56:07AM +0100, Build bot for Mark Brown wrote:
> > > 
> > > Today's -next fails to build an arm allmodconfig due to:
> > > 
> > > > 	arm-allmodconfig
> > > > ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]
> > > 
> > > caused by eaf3023b0498a (PCI: mediatek: Add MediaTek PCIe host
> > > controller support).
> > 
> > 
> > Hi Lorenzo,
> > 
> > I picked up your changes and had some modifications like what you did
> > for other platforms:
> > 
> > 9f8e3a5 PCI: Add devm_pci_alloc_host_bridge() interface 
> > 35a1a84 PCI: Add pci_free_host_bridge() interface
> > e33aafd PCI: Initialize bridge release function at bridge allocation
> > 
> > ...and it looks Okay.
> > 
> > I have also noticed that you continue sending patches for other
> > platforms but I have not yet had a look in detail. I'm quite busy these
> > days and don't have time to dig it, hence it is becoming a little
> > unmanageable for me.
> 
> If it is unmanageable you don't add yourself as a maintainer of that
> PCI host bridge driver, you know, we are all busy.
> 
> Your driver in the PCI tree as it stands contains already two bugs:
> 
> 1) It leaks memory on the probe failure path
> 2) pci_fixup_irqs() is broken on configurations with multiple host
>    bridges
> 
> And we keep copy'n'pasting that code.
> 
> > Did you have a chance to send the same patches for MediaTek?  I
> > appreciate that and I can help to test it on our platforms.
> 
> No, how could I have sent them ? It is not upstream and it is a separate
> branch in the PCI tree. As I mentioned in another thread it is probably
> best to drop my pci_fixup_irqs() removal patches since it is impossible
> to work on them without a stable branch to apply them against, in the
> interim we keep adding PCI host bridges that use the wrong interfaces by
> copy'n'pasting code that I have been trying to remove.
> 
> I think the best solution is to repost my series when v4.13-rc1 appears
> and ask all new crop of host bridge drivers to rebase against it.
> 
> I won't be able to follow mailing lists till end of next week, which
> is bad timing.
> 
> Bjorn, is the plan above ok ? Please let me know how you want to
> proceed.

Sorry, I was on vacation myself most of last week, and you're
unavailable most of this week, but I'd still like to try to get this
into v4.13.

We may not get every host tested, but I'm not sure that will happen
even if we wait for the next cycle.  If we trip over something it will
likely be something small or for a relatively rare platform, so we can
fix it up after the fact.

I haven't looked at everything yet, but my plan is to try to
incorporate the fixes people have posted and keep pushing forward.  If
that turns out not to work, I'll drop the pci_fixup_irqs() series, but
I'll at least give it a try.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
