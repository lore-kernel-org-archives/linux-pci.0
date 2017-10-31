Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171031150933.oho2ffvuj3iagx4m@dell>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <5094729.JAaD38WncM@aspire.rjw.lan>
 <20171031150933.oho2ffvuj3iagx4m@dell>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Oct 2017 17:28:57 +0100
Message-ID: <CAJZ5v0ipSJv0PWPrD3P-yeyD0JWe6EqSJSuZXgjtnFTrMEvpfQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] PM / mfd: intel-lpss: Use DPM_FLAG_SMART_SUSPEND
To: Lee Jones <lee.jones@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 31, 2017 at 4:09 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 16 Oct 2017, Rafael J. Wysocki wrote:
>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Make the intel-lpss driver set DPM_FLAG_SMART_SUSPEND for its
>> devices which will allow them to stay in runtime suspend during
>> system suspend unless they need to be reconfigured for some reason.
>>
>> Also make it avoid resuming its child devices if they have
>> DPM_FLAG_SMART_SUSPEND set to allow them to remain in runtime
>> suspend during system suspend.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/mfd/intel-lpss.c |    6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Is this patch independent?

It depends on the flag definition at least, but functionally it also
depends on the PCI support for the flag.

> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Thanks,
Rafael
