Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:44283 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274AbbLOQKi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Dec 2015 11:10:38 -0500
Subject: Re: [PATCH 0/2] Minor _OSC error handling improvements
To: Andy Lutomirski <luto@amacapital.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linux API <linux-api@vger.kernel.org>
References: <cover.1447949171.git.luto@kernel.org>
 <20151203172900.GB17565@localhost>
 <CALCETrV53ZR6Yy0m4xWzNTZJaQWrk9X7cMf3__32H+fN1ya0=g@mail.gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <56703B5E.7040601@intel.com>
Date: Tue, 15 Dec 2015 17:10:06 +0100
MIME-Version: 1.0
In-Reply-To: <CALCETrV53ZR6Yy0m4xWzNTZJaQWrk9X7cMf3__32H+fN1ya0=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/15/2015 4:15 AM, Andy Lutomirski wrote:
> [cc: linux-acpi and Rafael -- whoops]
>
> Rafael, do you want me to resend these?

Yes, please.

Thanks,
Rafael


> On Thu, Dec 3, 2015 at 9:29 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Thu, Nov 19, 2015 at 08:08:18AM -0800, Andy Lutomirski wrote:
>>> This doesn't fix any bugs, but it makes the debugging output a
>>> little more useful.
>>>
>>> Andy Lutomirski (2):
>>>    acpi: Tidy up _OSC error spacing
>>>    acpi: Show _OSC UUID when _OSC fails
>>>
>>>   drivers/acpi/bus.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>> These both look fine to me.  If you want it:
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
>

