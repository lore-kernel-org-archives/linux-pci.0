Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170525101256.GA12183@intel.com>
References: <20170525101256.GA12183@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 27 May 2017 18:32:48 +0300
Message-ID: <CAHp75VcfYuDAO-1e0VHOmeudS2dDti1FM8+N+gNVEux-D8PMUQ@mail.gmail.com>
Subject: Re: [Q] What about PCI mmio access alignment?
To: "Du, Changbin" <changbin.du@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 25, 2017 at 1:12 PM, Du, Changbin <changbin.du@intel.com> wrote:
> I have a basic quesion about the alignment when access PCI bar mmio space. Is
> the address accessed must be DW aligned and count must be DW aligned?

I guess the best answer is PCI architecture specification.
Book I have nearby tells me IIDnMS that yes, you have to follow alignment.

> As far as I know, The address field of TLB ignore lower 2 bits and the unit of
> length field also is DW. So does it mean above question is Yes? Else will CPU
> handle unaligned access for mmio space?

Here you perhaps meant the bus, not the CPU. PCI allows it as long as
actual device allows it.

(I recall patch series that tries to micro optimize PCI config space
access by grouping some bytes into words or even dwords, and it was
rejected).

> I want to know wether below access illegal or not:
>   - readb(bar0)
>   - readb(bar0 + 1)
>   - readl(bar0)

It depends.

-- 
With Best Regards,
Andy Shevchenko
