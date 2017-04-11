Return-Path: <SRS0=vx1N=3T=redhat.com=alex.williamson@kernel.org>
Return-Path: <SRS0=vx1N=3T=redhat.com=alex.williamson@kernel.org>
Date: Tue, 11 Apr 2017 15:51:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bodong@mellanox.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, saeedm@mellanox.com, Eli Cohen
 <eli@mellanox.com>
Subject: Re: [v2] PCI: Add an option to control probing of VFs before
 enabling SR-IOV
Message-ID: <20170411155133.64a330ac@t450s.home>
In-Reply-To: <20170411211211.GB14778@bhelgaas-glaptop.roam.corp.google.com>
References: <1490198038-20465-1-git-send-email-bodong@mellanox.com>
	<20170411211211.GB14778@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 11 Apr 2017 16:12:11 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Hi Bodong,
> 
> On Wed, Mar 22, 2017 at 05:53:58PM +0200, bodong@mellanox.com wrote:
> > From: Bodong Wang <bodong@mellanox.com>
> > 
> > Sometimes it is not desirable to probe the virtual functions after
> > SRIOV is enabled. This can save host side resource usage by VF
> > instances which would be eventually probed to VMs.
> > 
> > Add a new PCI sysfs interface "sriov_probe_vfs" to control that
> > from the PF, all current callers still retain the same functionality.
> > To modify it, echo 0/n/N (disable probe) or 1/y/Y (enable probe) to
> > 
> > /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs  
> 
> Is this basically the same functionality as /sys/bus/pci/drivers_autoprobe, 
> but limited to a specific PF?  I.e., could we accomplish the same thing
> with the following?
> 
>   # echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
>   # echo 0 > /sys/bus/pci/drivers_autoprobe
>   # echo 2 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
>   # echo 1 > /sys/bus/pci/drivers_autoprobe
> 
> If not, can you contrast the above with drivers_autoprobe?  If we need
> both, should they be named more similarly?

Logically it's similar, but the above is racy, not only would userspace
need to serialize such operations but a device hot added during that
blackout period wouldn't be probed.  So this is like a per PF
drivers_autoprobe for the VFs hosted by that device.  Thanks,

Alex

> > Note that, the choice must be made before enabling VFs. The change
> > will not take effect if VFs are already enabled. Simply, one can set
> > sriov_numvfs to 0, choose whether to probe or not, and then resume
> > sriov_numvfs.
> > 
> > Signed-off-by: Bodong Wang <bodong@mellanox.com>
> > Signed-off-by: Eli Cohen <eli@mellanox.com>
> > Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>  
