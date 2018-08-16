Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40264 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731260AbeHPLZk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 07:25:40 -0400
Message-ID: <6382ee9197b781f5f5680aa60176f937669a0a13.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: poza@codeaurora.org
Cc: okaya@kernel.org, Thomas Tai <thomas.tai@oracle.com>,
        bhelgaas@google.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 16 Aug 2018 18:28:28 +1000
In-Reply-To: <f022581a9ecb88e5501a09bdcdc62954@codeaurora.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
         <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
         <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
         <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
         <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
         <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
         <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
         <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
         <42bd39aef30fe24bfc48d378e1f5d35d@codeaurora.org>
         <54d19e0e3d44bedf247853144c6bbfed5561a125.camel@kernel.crashing.org>
         <f022581a9ecb88e5501a09bdcdc62954@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-16 at 13:52 +0530, poza@codeaurora.org wrote:
> 
> ok lets start with what we have rather than going back, because 
> reverting the changes is not going to solve anything

I'm not saying you should revert the DPC/AER changes, but I want to
revert the *spec* changes, they are wrong and they make EEH now not
match the spec.

IE. Documentation/PCI/pci-error-recovery.txt

> as I mentioned the behavior of some of the functions and DPC (was the 
> same before and now)
> but the good thing happened because of the patches is; there is a common 
> framework defined in err.c
> and DPC and AER both act on similar rules (the rule is what we define 
> understanding of SPEC)

Depends what you call spec. I'm talking about the Linux error recovery
specification.

Let's not muddle it with the PCIe spec itself, or I'll start quoting
Linus about the general usefulness of specs :-)

What we need to do is how we want Linux and drivers to behave for error
recovery, more / less *regardless* of what the PCIe spec says because
HW specs are invariably wrong and HW implementations ignore them more
often than not anyway.

> and all we have to do is discuss and evolve it or change it
> we can catch up on webex, (Sinan is going to be there in Plumber's 
> conference, I might not be able to join there, as we have bring-up 
> coming)

Ok, I'll try to get there. Let's plan at least a BOF or two if not a
microconf.

To setup a webex let's first list who needs to attend and respective
timezones so we can figure out a time. I'm in Australia east coast.

> > > The way DPC used to behave in 2016, is still the same; which involved
> > > removing and re-enumerating the devices.
> > 
> > Which is mostly useless for anything that isn't a network device.
> > 
> > We've been doing EEH for something like 15 to 20 years, so we have a
> > long experience with what it takes to get PCI(e) devices to recover on
> > enterprise systems.
> > 
> > Removing and re-enumerating is one of the very worst thing you can do
> > in that area.
> > 
> > Cheers,
> > Ben.
