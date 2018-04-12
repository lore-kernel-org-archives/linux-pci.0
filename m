Return-Path: <SRS0=YPu5=HB=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=YPu5=HB=intel.com=keith.busch@kernel.org>
Date: Thu, 12 Apr 2018 11:09:11 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
Message-ID: <20180412170911.GA6424@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
 <20180412150231.GD4810@localhost.localdomain>
 <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 12, 2018 at 12:27:20PM -0400, Sinan Kaya wrote:
> On 4/12/2018 11:02 AM, Keith Busch wrote:
> > 
> > Also, I thought the plan was to keep hotplug and non-hotplug the same,
> > except for the very end: if not a hotplug bridge, initiate the rescan
> > automatically after releasing from containment, otherwise let pciehp
> > handle it when the link reactivates.
> > 
> 
> Hmm...
> 
> AER driver doesn't do stop and rescan approach for fatal errors. AER driver
> makes an error callback followed by secondary bus reset and finally driver
> the resume callback on the endpoint only if link recovery is successful.
> Otherwise, AER driver bails out with recovery unsuccessful message.

I'm not sure if that's necessarily true. People have reported AER
handling triggers PCIe hotplug events, and creates some interesting race
conditions:

https://marc.info/?l=linux-pci&m=152336615707640&w=2

https://www.spinics.net/lists/linux-pci/msg70614.html

> Why do we need an additional rescan in the DPC driver if the link is up
> and driver resumes operation?

I thought the plan was to have DPC always go through the removal path
to ensure all devices are properly configured when containment is
released. In order to reconfigure those, you'll need to initiate the
rescan from somewhere.
