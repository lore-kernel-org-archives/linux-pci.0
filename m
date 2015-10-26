Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35709 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbbJZPD0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2015 11:03:26 -0400
Subject: Re: [RFC Patch 00/12] IXGBE: Add live migration support for SRIOV NIC
To: Lan Tianyu <tianyu.lan@intel.com>, bhelgaas@google.com,
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
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com>
 <562A7E33.4080800@gmail.com> <562DBBC9.4000104@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <562E40BB.6040404@gmail.com>
Date: Mon, 26 Oct 2015 08:03:23 -0700
MIME-Version: 1.0
In-Reply-To: <562DBBC9.4000104@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/25/2015 10:36 PM, Lan Tianyu wrote:
> On 2015年10月24日 02:36, Alexander Duyck wrote:
>> I was thinking about it and I am pretty sure the dummy write approach is
>> problematic at best.  Specifically the issue is that while you are
>> performing a dummy write you risk pulling in descriptors for data that
>> hasn't been dummy written to yet.  So when you resume and restore your
>> descriptors you will have once that may contain Rx descriptors
>> indicating they contain data when after the migration they don't.
> How about changing sequence? dummy writing Rx packet data fist and then
> its desc. This can ensure that RX data is migrated before its desc and
> prevent such case.

No.  I think you are missing the fact that there are 256 descriptors per 
page.  As such if you dirty just 1 you will be pulling in 255 more, of 
which you may or may not have pulled in the receive buffer for.

So for example if you have the descriptor ring size set to 256 then that 
means you are going to get whatever the descriptor ring has since you 
will be marking the entire ring dirty with every packet processed, 
however you cannot guarantee that you are going to get all of the 
receive buffers unless you go through and flush the entire ring prior to 
migrating.

This is why I have said you will need to do something to force the rings 
to be flushed such as initiating a PM suspend prior to migrating.  You 
need to do something to stop the DMA and flush the remaining Rx buffers 
if you want to have any hope of being able to migrate the Rx in a 
consistent state.  Beyond that the only other thing you have to worry 
about are the Rx buffers that have already been handed off to the 
stack.  However those should be handled if you do a suspend and somehow 
flag pages as dirty when they are unmapped from the DMA.

- Alex
