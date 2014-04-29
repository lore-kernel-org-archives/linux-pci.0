Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:48276 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaD2D3p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Apr 2014 23:29:45 -0400
Received: by mail-ve0-f180.google.com with SMTP id jz11so9021697veb.39
        for <linux-pci@vger.kernel.org>; Mon, 28 Apr 2014 20:29:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7c+8d9zbSrk_8cdNeyAcSVGve5uEQVcfpbG3feiYRxHg@mail.gmail.com>
References: <1398682281-18772-1-git-send-email-festevam@gmail.com>
	<CAErSpo70h=DeE3=EpF9d=RQM5y-3tTJ9ZqDiGQ8t5rLfs_zx6w@mail.gmail.com>
	<CAOMZO5BBLesVnHRkSkGaadr=-RpvUm68u2L2MZeQ2WOq28n=xw@mail.gmail.com>
	<CAErSpo7c+8d9zbSrk_8cdNeyAcSVGve5uEQVcfpbG3feiYRxHg@mail.gmail.com>
Date: Tue, 29 Apr 2014 00:29:44 -0300
Message-ID: <CAOMZO5CDDni9kGi6egBo_rfk1GGr3h3wk+im0jgqwyVa_3CtWg@mail.gmail.com>
Subject: Re: [PATCH] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t' type
From: Fabio Estevam <festevam@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 29, 2014 at 12:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> I didn't suggest changing the code to use an actual "struct resource".
>  I suggested using a similar printk format, e.g., "[mem
> %#010llx-%#010llx]".

Thanks for the clarification. Just sent v2 as suggested.
