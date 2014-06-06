Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:43619 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbaFFRC7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jun 2014 13:02:59 -0400
Message-id: <5391F438.90703@samsung.com>
Date: Fri, 06 Jun 2014 11:02:48 -0600
From: Shuah Khan <shuah.kh@samsung.com>
Reply-to: shuah.kh@samsung.com
MIME-version: 1.0
To: Eli Billauer <eli.billauer@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, devel@driverdev.osuosl.org,
	discuss@x86-64.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH v2 1/4] dma-mapping: Add devm_ interface for
 dma_map_single()
References: <1401606077-1739-1-git-send-email-eli.billauer@gmail.com>
 <1401606077-1739-2-git-send-email-eli.billauer@gmail.com>
 <538E3D04.9060808@samsung.com> <20140603233907.GB23880@8bytes.org>
 <20140604140408.GC5004@htj.dyndns.org> <20140604141211.GC23880@8bytes.org>
 <20140604141416.GD5004@htj.dyndns.org> <538F3548.4050101@gmail.com>
 <20140604212525.GE23880@8bytes.org> <5391A9C2.3040602@gmail.com>
 <20140606160103.GG15110@kroah.com> <5391EA92.9050306@gmail.com>
In-reply-to: <5391EA92.9050306@gmail.com>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/06/2014 10:21 AM, Eli Billauer wrote:
> On 06/06/14 19:01, Greg KH wrote:
>>> Please try to put yourself in my position: I have a driver that I care
>>> >  about, which works fine for a few years. It's based upon
>>> dma_map_single(),
>>> >  which seems to be the common way to get non-coherent memory, even
>>> for the
>>> >  driver's entire lifespan. I realize that dma_alloc_* was the
>>> intended way to
>>> >  do it, but fact is that dma_map_* has become the common choice.
>>>
>> Is your driver in the kernel tree?  If not, you really are on your own :(
>>
> It's the Xillybus driver in the staging area. I don't know if this
> counts for being in the kernel tree...
>
> The suggested patchset would allow replacing my use of dma_map_single()
> with a managed version of that function. This will clean the driver's
> code considerably.
>
> But I think that the discussion here is if it's valid to use
> dma_map_single() for a device-permanent DMA mapping, or if
> dma_alloc_noncoherent() is the only way. If the answer is no, there's
> quite obviously no point in a devres version for that function.
>

Eli,

dma_map_single() and dma_unmap_single() are streaming DMA APIs. These
are intended for one DMA transfer and unmapped right after it is done.

dma buffers are limited shared resources for streaming that are
shared by several drivers. Hence the need for use and release
model.

Please refer to the Using Streaming DMA mappings in DMA-API-HOWTO.txt

"- Streaming DMA mappings which are usually mapped for one DMA
   transfer, unmapped right after it (unless you use dma_sync_* below)
   and for which hardware can optimize for sequential accesses.

   This of "streaming" as "asynchronous" or "outside the coherency
   domain".

   Good examples of what to use streaming mappings for are:

         - Networking buffers transmitted/received by a device.
         - Filesystem buffers written/read by a SCSI device."


If I understand your intended usage correctly, you are looking to
allocate and hold the buffers for the lifetime of the driver. For
such cases, dma_alloc_*() interfaces are the ones to use.

Please also refer to DMA-API.txt as well. Hope this helps.

-- Shuah


-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658
