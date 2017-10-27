Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <59F2CABE.1080702@rock-chips.com>
Date: Fri, 27 Oct 2017 13:57:18 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Brian Norris <briannorris@chromium.org>
CC: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, rjw@rjwysocki.net, dianders@chromium.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH v8 1/7] dt-bindings: PCI: Add definition of PCIe WAKE#
 irq and PCI irq
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com> <20171026132840.20946-2-jeffy.chen@rock-chips.com> <20171027023331.GA11665@google.com> <59F2A2BA.5030307@rock-chips.com> <20171027054025.GA85582@google.com>
In-Reply-To: <20171027054025.GA85582@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Brian,

On 10/27/2017 01:40 PM, Brian Norris wrote:
> Another odd thing about this series is that the interrupt doesn't
> actually show up in /proc/interrupts, /sys/kernel/debug/gpio, or
> similar, seemingly because the wakeirq is requested/released every time
> we suspend/resume. So it's really not that obvious that the interrupt is
> being configured properly. That's not really a functional problem,
> necessarily, but it doesn't quite seem ideal.
>
right, so maybe we can call dev_pm_set_dedicated_wake_irq() in the 
setup(), and use device_set_wakeup_enable() to enable/disable it in the 
set_wakeup()?

> Brian
