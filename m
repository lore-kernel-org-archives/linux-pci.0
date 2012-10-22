Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50116 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932171Ab2JVW2K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Oct 2012 18:28:10 -0400
Message-ID: <5085C878.3000307@redhat.com>
Date: Mon, 22 Oct 2012 18:28:08 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Pat Erley <pat-lkml@erley.org>
CC: linux-pci@vger.kernel.org
Subject: Re: Ricoh Multifunction Device DMAR Bug
References: <5081F0D2.50509@erley.org>
In-Reply-To: <5081F0D2.50509@erley.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/19/2012 08:31 PM, Pat Erley wrote:
> I've been hitting the bug talked about in this thread:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=605888
>
> and using the patch in Comment 7 as a work around. In reading on, I saw that redhat released a kernel (kernel-2.6.35.6-45.fc14) that contains a patch like this:
>
The proposed fedora patch was to demo how identifying the ricoh device,
and pointing it's IOMMU resources to be the same as the fcn-0 device
was a proof of concept.
Being in the main-line, high-frequency map-single function would
destroy the performance for all devices on all systems, even those w/o ricoh device.
So, although 'it works', it has poor performance.
Now, if you only care about isolation/protection, and not performance, it works for you! :)
But for all other systems, the patch is a non-starter.

I believe the final solution was to disable iommu on these systems.

Devices behaving badly (using wrong src-id of DMA xactions).

> http://lists.fedoraproject.org/pipermail/scm-commits/2010-October/510785.html
>
> Is there any reason to omit this from mainline? The patch that redhat is using seems like a 'better' fix than the fixup I'm using from Comment 7, but does that completely disable DMAR when this device is present? That seems like an overkill approach, when there is the hack from the thread from redhat's bugzilla. Is there some other impact from the patch I'm using? Everything works fine on my system with it.
>
> Anyways, the point to all of this was, I really don't like having to carry patches and apply them with each update. I'd love to see some fixup get into mainline, especially if it can be minimal impact on functionality, like the first thread linked here. Is there anything else I can provide to help facilitate this?
>
> Pat Erley
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

