Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35246 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbbLIK3o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2015 05:29:44 -0500
Received: by wmuu63 with SMTP id u63so215773031wmu.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Dec 2015 02:29:43 -0800 (PST)
Subject: Re: [PATCH v4 1/5] PCI: designware: add memory barrier after enabling
 region
To: Arnd Bergmann <arnd@arndb.de>,
	Pratyush Anand <pratyush.anand@gmail.com>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <56669C50.9060700@linaro.org>
 <CAHM4w1k_EAt+xBBYyG3B7W9Fegc4j+uRq5t_biUsxOGt+k+xUA@mail.gmail.com>
 <1975309.Hla8QhEqf4@wuerfel>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <56680292.60905@linaro.org>
Date: Wed, 9 Dec 2015 12:29:38 +0200
MIME-Version: 1.0
In-Reply-To: <1975309.Hla8QhEqf4@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/09/2015 11:52 AM, Arnd Bergmann wrote:
> On Wednesday 09 December 2015 10:10:05 Pratyush Anand wrote:
>> On Tue, Dec 8, 2015 at 2:31 PM, Stanimir Varbanov
>>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>>> ---
>>>>  drivers/pci/host/pcie-designware.c |    5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>>>> index 02a7452bdf23..ed4dc2e2553b 100644
>>>> --- a/drivers/pci/host/pcie-designware.c
>>>> +++ b/drivers/pci/host/pcie-designware.c
>>>> @@ -164,6 +164,11 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
>>>>       dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
>>>>       dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
>>>>       dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
>>>> +     /*
>>>> +      * ensure that the ATU enable has been happaned before accessing
>>>> +      * pci configuration/io spaces through dw_pcie_cfg_[read|write].
>>>> +      */
>>>> +     wmb();
>>>>  }
>>>>
>>
>>
>> My understnading is that since writel() of dw_pcie_writel_rc() in
>> above code and readl(), writel() of dw_pcie_cfg_[read|write]() (which
>> will follow) goes through same device (ie PCIe host here). So, it is
>> guaranteed that 1st writel() will be executed before later
>> readl()/writel(). If that is true then we do not need any explicit
>> barrier here.
>>
>> Arnd, Russel: whats your opinion here.
> 
> I think the ordering is only enforced if the two register accesses are
> on the same device as seen from the bus, and it's possible that the
> RC registers and the config space registers are not considered the
> same thing here.
> 
> For config write, this is not a problem, because the config space write
> has a wmb() that enforces ordering, but it's possible that the config
> space read may hit the device in parallel with the PCIE_ATU_ENABLE
> write.

Hmm, just a matter of fact - as I described in the patch description
this wmb() fixed an issue with pcie device enumeration (I came down to
pci_bus_read_dev_vendor_id() returns zero) i.e. exactly a pci
configuration space read.

-- 
regards,
Stan
