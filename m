Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:38803 "HELO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754034Ab2CZIIT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Mar 2012 04:08:19 -0400
Message-ID: <4F7031A4.70601@mellanox.co.il>
Date: Mon, 26 Mar 2012 11:06:44 +0200
From: Yevgeny Petrilin <yevgenyp@mellanox.co.il>
MIME-Version: 1.0
To: <linux-pci@vger.kernel.org>
Subject: IRQ affinity enforced only after first interrupt.
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I'm working on an issue where affinity changes to IRQ only have effect after the first interrupt which still happens on the original core.
I understand that the decision regarding it takes place in this code:

	if (irq_can_move_pcntxt(data)) {
		ret = chip->irq_set_affinity(data, mask, false);
		switch (ret) {
		case IRQ_SET_MASK_OK:
			cpumask_copy(data->affinity, mask);
		case IRQ_SET_MASK_OK_NOCOPY:
			irq_set_thread_affinity(desc);
			ret = 0;
		}
	} else {
		irqd_set_move_pending(data);
		irq_copy_pending(desc, mask);
	}

Which means that the "IRQD_MOVE_PCNTXT" flag is not set in irq_data->state_use_accessors.
I was able to add this flag using irq_modify_status(), which is probably not the way to go.
This option also doesn't exist in older kernels (2.6.32)

So the question is, when irq_desc is created, how is it determined that "IRQD_MOVE_PCNTXT" flag is set?

Thanks,
Yevgeny
