Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53C6034E.5000105@ti.com>
Date: Wed, 16 Jul 2014 10:15:02 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Paul Walmsley <paul@pwsan.com>
CC: <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <tony@atomide.com>,
	<linux@arm.linux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm: dra7xx: Add hwmod data for pcie1 and pcie2 subsystems
References: <1403719366-9656-3-git-send-email-kishon@ti.com> <1404896567-32204-1-git-send-email-kishon@ti.com> <53BD2136.9030009@ti.com> <53C3B251.8000209@ti.com> <alpine.DEB.2.02.1407152013310.21432@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.02.1407152013310.21432@utopia.booyaka.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 16 July 2014 01:43 AM, Paul Walmsley wrote:
> On Mon, 14 Jul 2014, Kishon Vijay Abraham I wrote:
> 
>> On Wednesday 09 July 2014 04:32 PM, Rajendra Nayak wrote:
>>> On Wednesday 09 July 2014 02:32 PM, Kishon Vijay Abraham I wrote:
>>>> Added hwmod data for pcie1 and pcie2 subsystem present in DRA7xx SOC.
>>>>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>> Cc: Paul Walmsley <paul@pwsan.com>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>> Changes from v1:
>>>> * changed the clock domain to "pcie_clkdm"
>>>> * Added PCIe as a slave port for l3_main.
>>>
>>> Looks good to me,
>>> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
>>
>> Paul,
>>
>> Can you pick this one?
> 
> Yep, queued for 3.17.

Thanks :-)

-Kishon
> 
> - Paul
> 
