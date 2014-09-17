Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27028 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353AbaIQP4A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Sep 2014 11:56:00 -0400
Date: Wed, 17 Sep 2014 11:55:54 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/3] PCI/MSI/Armada-370-xp: Remove
 arch_msi_check_device()
Message-ID: <20140917155554.GE16945@titan.lakedaemon.net>
References: <cover.1410078503.git.agordeev@redhat.com>
 <9f3497a0f478f3ee7d4a16b9a4221d4377e5863d.1410078503.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9f3497a0f478f3ee7d4a16b9a4221d4377e5863d.1410078503.git.agordeev@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alexander,

On Sun, Sep 07, 2014 at 08:57:54PM +0200, Alexander Gordeev wrote:
> Moving MSI checks from arch_msi_check_device() function to
> arch_setup_msi_irqs() function makes code more compact and
> allows removing unnecessary hook arch_msi_check_device()
> from generic MSI code.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Now that ThomasP has had a chance to test, please adjust the subject
line to 'irqchip: armada-370-xp: M...' and

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
