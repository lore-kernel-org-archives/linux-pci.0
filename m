Return-Path: <SRS0=hGeN=GM=huawei.com=john.garry@kernel.org>
Return-Path: <SRS0=hGeN=GM=huawei.com=john.garry@kernel.org>
Subject: Re: [PATCH v17 00/10] LPC: legacy ISA I/O support
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <20180321233940.GI38649@bhelgaas-glaptop.roam.corp.google.com>
 <334da3b2-5233-5ad3-728e-7ae95231bf01@huawei.com>
 <20180322133544.GA236400@bhelgaas-glaptop.roam.corp.google.com>
CC: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>,
	"dann.frazier@canonical.com" <dann.frazier@canonical.com>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "joe@perches.com" <joe@perches.com>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linuxarm
	<linuxarm@huawei.com>, "minyard@acm.org" <minyard@acm.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "frowand.list@gmail.com"
	<frowand.list@gmail.com>, "agraf@suse.de" <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <8cc028fa-e4b5-514f-b2f6-a6bbd2ea57a6@huawei.com>
Date: Thu, 22 Mar 2018 14:18:10 +0000
MIME-Version: 1.0
In-Reply-To: <20180322133544.GA236400@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

>>>
>>> I applied this whole series to pci/lpc for v4.17.
>>>
>>> I made the following whitespace and other trivial corrections.
>>> Hopefully I didn't break anything.
>>>
>>
>> Hi Bjorn,
>>
>> Super thanks for doing this. In general the changes look ok. However a build
>> issue has appeared, below.
>
> It didn't just "appear"; I added it myself!  I fixed it and repushed the
> branch.
>

Hi Bjorn,

I repulled and tested, and it looks ok.

Thanks,
John

> .
>
