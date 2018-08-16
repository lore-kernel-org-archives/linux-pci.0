Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44781 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbeHPKCN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 06:02:13 -0400
Message-ID: <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: poza@codeaurora.org
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 16 Aug 2018 17:05:30 +1000
In-Reply-To: <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
         <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
         <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
         <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
         <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
         <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
         <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-16 at 16:51 +1000, Benjamin Herrenschmidt wrote:
> No, this is wrong and not the intent of the error handling.
> 
> You seem to be applying PCIe specific concepts brain-farted at Intel
> that are way way away from what we care about in practice and in Linux.
> 
> > e.g.  some driver handle errors ERR_NONFATAL or FATAL in similar ways
> > e.g.
> > ioat_pcie_error_detected();  calls  ioat_shutdown(); in case of 
> > ERR_NONFATAL
> > otherwise ioat_shutdown() in case of ERR_FATAL.
> 
> Since when the error handling callbacks even have the concept of FATAL
> vs. non-fatal ? This doesn't appear anyhwhere in the prototype of the
> struct pci_error_handlers and shouldn't.

Ugh... I just saw the changes you did to Documentation/PCI/pci-error-
recovery.txt and I would very much like to revert those !

Bjorn, you shouldn't let changes to the PCI error handling through
without acks from us, it looks like we didn't notice (we can't possibly
monitor all lists).

We wrote that in the firsat place and our EEH infrastructure rely on it
heavily on it.

Poza, you seem to have not understood the intent of the code and are
now changing the rules in ways that are broken in our opinion. This is
bad.

Bjorn, please revert all of those changes.

There was NEVER an intent to separate fatal from non-fatal at that
level. We could pass the information to the driver if we wished but the
recovery sequence is NOT intended to be different.

Especially we specifically do NOT want to unplug and replug the device
for fatal errors at all. This is not going to work with drivers that
cannot re-link with their various kernel services, such as storage
devices re-connecting with mounted file systems etc...

Those changes are utterly broken.

The basic premise of the design that we woudl do that unplug/replug
trick if and ONLY IF the driver doesn't have the appropriate callbacks.

We are also now looking at replacing this with an ubind/re-bind because
in practice, the unplugging is causing us all sort of problems. Sam
(CC) can elaborate.

Bjorn, we are the main authors of that spec (Linas wrote it under my
supervision) and created those callbacks for EEH. AER picked them up
only later. Those changes must be at the very least acked by us before
going upstream.

Ben.
