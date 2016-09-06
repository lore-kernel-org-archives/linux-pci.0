Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
Date: Tue, 6 Sep 2016 13:33:26 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] pci/aer: Add bus flag to skip source id matching
Message-ID: <20160906193325.GA14374@localhost.localdomain>
References: <1472167571-11123-1-git-send-email-jonathan.derrick@intel.com>
 <20160906192344.GD7554@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160906192344.GD7554@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 06, 2016 at 02:23:44PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 25, 2016 at 05:26:10PM -0600, Jon Derrick wrote:
> > Allow root port buses to choose to skip source id matching when finding
> > the faulting device. Certain root port devices may return an incorrect
> > source id and recommend to scan child device registers for aer
> > notifications.
> > 
> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> 
> Applied both of these to pci/host-vmd for v4.9, thanks!
Thanks!

> 
> I think I might even go farther and remove the "nosourceid" module
> parameter.  Per Documentation/PCI/pcieaer-howto.txt, it's to work
> around broken hardware, but it's not otherwise documented.  With the
> flag you're adding, we could add quirks for that broken hardware,
> which would be far better.  I doubt anybody's actually using that
> module parameter.
Yes I'll agree that it makes more sense to call out the nonconforming hardware and have their quirk/fix inbox
