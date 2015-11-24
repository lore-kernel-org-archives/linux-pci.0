Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] PCI: designware: remove wrong io_base assignment
To: Arnd Bergmann <arnd@arndb.de>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
 <EE11001F9E5DDD47B7634E2F8A612F2E162C6F70@lhreml503-mbs>
 <56533D93.5000604@linaro.org> <6899049.45pKpnsxmL@wuerfel>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <56542D0F.1020502@linaro.org>
Date: Tue, 24 Nov 2015 11:25:35 +0200
MIME-Version: 1.0
In-Reply-To: <6899049.45pKpnsxmL@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/23/2015 06:40 PM, Arnd Bergmann wrote:
> On Monday 23 November 2015 18:23:47 Stanimir Varbanov wrote:
>>>>
>>>> Fixes: 0021d22b73d6 ("PCI: designware: Use of_pci_get_host_bridge_resources()
>>>> to parse DT")
>>>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>
>> I think the bug is introduced in:
>>
>> cbce7900598c ("PCI: designware: Make driver arch-agnostic")
>>
>> cause the io_base is correctly calculated in 0021d22b73d6, do you agree?
> 
> 
> I think cbce7900598c just slightly changes the io_base value, but
> it's still referring to a bus address, not a cpu address, both before
> and after the patch.
> 
> 0021d22b73d6 hower seems to remove the correct 'pp->io_base = range.cpu_addr;'
> and replaces it with 'pp->io_base = pp->io->start;', so it's now in
> the wrong address space.
> 
> 	Arnd
> 

OK, I will resend this as separate patch, and will drop it from this series.

-- 
regards,
Stan
