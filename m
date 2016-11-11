Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Fri, 11 Nov 2016 18:28:38 -0500
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCHv2] PCI/VMD: Use SRCU as a local RCU to prevent delaying
 global RCU
Message-ID: <20161111232838.GD10660@localhost.localdomain>
References: <1478905725-219032-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478905725-219032-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 04:08:45PM -0700, Jon Derrick wrote:
> SRCU lets synchronize_srcu depend on VMD-local RCU primitives,
> preventing long delays from locking up RCU in other systems. VMD
> performs a synchronize when removing a device, but will hit all irq
> lists if the device uses all VMD vectors. This patch will not help VMD's
> RCU synchronization, but will isolate the read side delays to the VMD
> subsystem. Additionally, the use of SRCU in VMD's isr will keep it
> isolated from any other RCU waiters in the rest of the system.

Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
