Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 14 Sep 2016 15:30:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Lance Ortiz <lance.ortiz@hpe.com>,
        Betty Dall <betty.dall@hpe.com>,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Chen Gong <gong.chen@linux.intel.com>,
        KeithBuschkeith.busch@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Huang Ying <ying.huang@intel.com>,
        Vijay Mohan Pandarathil <vijaymohan.pandarathil@hpe.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Remove module parameters
Message-ID: <20160914203019.GB13189@localhost>
References: <20160906221522.23655.66321.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160906221522.23655.66321.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 06, 2016 at 05:19:22PM -0500, Bjorn Helgaas wrote:
> I'd like to remove the aerdriver.nosourceid and aerdriver.forceload kernel
> parameters.  They seem like basically debugging things that are not really
> supportable upstream.
> 
> "nosourceid" may have some legitimate uses, but I'd rather it were done via
> quirks with the flag Jon Derrick recently added so it happens
> automatically, without users having to specify the parameter.
> 
> I don't *know* of any actual users of either of these, but obviously that
> doesn't mean there are none.  Comments welcome.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI/AER: Remove aerdriver.nosourceid kernel parameter
>       PCI/AER: Remove aerdriver.forceload kernel parameter
> 
> 
>  Documentation/PCI/pcieaer-howto.txt |   26 +++++++++-----------------
>  drivers/pci/pcie/aer/aerdrv.c       |    7 +------
>  drivers/pci/pcie/aer/aerdrv.h       |    8 --------
>  drivers/pci/pcie/aer/aerdrv_core.c  |   31 ++++---------------------------
>  4 files changed, 14 insertions(+), 58 deletions(-)

I'm going to go out on a limb a little bit and apply these to pci/aer for
v4.9.  Please let me know if you trip over any issues.
