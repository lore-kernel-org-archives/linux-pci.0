Return-Path: <SRS0=4VT3=BW=ti.com=faiz_abbas@kernel.org>
Return-Path: <SRS0=4VT3=BW=ti.com=faiz_abbas@kernel.org>
Subject: Re: [PATCH v2] dwc: dra7xx: Print link state to console for debug
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <kishon@ti.com>, <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1508417009-30869-1-git-send-email-faiz_abbas@ti.com>
 <20171020230952.GZ6332@bhelgaas-glaptop.roam.corp.google.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <3692fbeb-bf8a-6de6-898b-551d899e9e55@ti.com>
Date: Mon, 23 Oct 2017 15:59:49 +0530
MIME-Version: 1.0
In-Reply-To: <20171020230952.GZ6332@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Saturday 21 October 2017 04:39 AM, Bjorn Helgaas wrote:
> On Thu, Oct 19, 2017 at 06:13:29PM +0530, Faiz Abbas wrote:
>> Enable support for printing the LTSSM link state for debugging PCI
>> when link is down.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>> v2:
>>  1. Changed dev_err() to dev_dbg()
>>  2. Changed static char array to static const char * const
>>  3. format changes
> 
> I'm not really sure how much debug help we want to carry around in the
> mainline kernel.  End users aren't going to use this; it seems like
> more of a lab tool, and in situations like that you usually end up
> carrying around some out-of-tree patches for a while anyway.  But I
> can probably be convinced either way.
> 

It'll be easier to support customers if they can tell us what the state
of the link is by just changing the log level. We won't have to send a
debug patch to the customer to find that out.

Thanks,
Faiz
