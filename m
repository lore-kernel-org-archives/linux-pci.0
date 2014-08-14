Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37945 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaHNJTz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Aug 2014 05:19:55 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NAA00HIWHX5VL50@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 14 Aug 2014 18:19:54 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>
Cc: linux-pci@vger.kernel.org, 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Mohit Kumar' <mohit.kumar@st.com>, kernel@pengutronix.de,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1406884222-23974-1-git-send-email-l.stach@pengutronix.de>
 <007901cfad75$58974040$09c5c0c0$%han@samsung.com>
 <1408005693.4649.15.camel@weser.hi.pengutronix.de>
In-reply-to: <1408005693.4649.15.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH] PCI: designware: check private_data validity in single
 place
Date: Thu, 14 Aug 2014 18:19:53 +0900
Message-id: <005101cfb7a0$e83bfe90$b8b3fbb0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, August 14, 2014 5:42 PM, Lucas Stach wrote:
> Am Freitag, den 01.08.2014, 19:42 +0900 schrieb Jingoo Han:
> > On Friday, August 01, 2014 6:10 PM, Lucas Stach wrote:
> > >
> > > The driver had checks for this sprinkled all over. As we call
> > > sys_to_pcie() before every instance of this check, we can as well
> > > move the check to this single location to make things clear.
> > >
> > > Removing the statements after BUG[_ON]() is safe as the kernel
> > > is halted at this point anyway.
> > >
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> 
> Does this mean this addresses your concerns with the original series and
> you are okay with it now? If so please provide an Ack to the patches of
> this series also, so Bjorn knows if he can pick those up.

Do you mean "[PATCH 0/4] PCI: designware: init order/resource alloc fixes"?
Sorry , I didn't review it. Also, I am not sure when I review it.

Mohit,
Would you review Lucas's patch?

Best regards,
Jingoo Han

> 
> Thanks,
> Lucas
> >
> > > ---
> > > This is a follow on patch to the series
> > > "PCI: designware: init order/resource alloc fixes", which
> > > addresses Jingoos review feedback, so this series should
> > > be hopefully good to go now.
> > > ---
> >
> 
> --
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |

