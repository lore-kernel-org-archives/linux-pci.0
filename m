Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38141 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541Ab2GDCDN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2012 22:03:13 -0400
Received: by vcbf11 with SMTP id f11so4620098vcb.19
        for <linux-pci@vger.kernel.org>; Tue, 03 Jul 2012 19:03:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1207031605350.29825-100000@netrider.rowland.org>
References: <CAErSpo61zd1Lv9s3CaTNTnmYemkhM=a8Lw_2bm4V=1GipJgzSw@mail.gmail.com>
	<Pine.LNX.4.44L0.1207031605350.29825-100000@netrider.rowland.org>
Date: Wed, 4 Jul 2012 10:03:12 +0800
Message-ID: <CAMz9Wg9fBxcHCmcOocfyMXZ+xj6rhkPOJ++gKPER9e14Z5J66w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Quirk for ASUS S3 issue
From: AceLan Kao <acelan.kao@canonical.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	=?Big5?B?rHgoQWxleCmtWq/R?= <alex.hung@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn and Alan,

2012/7/4 Alan Stern <stern@rowland.harvard.edu>:
> On Tue, 3 Jul 2012, Bjorn Helgaas wrote:
>
>> On Tue, Jul 3, 2012 at 2:55 AM, AceLan Kao <acelan.kao@canonical.com> wrote:
>> > Some of ASUS machines have problem to enter S3.
>>
>> This should include a specific description of the problem the user
>> sees.  From the code comment, it something like "Attempt to suspend
>> some ASUS systems causes hang.  Power cycle required to recover."
>> might be appropriate.
>>
>> The quirk you added is not specific to ASUS, though, so it must be
>> something that's safe on every system using the AMD and ATI devices
>> you specified.  I don't know whether that's the case.
>
> Is this the same bug as the one addressed by commit c2fb8a3fa255 (USB:
> add NO_D3_DURING_SLEEP flag and revert 151b61284776be2)?
>
> That bug seemed to occur only when the affected systems were put into
> S3 sleep while an EHCI controller was in power level D3.
We contacted the ASUS' BIOS engineer and try to verify this issue, for
it happened
on many ASUS' machines. Then they found that the system hangs in their
BIOS code.
The code will try to disable the USB if they found the PCI COMMAND
register is not zero.

That's not a correct behavior that BIOS should do, the PCI COMMAND
register is not
represent if the USB is disabled or not, It's a workaround they tried to fix
another issue in windows long time ago, but ASUS' BIOS engineer refuse to remove
that part of code. But windows will clear the PCI COMMAND register if
windows is already
disabled the USB.
So, I try to write this quirk.

>
>> > The root cause of this issue is result from the the BIOS will try to
>> > disable USBs which was already disabled by driver.
>> > BIOS will to check the EHCI command register, if it's not zero, then
>
> You don't mean "EHCI command register"; you mean "the EHCI controller's
> PCI COMMAND register".  The EHCI command register is a completely
> different register; it's part of the memory-mapped interface rather
> than the PCI config space.
Thank you very much, I'm not familiar with this.
It's EHCI controller's PCI COMMAND register.
>
>> > BIOS will think the USB is not disabled yet, so it will try to disable
>> > USB again.
>
> How do you know this?
ASUS' BIOS engineer told me :p

>
> Why should disabling an already-disabled USB controller cause the
> system to hang?
I don't know, it hangs in BIOS, not in kernel.

>
>> > To resolve this, we should clear the EHCI command register before
>> > entering S3. And this does no harm to the system, since it'll switch
>
> Is there any reason not to clear the PCI COMMAND register of every PCI
> USB host controller when entering S3?
Quote from ASUS, they only mentioned EHCI
---------
BIOS will check EHCI command register PCI regiter offset 04h to see if
USB is disabled or not.
Because regiter offset 04h is not cleared, BIOS think USB is not disabled.
Then BIOS will try to disabled USB, but the USB is disabled by Ubuntu
already. This conflict will cause system hang.
ASUS think since Ubuntu will disable USB, it also need to clear the
register too.
---------
>
>> > off the power after enter S3, so the value in memory is not important
>> > at all.
>>
>> System RAM is preserved in the S3 state (ACPI spec sec 7.3.4.4), so I
>> don't know how to interpret this statement.
Sorry for my bad wording, it's not System RAM, it's PCI COMMAND register.
H/W will reset it's value after wake up.
I'm not pretty sure of this part, but I can verify it later.

>>
>> Please include a bugzilla or problem report URL if you have one.
I didn't grep the bugzilla before sending out this patch, it's easy to find
that there are plenty of them. I'll add them and rewording the patch description

http://thread.gmane.org/gmane.linux.usb.general/61396/focus=61396 #
ehci_hcd related S3 lockup on ASUS laptops, again
https://bugzilla.kernel.org/show_bug.cgi?id=43064 # [00:1a.0 Intel
USB] Asus U36SD kernel freeze at suspend
https://bugzilla.kernel.org/show_bug.cgi?id=42883 # Unable to use
suspension and hibernation on ASUS N53JQ-SZ197X
https://bugzilla.kernel.org/show_bug.cgi?id=37632 # Many ASUS laptops
can't suspend with ehci_hcd loaded
http://www.mail-archive.com/acpi-bugzilla@lists.sourceforge.net/msg35833.html
# New: suspend Asus P5N-E SLI

>>
>> I'm not a USB or suspend/resume expert, so please get folks like Alan
>> Stern and Rafael Wysocki to take a look at this (cc'd).
>
> This really has nothing to do with USB, except the fact that the
> affected parts are USB host controllers.  It's entirely a PCI issue.
>
>> Please read the comment at the top of pci_ids.h; I don't think you
>> need to change that file.
Sorry, I'll remove the definition I added in pci_ids.h

>>
>> > Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>> > ---
>> >  drivers/pci/quirks.c    |   15 +++++++++++++++
>> >  include/linux/pci_ids.h |    2 ++
>> >  2 files changed, 17 insertions(+)
>> >
>> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> > index 194b243a..684cd1f 100644
>> > --- a/drivers/pci/quirks.c
>> > +++ b/drivers/pci/quirks.c
>> > @@ -2955,6 +2955,21 @@ static void __devinit asus_ehci_no_d3(struct pci_dev *dev)
>> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c26, asus_ehci_no_d3);
>> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c2d, asus_ehci_no_d3);
>> >
>> > +/*
>> > + * ASUS BIOS will check EHCI command register to see if USB if disabled
>> > + * or not. BIOS will try to disable USB if the command register is not
>> > + * cleared. But, actually, USB is disabled by the driver while entering S3,
>> > + * so it'll hang in BIOS when it try to disable USB.
>
> Why does the system hang?  There should be no problem clearing the PCI
> COMMAND register even while the controller is in D3.
>
> Does the BIOS try to access the memory-mapped registers while disabling
> the controller?
>
>> > + * Since it's going to enter S3, so it does no harm to clear the command
>> > + * register.
>> > + */
>> > +static void asus_clear_pci_command(struct pci_dev *dev)
>> > +{
>> > +       pci_write_config_word(dev, PCI_COMMAND, 0);
>> > +}
>> > +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON_EHCI, asus_clear_memory_bit);
>> > +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_EHCI, asus_clear_memory_bit);
>
> Why not do this for all EHCI controllers?  Or even all PCI devices?
>
> Alan Stern
>



-- 
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
