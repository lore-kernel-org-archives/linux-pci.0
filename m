Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:39020 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaJBVpU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Oct 2014 17:45:20 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so2884893qcv.38
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2014 14:45:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412283745.28143.23.camel@pasglop>
References: <1412210062.10667.1.camel@pasglop> <20141002153402.GC18056@google.com>
 <1412283745.28143.23.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 2 Oct 2014 15:44:57 -0600
Message-ID: <CAErSpo4XYYJGZvAH7bQp6DXdBtLFT4e8WR6ve3mdV1LY0JdgPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] gpu/radeon: Move 64-bit MSI quirk from arch to driver
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alex Deucher <alexdeucher@gmail.com>,
	Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 2, 2014 at 3:02 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2014-10-02 at 09:34 -0600, Bjorn Helgaas wrote:
>> On Thu, Oct 02, 2014 at 10:34:22AM +1000, Benjamin Herrenschmidt wrote:
>> >
>> > A number of radeon cards have a HW limitation causing them to be
>> > unable to generate the full 64-bit of address bits for MSIs. This
>> > breaks MSIs on some platforms such as POWER machines.
>> >
>> > We used to have a powerpc specific quirk to address that on a
>> > single card, but this doesn't scale very well, this is better
>> > put under control of the drivers who know precisely what a given
>> > HW revision can do.
>> >
>> > This moves the setting of the quirk flag to the radeon driver
>> >
>> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > ---
>> >
>> > v2: This is just adjusted to the new flag name
>>
>> I'm sorta confused because I got two "v2 2/4" emails a minute or so apart.
>> I assume they're the same.
>
> Yes, evo blew up while sending the series the first time around :(

No problem.  My real question is below, but you probably missed it
because of my email gripe :)

>> >  arch/powerpc/kernel/pci_64.c            |  1 -
>> >  drivers/gpu/drm/radeon/radeon_irq_kms.c | 10 ++++++++++
>> >  2 files changed, 10 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
>> > index d41a831..5330f6d 100644
>> > --- a/arch/powerpc/kernel/pci_64.c
>> > +++ b/arch/powerpc/kernel/pci_64.c
>> > @@ -271,5 +271,4 @@ static void quirk_radeon_32bit_msi(struct pci_dev *dev)
>> >  {
>> >     dev->no_64bit_msi = true;
>> >  }
>> > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon_32bit_msi);
>> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);
>>
>> Why do we keep the 0xaa68 quirk?  Shouldn't that be made generic, too?
>>
>> > diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
>> > index 16807af..e760671 100644
>> > --- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
>> > +++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
>> > @@ -202,6 +202,16 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
>> >     if (rdev->flags & RADEON_IS_AGP)
>> >             return false;
>> >
>> > +   /*
>> > +    * Older chips have a HW limitation, they can only generate 40 bits
>> > +    * of address for "64-bit" MSIs which breaks on some platforms, notably
>> > +    * IBM POWER servers, so we limit them
>> > +    */
>> > +   if (rdev->family < CHIP_BONAIRE) {
>> > +           dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
>> > +           rdev->pdev->no_64bit_msi = true;
>> > +   }
>> > +
>> >     /* force MSI on */
>> >     if (radeon_msi == 1)
>> >             return true;
>> >
>> >
>> >
>
>
