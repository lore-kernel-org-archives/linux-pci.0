Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbeEHTZf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 May 2018 15:25:35 -0400
Date: Tue, 8 May 2018 14:25:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180508192532.GA79697@bhelgaas-glaptop.roam.corp.google.com>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <20180312194236.GA12195@bhelgaas-glaptop.roam.corp.google.com>
 <20180312232626.GI18494@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180312232626.GI18494@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 05:26:26PM -0600, Keith Busch wrote:
> On Mon, Mar 12, 2018 at 02:47:30PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 12, 2018 at 08:25:51AM -0600, Keith Busch wrote:

> > > Per spec, DPC is the recommended way for handling surprise removal
> > > events and even recommends DPC capable slots *not* set 'Surprise'
> > > in Slot Capabilities so that removals are always handled by DPC. This
> > > service driver was developed with that use in mind.
> > 
> > Thanks for this tip.  The only thing I've found so far is the mention
> > of Surprise Down triggering DPC in the last paragraph of sec 6.7.5.
> > Are there other references I should look at?  I haven't found the
> > recommendation about not setting 'Surprise' in Slot Capabilities yet.
> 
> No problem, it's in the "IMPLEMENTATION NOTE" at the end of 6.2.10.4,
> "Avoid Disabled Link and Hot-Plug Surprise Use with DPC".
> 
> Outside the spec, Microsemi as one of the PCI-SIG contributors and early
> adopters of the capability published a white paper "Hot and Surprise
> Plug Recommendations for Enterprise PCIe" providing guidance for OS
> drivers using DPC. We originally developed to that guidance. The paper
> unfortunately appears to be pay-walled now. :(

Any chance you have a URL or contact info for this pay-walled white
paper?  Sounds like it might have useful information in it.
