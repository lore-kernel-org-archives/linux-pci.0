Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <59972817.4030907@rock-chips.com>
Date: Sat, 19 Aug 2017 01:47:03 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <20170818170107.GA119461@google.com>
In-Reply-To: <20170818170107.GA119461@google.com>
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Brian,

On 08/19/2017 01:01 AM, Brian Norris wrote:
> Did you test that this works out correctly as a level-triggered
> interrupt? IIUC, the dummy handler won't mask the interrupt, so it might
> keep firing. See:
>
> static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
> {
>          struct wake_irq *wirq = _wirq;
>          int res;
>
>          /* Maybe abort suspend? */
>          if (irqd_is_wakeup_set(irq_get_irq_data(irq))) {
>                  pm_wakeup_event(wirq->dev, 0);
>
>                  return IRQ_HANDLED; <--- We can return here, with the trigger still asserted
>          }
> ...
>
> This could cause some kind of an IRQ storm, including a lockup or
> significant slowdown, I think.

hmmm, right, but as i replied at cros partner issue, this irq handle 
might not be called actually...

in my test on cros 4.4 kernel, it would break by irq_may_run(returning 
false):
static bool irq_may_run(struct irq_desc *desc)
{
...
         /*
          * If the interrupt is an armed wakeup source, mark it pending
          * and suspended, disable it and notify the pm core about the
          * event.
          */
         if (irq_pm_check_wakeup(desc))
                 return false;


bool irq_pm_check_wakeup(struct irq_desc *desc)
{
         if (irqd_is_wakeup_armed(&desc->irq_data)) {
                 irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
                 desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
                 desc->depth++;
                 irq_disable(desc); <--- disabled here
                 pm_system_irq_wakeup(irq_desc_get_irq(desc));
                 return true;



and for irqd_is_wakeup_armed:

static bool suspend_device_irq(struct irq_desc *desc)
{
...
         if (irqd_is_wakeup_set(&desc->irq_data)) {
                 irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED); <-- set 
irqd_is_wakeup_armed here


void dpm_noirq_begin(void)
{
         cpuidle_pause();
         device_wakeup_arm_wake_irqs();
         suspend_device_irqs();


so unless we get an irq between device_wakeup_arm_wake_irqs and 
suspend_device_irq, the irq_pm_check_wakeup would not let us get to 
handle_threaded_wake_irq...


>
> BTW, in another context, Tony suggested we might need to fix up the IRQ flags
> like this:
>
> int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
> {
> ...
>          err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
> -                                  IRQF_ONESHOT, dev_name(dev), wirq);
> +                                  IRQF_ONESHOT | irq_get_trigger_type(irq), dev_name(dev), wirq);
>
> But IIUC, that's not actually necessary, because __setup_irq()
> automatically configures the trigger type if the driver didn't request
> one explicitly.

actually this would not work...irq_get_trigger_type would return zero 
due to a bug which we have a patch for it already:

9908207 New          [tip:irq/urgent] genirq: Restore trigger settings 
in irq_modify_status()


BTW, using dev_name for the name of this wake irq seems not very 
convenient...maybe add a ":wake" suffix?
>
> Brian



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
