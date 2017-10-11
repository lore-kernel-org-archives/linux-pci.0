Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 11 Oct 2017 13:32:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Glauber <jglauber@cavium.com>
Subject: Re: [PATCH v4 0/3] Workaround for bus/slot reset on Cavium cn8xxx
 root ports
Message-ID: <20171011183201.GK25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170908081033.3025-1-jglauber@cavium.com>
MIME-Version: 1.0
In-Reply-To: <20170908081033.3025-1-jglauber@cavium.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 david.daney@cavium.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robert Richter <robert.richter@cavium.com>,
 Jon Masters <jcm@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 08, 2017 at 10:10:30AM +0200, Jan Glauber wrote:
> Using vfio-pci on a combination of cn8xxx and some PCI devices results in
> a kernel panic. This is triggered by issuing a bus or a slot reset
> on the PCI device.
> 
> With this series both checks indicate that the reset is not possible
> preventing the kernel panic.
> 
> David Daney (2):
>   PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device
>   PCI: Avoid bus reset for Cavium cn8xxx root ports
> 
> Jan Glauber (1):
>   PCI: Avoid slot reset if bus reset is not possible
> 
>  drivers/pci/pci.c    | 8 ++++++++
>  drivers/pci/quirks.c | 8 ++++++++
>  2 files changed, 16 insertions(+)

Applied to pci/host-thunder for v4.15, thanks.

I reordered and renamed them like this:

  PCI: Mark Cavium CN8xxx to avoid bus reset
  PCI: Avoid bus reset if bridge itself is broken
  PCI: Avoid slot reset if bridge itself is broken

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
