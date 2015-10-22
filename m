Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55735 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbbJVNGO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 Oct 2015 09:06:14 -0400
Date: Thu, 22 Oct 2015 16:06:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Or Gerlitz <gerlitz.or@gmail.com>, emil.s.tantilov@intel.com,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	carolyn.wyborny@intel.com,
	"Skidmore, Donald C" <donald.c.skidmore@intel.com>, agraf@suse.de,
	matthew.vick@intel.com, intel-wired-lan@lists.osuosl.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	yang.z.zhang@intel.com,
	Mitch Williams <mitch.a.williams@intel.com>,
	nrupal.jani@intel.com, bhelgaas@google.com,
	Lan Tianyu <tianyu.lan@intel.com>,
	Linux Netdev List <netdev@vger.kernel.org>,
	Shannon Nelson <shannon.nelson@intel.com>,
	eddie.dong@intel.com, Linux Kernel <linux-kernel@vger.kernel.org>,
	john.ronciak@intel.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [RFC Patch 00/12] IXGBE: Add live migration support
 for SRIOV NIC
Message-ID: <20151022130605.GA20267@redhat.com>
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <CAJ3xEMiStMJdGjgO9=MQrhLpBo8ZiTRoOL_P=aC9kyrNi91FSw@mail.gmail.com>
 <1445455227.4059.867.camel@redhat.com>
 <20151022123252.GA19940@redhat.com>
 <1445518861.4059.869.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445518861.4059.869.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 22, 2015 at 07:01:01AM -0600, Alex Williamson wrote:
> On Thu, 2015-10-22 at 15:32 +0300, Michael S. Tsirkin wrote:
> > On Wed, Oct 21, 2015 at 01:20:27PM -0600, Alex Williamson wrote:
> > > The trouble here is that the VF needs to be unplugged prior to the start
> > > of migration because we can't do effective dirty page tracking while the
> > > device is connected and doing DMA.
> > 
> > That's exactly what patch 12/12 is trying to accomplish.
> > 
> > I do see some problems with it, but I also suggested some solutions.
> 
> I was replying to:
> 
> > So... what would you expect service down wise for the following
> > solution which is zero touch and I think should work for any VF
> > driver:
> 
> And then later note:
> 
> "Here it's done via an enlightened guest driver."

Oh, I misunderstood your intent. Sorry about that.

So we are actually in agreement between us then. That's nice.

-- 
MST
