Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] vfio/pci: Virtualize Maximum Payload Size
To: Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20170919164952.13200.78849.stgit@gimli.home>
 <c3bbb645-50a9-a1b4-c8f2-8973f0478a2a@redhat.com>
 <20170919142024.05723289@t450s.home>
 <3dd92928-3cda-50c1-6a67-10721c003c10@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a609bc8b-8c5b-0828-d175-50985d688fe3@codeaurora.org>
Date: Wed, 20 Sep 2017 09:01:09 -0400
MIME-Version: 1.0
In-Reply-To: <3dd92928-3cda-50c1-6a67-10721c003c10@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/20/2017 3:59 AM, Auger Eric wrote:
>> My impression is that MRRS is predominantly device and driver
>> dependent, not topology dependent.  A device can send a read request
>> with a size larger than MPS, which implies that the device supplying
>> the read data would split it into multiple TLPs based on MPS.
> I read that too on the net. However in in 6.3.4.1. (3.0. Nov 10), Rules
> for SW Configuration it is written:
> "Software must set Max_Read_Request_Size of an isochronous-configured
> device with a value that does not exceed the Max_Payload_Size set for
> the device."
> 
> But on the the other hand some drivers are setting the MMRS directly
> without further checking the MPS?

We discussed this on LPC. MRRS and MPS are two independent concepts and
are not related to each other under normal circumstances. 

The only valid criteria is that MRRS needs to be a multiple of MPS.

https://linuxplumbersconf.org/2017/ocw//system/presentations/4732/original/crs.pdf

Because completions are required to be a minimum of MPS size. If MRRS > MPS,
read response is sent as multiple completions.

The only reason you want to match MRRS==MPS is that you don't want a single
device to hog system resources. You can have MRRS 4k and MPS 128 bytes. Completions
come in as 128 x N packets on the PCI bus. 

If you are sharing the same PCI bus with some other device, switch; you are effectively
stalling other devices. That's why, isochronous devices are requesting small MRRS.

An Isochronous device is an exception not norm.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
