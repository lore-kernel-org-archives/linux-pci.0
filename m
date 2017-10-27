Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <59F2E234.1080801@rock-chips.com>
Date: Fri, 27 Oct 2017 15:37:24 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
CC: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, shawn.lin@rock-chips.com,
        briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v8 7/7] PCI / PM: Add support for the PCIe WAKE# signal
 for OF
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com> <20171026132840.20946-8-jeffy.chen@rock-chips.com> <20171026144221.GF21504@atomide.com>
In-Reply-To: <20171026144221.GF21504@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tony,

thanks for your Acked-by. but i'm moving the dedicated wakeirq setup to 
the setup(), so that the irq would be tracked in the /proc/interrupts.

please help to check the new v10 patches, thanks :)

On 10/26/2017 10:42 PM, Tony Lindgren wrote:
> * Jeffy Chen <jeffy.chen@rock-chips.com> [171026 06:31]:
>> Add pci-of.c to handle the PCIe WAKE# interrupt.
>>
>> Also use the dedicated wakeirq infrastructure to simplify it.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>
> Thanks for doing this, looks good to me from wakeirq point of view:
>
> Acked-by: Tony Lindgren <tony@atomide.com>
>
>
>
