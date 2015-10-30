Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5632D8C8.3010101@intel.com>
Date: Fri, 30 Oct 2015 10:41:12 +0800
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
References: <1445445464-5056-1-git-send-email-tianyu.lan@intel.com> <562A7E33.4080800@gmail.com> <562DBBC9.4000104@intel.com> <562E40BB.6040404@gmail.com> <5631B8CA.9040805@intel.com> <5631C3A7.2070900@gmail.com> <5631D9C2.2040206@intel.com> <56324682.5060507@gmail.com>
In-Reply-To: <56324682.5060507@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015年10月30日 00:17, Alexander Duyck wrote:
> On 10/29/2015 01:33 AM, Lan Tianyu wrote:
>> On 2015年10月29日 14:58, Alexander Duyck wrote:
>>> Your code was having to do a bunch of shuffling in order to get things
>>> set up so that you could bring the interface back up.  I would argue
>>> that it may actually be faster at least on the bring-up to just drop the
>>> old rings and start over since it greatly reduced the complexity and the
>>> amount of device related data that has to be moved.
>> If give up the old ring after migration and keep DMA running before
>> stopping VCPU, it seems we don't need to track Tx/Rx descriptor ring and
>> just make sure that all Rx buffers delivered to stack has been migrated.
>>
>> 1) Dummy write Rx buffer before checking Rx descriptor to ensure packet
>> migrated first.
> 
> Don't dummy write the Rx descriptor.  You should only really need to
> dummy write the Rx buffer and you would do so after checking the
> descriptor, not before.  Otherwise you risk corrupting the Rx buffer
> because it is possible for you to read the Rx buffer, DMA occurs, and
> then you write back the Rx buffer and now you have corrupted the memory.
> 
>> 2) Make a copy of Rx descriptor and then use the copied data to check
>> buffer status. Not use the original descriptor because it won't be
>> migrated and migration may happen between two access of the Rx
>> descriptor.
> 
> Do not just blindly copy the Rx descriptor ring.  That is a recipe for
> disaster.  The problem is DMA has to happen in a very specific order for
> things to function correctly.  The Rx buffer has to be written and then
> the Rx descriptor.  The problem is you will end up getting a read-ahead
> on the Rx descriptor ring regardless of which order you dirty things in.


Sorry, I didn't say clearly.
I meant to copy one Rx descriptor when receive rx irq and handle Rx ring.

Current code in the ixgbevf_clean_rx_irq() checks status of the Rx
descriptor whether its Rx buffer has been populated data and then read
the packet length from Rx descriptor to handle the Rx buffer.

My idea is to do the following three steps when receive Rx buffer in the
ixgbevf_clean_rx_irq().

(1) dummy write the Rx buffer first,
(2) make a copy of its Rx descriptor
(3) Check the buffer status and get length from the copy.

Migration may happen every time.
Happen between (1) and (2). If the Rx buffer has been populated data, VF
driver will not know that on the new machine because the Rx descriptor
isn't migrated. But it's still safe.

Happen between (2) and (3). The copy will be migrated to new machine
and Rx buffer is migrated firstly. If there is data in the Rx buffer,
VF driver still can handle the buffer without migrating Rx descriptor.

The next buffers will be ignored since we don't migrate Rx descriptor
for them. Their status will be not completed on the new machine.

-- 
Best regards
Tianyu Lan
