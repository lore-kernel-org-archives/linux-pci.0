Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38728 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbbDFNF4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Apr 2015 09:05:56 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo4cw2MSPmrur_QFMwnH01qf0XMfBEAyZ2f+HrUOGEXyjw@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org> <20150403193234.GD10892@google.com>
 <20150403205201.GF10892@google.com> <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
 <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com>
 <CAL_JsqJyH==8OtkcU8_P4_47U6qe6FYqj-WUZ20_Y+iC_OF4_w@mail.gmail.com> <CAErSpo4cw2MSPmrur_QFMwnH01qf0XMfBEAyZ2f+HrUOGEXyjw@mail.gmail.com>
From: Rob Herring <robherring2@gmail.com>
Date: Mon, 6 Apr 2015 08:05:33 -0500
Message-ID: <CAL_JsqLhteW8p1B7DrRzWzC_0UNYOKAU-yu2UhWRcb8PZ9AEnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	David Ahern <david.ahern@oracle.com>,
	"the arch/x86 maintainers" <x86@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Miller <davem@davemloft.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 4, 2015 at 10:25 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Apr 4, 2015 at 2:48 PM, Rob Herring <robherring2@gmail.com> wrote:
>> On Sat, Apr 4, 2015 at 7:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>>> I think there's still an unresolved question about the OF parsing code.
>>
>> Got a pointer to what that is? I'll take a guess. Generally, we make
>> the parsing code independent of the kernel addr sizes and use u64
>> types. The DT sizes and kernel sizes are not always aligned. For
>> example, an LPAE capable platform running a non-LPAE kernel build.
>
> Yep: http://lkml.kernel.org/r/1427857069-6789-3-git-send-email-yinghai@kernel.org
>
> Yinghai made a change to the sparc OF parsing code.  The question is
> whether a similar change should be made to clones of that code (two
> others in arch/sparc, one in arch/powerpc, and one in drivers/of).

Yes, it appears to me that is needed. At least the drivers/of/ code
does not distinguish 32 and 64 bit ATM.

Rob
