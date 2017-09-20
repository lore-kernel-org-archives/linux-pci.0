Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] vfio/pci: Virtualize Maximum Payload Size
To: Alex Williamson <alex.williamson@redhat.com>,
        Auger Eric <eric.auger@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jcm@redhat.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20170919164952.13200.78849.stgit@gimli.home>
 <c3bbb645-50a9-a1b4-c8f2-8973f0478a2a@redhat.com>
 <20170919142024.05723289@t450s.home>
 <3dd92928-3cda-50c1-6a67-10721c003c10@redhat.com>
 <a609bc8b-8c5b-0828-d175-50985d688fe3@codeaurora.org>
 <73d55003-6fcd-3741-73a1-365c73933538@redhat.com>
 <20170920101133.33b68d8f@w520.home>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2c094ad6-4641-ebee-7faa-21ad9beeca72@codeaurora.org>
Date: Wed, 20 Sep 2017 12:29:26 -0400
MIME-Version: 1.0
In-Reply-To: <20170920101133.33b68d8f@w520.home>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/20/2017 12:11 PM, Alex Williamson wrote:
> My impression is that the issue would be inefficiency.  There should be
> nothing functionally wrong with a read request less than MPS, but we're
> not "filling" the TLP as much as the topology allows.  Is that your
> understanding as well, Sinan?

That's my understanding as well. It would be a performance hit to use a
value less than MPS.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
