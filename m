Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752089AbdAYVRW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Jan 2017 16:17:22 -0500
Date: Wed, 25 Jan 2017 15:17:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Austin.Bolen@dell.com
Cc: keith.busch@intel.com, gregkh@linuxfoundation.org, lukas@wunner.de,
        linux-pci@vger.kernel.org, bhelgaas@google.com, wzhang@fb.com
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20170125211718.GA18383@bhelgaas-glaptop.roam.corp.google.com>
References: <20161212234226.GA7973@bhelgaas-glaptop.roam.corp.google.com>
 <20161213005547.GA12844@localhost.localdomain>
 <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
 <20161213231840.GD12113@localhost.localdomain>
 <B58D82457FDA0744A320A2FC5AC253B93D82F37D@fmsmsx104.amr.corp.intel.com>
 <20170120213550.GA16618@localhost.localdomain>
 <20170121073140.GA26396@wunner.de>
 <20170121084243.GA24706@kroah.com>
 <20170123160452.GA10771@localhost.localdomain>
 <35db59dfeccf4c83b5cb0eb3a1cf00b1@AUSX13MPC131.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35db59dfeccf4c83b5cb0eb3a1cf00b1@AUSX13MPC131.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Austin,

Thanks a lot for bringing some more PCIe spec expertise.  I wish
we had more insight into what the spec authors were thinking
because I'm sure we often miss the point and cause face-palms on
the committee.

On Wed, Jan 25, 2017 at 12:44:34AM +0000, Austin.Bolen@dell.com wrote:
> To add to what Keith sent, I wanted to throw in my 2 cents on
> this issue.  Full disclosure - I'm not a Linux developer and so
> my thoughts on this are more from the PCIe Base Specification
> point of view and specifically, hardening the spec to better
> support PCIe hot-plug for storage use cases (NVMe) and
> providing better guidance in the PCIe spec on how system
> software can interact with the PCIe subsystem to better
> determine/handle the sort of errors that arise in PCIe removal
> scenarios.
> 
> From Dell EMC side, we would definitely like to see the config
> read routines in all operating environments return an error
> status code any time data is synthesized by the root port - but
> especially for failures due to device removal.  Today, if bad
> data is synthesized by a root port due to a failed config read,
> the config read routines in various operating environments do
> not return an error.  We, and others, have found cases where
> the caller of these config routines will consume the bad data
> since the API did not return an error due to this type of
> failure.  Most folks have been patching up every caller to
> check if data is synthesized after every config read.

How exactly do the callers do this?  By checking for all ones
data?  It's legal for a config register to contain all ones, of
course, so checking for all ones by itself is not definitive.  A
driver does have additional knowledge about what registers exist
and what their legal contents are, but of course, the config
accessor in the core does not.

> This is not very efficient as there are many entities that read
> config space (device driver, bus driver, systems management
> software, diagnostic software, etc.).   This patch, or similar,
> is very beneficial because it localizes the error checking for
> synthesized data to a single location in the core config read
> APIs rather than distributing this code to every caller.

This sounds like you mean checking for synthesized data in the
PCI core.  How can we figure that out?  Is there something in the
root port that can tell us the data was synthesized?

Is there a way to do this check for both conventional PCI and
PCIe, since we use the same config accessors for PCI and PCIe?

We support many host bridges and most of the time (x86 platforms
with ACPI) we have no bridge-specific support in Linux, so
anything we do in the core would have to be pretty generic.  I'm
sure this is all obvious, so I apologize for restating it.  I'm
just not sure what the concrete details should look like.

> The callers benefit by only requiring a simple check of the
> return status code from the API (which many are already doing).

Very roughly, I'd guess about 10% of current Linux callers check
the status code:

  $ git grep "pci_read_config" | wc -l
  2922
  $ git grep "pci_read_config" | egrep "if \(pci| = pci" | wc -l
  219

But I certainly agree that the current API is hard for callers to
deal with.

> Having the check for a removed device before reading config
> space will result in correctly returning an error for most
> failures of this nature.  There is a race condition even with
> this patch, however.  If the device is present when the check
> occurs, but is removed just after that and before the config
> read goes out, the config routine can still return bad data
> without an error status return code.  To eliminate this race
> condition where bad data is returned, I think that config read
> routines will need to have a check *after* reading the data in
> addition to the check *before* reading.  The check after
> reading would need to determine if the data was synthesized and
> return and error status if so.
> 
> I'm interested in hearing what others think on returning an
> error for this case in the core config read APIs or any
> alternative ways to more gracefully handle these types of
> errors.

> 
> Thanks,
> Austin
