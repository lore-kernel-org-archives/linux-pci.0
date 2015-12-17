Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5672D8A1.2080407@linaro.org>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
	<1449149725-27607-2-git-send-email-stanimir.varbanov@linaro.org>
	<56669C50.9060700@linaro.org>
	<CAHM4w1k_EAt+xBBYyG3B7W9Fegc4j+uRq5t_biUsxOGt+k+xUA@mail.gmail.com>
	<20151209102359.GF8644@n2100.arm.linux.org.uk>
	<CAHM4w1m-NiwyCLz9tikbOcNtCmVu0Vd9FhmKKSuMi5ChzfDafA@mail.gmail.com>
	<5672D8A1.2080407@linaro.org>
Date: Thu, 17 Dec 2015 21:21:12 +0530
Message-ID: <CAHM4w1mjTqrXC_XFTXoAB_3w3L8R=Xg-cXrTUfTuMO9sgctoFw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] PCI: designware: add memory barrier after enabling region
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 17, 2015 at 9:15 PM, Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> On 12/11/2015 06:05 AM, Pratyush Anand wrote:
> > On Wed, Dec 9, 2015 at 3:53 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >
> > [...]
> >
> >>>>>       dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> >>>>> +     /*
> >>>>> +      * ensure that the ATU enable has been happaned before accessing
> >>>>> +      * pci configuration/io spaces through dw_pcie_cfg_[read|write].
> >>>>> +      */
> >>>>> +     wmb();
> >>>>>  }
> >>>>>
> >>>
> >>>
> >>> My understnading is that since writel() of dw_pcie_writel_rc() in
> >>> above code and readl(), writel() of dw_pcie_cfg_[read|write]() (which
> >>> will follow) goes through same device (ie PCIe host here). So, it is
> >>> guaranteed that 1st writel() will be executed before later
> >>> readl()/writel(). If that is true then we do not need any explicit
> >>> barrier here.
> >>>
> >>> Arnd, Russel: whats your opinion here.
> >>               ^l
> >
> > Sorry :(
> >
> >>
> >> writel() has a barrier _before_ the access but not after.
> >>
> >> The fact is that there's nothing which guarantees that the write will hit
> >> the hardware in a timely manner (forget any rules about PCI config space,
> >> the PCI ordering rules apply to the PCI bus, not to the ARM buses.)
> >>
> >> If you need this write to have hit the hardware before continuing, you
> >> need to read back from the same register.
> >
> > OK, so better to replace wmb() with read back of control register.
>
> Would the patch be acceptable if I replace wmb with read?

For me it would be fine.

~Pratyush
