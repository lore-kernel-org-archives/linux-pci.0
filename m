Return-Path: <SRS0=20La=ZV=broadcom.com=jon.mason@kernel.org>
Return-Path: <SRS0=20La=ZV=broadcom.com=jon.mason@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170208215508.GA4800@bhelgaas-glaptop.roam.corp.google.com>
References: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com> <20170208215508.GA4800@bhelgaas-glaptop.roam.corp.google.com>
From: Jon Mason <jon.mason@broadcom.com>
Date: Wed, 8 Feb 2017 17:33:46 -0500
Message-ID: <CAC3K-4o2czeCdtATwZCLzN9H-PaPUgm5GaUXqBsAFD2ueuUDCw@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: iproc: MPS fix and quirks
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 8, 2017 at 4:55 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Jan 27, 2017 at 04:44:07PM -0500, Jon Mason wrote:
>> A patch that corrects an issue where the MPS could not be set, and
>> another that fixes some quirks in the PAXC
>>
>> Jon Mason (2):
>>   PCI: iproc: allow the MPS to be set
>>   PCI: Add quirk entry for NS2 PAXC PCI
>>
>>  drivers/pci/host/pcie-iproc.c |  5 ++++-
>>  drivers/pci/quirks.c          | 21 +++++++++++++++++++++
>>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> Applied with Ray's ack to pci/host-iproc for v4.11, thanks!
>
> It looks to me like several other drivers need a similar MPS fix.
> I'll CC you on the patches.

I'm happy to look at whatever you want to CC me on, but this is an SoC
thing that I do not believe is applicable to the standard PCI device
(if that is what you are referring to).

Thanks,
Jon

>
> Bjorn
