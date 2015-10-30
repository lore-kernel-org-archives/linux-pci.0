Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <BY2PR0301MB16543334659C86300E12DD5AA02F0@BY2PR0301MB1654.namprd03.prod.outlook.com>
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
	<1446162376-43419-7-git-send-email-jakeo@microsoft.com>
	<CAHp75VfcLVsESDT-KdjobcKVwSWUT=f1i_1PrET47tJ=rB91jA@mail.gmail.com>
	<DM2PR0301MB123280EE1F7E37B57E27E6EAAB2F0@DM2PR0301MB1232.namprd03.prod.outlook.com>
	<CAHp75VdTFWMtxT3ftfT4-EgvMaQD=rXVcZf2K2adJM_zyT5Rdg@mail.gmail.com>
	<BY2PR0301MB16543334659C86300E12DD5AA02F0@BY2PR0301MB1654.namprd03.prod.outlook.com>
Date: Fri, 30 Oct 2015 18:58:43 +0200
Message-ID: <CAHp75Ve5kbzUN341Q85dSQsQDkj0NDPMzmD7_8c=RS5ae2ULyA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] drivers:hv: Define the channel type for Hyper-V
 PCI Express pass-through
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: KY Srinivasan <kys@microsoft.com>
Cc: Jake Oshins <jakeo@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	"tglx@redhat.com" <tglx@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 6:56 PM, KY Srinivasan <kys@microsoft.com> wrote:

>> >> What about
>> >> #include <linux/uuid.h>
>> >>
>> >> UUID_LE(...)
>> >>
>> >> And you may use uuid_le type instead of custom raw buffer.
>> >>
>> >
>> > Thanks.  I was just following the form of all the others in this file.  I think
>> that this was done to match up with the representation that's coming across
>> the VM boundary from Windows.
>>
>> Perhaps a separate patch to move to uuid.h then?
>
> Yes; I am about to send out a patch to use the UUID_LE macro for all of the Hyper-V guids.

And switching to struct uuid_le ?

-- 
With Best Regards,
Andy Shevchenko
