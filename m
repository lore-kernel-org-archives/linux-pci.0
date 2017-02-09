Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v5] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
 "colin.king@canonical.com" <colin.king@canonical.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1486364596-19699-1-git-send-email-bharatku@xilinx.com>
 <4b04e834-08b6-a728-8fe5-13106d50b3b2@arm.com>
 <8520D5D51A55D047800579B094147198263E68AA@XAP-PVEXMBX02.xlnx.xilinx.com>
 <131228fb-d3f8-3836-3713-e948ed30d398@arm.com>
 <8520D5D51A55D047800579B094147198263E6AF3@XAP-PVEXMBX02.xlnx.xilinx.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <2196f028-b834-9d32-cc3a-e3eb5ed6c3b1@arm.com>
Date: Thu, 9 Feb 2017 16:03:14 +0000
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198263E6AF3@XAP-PVEXMBX02.xlnx.xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Ravikiran Gummaluri <rgummal@xilinx.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 09/02/17 15:16, Bharat Kumar Gogada wrote:
>>
>> On 09/02/17 12:01, Bharat Kumar Gogada wrote:
>>>> On 06/02/17 07:03, Bharat Kumar Gogada wrote:
>>>>> +static struct irq_chip nwl_leg_irq_chip = {
>>>>> +	.name = "nwl_pcie:legacy",
>>>>> +	.irq_enable = nwl_unmask_leg_irq,
>>>>> +	.irq_disable = nwl_mask_leg_irq,
>>>>
>>>> You don't need these two if they are implemented in terms of mask/unmask.
>>>
>>> These are being invoked by some drivers other than interrupt flow.
>>> Ex: drivers/net/wireless/ath/ath9k/main.c
>>> static int ath_reset_internal(struct ath_softc *sc, struct
>>> ath9k_channel *hchan) {
>>>          ....
>>>          disable_irq(sc->irq);
>>>          tasklet_disable(&sc->intr_tq);
>>>         ...
>>>         ...
>>>         enable_irq(sc->irq);
>>>         spin_unlock_bh(&sc->sc_pcu_lock); } For us masking/unmasking
>>> is the way to enable/disable interrupts.
>>
>> And if you looked at the way disable_irq is implemented, you would have found
>> out that it falls back to masking if there is no disable method, preserving the
>> semantic you expect.
>>
> Yes I did see, but this fall back requires extra "IRQ_DISABLE_UNLAZY" flag to be set to each virq. 

No it doesn't. If you do a disable_irq(), the interrupt is flagged as
disabled, but nothing gets done. If an interrupt actually fires, then
the interrupts gets masked, and the handler is not called.

So just drop these two methods, because if this doesn't work, you have
bigger issues.

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
