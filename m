Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:65243 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab3EGWVn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2013 18:21:43 -0400
Received: by mail-ie0-f178.google.com with SMTP id b11so2076065iee.9
        for <linux-pci@vger.kernel.org>; Tue, 07 May 2013 15:21:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5188b791.a110420a.0bea.077eSMTPIN_ADDED_BROKEN@mx.google.com>
References: <1367712653.11982.19.camel@pasglop>
	<1367712932.11982.20.camel@pasglop>
	<CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	<1367732090.11982.38.camel@pasglop>
	<CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	<1367740336.11982.41.camel@pasglop>
	<51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	<1367837311.15842.31.camel@pasglop>
	<CAE9FiQU=ZEfvVKeQgVOa0jeG5smJrKRaeLTOckR=v2vzTyTvLw@mail.gmail.com>
	<5188b791.a110420a.0bea.077eSMTPIN_ADDED_BROKEN@mx.google.com>
Date: Tue, 7 May 2013 15:21:42 -0700
Message-ID: <CAE9FiQUc2q0GfVumVrp3_ba0q6N_a_WxjKhMWbyqbLfO=WGaFQ@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 7, 2013 at 1:11 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> Yinghai, thanks for the updated patch. It's working well with (v1 #1 and v2 #2), which
> was applied on top of Ben's patch sent for review. The kernel log is attached in case
> you want double-check.
>
Yes, that works.

I just sent v3, please test that.

That should be less invasive for v3.10. As it will skip adding failed
resource to failed list when the resource is IORESOURCE_IO, and bus
does not have IORESOURCE_IO.

Thanks

Yinghai
