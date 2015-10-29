Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62321 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbbJ2Iob (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 04:44:31 -0400
Message-ID: <5631D9C2.2040206@intel.com>
Date: Thu, 29 Oct 2015 16:33:06 +0800
From: Lan Tianyu <tianyu.lan@intel.com>
MIME-Version: 1.0
To: Alexander Duyck <alexander.duyck@gmail.com>, bhelgaas@google.com,
	carolyn.wyborny@intel.com, donald.c.skidmore@intel.com,
	eddie.dong@intel.com, nrupal.jani@intel.com,
	yang.z.zhang@intel.com, agraf@suse.de, kvm@vger.kernel.org,
	pbonzini@redhat.com, qemu-devel@nongnu.org,
	emil.s.tantilov@intel.com, intel-wired-lan@lists.osuosl.org,
	jeffrey.t.kirsher@intel.com, jesse.brandeburg@intel.com,
	john.ronciak@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, matthew.vick@intel.com,
	mitch.a.williams@intel.com, netdev@vger.kernel.org,
	shannon.nelson@intel.com
Subject: Re: [RFC Patch 00/12] IXGBE: Add live migration support for SRIOV
 NIC
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com> <562A7E33.4080800@gmail.com> <562DBBC9.4000104@intel.com> <562E40BB.6040404@gmail.com> <5631B8CA.9040805@intel.com> <5631C3A7.2070900@gmail.com>
In-Reply-To: <5631C3A7.2070900@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015年10月29日 14:58, Alexander Duyck wrote:
> 
> Your code was having to do a bunch of shuffling in order to get things
> set up so that you could bring the interface back up.  I would argue
> that it may actually be faster at least on the bring-up to just drop the
> old rings and start over since it greatly reduced the complexity and the
> amount of device related data that has to be moved.

If give up the old ring after migration and keep DMA running before
stopping VCPU, it seems we don't need to track Tx/Rx descriptor ring and
just make sure that all Rx buffers delivered to stack has been migrated.

1) Dummy write Rx buffer before checking Rx descriptor to ensure packet
migrated first.

2) Make a copy of Rx descriptor and then use the copied data to check
buffer status. Not use the original descriptor because it won't be
migrated and migration may happen between two access of the Rx descriptor.

-- 
Best regards
Tianyu Lan
