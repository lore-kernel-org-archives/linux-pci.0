Return-Path: <SRS0=KPmd=D6=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=KPmd=D6=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 3 Jan 2018 12:18:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: pci driver loads right after unload
Message-ID: <20180103111834.GA5412@kroah.com>
References: <13c000eb-5fbe-1787-54c0-d113500cf3db@mellanox.com>
 <20180102190003.GB6211@bhelgaas-glaptop.roam.corp.google.com>
 <20180102192721.GB10273@kroah.com>
 <fb4bb470-c30e-c173-3267-99e283f79e02@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fb4bb470-c30e-c173-3267-99e283f79e02@mellanox.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 03, 2018 at 12:50:05PM +0200, Max Gurtovoy wrote:
> Hi Greg/Bjorn,
> 
> On 1/2/2018 9:27 PM, Greg Kroah-Hartman wrote:
> > On Tue, Jan 02, 2018 at 01:00:03PM -0600, Bjorn Helgaas wrote:
> > > [+cc Greg, linux-kernel]
> > > 
> > > Hi Max,
> > > 
> > > Thanks for the report!
> > > 
> > > On Tue, Jan 02, 2018 at 01:50:23AM +0200, Max Gurtovoy wrote:
> > > > hi all,
> > > > I encountered a strange phenomena using 2 different pci drivers
> > > > (nvme and mlx5_core) since 4.15-rc1:
> > > > when I try to unload the modules using "modprobe -r" cmd it calls
> > > > the .probe function right after calling the .remove function and the
> > > > module is not realy unloaded.
> > > > I think there is some race condition because when I added a
> > > > msleep(1000) after "pci_unregister_driver(&nvme_driver);" (in the
> > > > nvme module testing, it also worked in the mlx5_core), the issue
> > > > seems to dissapear.
> > > 
> > > You say "since 4.15-rc1".  Does that mean it's a regression?  If so,
> > > what's the most recent kernel that does not have this problem?  Worst
> > > case, you could bisect to find where it broke.
> > > 
> > > I don't see anything obvious in the drivers/pci changes between v4.14
> > > and v4.15-rc1.  Module loading and driver binding is mostly driven by
> > > the driver core and udev.  Maybe you could learn something with
> > > "udevadm monitor" or by turning on the some of the debug in
> > > lib/kobject_uevent.c?
> > 
> > 
> > This should be resolved in 4.15-rc6, there was a regression in -rc1 in
> > this area when dealing with uevents over netlink.
> > 
> > Max, can you test -rc6 to verify if this is really fixed or not?
> 
> I've tested -rc6 and the issue doesn't repro.
> I'll continue monitoring this scenario in -rc7.
> Can you point to the commit that fixes the issue ? and I'll test the kernel
> with/without this patch.

9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
