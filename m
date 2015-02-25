Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:52269 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbbBYUSf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 15:18:35 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so4534139qac.8
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2015 12:18:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150225185423.GA19236@pd.tnic>
References: <1424818246-11841-1-git-send-email-linux@rasmusvillemoes.dk> <20150225185423.GA19236@pd.tnic>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 25 Feb 2015 12:18:14 -0800
Message-ID: <CAErSpo5WwP1z+rzXzEM8_bJ2sq7rixOWiF5CqYYSK32r0sVYuw@mail.gmail.com>
Subject: Re: [PATCH] PCI/AER: Avoid info leak in __print_tlp_header
To: Borislav Petkov <bp@suse.de>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Tony]

On Wed, Feb 25, 2015 at 10:54 AM, Borislav Petkov <bp@suse.de> wrote:
> On Tue, Feb 24, 2015 at 11:50:46PM +0100, Rasmus Villemoes wrote:
>> Commit fab4c256a58b ("PCI/AER: Add a TLP header print helper")
>> introduced the helper function __print_tlp_header, but contrary to the
>> intention, the behaviour did change: Since we're taking the address of
>
> Whoops, good catch.
>
>> the parameter t, the first 4 or 8 bytes printed will be the value of
>> the pointer t itself, and the remaining 12 or 8 bytes will be
>> who-knows-what (something from the stack).
>>
>> We want to treat the four members of the struct aer_header_log_regs as
>> little-endian 32 bit numbers and print those. That can be done without
>> ugly and confusing casts.
>>
>> Fixes: fab4c256a58b ("PCI/AER: Add a TLP header print helper")
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  drivers/pci/pcie/aer/aerdrv_errprint.c | 13 +++----------
>>  1 file changed, 3 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> index c6849d9e86ce..e328978038c1 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
>> @@ -132,16 +132,9 @@ static const char *aer_agent_string[] = {
>>  static void __print_tlp_header(struct pci_dev *dev,
>>                              struct aer_header_log_regs *t)
>>  {
>> -     unsigned char *tlp = (unsigned char *)&t;
>> -
>> -     dev_err(&dev->dev, "  TLP Header:"
>> -             " %02x%02x%02x%02x %02x%02x%02x%02x"
>> -             " %02x%02x%02x%02x %02x%02x%02x%02x\n",
>> -             *(tlp + 3), *(tlp + 2), *(tlp + 1), *tlp,
>> -             *(tlp + 7), *(tlp + 6), *(tlp + 5), *(tlp + 4),
>> -             *(tlp + 11), *(tlp + 10), *(tlp + 9),
>> -             *(tlp + 8), *(tlp + 15), *(tlp + 14),
>> -             *(tlp + 13), *(tlp + 12));
>> +     dev_err(&dev->dev, "  TLP Header: %08x %08x %08x %08x\n",
>> +             le32_to_cpu(t->dw0), le32_to_cpu(t->dw1),
>> +             le32_to_cpu(t->dw2), le32_to_cpu(t->dw3));
>
> I'm not sure about this: I think the original intention was to dump the
> dwords MS-bit to LS-bit like this here:
>
> http://www.fpga4fun.com/PCI-Express4.html
>
> Now, if this runs on a big endian machine, converting to CPU order would
> be wrong IMHO. You'd rather want do do cpu_to_le32() for consistency.
> But I don't know whether big endian machines are even sporting PCIE
> AER...

I think we should expect AER to be used on big-endian machines.  I'm
pretty sure it's used on Itanium in big-endian mode.

Why are we worrying about byte order here at all?  I'd think we could
just print t->dw0 directly with %08x.

Any byte order issues should be handled when we fill in the struct
aer_header_log_regs.  For normal AER (non-APEI), we use
pci_read_config_dword() to directly fill in info->tlp.dw0, etc. in
get_device_error_info(), so I don't think there's a problem there.

For APEI, it looks like it would happen somewhere in
ghes_read_estatus().  I didn't follow the whole path here, but I would
argue that by the time we put data in t->dw0, it should be in CPU
order so a mask like 0x80000000 would work the same on LE and BE
boxes.

Bjorn
