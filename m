Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 15 Aug 2017 11:13:38 +0200
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
Message-ID: <20170815091338.GA3317@hc>
References: <20170726163049.GG28875@nazgul.tnic>
 <20170726173353.GB21705@kroah.com>
 <1a2eedea-040d-c746-eaf0-1d8085b3f2bf@gmail.com>
 <20170726200802.GA17722@kroah.com>
 <b27cda60-8bf8-47a1-15b5-bf8b3a83fc45@gmail.com>
 <20170727051157.GA4525@nazgul.tnic> <20170727090856.GB15784@hc>
 <20170727131515.GC28548@nazgul.tnic>
 <20170728231233.GA29240@kroah.com> <20170808132509.GJ13355@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170808132509.GJ13355@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, David Daney <ddaney.cavm@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 08, 2017 at 02:25:10PM +0100, Will Deacon wrote:
> On Fri, Jul 28, 2017 at 04:12:33PM -0700, Greg KH wrote:
> > On Thu, Jul 27, 2017 at 03:15:15PM +0200, Borislav Petkov wrote:
> > > On Thu, Jul 27, 2017 at 11:08:56AM +0200, Jan Glauber wrote:
> > > > OK. As fixing the firmware will take quite some time I'll go for the memory
> > > > controller driver that starts EDAC / PMU depending on their CONFIG_.
> > > > 
> > > > What would be the proper location for the multiplexer?
> > > > drivers/soc/cavium or drivers/misc?
> > > 
> > > Uff, no idea. Greg? You're the special drivers guy. :-)
> > 
> > Start out in misc/ and let's see the code to determine if it should be
> > moved elsewhere.
> 
> Jan, are you ok making this change, or are you waiting for anything else
> from us? (Mark and I are just going through the pending PMU patches and
> we're not clear on the status of this one).

Hi Will,
it's my turn but I was on vacation. It was not completely trivial (well,
to me) to get the multiplexing working with modules but I'll look at it
again this week.

Cheers,
Jan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
