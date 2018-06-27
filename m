Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 Jun 2018 16:23:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: i801: Fix runtime PM
Message-ID: <20180627212340.GA161569@bhelgaas-glaptop.roam.corp.google.com>
References: <20180626143913.7361-1-jarkko.nikula@linux.intel.com>
 <20180627221550.0fa5f2df@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180627221550.0fa5f2df@endymion>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, linux-pm, linux-kernel]

On Wed, Jun 27, 2018 at 10:15:50PM +0200, Jean Delvare wrote:
> Hi Jarkko,
> 
> On Tue, 26 Jun 2018 17:39:12 +0300, Jarkko Nikula wrote:
> > Commit 9c8088c7988 ("i2c: i801: Don't restore config registers on
> > runtime PM") nullified the runtime PM suspend/resume callback pointers
> > while keeping the runtime PM enabled. This causes that device stays in
> > D0 power state and sysfs /sys/bus/pci/devices/.../power/runtime_status
> > shows "error" when runtime PM framework attempts to autosuspend the
> > device.
> > 
> > This is due PCI bus runtime PM which checks for driver runtime PM
> > callbacks and returns with -ENOSYS if they are not set. Fix this by
> > having a shared dummy runtime PM callback that returns with success.
> > 
> > Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> 
> I don't want to sound like I'm trying to decline all responsibility for
> a regression I caused, but frankly, if just using SIMPLE_DEV_PM_OPS()
> breaks runtime PM, then it's the PM model which is broken, not the
> i2c-i801 driver.
> 
> I will boldly claim that the PCI bus runtime code is simply wrong in
> returning -ENOSYS in the absence of runtime PM callbacks, and it should
> be changed to return 0 instead. Or whoever receives that -ENOSYS should
> not treat it as an error - whatever makes more sense.
> 
> Having to add dummy functions in every PCI driver that doesn't need to
> do anything special for runtime PM sounds plain stupid. It should be
> pretty obvious that a whole lot of drivers are going to use
> SIMPLE_DEV_PM_OPS() because it exists and seems to do what they want,
> and all of them will be bugged because the PCI core is doing something
> silly and unexpected.
> 
> So please let's fix it at the PCI subsystem core level. Adding Bjorn
> and the linux-pci list to Cc.

Thanks Jean.  What you describe does sound broken.  I think the PM
guys (cc'd) will have a better idea of how to deal with this.
