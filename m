Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:33082 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759396AbbJ3Qw0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 12:52:26 -0400
MIME-Version: 1.0
In-Reply-To: <DM2PR0301MB123280EE1F7E37B57E27E6EAAB2F0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
	<1446162376-43419-7-git-send-email-jakeo@microsoft.com>
	<CAHp75VfcLVsESDT-KdjobcKVwSWUT=f1i_1PrET47tJ=rB91jA@mail.gmail.com>
	<DM2PR0301MB123280EE1F7E37B57E27E6EAAB2F0@DM2PR0301MB1232.namprd03.prod.outlook.com>
Date: Fri, 30 Oct 2015 18:52:25 +0200
Message-ID: <CAHp75VdTFWMtxT3ftfT4-EgvMaQD=rXVcZf2K2adJM_zyT5Rdg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] drivers:hv: Define the channel type for Hyper-V
 PCI Express pass-through
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Jake Oshins <jakeo@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
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
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 5:57 PM, Jake Oshins <jakeo@microsoft.com> wrote:

>> > + * PCI Express Pass Through
>> > + * {44C4F61D-4444-4400-9D52-802E27EDE19F}
>> > + */
>> > +
>> > +#define HV_PCIE_GUID \
>> > +       .guid = { \
>> > +                       0x1D, 0xF6, 0xC4, 0x44, 0x44, 0x44, 0x00, 0x44, \
>> > +                       0x9D, 0x52, 0x80, 0x2E, 0x27, 0xED, 0xE1, 0x9F \
>> > +               }
>>
>> What about
>> #include <linux/uuid.h>
>>
>> UUID_LE(...)
>>
>> And you may use uuid_le type instead of custom raw buffer.
>>
>
> Thanks.  I was just following the form of all the others in this file.  I think that this was done to match up with the representation that's coming across the VM boundary from Windows.

Perhaps a separate patch to move to uuid.h then?

-- 
With Best Regards,
Andy Shevchenko
