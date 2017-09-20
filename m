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
 <a609bc8b-8c5b-0828-d175-50985d688fe3@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2d1bb8bf-074b-493b-ff39-3c053fc5f32e@codeaurora.org>
Date: Wed, 20 Sep 2017 09:02:23 -0400
MIME-Version: 1.0
In-Reply-To: <a609bc8b-8c5b-0828-d175-50985d688fe3@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/20/2017 9:01 AM, Sinan Kaya wrote:
> The only valid criteria is that MRRS needs to be a multiple of MPS.
> 
> https://linuxplumbersconf.org/2017/ocw//system/presentations/4732/original/crs.pdf
> 

Apologies for sending the wrong link. Correcting it.

https://linuxplumbersconf.org/2017/ocw//system/presentations/4737/original/mps.pdf

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
