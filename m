Return-Path: <SRS0=5whQ=CP=ucw.cz=mj+f-171117+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=5whQ=CP=ucw.cz=mj+f-171117+helgaas=kernel.org@kernel.org>
Date: Fri, 17 Nov 2017 13:55:09 +0100
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: lspci reports 'stale' BAR info after a card reset
Message-ID: <mj+md-20171117.125313.18569.nikam@ucw.cz>
References: <063D6719AE5E284EB5DD2968C1650D6DD009AD46@AcuExch.aculab.com>
 <20171018170429.GA6332@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018170429.GA6332@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hello!

> I agree, it does seem odd that the hexdump reflects the hardware but
> the text does not.  I don't know whether that's intentional; maybe
> Martin does.

By default, lspci reports the BAR addresses and IRQs used by the
kernel. You can use "lspci -b" to get a "bus-centric" view, which
reads the config space.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: Who invented the first airplane that did not fly?  A: The Wrong Brothers.
