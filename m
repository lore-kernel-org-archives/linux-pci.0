Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 Mar 2017 17:40:45 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Dongdong Liu <liudongdong3@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Bad DT binding (hisi-pcie-almost-ecam)
Message-ID: <20170310174045.GB24571@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've just spotted commit:

  a2ec1996098c7da0 ("PCI: hisi: Add DT almost-ECAM support for Hip06/Hip07 host controllers")

... which went in for v4.11-rc1.

I hadn't seen this until now, and as far as I can tell this never went
to the devicetree list.

The commit adds the "hisilicon,pcie-almost-ecam", which goes against the
usual DT conventions, and is non-sensical in that it describes the IP
based on what it isn't.

This binding shouldn't have gone in as-is, and we should fix it before
v4.11.

The binding states that this IP is found in Hip06 and Hip07. For these
cases we'd usually take the name of the first implementation, e.g.
something like "hisilicon,hip06-pcie", which can be used as a fallback
in the compatible list if reused in subsequent SoC generations.

I also see that "hisilicon,hip06-pcie" already exists, so I'm even more
suspicious.

What exactly is the "hisilicon,pcie-almost-ecam" binding trying to
describe? Is it a different IP also found on Hip06, or is it a new
binding for the same IP?

Thanks,
Mark.
