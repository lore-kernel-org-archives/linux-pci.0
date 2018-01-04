Return-Path: <SRS0=23Ue=D7=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=23Ue=D7=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180104221448.GH189897@bhelgaas-glaptop.roam.corp.google.com>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2436726.ykYRzVD45y@aspire.rjw.lan>
 <33674270.0PFIgc82r6@aspire.rjw.lan> <20180104221448.GH189897@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Jan 2018 00:28:39 +0100
Message-ID: <CAJZ5v0jqQGM0KdUQ4x4bky+uXpKM90Aw7GLSFNWYW+9FppdmBw@mail.gmail.com>
Subject: Re: [PATCH 7/7] PCI / PM: Use SMART_SUSPEND and LEAVE_SUSPENDED flags
 for PCIe ports
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>,
	Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-i2c <linux-i2c@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 4, 2018 at 11:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Jan 03, 2018 at 01:38:27AM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Make the PCIe port driver set DPM_FLAG_SMART_SUSPEND and
>> DPM_FLAG_LEAVE_SUSPENDED for the devices handled by it to benefit
>> from the opportunistic optimizations in the PCI layer enabled by
>> these flags.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Please merge this along with the rest of the series.

I will, thank you!
