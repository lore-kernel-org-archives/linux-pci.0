Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:39310 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbaHGDMY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 23:12:24 -0400
Received: by mail-la0-f47.google.com with SMTP id mc6so3068208lab.34
        for <linux-pci@vger.kernel.org>; Wed, 06 Aug 2014 20:12:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <001901cfb1eb$f22cd8d0$d6868a70$%han@samsung.com>
References: <CAOMZO5CmDa4=AcHZpWcaLanDZQ3fXNfQbcN_0Oc04MWPw9bY1Q@mail.gmail.com>
	<20140806043204.GA2755@pratyush-vbox>
	<1407314357.5208.2.camel@weser.hi.pengutronix.de>
	<001901cfb1eb$f22cd8d0$d6868a70$%han@samsung.com>
Date: Thu, 7 Aug 2014 00:12:22 -0300
Message-ID: <CAOMZO5BNSEyM+Y4PrTdm6Q=a8vQ+GL02aJmJ+dCOQ+yky0fN8A@mail.gmail.com>
Subject: Re: designware: missing *config* reg space
From: Fabio Estevam <festevam@gmail.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Pratyush Anand <pratyush.anand@st.com>, kishon@ti.com,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jingoo,

On Thu, Aug 7, 2014 at 12:01 AM, Jingoo Han <jg1.han@samsung.com> wrote:

> I agree with Lucas Stach's opinion.
> Printing errors is necessary to let people change to fix the DT.
> According to the DT spec, using *ranges* is wrong. So, dev_err()
> can be used.

Could you please point me to a dts that uses 'config' in the PCI node,
so I could use it as reference?

Thanks
