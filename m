Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Voegtle <tv@lio96.de>
Cc: Dave Airlie <airlied@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Subject: Re: regression in 4.0.0-rc1 with r8169 ethernet
Date: Fri, 27 Feb 2015 23:24:49 +0100
Message-ID: <1588858.OaSxSRONoY@vostro.rjw.lan>
In-Reply-To: <alpine.LSU.2.11.1502271534570.10799@er-systems.de>
References: <CAPM=9tz8HQAZbdfgE15++i++NkArjxqiY3-BjANqDBTo1g-pOw@mail.gmail.com> <CAPM=9txFHJXbhXQsSyL=h2oG83tr5ZnJj7G6cFtVQ+EDWdXv6w@mail.gmail.com> <alpine.LSU.2.11.1502271534570.10799@er-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, February 27, 2015 03:50:32 PM Thomas Voegtle wrote:
> 
> Hi,
> 
> I have the same problem with a Asrock Q1900B-ITX mainboard with 
> a Intel Celeron J1900 onboard.
> 
> I did a bisect and ended up with:
> 
> 593669c2ac0fe18baee04a3cd5539a148aa48574 is the first bad commit
> 
> commit 593669c2ac0fe18baee04a3cd5539a148aa48574
> Author: Jiang Liu <jiang.liu@linux.intel.com>
> Date:   Thu Feb 5 13:44:46 2015 +0800
> 
>      x86/PCI/ACPI: Use common ACPI resource interfaces to simplify 
> implementation
> 
> 
> I can revert this quite big commit on current git head (4f671fe) with no 
> problems and then everything is fine again.

Thanks for nailing this one!

It really wasn't supposed to make any functional difference, though, so there
must be some subtle mistake that escaped everyone in it.

I'll have a look at that and hopefully Jiang Liu will be able to help in the
meantime too.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
