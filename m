Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:65439 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589AbaGKSJt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 14:09:49 -0400
Received: by mail-ie0-f177.google.com with SMTP id at20so1200236iec.22
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2014 11:09:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4DzJ112NxfjXT=NbXMxNqre_Vo61fS0Mem=MWCz+OvcA@mail.gmail.com>
References: <20140611060118.GB3169@yanx>
	<CAE9FiQWe2bf7QbKn9kmZS34a4cMewsdD-9qAELdXs-dEtx70GQ@mail.gmail.com>
	<20140702210736.GB28852@google.com>
	<CAE9FiQU5Ltu89zmRG0h2aXfXH0oCcTEP=jF7b=zHi=SaOA2rKg@mail.gmail.com>
	<20140703131526.GG28852@google.com>
	<CAE9FiQWPGXMBYmpzyk8cicKZ1ELUZiARkZjr2vvgntmt3bt1jQ@mail.gmail.com>
	<20140703221152.GH28852@google.com>
	<CAE9FiQX69x_YgHihYM-+tahTvbuk6MATBXvm9Rz5kiQ9UpKNPg@mail.gmail.com>
	<CAErSpo4DzJ112NxfjXT=NbXMxNqre_Vo61fS0Mem=MWCz+OvcA@mail.gmail.com>
Date: Fri, 11 Jul 2014 11:09:48 -0700
Message-ID: <CAE9FiQWUPd4d9DWeiuDqQ=tKKe+5ZofUEw3JViXYs6+9zBG6Sg@mail.gmail.com>
Subject: Re: [PATCH] pci: Allow very large resource windows
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 11, 2014 at 11:00 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> I explained why I think it is dangerous in the paragraph "With
> 'r->flags = 0', ..." above.  This a question of how the hardware
> behaves, so if you think I'm wrong, you need to point out something in
> the spec that says the hardware works differently than how I think it
> does.

If the BAR have all 0, cpu can not access it as hw will forward access to ram
controller according to routing table.

Yinghai
