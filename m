Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 12 Sep 2017 02:40:49 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: Jan Glauber <jglauber@cavium.com>, Bjorn Helgaas <bhelgaas@google.com>,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Jon Masters <jcm@redhat.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [v4,0/3] Workaround for bus/slot reset on Cavium cn8xxx root ports
Message-ID: <20170912094049.GA14111@localhost.localdomain>
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
Cc: Robert Richter <robert.richter@cavium.com>, david.daney@cavium.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

Are there any updates on this ?
Comments/objections/acks/nacks ?

WBBR,
Vadim

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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
