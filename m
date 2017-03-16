Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 16 Mar 2017 18:47:33 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mason <slash.tmp@free.fr>
Subject: Re: Legacy PCI interrupt support in PCIe host driver
In-Reply-To: <8443b350-6aa6-75f8-af48-892c722fc2d9@free.fr>
Message-ID: <alpine.DEB.2.20.1703161843420.3586@nanos>
References: <5612adb6-af5c-9fbf-e725-813ee7fe1b4b@free.fr>
 <8443b350-6aa6-75f8-af48-892c722fc2d9@free.fr>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Liviu Dudau <liviu.dudau@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 16 Mar 2017, Mason wrote:
> About shared ISRs. Are they supposed to return IRQ_HANDLED
> if and only if they handled something?

Every interrupt handler is supposed to return IRQ_NONE if it did not handle
it. That does not depend on shared or not. The handler does not know if
it's on a shared interrupt line or not. IRQF_SHARED only tells, that the
handler is capable of sharing the interrupt line with another device.

> Will that stop the next ISR from being called?

No.

> I guess if two interrupts fire at the same time, we'll just take two
> separate exceptions?

Wrong guess. That might work with level interupts, but with other types
nothing will raise another exception. Sharing interrupts on edge types is a
stupid idea, but hardware folks insist on implementing stupid ideas.

Thanks,

	tglx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
