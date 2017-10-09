Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdJIFnV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2017 01:43:21 -0400
Date: Mon, 9 Oct 2017 07:43:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jia-Ju Bai <baijiaju1990@163.com>
Cc: forest@alittletooquiet.net, simon@nikanor.nu, tvboxspy@gmail.com,
        scott@matheina.com, dan.a.cashman@gmail.com,
        golubev.mikhail@gmail.com, bhelgaas@google.com,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [BUG] vt6655: A possible sleep-in-atomic bug in vt6655_suspend
Message-ID: <20171009054327.GA12559@kroah.com>
References: <f3f4b129-471e-6ccd-a2fa-6ffd915bcb7f@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f3f4b129-471e-6ccd-a2fa-6ffd915bcb7f@163.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 09, 2017 at 09:10:28AM +0800, Jia-Ju Bai wrote:
> According to device_main.c, the driver may sleep under a spinlock,
> and the function call path is:
> vt6655_suspend (acquire the spinlock)
>   pci_set_power_state
>     __pci_start_power_transition (drivers/pci/pci.c)
>       msleep --> may sleep
> 
> A possible fix is to replace msleep with mdelay in
> __pci_start_power_transition in drivers/pci/pci.c.

Patches are usually best to send in for things that you find like this.

thanks,

greg k-h
