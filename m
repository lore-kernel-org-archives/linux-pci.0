Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v12 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: Joe Perches <joe@perches.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
 <1516725385-24535-8-git-send-email-john.garry@huawei.com>
 <CAJZ5v0ghc1sthrMBobSXfNrxoKrjbie9qnKYnLdxnpLfZPzs8w@mail.gmail.com>
 <8beedbb3-9098-6440-9ddf-e64b2a8e5151@huawei.com>
 <1517832650.7489.256.camel@perches.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        "dann.frazier@canonical.com" <dann.frazier@canonical.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Corey Minyard <minyard@acm.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <af37de60-a016-f8e3-9e17-d4e7d345f3fb@huawei.com>
Date: Mon, 5 Feb 2018 12:17:20 +0000
MIME-Version: 1.0
In-Reply-To: <1517832650.7489.256.camel@perches.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/02/2018 12:10, Joe Perches wrote:
> On Mon, 2018-02-05 at 11:01 +0000, John Garry wrote:
>> On 04/02/2018 07:45, Rafael J. Wysocki wrote:
>>> +       /* translate the I/O resources */
>>>> +       for (i = 0; i < count; i++) {
>>>> +               if (resources[i].flags & IORESOURCE_IO) {
>>>> +                       ret = acpi_translate_logicio_res(adev, host,
>>>> +                                                       &resources[i]);
>>>
>>> You don't need to break this line as far as I'm concerned.
>>
>> This is just to keep checkpatch happy. I could move the complete
>> function call to a single line. And also shortening some symbols will help.
>
> This could also use continue as well
>
> 	/* translate the I/O resources */
> 	for (i = 0; i < count; i++) {
> 		if (!(resources[i].flags & IORESOURCE_IO))
> 			continue;
> 		ret = acpi_translate_logicio_res(adev, host, &resources[i]);
> 		if (ret) {
> 			kfree(resources);
> 			dev_err(child, "Translate I/O range failed (%d)!\n",
> 				ret);
> 			return ret;
> 		}
> 	}

Sure, that reduces the indentation as well.

cheers

>
>
> .
>


