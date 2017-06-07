Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUiuqB3vPYkAJfP5+qotcH=o1gJnH8Mosr9VSKxAQGJMQ@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-7-palmer@dabbelt.com> <CAMuHMdUiuqB3vPYkAJfP5+qotcH=o1gJnH8Mosr9VSKxAQGJMQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Jun 2017 10:01:57 +0200
Message-ID: <CAK8P3a3FVKto9Kg8nfxizoKa+6kjYpT1JQrSASwAd1o5bBJBUw@mail.gmail.com>
Subject: Re: [PATCH 06/17] pci: Add generic pcibios_{fixup_bus,align_resource}
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, albert@sifive.com,
        patches@groups.riscv.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 7, 2017 at 9:19 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> CC pci folks
>
> On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> While upstreaming the RISC-V port, it was pointed out that multiple
>> architectures (arc, arm64, cris, microblaze, sh, tile) have copied the
>> mostly empty versions of at least one of these functions.  This defines
>> weakly bound versions of the common functions so other architetures can
>> use them.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Thanks a lot for taking care of this!

>> diff --git a/drivers/pci/bios.c b/drivers/pci/bios.c
>> new file mode 100644
>> index 000000000000..ffe34c024aa8
>> --- /dev/null
>> +++ b/drivers/pci/bios.c
>> @@ -0,0 +1,42 @@
>> +
>> +/* This file contains weakly bound functions that implement pcibios functions
>> + * that some architectures have copied verbatim.
>> + */

Instead of adding a new file, I would suggest adding the two functions next
to their callers, in probe.c and setup-res.c, respectively.

        Arnd
