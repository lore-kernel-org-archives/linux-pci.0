Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 18 Dec 2017 16:48:13 -0800
From: Brian Norris <briannorris@chromium.org>
To: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20171219004811.GA216620@google.com>
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

Hi Jeffy, Tony,

On Wed, Aug 23, 2017 at 09:32:39AM +0800, Jeffy Chen wrote:
> Hi Tony,
> 
> On 08/23/2017 01:26 AM, Tony Lindgren wrote:
> >OK, let's fix any wakeriq ordering issues to make it more
> >usable. Sounds like in your case the wakeirq needs to be enabled
> >late and disabled early, while in my test cases I can keep it
> >enabled basically any time.
> 
> yes, in my case it's a level triggered irq, which needs to be
> disabled when receive it(by irq_pm_check_wakeup(my hack) or inside
> of the custom irq handler)
> 
> 
> and for eage irq, maybe we should enable it right after(or before)
> the driver activate wake function(for example activate WOWLAN or
> WOLAN), otherwise would it be possible to miss some irqs(triggered
> before we actually enable the wake irq)?

Did this problem ever get resolved? To be clear, I believe the problem
at hand is:

(a) in suspend/resume (not runtime PM; we may not even have runtime PM
support for most PCI devices)
(b) using a level-triggered signal (PCI WAKE# is active low, and it's
nice to avoid certain races by treating it as level-triggered)

And with the current wakeirq code (and the latest version of Jeffy's
patch series, IIUC), I believe the above case can still trigger an
interrupt storm of sorts (it's not usually unrecoverably-stormy, since
it's a threaded IRQ, and we make "enough" progress).

I don't see how "ordering" can really resolve this problem, unless the
ordering is configured such that the interrupt handler never runs (e.g.,
we disable the IRQ before we get out of any "noirq" phase).

Options I can think of:
(1) implement runtime PM callbacks for all PCI devices, where we clear
any PME status and ensure WAKE# stops asserting [1]
(2) synchronize a device's resume() with the dedicated wake IRQ
(3) skip using the dedicated wake IRQ infrastructure and write our own
interrupt handler for this PCI/PM function

Option (1) seems pretty strange; we don't actually want to manage these
devices with runtime PM.

Option (2) could work, but it would probably require sharing more of the
core suspend/resume internals between
drivers/base/power/{wakeirq,main}.c, which may not be desirable. Among
other problems, that seems more fragile.

Option (3) is easy enough, and we already did that once for the first
pass at poorly implementing this WAKE# logic within the mwifiex driver
:)

> >If this is for suspend/resume, You could just register the
> >wakeirq on suspend and then remove it on resume. We do have at
> >least network drivers doing device_init_wakeup(dev, true) and
> >device_init_wakeup(dev, false) as needed for WOL, see for example
> >bfin_mac_ethtool_setwol().

I don't see how that would be good enough. You still have a window of
time while the driver hasn't finished resuming, in which the interrupt
handler might trigger many times.

Brian

[1] Then we also need to fixup handle_threaded_wake_irq(). Currently it
will not even try to resume the device:

	/* Maybe abort suspend? */
	if (irqd_is_wakeup_set(irq_get_irq_data(irq))) {
		pm_wakeup_event(wirq->dev, 0);

		return IRQ_HANDLED; <--- we exit here
	}

	/* We don't want RPM_ASYNC or RPM_NOWAIT here */
	res = pm_runtime_resume(wirq->dev);
	...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
