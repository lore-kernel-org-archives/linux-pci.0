Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:64007 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513Ab3BZDwn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Feb 2013 22:52:43 -0500
Received: by mail-qa0-f41.google.com with SMTP id bs12so2125365qab.14
        for <linux-pci@vger.kernel.org>; Mon, 25 Feb 2013 19:52:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1360874504.16827.5.camel@x220>
References: <CAErSpo5PFn9gDgKWHoGpiSEE9862WbTDm7VVtxMxX05zK7b6kw@mail.gmail.com>
	<1360874504.16827.5.camel@x220>
Date: Mon, 25 Feb 2013 20:52:42 -0700
Message-ID: <CAErSpo6_tO8r2xq-7uo8H18L61Kunb0HgTOvZv0u-sCQKwipxA@mail.gmail.com>
Subject: Re: [Bug 53811] [REGRESSION]: acpiphp broken on Lenovo X220 from 3.6 onwards
From: Bjorn Helgaas <bhelgaas@google.com>
To: ALLurGroceries <allurgroceries@gmail.com>,
	Huang Ying <ying.huang@intel.com>
Cc: Zheng Yan <zheng.z.yan@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+to Huang]

On Thu, Feb 14, 2013 at 1:41 PM, ALLurGroceries
<allurgroceries@gmail.com> wrote:
> On Thu, 2013-02-14 at 10:40 -0700, Bjorn Helgaas wrote:
>> [+cc Zheng, Rafael, linux-pci]
>>
>> On Wed, Feb 13, 2013 at 11:55 PM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
>> > https://bugzilla.kernel.org/show_bug.cgi?id=53811
>> >
>> >            Summary: acpiphp broken on Lenovo X220 from 3.6 onwards
>>
>> Thanks for the report.  Can you please attach complete dmesg logs from
>> kernels with your patch (showing a working hotplug) and without your
>> patch (showing the failing hotplug)?
>
> OK, they're attached. The hotplug is at the very end of both. Without
> the patch, when I try to power the card on with
> echo 1 > /sys/bus/pci/slots/1/power
>
> I get:
> acpiphp_glue: acpiphp_enable_slot: Slot status is not ACPI_STA_ALL

Does anybody care about this runtime PM support for PCIe ports?  If
nobody wants to fix this regression, I'm going to revert 71a83bd727
"PCI/PM: add runtime PM support to PCIe port" and anything that
depends on it.

Bjorn
