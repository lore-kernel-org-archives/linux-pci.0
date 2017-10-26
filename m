Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Oct 2017 07:42:22 -0700
From: Tony Lindgren <tony@atomide.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pm@vger.kernel.org, shawn.lin@rock-chips.com,
        briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH v8 7/7] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Message-ID: <20171026144221.GF21504@atomide.com>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
 <20171026132840.20946-8-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171026132840.20946-8-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Jeffy Chen <jeffy.chen@rock-chips.com> [171026 06:31]:
> Add pci-of.c to handle the PCIe WAKE# interrupt.
> 
> Also use the dedicated wakeirq infrastructure to simplify it.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Thanks for doing this, looks good to me from wakeirq point of view:

Acked-by: Tony Lindgren <tony@atomide.com>
