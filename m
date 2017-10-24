Return-Path: <SRS0=LpGo=BX=ti.com=kishon@kernel.org>
Return-Path: <SRS0=LpGo=BX=ti.com=kishon@kernel.org>
Subject: Re: [PATCH v2] dwc: dra7xx: Print link state to console for debug
To: Bjorn Helgaas <helgaas@kernel.org>, Faiz Abbas <faiz_abbas@ti.com>
References: <1508417009-30869-1-git-send-email-faiz_abbas@ti.com>
 <20171020230952.GZ6332@bhelgaas-glaptop.roam.corp.google.com>
 <3692fbeb-bf8a-6de6-898b-551d899e9e55@ti.com>
 <20171023140411.GB9092@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6a82ce2d-3feb-a6eb-d33d-b4b1e3f6b33b@ti.com>
Date: Tue, 24 Oct 2017 11:48:13 +0530
MIME-Version: 1.0
In-Reply-To: <20171023140411.GB9092@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Monday 23 October 2017 07:34 PM, Bjorn Helgaas wrote:
> On Mon, Oct 23, 2017 at 03:59:49PM +0530, Faiz Abbas wrote:
>> On Saturday 21 October 2017 04:39 AM, Bjorn Helgaas wrote:
>>> On Thu, Oct 19, 2017 at 06:13:29PM +0530, Faiz Abbas wrote:
>>>> Enable support for printing the LTSSM link state for debugging PCI
>>>> when link is down.
>>>>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>> ---
>>>> v2:
>>>>  1. Changed dev_err() to dev_dbg()
>>>>  2. Changed static char array to static const char * const
>>>>  3. format changes
>>>
>>> I'm not really sure how much debug help we want to carry around in the
>>> mainline kernel.  End users aren't going to use this; it seems like
>>> more of a lab tool, and in situations like that you usually end up
>>> carrying around some out-of-tree patches for a while anyway.  But I
>>> can probably be convinced either way.
>>
>> It'll be easier to support customers if they can tell us what the state
>> of the link is by just changing the log level. We won't have to send a
>> debug patch to the customer to find that out.
> 
> That still sounds like a lab debug situation to me.  Regular customers
> do not debug things at the level of the link state.  I'm not aware of
> any other drivers that do this, so including this hints that this
> driver/hardware is not very mature.
> 
> Printing text certainly *looks* nice, but it adds a lot of code and
> I'm not sure how much actual value they add.  Just printing a hex
> value might be more reliable in terms of communicating it accurately
> back to you.  E.g., it might be easier to lose the distinction between
> DISABLED_ENTRY and DISABLED_IDLE than between 0x745f and 0x7463,
> especially in a phone situation.
> 
> Anyway, if Kishon acks this, I'll apply it.  One nit: please do the
> "link up" test once, e.g.,

IMHO both print text and the debug print itself helps to save developer effort.

FWIW:
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
