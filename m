Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:32872 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933974AbeFLOlt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jun 2018 10:41:49 -0400
Date: Tue, 12 Jun 2018 08:44:44 -0600
From: Keith Busch <keith.busch@intel.com>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/AER: Prevent runtime power management during recovery
Message-ID: <20180612144443.GA3142@localhost.localdomain>
References: <20180611222918.1708-1-keith.busch@intel.com>
 <08e0ba9f-69cd-ea18-ae1b-d0795cceb306@codeaurora.org>
 <76f700a5484d82529272d94b4531e434@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <76f700a5484d82529272d94b4531e434@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 12, 2018 at 01:21:53PM +0530, poza@codeaurora.org wrote:
> On 2018-06-12 10:10, Sinan Kaya wrote:
> > On 6/11/2018 6:29 PM, Keith Busch wrote:
> > > A bridge that supports D3 but not hotplug will be subject to runtime
> > > power management placing it in a non-operation power state if it
> > > doesn't
> > > have any devices attached. This patch will prevent this power
> > > management
> > > during error recovery so that the rescan at the end may be successful.
> > 
> > If there is no card connected, why would the bridge observe a fatal
> > error?
> 
> fatal error could be coming from anywhere let us say below RootPort..
> and RP observes it and decides to take the tree down....
> Is that the case Keith is talking about ?

Right, the err fatal handling removes all the devices below a bridge,
making that bridge allowed for run time d3.
 
> Why will re-enumeration be a problem even if runtime PM is active ?
> I assume that enumeration will get bridge out of D3.

That doesn't seem to be the case.
