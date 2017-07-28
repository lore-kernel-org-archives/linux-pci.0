Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 27 Jul 2017 18:11:30 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
Message-ID: <20170728011130.GC19160@kroah.com>
References: <20170726154515.GA11453@hc> <20170726155548.GF28875@nazgul.tnic>
 <20170726161949.GB15426@kroah.com>
 <20170726163049.GG28875@nazgul.tnic>
 <20170726173353.GB21705@kroah.com>
 <1a2eedea-040d-c746-eaf0-1d8085b3f2bf@gmail.com>
 <20170726200802.GA17722@kroah.com>
 <b27cda60-8bf8-47a1-15b5-bf8b3a83fc45@gmail.com>
 <20170727022907.GC1398@kroah.com>
 <4f58aeab-7b8d-50dc-5497-6ac42536e0c0@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4f58aeab-7b8d-50dc-5497-6ac42536e0c0@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jan Glauber <jan.glauber@caviumnetworks.com>, Borislav Petkov <bp@alien8.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 27, 2017 at 10:29:53AM -0700, David Daney wrote:
> On 07/26/2017 07:29 PM, Greg KH wrote:
> > On Wed, Jul 26, 2017 at 02:02:42PM -0700, David Daney wrote:
> > > On 07/26/2017 01:08 PM, Greg KH wrote:
> > > > On Wed, Jul 26, 2017 at 01:02:38PM -0700, David Daney wrote:
> > > > > On 07/26/2017 10:33 AM, Greg KH wrote:
> > > > > > On Wed, Jul 26, 2017 at 06:30:49PM +0200, Borislav Petkov wrote:
> > > > > > > On Wed, Jul 26, 2017 at 09:19:49AM -0700, Greg KH wrote:
> > > > > > > > On Wed, Jul 26, 2017 at 05:55:48PM +0200, Borislav Petkov wrote:
> > > > > > > > > On Wed, Jul 26, 2017 at 05:45:15PM +0200, Jan Glauber wrote:
> > > > > > > > > > The PMU/EDAC devices are all PCI devices do I need the 'struct pci_dev *'.
> > > > > > > > > > I'm not aware of other ways to access these devices. Please enlighten
> > > > > > > > > > me if I'm missing something.
> > > > > > > > > 
> > > > > > > > > Me enlighten you on Cavium hardware?! You're funny.
> > > > > > > > > 
> > > > > > > > > So I don't know whether the PCI hotplug code can run more than one
> > > > > > > > > function upon PCI ID detection. Probably Greg will say, write a
> > > > > > > > > multiplexer wrapper. :-)
> > > > > > > > 
> > > > > > > > -ENOCONTEXT....
> > > > > > > > 
> > > > > > > > Anyway, pci questions are best asked on the linux-pci@vger list.  And
> > > > > > > > yes, all PCI devices end up with a 'struct pci_dev *' automatically.
> > > > > > > 
> > > > > > > Simple: so they have a PCI ID of a memory contoller and want to hotplug
> > > > > > > two drivers for it. And those two drivers should remain independent from
> > > > > > > each other.
> > > > > > 
> > > > > > Hahahahaha, no.  That's crazy, you were right in guessing what my answer
> > > > > > was going to be :)
> > > > > > 
> > > > > 
> > > > > 
> > > > > Just to be clear about the situation, the device is a memory controller.  It
> > > > > has two main behaviors we are interested in:
> > > > > 
> > > > > A) Error Detection And Correction (EDAC).  This should be connected to the
> > > > > kernel's EDAC subsystem.  An existing driver (drivers/edac/thunderx_edac.c)
> > > > > does exactly this.
> > > > > 
> > > > > B) Performance Counters for actions taken in the corresponding memory. This
> > > > > should be connected to the kernel's perf framework as an uncore-PMU (the
> > > > > subject of this patch set).
> > > > > 
> > > > > It is a single PCI device.  What should the driver architecture look like to
> > > > > connect it to two different kernel subsystems?
> > > > 
> > > > Modify the drivers/edac/thunderx_edac.c code to add support for
> > > > performance counters.
> > > > 
> > > 
> > > Thanks Greg.  This adds some clarity to the situation.
> > > 
> > > This technique does slightly complicate the mapping of files and directories
> > > in the kernel source tree to maintainers.
> > > 
> > > Also, if a given configuration disables CONFIG_EDAC there is some hackery
> > > needed to get the perf portion of the driver included.
> > 
> > Well, you all deserve it for trying to have a single PCI device do
> > multiple things at the same time.  There's no real good reason for
> > creating hardware that way, PCI devices are "free", you should go throw
> > a printed copy of the PCI spec at the firmware developers who did this
> > to you.
> 
> The problem lies in something even more congealed than the "firmware". The
> PCI topology is etched in to the very fabric of the silicon of the SoC.

That's not very wise, as you can see here, most "modern" chips allow
stuff like this to be changeable at the firmware level.  I strongly
suggest telling the hardware developers to fix this for your next
revision.

Oh well, fix it in the kernel, that's what it's there for :)

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
