Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33822 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbbJ2G6t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2015 02:58:49 -0400
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
 <562E40BB.6040404@gmail.com> <5631B8CA.9040805@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <5631C3A7.2070900@gmail.com>
Date: Wed, 28 Oct 2015 23:58:47 -0700
MIME-Version: 1.0
In-Reply-To: <5631B8CA.9040805@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/28/2015 11:12 PM, Lan Tianyu wrote:
> On 2015年10月26日 23:03, Alexander Duyck wrote:
>> No.  I think you are missing the fact that there are 256 descriptors per
>> page.  As such if you dirty just 1 you will be pulling in 255 more, of
>> which you may or may not have pulled in the receive buffer for.
>>
>> So for example if you have the descriptor ring size set to 256 then that
>> means you are going to get whatever the descriptor ring has since you
>> will be marking the entire ring dirty with every packet processed,
>> however you cannot guarantee that you are going to get all of the
>> receive buffers unless you go through and flush the entire ring prior to
>> migrating.
>
> Yes, that will be a problem. How about adding tag for each Rx buffer and
> check the tag when deliver the Rx buffer to stack? If tag has been
> overwritten, this means the packet data has been migrated.

Then you have to come up with a pattern that you can guarantee is the 
tag and not part of the packet data.  That isn't going to be something 
that is easy to do.  It would also have a serious performance impact on 
the VF.

>> This is why I have said you will need to do something to force the rings
>> to be flushed such as initiating a PM suspend prior to migrating.  You
>> need to do something to stop the DMA and flush the remaining Rx buffers
>> if you want to have any hope of being able to migrate the Rx in a
>> consistent state.  Beyond that the only other thing you have to worry
>> about are the Rx buffers that have already been handed off to the
>> stack.  However those should be handled if you do a suspend and somehow
>> flag pages as dirty when they are unmapped from the DMA.
>>
>> - Alex
> This will be simple and maybe our first version to enable migration. But
> we still hope to find a way not to disable DMA before stopping VCPU to
> decrease service down time.

You have to stop the Rx DMA at some point anyway.  It is the only means 
to guarantee that the device stops updating buffers and descriptors so 
that you will have a consistent state.

Your code was having to do a bunch of shuffling in order to get things 
set up so that you could bring the interface back up.  I would argue 
that it may actually be faster at least on the bring-up to just drop the 
old rings and start over since it greatly reduced the complexity and the 
amount of device related data that has to be moved.

