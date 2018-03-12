Return-Path: <SRS0=QNR6=GC=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=QNR6=GC=intel.com=keith.busch@kernel.org>
Date: Mon, 12 Mar 2018 11:56:30 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: poza@codeaurora.org, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180312175630.GF18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
 <20180312145823.GC18494@localhost.localdomain>
 <eb2810113f98c2ff8201da1a0f827493@codeaurora.org>
 <20180312173301.GD18494@localhost.localdomain>
 <57d0b245-aecb-1518-c8bb-df8b69a86bcc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57d0b245-aecb-1518-c8bb-df8b69a86bcc@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 01:41:07PM -0400, Sinan Kaya wrote:
> I was just writing a reply to you. You acted first :)
> 
> On 3/12/2018 1:33 PM, Keith Busch wrote:
> >>> After releasing a slot from DPC, the link is allowed to retrain. If
> >>> there
> >>> is a working device on the other side, a link up event occurs. That
> >>> event is handled by the pciehp driver, and that schedules enumeration
> >>> no matter what you do to the DPC driver.
> >> yes, that is what i current, but this patch-set makes DPC aware of error
> >> handling driver callbacks.
> > I've been questioning the utility of doing that since the very first
> > version of this patch set.
> > 
> 
> I think we should all agree that shutting down the device drivers with active
> work is not safe. There could be outstanding work that the endpoint driver
> needs to take care of. 
> 
> That was the motivation for this change so that we give endpoint drivers an 
> error callback when something goes wrong. 
> 
> The rest is implementation detail that we can all figure out.

I'm not sure if I agree here. All Linux device drivers are supposed to
cope with sudden/unexpected loss of communication at any time. This
includes cleaning up appropriately when requested to unbind from an
inaccessible device with active outstanding work.
