Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 02/10] driver core: Functional dependencies tracking
 support
Date: Wed, 07 Sep 2016 01:57:11 +0200
Message-ID: <1546158.G8Vnv1pldV@vostro.rjw.lan>
In-Reply-To: <20160728152831.GA1929@wunner.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <2841548.NIYVpJFBcH@vostro.rjw.lan> <20160728152831.GA1929@wunner.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Inki Dae <inki.dae@samsung.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Kukjin Kim <kgene@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-pci@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 28, 2016 05:28:31 PM Lukas Wunner wrote:
> On Thu, Jul 28, 2016 at 02:30:31AM +0200, Rafael J. Wysocki wrote:
> > On Monday, July 25, 2016 12:48:32 AM Lukas Wunner wrote:
> > > On Thu, Jul 21, 2016 at 02:25:15AM +0200, Rafael J. Wysocki wrote:
> > > > On Thursday, July 21, 2016 01:25:53 AM Lukas Wunner wrote:
> > > > > I guess I could amend portdrv to return -EPROBE_DEFER on Macs if
> > > > > no driver is bound to the NHI. Doesn't feel pretty to me though.
> > > > > 
> > > > > Ultimately this seems to be the same issue as with calling
> > > > > dev_pm_domain_set() for a bound device. Perhaps device_link_add()
> > > > > can likewise be allowed if a runtime PM ref is held for the devices
> > > > > and the call happens under lock_system_sleep()?
> > > > 
> > > > No, the whole synchronization scheme in the links code would have had to be
> > > > changed for that to really work.
> > > > 
> > > > And it really is about what is needed (at least in principle) to run your
> > > > device.  If you think you need device X with a driver to handle device Y
> > > > correctly, then either you need it all the time, from probe to remove, or
> > > > you just don't really need it at all.
> > > 
> > > Real life isn't as simple as that.
> > > 
> > > In this case, we have consumers (hotplug ports) which are doing fine
> > > if the driver for the supplier (NHI) is not loaded. But once it loads,
> > > the links must be in place.
> > 
> > Hmm.
> > 
> > What if it is not loaded and the system suspends.  Will everything work
> > as expected after the subsequent resume?
> 
> The short answer is yes.

OK

I think it's possible to add a link flag to address this case.

Namely, if that flag is passed to device_link_add(), the link will be
added in the DEVICE_LINK_ACTIVE state right away, but that will need to
be synchronized against all possible transitions of the consumer device
(at least).

It's better to do that in a separate patch for this reason IMO.

Thanks,
Rafael


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
