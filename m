Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 10 Nov 2016 09:30:37 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH] PCI: mvebu: Take control of mbus windows setup by the
 firmware
Message-ID: <20161110093037.376ae79d@free-electrons.com>
In-Reply-To: <20161026174440.GA24717@obsidianresearch.com>
References: <20161026174440.GA24717@obsidianresearch.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Wed, 26 Oct 2016 11:44:40 -0600, Jason Gunthorpe wrote:
> The firmware may setup the mbus to access PCI-E and indicate this
> has happened with a ranges mapping for the PCI-E ID. If this happens
> then the mbus setup and the pci dynamic setup conflict, creating
> problems.
> 
> Have PCI-E assume control of the firmware specified default mapping by
> setting the value of the bridge window to match the firmware mapping.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Sorry for the late feedback. I am not sure to fully understand what you
are trying to do here.

However, one thing that confuses me specifically is how can the kernel
get any MBus mapping set up by the firmware? Indeed, when the
mvebu-mbus driver initializes, it destroys all existing MBus windows
that might have been left by the firmware/bootloader:

static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
                                         phys_addr_t mbuswins_phys_base,
                                         size_t mbuswins_size,
                                         phys_addr_t sdramwins_phys_base,
                                         size_t sdramwins_size,
                                         phys_addr_t mbusbridge_phys_base,
                                         size_t mbusbridge_size,
                                         bool is_coherent)
[...]
        for (win = 0; win < mbus->soc->num_wins; win++)
                mvebu_mbus_disable_window(mbus, win);

Why does Linux needs to rely on what the firmware has setup in terms of
MBus windows? Why can't Linux just find out the right BAR base/size
like it is doing for all other devices?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
