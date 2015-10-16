Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 16 Oct 2015 11:56:28 -0500
From: Ben Shelton <benjamin.h.shelton@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: IOV: read SRIOV_NUM_VF after enabling ARI
Message-ID: <20151016165627.GA52728@bhshelto-vm>
References: <1444317617-13399-1-git-send-email-benjamin.h.shelton@intel.com>
 <20151015175825.GD17702@localhost>
 <562005F7.7030205@gmail.com>
 <20151015213603.GB13636@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20151015213603.GB13636@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

> What problem does this patch solve, Ben?  I assume you have devices
> that do change TotalVFs when ARI is enabled, and you do want the new
> value?
> 
> Or is the problem something like the following:
> 
>   - ...
>   - Linux PCI core sees TotalVFs = X (saved as iov->total_VFs)
>   - Linux sets ARI Capable Hierarchy
>   - Device changes TotalVFs to X + Y (but PCI core doesn't notice)
>   - Driver reads TotalVFs and sees X + Y
>   - Driver attempts pci_enable_sriov(dev, X + Y), which fails because
>     sriov_enable() sees "X + Y > iov->total_VFs"

Here's a short snippet from the databook for the PCI Express controller we're
using:

"Supports two sets of VF Stride, First VF Offset, InitialVFs, and TotalVFs
registers per PF—one each for ARI and non-ARI hierarchies. Selection is
performed by host software through the ARI Capable Hierarchy bit of the Control
register in the PF0 SR-IOV capability structure."

The values in InitialVFs and TotalVFs are HWinit for each set of registers.

So the issue this is intended to fix is the following:

- Linux PCI core sees TotalVFs = X (saved as iov->total_VFs).
- Linux sets ARI Capable Hierarchy.
- Device switches to exposing the second set of registers, where
  InitialVFs = TotalVFs = Y (where Y > X).
- User enables one or more VFs on the device, e.g. by writing a value to
  sriov_numvfs in the sysfs.
- Driver calls pci_enable_sriov() for the device, which then calls
  sriov_enable().  sriov_enable() reads InitialVFs (= Y) and then checks if it's
  greater than iov->total_VFs (= X).  Since Y > X, the comparison is true, so
  sriov_enable() fails out and returns -EIO.

> 
> I'm a little dubious about drivers reading the SRIOV capability
> directly, so maybe this is a symptom of deeper problems.

I agree that the driver should not be reading the capability directly, but from
what I understand, it's intended for the device itself to do this.  From the PCI
SR-IOV spec revision 1.1:

"ARI Capable Hierarchy is a hint to the Device that ARI has been enabled in the
Root Port or Switch Downstream Port immediately above the Device."

Ben

> 
> Bjorn
