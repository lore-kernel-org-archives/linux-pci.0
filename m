Return-Path: <SRS0=hWXb=YR=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=hWXb=YR=quantumtechnology.info=kilian.singer@kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <3913750.OA6IItgEjC@aspire.rjw.lan>
 <3ce9e85d-381c-1c5d-b01d-65b8cf64e1ae@quantumtechnology.info>
 <2944797.fnVvnXZV6t@aspire.rjw.lan>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Peter Wu <peter@lekensteyn.nl>,
 Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>
From: Kilian Singer <kilian.singer@quantumtechnology.info>
Message-ID: <aeb7069c-6fbc-2a1c-4f5a-513c9fbce220@quantumtechnology.info>
Date: Tue, 3 Jan 2017 23:25:14 +0100
MIME-Version: 1.0
In-Reply-To: <2944797.fnVvnXZV6t@aspire.rjw.lan>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Yes that is true:

"Shutdown and suspend/resume work on 4.7.0-1 but fail on 4.8. and 4.9."


I just did not check if the proposed patches fix the suspend/resume.

On 03-Jan-17 23:07, Rafael J. Wysocki wrote:
> On Tuesday, January 03, 2017 10:52:48 PM Kilian Singer wrote:
>> I have not checked if suspend/resume broken.
>> Which patch should I check suspend resume for.
>> When I wrote about firefox and lockscreen issue resolved
>> I forgot to check about the suspend/resume.
> Well, here:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=190861#c26
>
> you said:
>
> "Shutdown and suspend/resume work on 4.7.0-1 but fail on 4.8. and 4.9."
>
> and here:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=190861#c29
>
> you said:
>
> "the pci_port_pm=off
> fixes both the firefox issue and the lock screen issue. Also suspend/resume work.
> Tested on 4.9"
>
> which to me means that suspend/resume is also broken for you
> due to the PCIe ports PM support enabled (the command line option
> should be pcie_port_pm=off, BTW, but I'm assuming that this is what you
> actually used).
>
> Now, it may be broken due to the runtime PM breakage triggering after system
> resume (which may be verified by checking if the revert actually fixes system
> suspend-resume too on your machine), but even then I wouldn't revert that
> particular commit.
>
> Thanks,
> Rafael
>
