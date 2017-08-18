Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 18 Aug 2017 11:28:52 -0700
From: Tony Lindgren <tony@atomide.com>
To: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20170818182850.GG6008@atomide.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <20170818170107.GA119461@google.com>
 <59972817.4030907@rock-chips.com>
MIME-Version: 1.0
In-Reply-To: <59972817.4030907@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, Brian Norris <briannorris@chromium.org>,
 dianders@chromium.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

* jeffy <jeffy.chen@rock-chips.com> [170818 11:05]:
> On 08/19/2017 01:01 AM, Brian Norris wrote:
> > BTW, in another context, Tony suggested we might need to fix up the IRQ flags
> > like this:
> > 
> > int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
> > {
> > ...
> >          err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
> > -                                  IRQF_ONESHOT, dev_name(dev), wirq);
> > +                                  IRQF_ONESHOT | irq_get_trigger_type(irq), dev_name(dev), wirq);
> > 
> > But IIUC, that's not actually necessary, because __setup_irq()
> > automatically configures the trigger type if the driver didn't request
> > one explicitly.
> 
> actually this would not work...irq_get_trigger_type would return zero due to
> a bug which we have a patch for it already:
> 
> 9908207 New          [tip:irq/urgent] genirq: Restore trigger settings in
> irq_modify_status()

Thanks for that information. So it seems we can leave out the
irq_get_trigger_type() here then? Might be worth checking
that it really does get populated though :)

> BTW, using dev_name for the name of this wake irq seems not very
> convenient...maybe add a ":wake" suffix?

Good idea, will take a look.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
