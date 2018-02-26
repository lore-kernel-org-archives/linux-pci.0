Return-Path: <SRS0=CXPL=FU=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=CXPL=FU=linux.intel.com=mika.westerberg@kernel.org>
Date: Mon, 26 Feb 2018 13:52:47 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Peter Wu <peter@lekensteyn.nl>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Subject: Re: [PATCH v1 1/2] PCI: Add PCIe port runtime suspend details
Message-ID: <20180226115247.GN27191@lahna.fi.intel.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908203999.37696.12678235610905422348.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0hys5UY69H=ARHA-EsmH-CVqTQNSQciktDQ=nVBEKJHqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hys5UY69H=ARHA-EsmH-CVqTQNSQciktDQ=nVBEKJHqQ@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:31:51AM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 20, 2018 at 12:14 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Add details about how we decide whether we can put a PCI bridge in D3.
> > 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") added this
> > support to reduce power consumption on Intel Sunrise Point and Broxton
> > platforms.
> >
> > In some cases we don't use D3 for bridges even when it should work, simply
> > because it's impractical to test the configuration, or we tripped over some
> > possible hardware issue on older platforms.  Links to discussion of the
> > PCIe port runtime power management patches, which includes mention of these
> > issues, are below.
> >
> > No functional change.
> >
> > Link: v1: https://lkml.kernel.org/r/1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: v2: https://lkml.kernel.org/r/1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: v3: https://lkml.kernel.org/r/1460628268-16204-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: v4: https://lkml.kernel.org/r/1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: v5: https://lkml.kernel.org/r/1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: v6: https://lkml.kernel.org/r/1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: https://lkml.kernel.org/r/2858019.9TUCWsDpTB@aspire.rjw.lan
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Also

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
