Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
To: Sinan Kaya <okaya@codeaurora.org>, Alex_Gagniuc@Dellteam.com,
        bhelgaas@google.com
Cc: Austin.Bolen@dell.com, Shyam.Iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
 <28004506-24f0-6d10-2d1e-074e0483d2f9@codeaurora.org>
 <4e0611c872054e768daa96b302651db3@ausx13mps321.AMER.DELL.COM>
 <f260078b-6918-7fd9-39d6-e9f300e4c048@codeaurora.org>
 <3b8a895b-3080-7ddb-cbfd-5aa972e9bf65@gmail.com>
 <35563ce3-e235-096c-4b9b-5f3664d67d0f@codeaurora.org>
 <093b2789-39a1-db9e-5783-b0488b3c9ccd@gmail.com>
 <32d58835-2f35-0b80-38d0-b9ff603619dd@codeaurora.org>
 <54071f83-5d0d-04a0-d448-0c99ec0ffc4f@gmail.com>
 <29ad2bf5-b5af-35be-3bef-2d0652aa2e33@codeaurora.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <954892f0-196d-b11c-c2a0-e4a0e4be4b8c@gmail.com>
Date: Thu, 31 May 2018 12:27:20 -0500
MIME-Version: 1.0
In-Reply-To: <29ad2bf5-b5af-35be-3bef-2d0652aa2e33@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/31/2018 12:11 PM, Sinan Kaya wrote:
> On 5/31/2018 12:49 PM, Alex G. wrote:
>>> 	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
>>> 	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width, *parent*);
>> That's confusing. I'd expect _capable() and _available() to be
>> symmetrical. They either both look at one link only, or both go down to
>> the root port. Though it seems _capable() is link-local, and
>> _available() is down to root port.
>>
> 
> As you know, link speed is a qualification of two devices speed capability.
> Both speed and width parameters get negotiated by two devices during TS1 and TS2
> ordered set exchange. 
> 
> You need to see what your link partner can support in available function() vs.
> what this device can do in bandwidth() function.

I see. I'm not sure I can use pcie_print_link_status() without some
major refactoring. I need to look at capability of device and it
downstream port. There's no point complaining that an x16 device is
running at x4 when the port is only x4 capable.

Let me think some more on this.

Alex
