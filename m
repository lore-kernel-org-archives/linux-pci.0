Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] vfio/pci: Virtualize Maximum Payload Size
To: Sinan Kaya <okaya@codeaurora.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20170919164952.13200.78849.stgit@gimli.home>
 <c3bbb645-50a9-a1b4-c8f2-8973f0478a2a@redhat.com>
 <20170919142024.05723289@t450s.home>
 <3dd92928-3cda-50c1-6a67-10721c003c10@redhat.com>
 <a609bc8b-8c5b-0828-d175-50985d688fe3@codeaurora.org>
 <73d55003-6fcd-3741-73a1-365c73933538@redhat.com>
 <20170920101133.33b68d8f@w520.home>
 <2c094ad6-4641-ebee-7faa-21ad9beeca72@codeaurora.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d6f4c641-c9c1-255a-18e5-e7956bbcac6a@redhat.com>
Date: Thu, 21 Sep 2017 08:36:30 +0200
MIME-Version: 1.0
In-Reply-To: <2c094ad6-4641-ebee-7faa-21ad9beeca72@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On 20/09/2017 18:29, Sinan Kaya wrote:
> On 9/20/2017 12:11 PM, Alex Williamson wrote:
>> My impression is that the issue would be inefficiency.  There should be
>> nothing functionally wrong with a read request less than MPS, but we're
>> not "filling" the TLP as much as the topology allows.  Is that your
>> understanding as well, Sinan?
> 
> That's my understanding as well. It would be a performance hit to use a
> value less than MPS.
> 
> 

Thank you for your explanations.

best Regards

Eric
