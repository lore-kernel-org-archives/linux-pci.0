Return-Path: <linux-acpi-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: regression in 4.0.0-rc1 with r8169 ethernet
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54F17715.6050506@linux.intel.com>
Date: Sat, 28 Feb 2015 00:36:34 -0800
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Voegtle <tv@lio96.de>, Dave Airlie <airlied@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Message-Id: <32040DE9-54EE-4A7D-883A-F578ACFE4338@holtmann.org>
References: <CAPM=9tz8HQAZbdfgE15++i++NkArjxqiY3-BjANqDBTo1g-pOw@mail.gmail.com> <CAPM=9txFHJXbhXQsSyL=h2oG83tr5ZnJj7G6cFtVQ+EDWdXv6w@mail.gmail.com> <alpine.LSU.2.11.1502271534570.10799@er-systems.de> <1588858.OaSxSRONoY@vostro.rjw.lan> <54F17715.6050506@linux.intel.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jiang,

>>> I have the same problem with a Asrock Q1900B-ITX mainboard with 
>>> a Intel Celeron J1900 onboard.
>>> 
>>> I did a bisect and ended up with:
>>> 
>>> 593669c2ac0fe18baee04a3cd5539a148aa48574 is the first bad commit
>>> 
>>> commit 593669c2ac0fe18baee04a3cd5539a148aa48574
>>> Author: Jiang Liu <jiang.liu@linux.intel.com>
>>> Date:   Thu Feb 5 13:44:46 2015 +0800
>>> 
>>>     x86/PCI/ACPI: Use common ACPI resource interfaces to simplify 
>>> implementation
>>> 
>>> 
>>> I can revert this quite big commit on current git head (4f671fe) with no 
>>> problems and then everything is fine again.
>> 
>> Thanks for nailing this one!
>> 
>> It really wasn't supposed to make any functional difference, though, so there
>> must be some subtle mistake that escaped everyone in it.
>> 
>> I'll have a look at that and hopefully Jiang Liu will be able to help in the
>> meantime too.
> Hi all,
> 	Sorry for slow response, just return from Chinese New Holidays:)
> Hi Thomas,
> 	Could you please help to provide the dmesgs before and after the
> revert?

just grab a Minnowboard Max and test this by yourself. It has the same problem. The MAC address is ff:ff:ff:ff:ff:ff with this patch. Once I reverted it, the MAC address is correctly read again.

Regards

Marcel

