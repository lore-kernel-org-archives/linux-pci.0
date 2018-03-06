Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <1520335161.10722.413.camel@linux.intel.com>
Subject: Re: [PATCH v15 8/9] HISI LPC: Add ACPI support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>,
        mika.westerberg@linux.intel.com, rafael@kernel.org,
        lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
        hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com,
        arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net,
        dann.frazier@canonical.com, andy.shevchenko@gmail.com,
        robh@kernel.org
Cc: joe@perches.com, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com, minyard@acm.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        rdunlap@infradead.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, frowand.list@gmail.com, agraf@suse.de
Date: Tue, 06 Mar 2018 13:19:21 +0200
In-Reply-To: <10d3b5b8-0662-27b1-ff72-5080dd54d78e@huawei.com>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
         <1519663249-9850-9-git-send-email-john.garry@huawei.com>
         <1519933855.10722.364.camel@linux.intel.com>
         <10d3b5b8-0662-27b1-ff72-5080dd54d78e@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-03-02 at 10:19 +0000, John Garry wrote:
> On 01/03/2018 19:50, Andy Shevchenko wrote:
> > On Tue, 2018-02-27 at 00:40 +0800, John Garry wrote:

> > Ok, this needs to be thought about a bit more.
> > 
> > I guess I understand what's is the problem with PNP IDs in the
> > driver.
> > 
> > You probe your LPC device quite late.
> > One option is to move from classical probe to a event-driven model,
> > i.e.
> > via registering a notifier (see acpi_lpss.c), preparing necessary
> > stuff
> > at earlier stages and then register devices by their enumeration and
> > appearance.
> > 
> > Though, if I would be you I would seek a opinion from Rafael and
> > Mika
> > (maybe others as well).
> 
> I would like to give a bit more background on this HW. This HW is now 
> for us a legacy device. It will be used in no more chipsets. It is
> only 
> used in hip06 and hip07 chipsets on our D03 and D05 boards, 
> respectively. On these boards we have the following LPC slave devices
> only:
> D03: UART, IPMI
> D05: IPMI
> 
> Supporting IPMI for D05 is required. Supporting legacy D03 and the
> UART 
> is a "nice-to-have". But it is definitely ok for us to not support
> this 
> device.

I see. But it raises another question to the whole series, why do we
introduce a generic indirect IO for only two devices ever?

Can't it be done in the (MFD) driver itself?

Possible another option, is to introduce a specific regmap for that and
use it in the drivers (though it might be not so trivial with existing
ones).

> Our previous ACPI support solution did use a scan handler for this
> host, 
> but there was some sensible pushback on this - please check this if
> not 
> familiar: https://lkml.org/lkml/2018/2/14/532

> Overall it does not make sense to try to move this back to
> drivers/acpi 
> and receive more pushback from that direction,

Ah, I think the ARM people just worried mostly about arm64 in the
pathnames, though your case is very similar to our LPSS for only few
SoCs.

I would rather think if you move it directly to drivers/acpi it would be
fine.

>  and only delay 
> indefinitely upstreaming this driver (which is now running at ~27
> months 
> since v1) to just support a PNP-compatible device which we don't care 
> too much about.

Ouch!

As I suggested before, you would better to get an input from
maintainers.

My personal opinion that the handler approach is cleaner, though it's
still non-generic stuff. I think that this is what Mika referred to in
his mail.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
