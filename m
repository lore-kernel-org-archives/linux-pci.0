Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH 3/9] PCI: pciehp: Drop hotplug_slot_ops wrappers
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
References: <cover.1534686484.git.lukas@wunner.de>
 <f430b343ae47e0587401a2b0c6d24f3c6f90cdfd.1534686485.git.lukas@wunner.de>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <df979e53-e0ca-56dd-ca1b-b3818a60e9cd@kernel.org>
Date: Sun, 19 Aug 2018 18:01:04 -0400
MIME-Version: 1.0
In-Reply-To: <f430b343ae47e0587401a2b0c6d24f3c6f90cdfd.1534686485.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 8/19/2018 10:29 AM, Lukas Wunner wrote:
> pciehp's ->enable_slot, ->disable_slot, ->get_attention_status and
> ->reset_slot callbacks are currently implemented by wrapper functions
> that do nothing else but call down to a backend function.  The backends
> are not called from anywhere else, so drop the wrappers and use the
> backends directly as callbacks, thereby shaving off a few lines of
> unnecessary code.
> 
> No functional change intended.
> 
> Signed-off-by: Lukas Wunner<lukas@wunner.de>

Great work. I was surprised by the number of steps we need to
jump in order to reach to real code here. Simplification is welcome.		
