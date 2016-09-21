Return-Path: <rjw@rjwysocki.net>
Return-Path: <rjw@rjwysocki.net>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tyler Baicar <tbaicar@codeaurora.org>, lenb@kernel.org, bhelgaas@google.com, paul.gortmaker@windriver.com, sudipm.mukherjee@gmail.com, axboe@fb.com, izumi.taku@jp.fujitsu.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bp@suse.de
Subject: Re: [PATCH V2 0/2] Correct AER severity for printing AER information
Date: Wed, 21 Sep 2016 02:27:10 +0200
Message-ID: <4757037.bRpWDgK618@vostro.rjw.lan>
In-Reply-To: <20160920194103.GD4941@localhost>
References: <1473887686-24420-1-git-send-email-tbaicar@codeaurora.org> <20160920194103.GD4941@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, September 20, 2016 02:41:03 PM Bjorn Helgaas wrote:
> On Wed, Sep 14, 2016 at 03:14:44PM -0600, Tyler Baicar wrote:
> > AER severity handling has two issues that cause the AER information to
> > be printed incorrectly. The first issue is that the function to calculate
> > the AER severity is called twice in the code path to print the AER
> > information. The second issue is that the original call to calculate the
> > AER severity expects the CPER severity but is recieving the GHES
> > severity.
> > 
> > V2: Fix minor typo in commit text.
> > 
> > V1: https://lkml.org/lkml/2016/9/12/1075
> > 
> > Tyler Baicar (2):
> >   PCI/AER: Remove duplicate AER severity translation
> >   acpi: apei: send correct severity to calculate AER severity
> > 
> >  drivers/acpi/apei/ghes.c               | 2 +-
> >  drivers/pci/pcie/aer/aerdrv_errprint.c | 6 ++----
> >  include/linux/aer.h                    | 2 +-
> >  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> I applied both to pci/aer for v4.9, thanks!
> 
> Rafael, the second one is strictly ACPI, and I'd be happy to let you
> deal with it if you prefer.

It can go in via PCI I think.  Either way is fine by me actually. :-)

Thanks,
Rafael
