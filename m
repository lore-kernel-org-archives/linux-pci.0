Return-Path: <SRS0=g0YK=HQ=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=g0YK=HQ=codeaurora.org=okaya@kernel.org>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
To: Bjorn Helgaas <helgaas@kernel.org>,
 Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b62c2a8e-fe14-6d7d-147c-0ce3b0c0ab2f@codeaurora.org>
Date: Fri, 27 Apr 2018 15:34:30 -0400
MIME-Version: 1.0
In-Reply-To: <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for adding me.

On 4/27/2018 3:22 PM, Bjorn Helgaas wrote:
> Sinan mooted the idea of using a "no-wait" path of sending the "don't
> generate hotplug interrupts" command.  I think we should work on this
> idea a little more.  If we're shutting down the whole system, I can't
> believe there's much value in *anything* we do in the pciehp_remove()
> path.
> 
> Maybe we should just get rid of pciehp_remove() (and probably
> pcie_port_remove_service() and the other service driver remove methods)
> completely.  That dates from when the service drivers could be modules that
> could be potentially unloaded, but unloading them hasn't been possible for
> years.

Shutdown path is also used for kexec. Leaving hotplug interrupts pending is
dangerous for the newly loaded kernel as it leaves spurious interrupts
during the new kernel boot.

I think we should always disable the hotplug interrupt on shutdown. We might
think of not waiting for command-completion as a middle-ground or go to polling
path instead of interrupts all the time.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
