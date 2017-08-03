Return-Path: <SRS0=l3MC=7F=cogentembedded.com=sergei.shtylyov@kernel.org>
Return-Path: <SRS0=l3MC=7F=cogentembedded.com=sergei.shtylyov@kernel.org>
Subject: Re: [PATCH] pci: ftpci100: fix of_irq_get() error check
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20170715214406.657273405@cogentembedded.com>
 <20170802213639.GI20308@bhelgaas-glaptop.roam.corp.google.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <19109fc3-6afb-b710-4493-77227b7533ef@cogentembedded.com>
Date: Thu, 3 Aug 2017 12:32:29 +0300
MIME-Version: 1.0
In-Reply-To: <20170802213639.GI20308@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hello!

On 8/3/2017 12:36 AM, Bjorn Helgaas wrote:

>> of_irq_get() may return a negative error number as well as 0 on failure,
>> while the driver only checks for 0, blithely continuing with the call to
>> irq_set_chained_handler_and_data() -- that function expects *unsigned int*
>> so should probably do nothing when a large IRQ number resulting from a
>> conversion of a negative error number is passed to it. The driver then
>> probes successfully while being only partly functional...
>>
>> Check for 'irq <= 0' instead and propagate the negative error number to
>> the probe method --  that will allow the deferred probing as well...
>>
>> Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Applied with Linus' reviewed-by to pci/host-faraday for v4.14, thanks!

    Thanks! But why only to 4.14?

[...]

MBR, Sergei
