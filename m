Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbdH2UuB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Aug 2017 16:50:01 -0400
Date: Tue, 29 Aug 2017 15:49:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Samuel Sieb <samuel@sieb.net>
Cc: Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170829204958.GP8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170713025608.GC4486@bhelgaas-glaptop.roam.corp.google.com>
 <b1570450-1c83-1f76-ab1e-c94bd34f9b84@sieb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b1570450-1c83-1f76-ab1e-c94bd34f9b84@sieb.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 29, 2017 at 01:02:41PM -0700, Samuel Sieb wrote:
> On 07/12/2017 07:56 PM, Bjorn Helgaas wrote:
> >On Fri, Apr 07, 2017 at 04:32:18PM +0200, Joerg Roedel wrote:
> >>From: Joerg Roedel <jroedel@suse.de>
> >>
> >>ATS is broken on this hardware and causes IOMMU stalls and
> >>system failure. Disable ATS on these devices to make them
> >>usable again with IOMMU enabled.
> >>
> >>Note that the commit in the Fixes-tag is not buggy, it
> >>just uncovers the problem in the hardware by increasing
> >>the ATS-flush rate.
> >>
> >>Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
> >>Signed-off-by: Joerg Roedel <jroedel@suse.de>
> >
> >Applied with Alex's ack to pci/virtualization for v4.14, thanks!
> 
> Is there any chance of getting this into an earlier kernel?  This is
> a pretty devastating bug for users!  I'm currently providing patched
> kernels, but if they run upgrades and get a new kernel without
> noticing it, any filesystem they access will get completely mangled.

I assume you're looking to get this into stable kernels or distro
update kernels.  I don't personally deal with either of those, but for
stable kernels, see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst

For distro update kernels, you'd have to talk to the distro folks, and
I don't have contacts for those.

Bjorn
