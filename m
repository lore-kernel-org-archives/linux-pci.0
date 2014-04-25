Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56094 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbaDYK3w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 06:29:52 -0400
Message-ID: <1398421728.4657.28.camel@weser.hi.pengutronix.de>
Subject: Re: PCIE support as loadable module
From: Lucas Stach <l.stach@pengutronix.de>
To: Pratyush Anand <pratyush.anand@st.com>
Cc: shiv prakash Agarwal <chhotu.shiv@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Murray <amurray@embedded-bits.co.uk>
Date: Fri, 25 Apr 2014 12:28:48 +0200
In-Reply-To: <20140425085049.GB3168@pratyush-vbox>
References: <CAHH3p5Jib+ypEM0kUtRTn-qpfYCqw60fRKqjsNxbQpNTo+Zouw@mail.gmail.com>
	 <20140425085049.GB3168@pratyush-vbox>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 25.04.2014, 14:20 +0530 schrieb Pratyush Anand:
> On Thu, Apr 24, 2014 at 03:45:58PM +0800, shiv prakash Agarwal wrote:
> > Hi All,
> > 
> > Can we support PCIE driver as loadable module instead of including it in kernel?
> 
> I think it should work with current code. But, You will have to keep
> all PCIe device (ep/card) driver also as module, and they must be
> inserted only after host (RC) driver module.

Um, care to explain why?
I think the bus probing should only happen once the RC driver is there.
It shouldn't matter if device drivers are already registered at this
stage, their probe function will only be called when the bus gets
populated.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

