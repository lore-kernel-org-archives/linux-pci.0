Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:8347 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3LLKro (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 05:47:44 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Shawn Guo' <shawn.guo@linaro.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Simon Horman' <horms@verge.net.au>,
	'Magnus Damm' <magnus.damm@gmail.com>,
	'Valentine Barshak' <valentine.barshak@cogentembedded.com>,
	'Wei Yongjun' <weiyj.lk@gmail.com>,
	'Wei Yongjun' <yongjun_wei@trendmicro.com.cn>,
	'Kuninori Morimoto' <kuninori.morimoto.gx@renesas.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <20131211183237.GI4699@google.com>
 <20131212070045.GO18380@S2101-09.ap.freescale.net>
In-reply-to: <20131212070045.GO18380@S2101-09.ap.freescale.net>
Subject: Re: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada,
 R-Car PCI host maintainers
Date: Thu, 12 Dec 2013 19:47:02 +0900
Message-id: <000001cef727$7da93730$78fba590$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 12, 2013 4:01 PM, Shawn Guo wrote:
> On Wed, Dec 11, 2013 at 11:32:37AM -0700, Bjorn Helgaas wrote:
> > +PCI DRIVER FOR IMX6
> > +M:	Shawn Guo <shawn.guo@linaro.org>
> 
> Thanks for the nomination.  But I think a better person for this
> position would be Richard Zhu <r65037@freescale.com> (copied).  He knows
> the driver and controller much better than myself, and most importantly
> he is the driver owner for Freescale kernel and he has the contact to
> Freescale PCIe hardware people.

I agree with Shawn Guo's opinion. :-)

Richard Zhu has been maintaining i.MX6 PCIe driver. Also he can contact
Freescale PCIe hardware engineers. Thus, he is the appropriate person
for the Maintainer of i.MX PCIe.

Best regards,
Jingoo Han

> 
> Shawn
> 
> > +L:	linux-pci@vger.kernel.org
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:	drivers/pci/host/*imx6*

