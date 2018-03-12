Return-Path: <SRS0=5Xs+=GC=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=5Xs+=GC=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 12 Mar 2018 19:31:08 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
In-Reply-To: <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <7130ab5d568b721ee59f029cf0d5072c@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-03-12 03:33, Bjorn Helgaas wrote:
> On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
>> This patch set brings in error handling support for DPC
>> 
>> The current implementation of AER and error message broadcasting to 
>> the
>> EP driver is tightly coupled and limited to AER service driver.
>> It is important to factor out broadcasting and other link handling
>> callbacks. So that not only when AER gets triggered, but also when DPC 
>> get
>> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
>> 
>> DPC should enumerate the devices after recovering the link, which is
>> achieved by implementing error_resume callback.
> 
> The main point of this series is to call the driver error handling
> callbacks (error_detected(), mmio_enabled(), slot_reset(), etc.) when
> DPC events occur.  We've always called them for AER events, but prior
> to this series, we didn't call them for DPC events.
> 
> That's a good thing -- we should treat DPC events as much like AER
> events as possible.
> 
> This series does make it more obvious that there's still a big
> difference between AER and DPC handling -- for DPC, we remove and
> re-enumerate all the devices, but we don't for AER.
> 
> That difference has been there since the beginning of DPC, so it has
> nothing to do with *this* series EXCEPT for the fact that it really
> complicates the logic you're adding to reset_link() and
> broadcast_error_message().
> 
> We ought to be able to simplify that somehow because the only real
> difference between AER and DPC should be that DPC automatically
> disables the link and AER does it in software.
> 
> Bjorn

Ok, so here is slight modification which I will do and will post final 
looking patches.

1) do not enumerate the devices after link is up (since AER does not do 
it)
2) remove the call to pci_stop_and_remove_bus_device(dev); because now 
DPC also makes use of driver's callback. (like AER does)

above 2 changes should make behavior of DPC identical to AER.

Regards,
Oza.
