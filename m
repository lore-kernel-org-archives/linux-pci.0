Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 21 Sep 2017 10:06:59 +0200
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [v4,0/3] Workaround for bus/slot reset on Cavium cn8xxx root ports
Message-ID: <20170921080659.GA12818@hc>
References: <20170908081033.3025-1-jglauber@cavium.com>
 <20170912094049.GA14111@localhost.localdomain>
 <20170920120912.7544420d@t450s.home>
MIME-Version: 1.0
In-Reply-To: <20170920120912.7544420d@t450s.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: kvm@vger.kernel.org, david.daney@cavium.com, linux-pci@vger.kernel.org,
 Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>,
 linux-kernel@vger.kernel.org, Robert Richter <robert.richter@cavium.com>,
 Jon Masters <jcm@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 20, 2017 at 12:09:12PM -0600, Alex Williamson wrote:
> On Tue, 12 Sep 2017 02:40:49 -0700
> Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> 
> > Hi all,
> > 
> > Are there any updates on this ?
> > Comments/objections/acks/nacks ?
> > 
> > WBBR,
> > Vadim
> > 
> > On Fri, Sep 08, 2017 at 10:10:30AM +0200, Jan Glauber wrote:
> > > Using vfio-pci on a combination of cn8xxx and some PCI devices results in
> > > a kernel panic. This is triggered by issuing a bus or a slot reset
> > > on the PCI device.
> > > 
> > > With this series both checks indicate that the reset is not possible
> > > preventing the kernel panic.
> > > 
> > > David Daney (2):
> > >   PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device
> > >   PCI: Avoid bus reset for Cavium cn8xxx root ports
> > > 
> > > Jan Glauber (1):
> > >   PCI: Avoid slot reset if bus reset is not possible
> > > 
> > >  drivers/pci/pci.c    | 8 ++++++++
> > >  drivers/pci/quirks.c | 8 ++++++++
> > >  2 files changed, 16 insertions(+)  
> 
> 
> Looks ok to me, for series:
> 
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

Thanks for the review. And also for being patient with my iterations.

> I am curious why we're happy targeting this quirk at a single device ID
> while at the same time trying to expand the ACS quirk to a notable
> fraction of the Cavium PCI device ID address space.  Thanks,

David, please correct me if I'm wrong but I think this problem only
exists on cn88xx (device id 0xa100) but not on cn81xx/cn83xx (0xa200,
0xa300). I've seen the bridge causing the problem only on cn88xx.

--Jan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
