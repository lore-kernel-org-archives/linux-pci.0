Return-Path: <SRS0=/CHQ=Y7=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=/CHQ=Y7=quantumtechnology.info=kilian.singer@kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20170117145628.GD22776@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From: Kilian Singer <kilian.singer@quantumtechnology.info>
Message-ID: <76b3e542-2739-92cb-db8c-1d04863f5995@quantumtechnology.info>
Date: Tue, 17 Jan 2017 16:49:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170117145628.GD22776@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,

I got two patches to test but they fail because I need to know the git
version against which to patch.

Also a manual patch was not possible because the source code differed
too much.

So currently I am waiting for that info.

Best regards

Kilian


On 17-Jan-17 15:56, Bjorn Helgaas wrote:
> On Tue, Dec 27, 2016 at 05:57:37PM -0600, Bjorn Helgaas wrote:
>> Hi Killian,
>>
>> Thanks for the report (https://bugzilla.kernel.org/show_bug.cgi?id=3D1=
90861)
>> and all the debugging you've done.  Below is a revert of the troubleso=
me
>> commit.  Can you test it and verify that it also fixes the problem?
>>
>> I assume Mika is looking at this and will have a better solution soon.
>> But if not, I'll queue this up for v4.10.
> Can somebody please summarize the current state of this issue?  I
> assume somebody has already posted a better patch that should replace
> this naive revert, but I haven't been following the whole thread.
>
>> commit e648b1ca2b94d207289fedc2538d33c57cdbc4de
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Tue Dec 27 17:27:30 2016 -0600
>>
>>     Revert "PCI: Add runtime PM support for PCIe ports"
>>    =20
>>     Revert 006d44e49a25 ("PCI: Add runtime PM support for PCIe ports")=
.
>>    =20
>>     Killian reported that on a Lenovo W54l with i7-4810MQ, Intel HD Gr=
aphics
>>     4600, and NVIDIA Quadro=AE K1100M, locking the screen kills all ke=
yboard and
>>     mouse interaction.  Reverting 006d44e49a25 fixes the problem.
>>    =20
>>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D190861
>>     Reported-by: kilian.singer@quantumtechnology.info
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>     CC: stable@vger.kernel.org	# v4.8+
>>     CC: Mika Westerberg <mika.westerberg@linux.intel.com>
