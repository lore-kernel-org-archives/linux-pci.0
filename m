Return-Path: <SRS0=QNR6=GC=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=QNR6=GC=intel.com=keith.busch@kernel.org>
Date: Mon, 12 Mar 2018 11:33:01 -0600
From: Keith Busch <keith.busch@intel.com>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180312173301.GD18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
 <20180312145823.GC18494@localhost.localdomain>
 <eb2810113f98c2ff8201da1a0f827493@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eb2810113f98c2ff8201da1a0f827493@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 09:04:47PM +0530, poza@codeaurora.org wrote:
> On 2018-03-12 20:28, Keith Busch wrote:
> > I'm not sure I understand. The link is disabled while DPC is triggered,
> > so if anything, you'd want to un-enumerate everything below the
> > contained
> > port (that's what it does today).
> > 
> > After releasing a slot from DPC, the link is allowed to retrain. If
> > there
> > is a working device on the other side, a link up event occurs. That
> > event is handled by the pciehp driver, and that schedules enumeration
> > no matter what you do to the DPC driver.
> 
> yes, that is what i current, but this patch-set makes DPC aware of error
> handling driver callbacks.

I've been questioning the utility of doing that since the very first
version of this patch set.

> besides, in absence of pciehp there is nobody to do enumeration.

If you configure your kernel to not have a feature, you don't get to
expect the feature works.

You can still manually rescan through sysfs, /sys/bus/pci/rescan.
 
> And, I was talking about pci_stop_and_remove_bus_device() in dpc.
> if DPC calls driver's error callbacks, is it required to stop the devices  ?

DPC is PCIe's preferred surprise removal mechanism. If you don't want
the DPC driver to handle removing devices downstream the containment,
how do you want those devices get removed? Just calling driver's error
callbacks leaves the kernel's view of the topology in the wrong state.
