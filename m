Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:50635 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbaAHU2m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2014 15:28:42 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so2592422iec.37
        for <linux-pci@vger.kernel.org>; Wed, 08 Jan 2014 12:28:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52CD2387.2030403@gmail.com>
References: <52CBC4D1.5080706@gmail.com>
	<CAErSpo7bUchKT5WN+BBq6oKn+O62gWbH+gfaruePBAYrvP7Lmw@mail.gmail.com>
	<52CD2387.2030403@gmail.com>
Date: Wed, 8 Jan 2014 12:28:41 -0800
Message-ID: <CAE9FiQV5r-c4ufd2SqLJk-KcoJhucmr6RszUb0LyUFtgq_a5sg@mail.gmail.com>
Subject: Re: pci->pcie bridge issue: kernel unable to find a free I/O port range.
From: Yinghai Lu <yinghai@kernel.org>
To: "`VL" <vl.homutov@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 8, 2014 at 2:08 AM, `VL <vl.homutov@gmail.com> wrote:
>
> I've enabled netconsole and got some output.
> Here it is: http://dpaste.com/1542030/

It does include any realloc message.

> Note that since the hang occurs on the module load, netconsole was unable
> to send latest messages and the log looks clear
>
> I've rebuilt kernel with sound driver compiled in, and the hang occured
> during
> kernel load, userspace was not reached (but in this case, netconsole was
> useless at
> all) and I've made a photo of screen (attached). Note there is ACPI warning
> about
> system IO conflict.

Can you enable

CONFIG_PCI_DEBUG=y

and boot with "debug ignore_loglevel initcall_debug"?

Thanks

Yinghai
