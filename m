Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:32892 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2FKT7n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 15:59:43 -0400
Received: by pbbrp8 with SMTP id rp8so6036033pbb.19
        for <linux-pci@vger.kernel.org>; Mon, 11 Jun 2012 12:59:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20120611T205954-871@post.gmane.org>
References: <loom.20120607T194858-986@post.gmane.org>
	<CAE9FiQWau+ko4JiEEjM=2xSH_7FPBr_ZYOm8YGpin2p97=12PQ@mail.gmail.com>
	<loom.20120611T205954-871@post.gmane.org>
Date: Mon, 11 Jun 2012 12:59:43 -0700
Message-ID: <CAE9FiQWsv+VU_240BgzHhyR5=A+7DkceWR0oNuYgYxi5TwWvyg@mail.gmail.com>
Subject: Re: PCIe rescan not working
From: Yinghai Lu <yinghai@kernel.org>
To: Tom Carr <tkcarr03873@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 11, 2012 at 12:32 PM, Tom Carr <tkcarr03873@gmail.com> wrote:
>
> Yinghai, sorry about the direct email on Friday, I tried to reply back to the
> newsgroup but the send kept failing. Your suggestion worked but only if there
> were no drivers attached to the endpoints. If I load the driver for the endpoint
> at bus 6.0 and 9.0, then load the empty FPGA at bus 8.0, which is off of 4.8,
> and write 1 to /sys/bus/pci/remove the system crashes. Is there a
> requirement that all down stream devices be removed? I could not find any such
> requirement in any documentation. Here is the most of the stack trace.

can you please try current linus kernel like
3.4 or 3.5-rc1 ?

looks like there is some stop/remove pci device code bug in old kernel.

Thanks

Yinghai
