Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <59F29566.4080806@rock-chips.com>
Date: Fri, 27 Oct 2017 10:09:42 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
CC: linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v8 7/7] PCI / PM: Add support for the PCIe WAKE# signal
 for OF
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com> <20171026132840.20946-8-jeffy.chen@rock-chips.com> <334be327-543f-d379-83de-ce84799fa49a@codeaurora.org>
In-Reply-To: <334be327-543f-d379-83de-ce84799fa49a@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

Thanks for your reply.

On 10/26/2017 11:16 PM, Sinan Kaya wrote:
> If the intention is to push this to pci directory, this code needs to be made
> platform agnostic by splitting into two pieces.
>
> I think you can make this code common by abstracting the IRQ number and
> have some generic code like pci-wake.c in pci directory without the of prefix
> in this file.
>
> Then, you can have some other OF specific code in the drivers/of directory
> that reads the IRQ from OF and calls the common code in PCI directory.

right, that make sense to me...i'll wait for Brian & Bjorn & Rafael's 
opinions, then start rewriting these, thanks :)
