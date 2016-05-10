Return-Path: <geert.uytterhoeven@gmail.com>
Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20160510115103.GB29582@localhost>
References: <20160509195410.GB18166@localhost>
	<57317B31.8030203@suse.de>
	<20160510115103.GB29582@localhost>
Date: Tue, 10 May 2016 13:56:35 +0200
Message-ID: <CAMuHMdWaDLd8vZ9SEmmUKRyEkDPaO4MCq5-JjyCcXVGQMUNYuA@mail.gmail.com>
Subject: Re: Build warning regression (104daa71b396 ("PCI: Determine actual
 VPD size on first access"))
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, May 10, 2016 at 1:51 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, May 10, 2016 at 08:09:53AM +0200, Hannes Reinecke wrote:
>> On 05/09/2016 09:54 PM, Bjorn Helgaas wrote:
>> > Hi Hannes,
>> >
>> > Geert's list of build regressions and improvements
>> > (http://lkml.kernel.org/r/1462782250-6231-1-git-send-email-geert@linux-m68k.org)
>> > shows these new warnings:
>> >
>> >   drivers/pci/access.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 318:8
>> >   drivers/pci/access.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 340:6
>> >
>> > which I think are due to 104daa71b396 ("PCI: Determine actual VPD size on
>> > first access").
>> >
>> > Would you mind fixing those up and sending me a patch?  These were in
>> > the v4.6-rc1 regressions email, and I should have noticed then, but I
>> > didn't.
>> >
>> This is curious.
>> The code has this:
>>
>> size_t off = 0;
>>
>> ...
>>
>> dev_warn(&dev->dev,
>>       "invalid large VPD tag %02x size at offset %zu",
>>       tag, off + 1);
>>
>> Which, as per my reading, suggests that the last argument to
>> dev_warn() is of type size_t.
>>
>> Which tree has generated the above warning?
>
> Yeah, it wasn't obvious to me how this would happen either.  From
> Geert's original email, I think the tree is v4.6-rc7, i.e.,
> 44549e8f5eea4e0a41b487b63e616cb089922b99.
>
> Geert, can you tell which config generated this warning?

It was seen with v4.6-rc7/microblaze/nommu_defconfig only.

As I agree the type of the last parameter is correct, it's probably a
compiler issue.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
