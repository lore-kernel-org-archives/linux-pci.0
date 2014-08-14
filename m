Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56420 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbaHNInl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Aug 2014 04:43:41 -0400
Message-ID: <1408005693.4649.15.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH] PCI: designware: check private_data validity in single
 place
From: Lucas Stach <l.stach@pengutronix.de>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Mohit Kumar' <mohit.kumar@st.com>, kernel@pengutronix.de
Date: Thu, 14 Aug 2014 10:41:33 +0200
In-Reply-To: <007901cfad75$58974040$09c5c0c0$%han@samsung.com>
References: <1406884222-23974-1-git-send-email-l.stach@pengutronix.de>
	 <007901cfad75$58974040$09c5c0c0$%han@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jingoo,

Am Freitag, den 01.08.2014, 19:42 +0900 schrieb Jingoo Han:
> On Friday, August 01, 2014 6:10 PM, Lucas Stach wrote:
> > 
> > The driver had checks for this sprinkled all over. As we call
> > sys_to_pcie() before every instance of this check, we can as well
> > move the check to this single location to make things clear.
> > 
> > Removing the statements after BUG[_ON]() is safe as the kernel
> > is halted at this point anyway.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Acked-by: Jingoo Han <jg1.han@samsung.com>

Does this mean this addresses your concerns with the original series and
you are okay with it now? If so please provide an Ack to the patches of
this series also, so Bjorn knows if he can pick those up.

Thanks,
Lucas
> 
> > ---
> > This is a follow on patch to the series
> > "PCI: designware: init order/resource alloc fixes", which
> > addresses Jingoos review feedback, so this series should
> > be hopefully good to go now.
> > ---
> 

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

