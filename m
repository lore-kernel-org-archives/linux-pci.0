Return-Path: <SRS0=TCfM=6R=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=TCfM=6R=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V4] PCI: handle CRS returned by device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, vikrams@codeaurora.org,
 Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
References: <1499375234-23928-1-git-send-email-okaya@codeaurora.org>
 <20170713234910.GB5944@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ae1846b2-1752-577b-e651-ef864953af8e@codeaurora.org>
Date: Fri, 14 Jul 2017 10:28:58 -0400
MIME-Version: 1.0
In-Reply-To: <20170713234910.GB5944@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 7/13/2017 7:49 PM, Bjorn Helgaas wrote:
> How VFs report vendor ID is irrelevant.

I was trying to highlight this. 

"SR-IOV spec rev 1.1, 3.4.1.1 & 3.4.1.2, Vendor ID and Device ID fields
for the VF return 0xFFFF when read.  The "Virtualization Intermediary"
is supposed to use the vendor ID from the PF and the device ID defined
in the PF SR-IOV capability."

https://www.spinics.net/lists/linux-pci/msg58530.html

The point is we can't use pci_bus_read_dev_vendor_id() for both
virtual and physical functions as in my V3 patch.

> 
> What *is* relevant is how FLR affects VFs.  The SR-IOV spec, r1.1,
> sec 2.2.2, says FLR doesn't affect a VF's existence in config space.
> 

I see.

> That suggests to me that reading a VF's PCI_COMMAND register after an
> FLR should always return valid data (never ~0).  I suppose an FLR VF
> reset isn't instantaneous, though, so I suppose we do need the 100ms
> delay.  But maybe we should just return immediately after that,
> without reading any VF config space?

make sense.

> 
> pci_flr_wait() was added by 5adecf817dd6 ("PCI: Wait for up to 1000ms
> after FLR reset"); maybe Alex has more insight into this.

I think code is handling both virtual and physical functions. 1 second
is nice to have for physical functions. See this comment at the top.

/*
 * We should only need to wait 100ms after FLR, but some devices take longer.
 * Wait for up to 1000ms for config space to return something other than -1.
 * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
 * dword because VFs don't implement the 1st dword.
 */

Since we are separating the handling of physical and virtual functions,
we could go back to 100ms for virtual functions and handle CRS/wait for
physical functions.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
