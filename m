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
 <73d55003-6fcd-3741-73a1-365c73933538@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <97d4a49c-4864-42eb-7385-03747309ae55@codeaurora.org>
Date: Wed, 20 Sep 2017 11:04:10 -0400
MIME-Version: 1.0
In-Reply-To: <73d55003-6fcd-3741-73a1-365c73933538@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/20/2017 10:26 AM, Auger Eric wrote:
>> Because completions are required to be a minimum of MPS size. If MRRS > MPS,
>> read response is sent as multiple completions.
> With that patch, you can end up with MRRS < MPS. Do I understand
> correctly this is an issue?

To give the right context, I tried to mean that you can't use MRRS as a length
value for completions if MRRS is a fairly large number and bigger than MPS.

Therefore, a single completion packet size needs to be less than MRRS and cannot
exceed MPS. Spec is even calling for receivers to throw an error if completion
length is greater than MPS.

single completion <= MPS (128) <= MRRS (4k)

I looked at the spec again. I have not seen anything in the spec that prohibits
MRRS < MPS as long as completion size is less than MPS.

single completion <= MRRS (128) < MPS (256)

I think this is also valid. 

I hope I got it right this time.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
