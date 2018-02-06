Return-Path: <SRS0=8nNQ=FA=gmail.com=ulfalizer@kernel.org>
Return-Path: <SRS0=8nNQ=FA=gmail.com=ulfalizer@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-21-ulfalizer@gmail.com>
 <20180206191126.GB98765@bhelgaas-glaptop.roam.corp.google.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 6 Feb 2018 23:17:05 +0100
Message-ID: <CAFkk2KTUGG9-VZcJpvD_qkE3+AMy2XZOvU4=UEWp4arrzRWw+Q@mail.gmail.com>
Subject: Re: [PATCH 20/20] x86/PCI: VMD: Fix malformed default
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, tfiga@chromium.org, paul.burton@mips.com,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Linus Walleij <linus.walleij@linaro.org>,
	Vineet Gupta <vgupta@synopsys.com>, mgorman@techsingularity.net,
	Christoph Hellwig <hch@lst.de>, mina86@mina86.com, Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@codeaurora.org>, Paul Mackerras <paulus@ozlabs.org>,
	Will Deacon <will.deacon@arm.com>, Tony Lindgren <tony@atomide.com>,
	Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 6, 2018 at 8:11 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> x86/PCI: VMD: Fix malformed default
>
> In the title, please include a clue about what default you're talking
> about, e.g., mention Kconfig somehow.
>
> On Mon, Feb 05, 2018 at 02:21:32AM +0100, Ulf Magnusson wrote:
>> 'default N' should be 'default n', though they happen to have the same
>> effect here, due to undefined symbols (N in this case) evaluating to n
>> in a tristate sense.
>>
>> Remove the default from VMD instead of changing it. bool and tristate
>> symbols implicitly default to n.
>>
>> Discovered with the
>> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>> script.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
>>  drivers/pci/host/Kconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index a4ed7484d127..dc8a2a175f19 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -215,7 +215,6 @@ config PCIE_TANGO_SMP8759
>>  config VMD
>>       depends on PCI_MSI && X86_64 && SRCU
>>       tristate "Intel Volume Management Device Driver"
>> -     default N
>>       ---help---
>>         Adds support for the Intel Volume Management Device (VMD). VMD is a
>>         secondary PCI host bridge that allows PCI Express root ports,
>> --
>> 2.14.1
>>

Typoed the --in-reply-to. v2 is at https://lkml.org/lkml/2018/2/6/770

Cheers,
Ulf
