Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 15 Oct 2015 16:36:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Ben Shelton <benjamin.h.shelton@intel.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: IOV: read SRIOV_NUM_VF after enabling ARI
Message-ID: <20151015213603.GB13636@localhost>
References: <1444317617-13399-1-git-send-email-benjamin.h.shelton@intel.com>
 <20151015175825.GD17702@localhost>
 <562005F7.7030205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <562005F7.7030205@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 15, 2015 at 01:00:55PM -0700, Alexander Duyck wrote:
> On 10/15/2015 10:58 AM, Bjorn Helgaas wrote:
> >Hi Ben,
> >
> >On Thu, Oct 08, 2015 at 10:20:17AM -0500, Ben Shelton wrote:
> >>For some SR-IOV devices, the number of available virtual functions increases
> >>after enabling ARI.  Currently, SRIOV_NUM_VF is read and saved off before the
> >>ARI control bit is enabled in SRIOV_CTRL.  This causes an issue when VFs are
> >>enabled.
> >>
> >>At device init, SRIOV_INITIAL_VF and SRIOV_NUM_VF are specified to contain the
> >>number of available VFs for the device.  sriov_enable() does a sanity check
> >>that SRIOV_INITIAL_VF is not greater than iov->total_VFs, the saved-off value
> >>of SRIOV_NUM_VF.  Since the value of both SRIOV_INITIAL_VF and SRIOV_NUM_VF has
> >>increased after enabling the ARI bit, the check fails, and the VFs cannot be
> >>enabled.
> >>
> >>To fix the issue, write SRIOV_CTRL first, and then read SRIOV_NUM_VF.
> >
> >I think you mean PCI_SRIOV_TOTAL_VR (not NUM_VF), right?
> >
> >This is interesting because the spec says TotalVFs is HwInit, which
> >means it's read-only, and it doesn't mention anything about it
> >changing when ARIis enabled.  I can see why it would change in that
> >case, so maybe this is just a goof in the spec.
> 
> I think it is supposed to be HwInit because changing the value can
> cause issues with resource allocation for the VFs.  Specifically if
> the number of VFs increases after the BIOS has come through and
> assigned MMIO resources it is possible that there may not be
> resources available.

Maybe, although sufficiently smart software could deal with that by
reassigning resources.  Theoretically, anyway.

> I suspect we are going to end up having to quirk a number of devices
> in the future because of this as I can see this easily causing
> issues.

I guess the issue if we made this change would be:

  - BIOS sees "ARI Capable Hierarchy" is zero
  - BIOS sees TotalVFs = X
  - BIOS allocates space for X VFs (size = "S * X")
  - Linux sets ARI Capable Hierarchy
  - Linux sees TotalVFs = X + Y
  - Linux reads SR-IOV BAR, computes size as "S * (X + Y)"
  - Linux tries to claim SR-IOV BAR, but fails because size is now too
    large to fit where BIOS put it

Right?  What sort of quirk would you envision?  Something to keep us
from increasing "total" beyond what it was before we turned on ARI
Capable?

What problem does this patch solve, Ben?  I assume you have devices
that do change TotalVFs when ARI is enabled, and you do want the new
value?

Or is the problem something like the following:

  - ...
  - Linux PCI core sees TotalVFs = X (saved as iov->total_VFs)
  - Linux sets ARI Capable Hierarchy
  - Device changes TotalVFs to X + Y (but PCI core doesn't notice)
  - Driver reads TotalVFs and sees X + Y
  - Driver attempts pci_enable_sriov(dev, X + Y), which fails because
    sriov_enable() sees "X + Y > iov->total_VFs"

I'm a little dubious about drivers reading the SRIOV capability
directly, so maybe this is a symptom of deeper problems.

Bjorn
