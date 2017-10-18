Return-Path: <SRS0=y0Ce=BR=oracle.com=james.puthukattukaran@kernel.org>
Return-Path: <SRS0=y0Ce=BR=oracle.com=james.puthukattukaran@kernel.org>
Message-ID: <59E7B802.5010907@oracle.com>
Date: Wed, 18 Oct 2017 16:22:26 -0400
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] PCI: Workaround wrong flags completions for IDT switch
References: <59C02719.5050103@oracle.com> <9741d204-1dd6-2cc2-c133-2ef49c8a404b@codeaurora.org> <59CAB001.10207@oracle.com> <7084085b-89e7-80fa-d10b-06f121eb57be@codeaurora.org> <20171011192704.GN25517@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171011192704.GN25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 10/11/2017 03:27 PM, Bjorn Helgaas wrote:
> On Tue, Sep 26, 2017 at 04:03:13PM -0400, Sinan Kaya wrote:
>> On 9/26/2017 3:52 PM, James Puthukattukaran wrote:
>>>> I think you want to do the part above as part of a quirk that runs before
>>>> the probe.
>>>
>>> I don't think there's a way to run this early enough?
>>
>> Bjorn?
>>
>> I have seen multiple quirk types in quirks.c some prefixed with EARLY and
>> other LATE.
>
> I'm hoping an early quirk on the switch would be early enough, since
> the workaround needs to be done for devices downstream from the
> switch.
>

The problem is that this won't work for hotplug, which is where this bug 
is exposed. The issue is really moot for boot time since the requester 
id for down stream devices was "locked in" prior to enabling ACS  when 
the BIOS probes the devices present. So, this issue is for when a device 
is hotplugged downstream to this IDT switch.
James
