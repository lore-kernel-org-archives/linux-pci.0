Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36423 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbbLODPe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 22:15:34 -0500
Received: by obcno2 with SMTP id no2so29165316obc.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Dec 2015 19:15:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151203172900.GB17565@localhost>
References: <cover.1447949171.git.luto@kernel.org> <20151203172900.GB17565@localhost>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 14 Dec 2015 19:15:13 -0800
Message-ID: <CALCETrV53ZR6Yy0m4xWzNTZJaQWrk9X7cMf3__32H+fN1ya0=g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Minor _OSC error handling improvements
To: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux API <linux-api@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[cc: linux-acpi and Rafael -- whoops]

Rafael, do you want me to resend these?

--Andy

On Thu, Dec 3, 2015 at 9:29 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Nov 19, 2015 at 08:08:18AM -0800, Andy Lutomirski wrote:
>> This doesn't fix any bugs, but it makes the debugging output a
>> little more useful.
>>
>> Andy Lutomirski (2):
>>   acpi: Tidy up _OSC error spacing
>>   acpi: Show _OSC UUID when _OSC fails
>>
>>  drivers/acpi/bus.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> These both look fine to me.  If you want it:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>



-- 
Andy Lutomirski
AMA Capital Management, LLC
