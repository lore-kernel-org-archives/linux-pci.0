Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F884340@lhreml507-mbx>
References: <20160920140518.GD13855@localhost> <CAKv+Gu-j-gKiNMx-TvSxezJth1619FN8W1rAy7DKpkmfX9ii6A@mail.gmail.com>
 <20160920191744.GA4941@localhost> <20160921140549.GA11968@red-moon>
 <20160921180457.GB20006@localhost> <20160922094955.GB18637@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8815A9@lhreml507-mbx> <20160922124446.GA21681@red-moon>
 <20160922183101.GA14510@localhost> <20160922221042.GA1514@localhost>
 <20160923101145.GA31120@red-moon> <EE11001F9E5DDD47B7634E2F8A612F2E1F884340@lhreml507-mbx>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 14 Sep 2017 07:06:58 -0700
Message-ID: <CAKv+Gu8x0j-O3WPE7Cvi4oX5J5Cq1vUhDNB_UdjE88eQh83DDA@mail.gmail.com>
Subject: Re: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Wangyijing <wangyijing@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(remove most cc's)

Hi all,

Apologies for digging up this old thread.

I am currently looking into whether it is feasible to refactor some of
the ACPI PCI quirk code we have so it can apply to more instances of
the Synopsys Designware PCIe (i.e., for Marvell and Socionext SOCs),
which all suffer from the same issue that type 0 config TLPs are not
filtered before being sent out on the link, resulting in devices
appearing multiple times.

The pci-hisi.c quirk already appears to do exactly what would solve
the problem on other SoCs as well. So I will try to refactor this code
into something that I could propose for upstream, while probably
getting the ARM SBSA authors to offer some guidance that this IP must
not be used for new designs.

In any case, the chances of any such changes being acceptable upstream
are probably higher if we can reuse the exact same quirk as we have
already implemented for HiSilicon, so I wonder if anyone from Huawei
could comment on some questions I have:
- Why does the config space accessor override use 32-bit accesses only
for bus #0? Is that really necessary?
- Why does the Hisi quirk use different config base addresses for bus
#0 and the other buses? Is this simply because the firmware does not
use contiguous iATU windows for bus #0 and buses #1 and up? So is
there anything mapped in the 1 MB slice at the base of the respective
256 MB mappings that generate type1 config cycles?

Having just a shared set of config space accessor overrides would
already be an improvement, given that they can be shared with a DT
based driver for this IP in ECAM mode as well.

Thanks,
Ard.
