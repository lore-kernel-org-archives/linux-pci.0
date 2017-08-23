Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 22 Aug 2017 18:57:15 -0700
From: Brian Norris <briannorris@chromium.org>
To: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20170823015714.GA129497@google.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <20170818170107.GA119461@google.com>
 <20170818181416.GF6008@atomide.com>
 <5997486D.4040803@rock-chips.com>
 <20170822172653.GJ6008@atomide.com>
 <599CDB37.3070307@rock-chips.com>
MIME-Version: 1.0
In-Reply-To: <599CDB37.3070307@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Heiko Stuebner <heiko@sntech.de>, Tony Lindgren <tony@atomide.com>,
 linux-pci@vger.kernel.org, shawn.lin@rock-chips.com,
 linux-kernel@vger.kernel.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jeffy,

On Wed, Aug 23, 2017 at 09:32:39AM +0800, Jeffy Chen wrote:
> and for eage irq, maybe we should enable it right after(or before)
> the driver activate wake function(for example activate WOWLAN or
> WOLAN), otherwise would it be possible to miss some irqs(triggered
> before we actually enable the wake irq)?

I already mentioned this: for the PCI case, the specification explicitly
says that the WAKE# pin must remain asserted until the system wakes and
resets the link. So we don't have this problem.

But it is probably still useful to make sure there's a well-defined
point at which these interrupts are armed, so that if a device driver
does care, it can account for that. Just before suspend_noirq (as it is
today) is probably fine, so if there's some device-level handling that
needs to happen before we get to suspend (but after the wakeirq is
armed), it can go in the device or bus {suspend,resume}_noirq callbacks.

Brian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
