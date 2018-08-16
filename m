Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36683 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeHPLHo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 07:07:44 -0400
Message-ID: <2607ca214f9d4f461a13e8e94b853056ba02966a.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: poza@codeaurora.org
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 16 Aug 2018 18:10:41 +1000
In-Reply-To: <96ecbc5963993703381ffcdda093d147@codeaurora.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
         <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
         <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
         <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
         <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
         <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
         <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
         <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
         <3f454ec4e96842286e1bfeba960f9f37bfcfaf6f.camel@kernel.crashing.org>
         <96ecbc5963993703381ffcdda093d147@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-16 at 13:26 +0530, poza@codeaurora.org wrote:
> > Please, at the very least revert the spec changes. They are utterly
> > wrong.
> > 
> > The driver MUST remain active during the recovery process *including*
> > fatal errors.
> > 
> > Only if the recovery fails and the driver gives us may you chose to
> > unplug the device (though there is little point).
> > 
> > What you have designed will work fine for network drivers but will not
> > work for storage.
> > 
> > Ben.
> 
> Hi Ben,
> 
> If you look at original DPC driver it was doing exactly the same as it 
> is doing now.
> so with or without new changes DPC driver had the same behavior from 
> beginning.

Yes and that behaviour is utterly wrong.

> commit 26e515713342b6f7c553aa3c66b21c6ab7cf82af

Yup, I noticed. We don't use DPC, all of that is subsumed into our EEH
infrastructure, so we didn't notice.

But now that the wrongness is spreading it's starting to show,
especially the changes to the spec.

We shouldn't be too focused on ERR_FATAL vs NON_FATAL. HW has a knack
for misreporting these things anyway.

All we really care about is whether the device was isolated and data
was lost or whether it's just an informational corrected error. The
latter should just be reported without impact. The former should lead
to a recovery procedure.

The design of the error callback was specifially so that you *could*
reset the link (or even PERST the whole device & retrain) *without*
having to unbind the driver or worse, soft-unplug the device.
Specifically beacause once you do the latter, you lose the links to the
mounted filesystems and those cannot be re-established.

So the spec needs to be reverted, DPC fixed and AER as well to do the
right thing here.

In fact it would be nice if we could make some of that logic common
with EEH. Sam (CC) has been cleaning up some of our EEH code which is,
to be honest, a bloody mess, so we might be able to comprehend and
refactor it more easily.

The basic idea is that regardless of the type of error, you first
notify the driver that an error occured. At that point, the io channel
might have been frozen already, so the driver can make no expectation
that the device is still reachable, which matches what DPC does I
believe.

The driver can ask for re-enabling the channel if it thinks it can
attempt a recovery but the core doesn't have to honor it and can chose
to just reset the device.

Similarly, in case of re-enabling, the driver can decide that this
didn't work out and request an escalation to a reset.

So typically, a non-fatal could go through the re-enable phase (in the
case where DPC didn't actually block the channel at all), while non-
fatal would always go to reset.

The only case where we would "unplug" on the linux side is when the
driver doesn't have error handling callbacks.

Cheers,
Ben.
 
