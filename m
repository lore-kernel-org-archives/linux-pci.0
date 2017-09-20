Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbdITO0a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Sep 2017 10:26:30 -0400
Subject: Re: [PATCH] vfio/pci: Virtualize Maximum Payload Size
To: Sinan Kaya <okaya@codeaurora.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20170919164952.13200.78849.stgit@gimli.home>
 <c3bbb645-50a9-a1b4-c8f2-8973f0478a2a@redhat.com>
 <20170919142024.05723289@t450s.home>
 <3dd92928-3cda-50c1-6a67-10721c003c10@redhat.com>
 <a609bc8b-8c5b-0828-d175-50985d688fe3@codeaurora.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <73d55003-6fcd-3741-73a1-365c73933538@redhat.com>
Date: Wed, 20 Sep 2017 16:26:25 +0200
MIME-Version: 1.0
In-Reply-To: <a609bc8b-8c5b-0828-d175-50985d688fe3@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On 20/09/2017 15:01, Sinan Kaya wrote:
> On 9/20/2017 3:59 AM, Auger Eric wrote:
>>> My impression is that MRRS is predominantly device and driver
>>> dependent, not topology dependent.  A device can send a read request
>>> with a size larger than MPS, which implies that the device supplying
>>> the read data would split it into multiple TLPs based on MPS.
>> I read that too on the net. However in in 6.3.4.1. (3.0. Nov 10), Rules
>> for SW Configuration it is written:
>> "Software must set Max_Read_Request_Size of an isochronous-configured
>> device with a value that does not exceed the Max_Payload_Size set for
>> the device."
>>
>> But on the the other hand some drivers are setting the MMRS directly
>> without further checking the MPS?
> 
> We discussed this on LPC. MRRS and MPS are two independent concepts and
> are not related to each other under normal circumstances. 
> 
> The only valid criteria is that MRRS needs to be a multiple of MPS.
> 
> https://linuxplumbersconf.org/2017/ocw//system/presentations/4732/original/crs.pdf
> 
> Because completions are required to be a minimum of MPS size. If MRRS > MPS,
> read response is sent as multiple completions.

With that patch, you can end up with MRRS < MPS. Do I understand
correctly this is an issue?

Thanks

Eric
> 
> The only reason you want to match MRRS==MPS is that you don't want a single
> device to hog system resources. You can have MRRS 4k and MPS 128 bytes. Completions
> come in as 128 x N packets on the PCI bus. 
> 
> If you are sharing the same PCI bus with some other device, switch; you are effectively
> stalling other devices. That's why, isochronous devices are requesting small MRRS.
> 
> An Isochronous device is an exception not norm.
> 
