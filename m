Return-Path: <SRS0=QNR6=GC=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=QNR6=GC=intel.com=keith.busch@kernel.org>
Date: Mon, 12 Mar 2018 08:25:51 -0600
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
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180312142551.GB18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 11, 2018 at 11:03:58PM -0400, Sinan Kaya wrote:
> On 3/11/2018 6:03 PM, Bjorn Helgaas wrote:
> > On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
> 
> > That difference has been there since the beginning of DPC, so it has
> > nothing to do with *this* series EXCEPT for the fact that it really
> > complicates the logic you're adding to reset_link() and
> > broadcast_error_message().
> > 
> > We ought to be able to simplify that somehow because the only real
> > difference between AER and DPC should be that DPC automatically
> > disables the link and AER does it in software.
> 
> I agree this should be possible. Code execution path should be almost
> identical to fatal error case.
> 
> Is there any reason why you went to stop driver path, Keith?

The fact is the link is truly down during a DPC event. When the link
is enabled again, you don't know at that point if the device(s) on the
other side have changed. Calling a driver's error handler for the wrong
device in an unknown state may have undefined results. Enumerating the
slot from scratch should be safe, and will assign resources, tune bus
settings, and bind to the matching driver.

Per spec, DPC is the recommended way for handling surprise removal
events and even recommends DPC capable slots *not* set 'Surprise'
in Slot Capabilities so that removals are always handled by DPC. This
service driver was developed with that use in mind.
