Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <54F5ED32.6070200@punnoor.de>
Date: Tue, 03 Mar 2015 18:19:46 +0100
From: Prakash Punnoor <prakash@punnoor.de>
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Voegtle <tv@lio96.de>, Hudd <hedede.l@gmail.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Subject: Re: [Debug 0/2] Fix regressions caused by commit 593669c2ac0f
References: <1425356741-26789-1-git-send-email-jiang.liu@linux.intel.com> <CAPM=9txLQMWzEw0M6v0J8wdCtmH17NMMY_jckiBmAC+keHSTHw@mail.gmail.com>
In-Reply-To: <CAPM=9txLQMWzEw0M6v0J8wdCtmH17NMMY_jckiBmAC+keHSTHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03.03.2015 05:34, Dave Airlie wrote:
> On 3 March 2015 at 14:25, Jiang Liu <jiang.liu@linux.intel.com> wrote:
>> Commit 593669c2ac0f (x86/PCI/ACPI: Use common ACPI resource interfaces
>> to simplify implementation) causes regression to several platforms,
>> which is caused by stricter checks in new ACPI resource parsing code
>> and BIOSes report incorrect ACPI resource descriptors.  So try to relax
>> the check to avoid regressions.
>>
>> Jiang Liu (2):
>>   x86/PCI/ACPI: Ignore resources consumed by host bridge itself
>>   x86/PCI/ACPI: Relax ACPI resource descriptor checks to work around
>>     BIOS bugs
> 
> I've booted my machine with that lost its r8169 and it appears to be
> working now.
> 
> So from the regression POV:
> Tested-by: Dave Airlie <airlied@redhat.com>

Works for me, as well. Thanks!

Tested-by: Prakash Punnoor <prakash@punnoor.de>


Regards,

Prakash
