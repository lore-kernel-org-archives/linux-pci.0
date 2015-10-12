Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38769 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbbJLOLq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 10:11:46 -0400
Message-ID: <1444659102.3364.19.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] PCI: designware: Move LTSSM state definitions to
 pcie-designware.h
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Date: Mon, 12 Oct 2015 16:11:42 +0200
In-Reply-To: <CAOMZO5CKWj9tWCOZV65xwFCB7b120weq3Aq7_de-aMdEYAZWpA@mail.gmail.com>
References: <1444355306-21486-1-git-send-email-festevam@gmail.com>
	 <1444645188.3364.5.camel@pengutronix.de>
	 <1444645685.3364.8.camel@pengutronix.de>
	 <CAOMZO5CyGybRSJfCNwJAXrPuKpJqsA_w0Qfb+vhUXCyCe-PKiQ@mail.gmail.com>
	 <1444656873.3364.14.camel@pengutronix.de>
	 <CAOMZO5CKWj9tWCOZV65xwFCB7b120weq3Aq7_de-aMdEYAZWpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 12.10.2015, 11:04 -0300 schrieb Fabio Estevam:
> On Mon, Oct 12, 2015 at 10:34 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Am Montag, den 12.10.2015, 09:31 -0300 schrieb Fabio Estevam:
> >> On Mon, Oct 12, 2015 at 7:28 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> >>
> >> > Actually the TRM states that i.MX6 is using the same narrower mask of
> >> > 0x1f for the LTSSM state, so another reason to just use that.
> >>
> >> The manual I have seems to tell a different value :-)
> >>
> >> Please check: http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf
> >>
> >> "48.12.11
> >> Debug Register 0 (PCIE_PL_DEBUG0)"
> >>
> >> says "[5:0]: xmlh_ltssm_state LTSSM current state. See source for encodings"
> >>
> > Urgh. Seems we got confused by all the different defines.
> >
> > In fact [5:0] is 0x1f, so i.MX6 uses the same mask as Keystone, yet the
> 
> No, bits [5..0] means 0x3f. What am I missing here?

That you have to deal with people who are apparently unable to count to
5. *me puts on the brown paper bag*

Still I would love to have a definition in the common header that's
usable for all drivers. So unless there is a reason to use 0x3f (and we
don't have any LTSSM state defines which would use the extra bit) keep
it at 0x1f. Simpler, cleaner... IMHO.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

