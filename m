Return-Path: <SRS0=wdry=A3=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=wdry=A3=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20170926213547.GV15970@bhelgaas-glaptop.roam.corp.google.com>
References: <1877076.QiUpNxchJO@aspire.rjw.lan> <20170926213547.GV15970@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Sep 2017 23:39:51 +0200
Message-ID: <CAJZ5v0i0=Cz2uKw92-5QR8G-JGqjSu9gOxcMsepCCVP=sywyaw@mail.gmail.com>
Subject: Re: [PATCH] PM / PCI: Do not resume any devices in pci_pm_prepare()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>,
	Linux PM <linux-pm@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 26, 2017 at 11:35 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Sep 25, 2017 at 01:33:13AM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> It should not be necessary to resume devices with ignore_children set
>> in pci_pm_prepare(), because they should be resumed explcitly by
>> their children drivers during suspend if need be and they will be
>> resumed by pci_pm_suspend() after that anyway, so avoid doing that.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Oh, and I meant to also say that you've merged the PM-related things
> here in the past, so I assume you'll take this one :)

I will. :-)
