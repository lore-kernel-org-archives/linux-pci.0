Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37073 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbJLOEp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 10:04:45 -0400
Received: by igcpe7 with SMTP id pe7so81171170igc.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2015 07:04:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1444656873.3364.14.camel@pengutronix.de>
References: <1444355306-21486-1-git-send-email-festevam@gmail.com>
	<1444645188.3364.5.camel@pengutronix.de>
	<1444645685.3364.8.camel@pengutronix.de>
	<CAOMZO5CyGybRSJfCNwJAXrPuKpJqsA_w0Qfb+vhUXCyCe-PKiQ@mail.gmail.com>
	<1444656873.3364.14.camel@pengutronix.de>
Date: Mon, 12 Oct 2015 11:04:44 -0300
Message-ID: <CAOMZO5CKWj9tWCOZV65xwFCB7b120weq3Aq7_de-aMdEYAZWpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: designware: Move LTSSM state definitions to pcie-designware.h
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 12, 2015 at 10:34 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Montag, den 12.10.2015, 09:31 -0300 schrieb Fabio Estevam:
>> On Mon, Oct 12, 2015 at 7:28 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
>>
>> > Actually the TRM states that i.MX6 is using the same narrower mask of
>> > 0x1f for the LTSSM state, so another reason to just use that.
>>
>> The manual I have seems to tell a different value :-)
>>
>> Please check: http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf
>>
>> "48.12.11
>> Debug Register 0 (PCIE_PL_DEBUG0)"
>>
>> says "[5:0]: xmlh_ltssm_state LTSSM current state. See source for encodings"
>>
> Urgh. Seems we got confused by all the different defines.
>
> In fact [5:0] is 0x1f, so i.MX6 uses the same mask as Keystone, yet the

No, bits [5..0] means 0x3f. What am I missing here?
