Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44100 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbbJLNei (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 09:34:38 -0400
Message-ID: <1444656873.3364.14.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] PCI: designware: Move LTSSM state definitions to
 pcie-designware.h
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Mon, 12 Oct 2015 15:34:33 +0200
In-Reply-To: <CAOMZO5CyGybRSJfCNwJAXrPuKpJqsA_w0Qfb+vhUXCyCe-PKiQ@mail.gmail.com>
References: <1444355306-21486-1-git-send-email-festevam@gmail.com>
	 <1444645188.3364.5.camel@pengutronix.de>
	 <1444645685.3364.8.camel@pengutronix.de>
	 <CAOMZO5CyGybRSJfCNwJAXrPuKpJqsA_w0Qfb+vhUXCyCe-PKiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 12.10.2015, 09:31 -0300 schrieb Fabio Estevam:
> On Mon, Oct 12, 2015 at 7:28 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> > Actually the TRM states that i.MX6 is using the same narrower mask of
> > 0x1f for the LTSSM state, so another reason to just use that.
> 
> The manual I have seems to tell a different value :-)
> 
> Please check: http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf
> 
> "48.12.11
> Debug Register 0 (PCIE_PL_DEBUG0)"
> 
> says "[5:0]: xmlh_ltssm_state LTSSM current state. See source for encodings"
> 
Urgh. Seems we got confused by all the different defines.

In fact [5:0] is 0x1f, so i.MX6 uses the same mask as Keystone, yet the
common and shared header now states a mask of 0x3f with Keystone being
the exception. That doesn't reflect reality which isn't nice IMHO. I
think it would be better to just use 0x1f as the LTSSM mask in the
shared header and use this for all drivers until a need arises for using
the extra bit on SPEAR.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

