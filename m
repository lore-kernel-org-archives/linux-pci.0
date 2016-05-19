Return-Path: <mj+f-190516+helgaas=kernel.org@ucw.cz>
Return-Path: <mj+f-190516+helgaas=kernel.org@ucw.cz>
Date: Thu, 19 May 2016 17:42:06 +0200
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Martin Mansfield <mrmansfield@ntlworld.com>,
	Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Subject: Re: Reason for hang after running lspci -vv as root
Message-ID: <mj+md-20160519.154142.3546.albireo@ucw.cz>
References: <05A7667AE5A84EFC87D025E140351A4C@pc1>
 <mj+md-20160514.100302.61929.camelot@ucw.cz>
 <20160517142711.GA19170@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160517142711.GA19170@localhost>
List-ID: <linux-pci.vger.kernel.org>

Hello!

> I don't know whether lspci reads VPD using sysfs or a different way.
> If it reads it differently, it's possible it could still cause a hang,
> even with the kernel blacklist.

Yes, it uses sysfs for that.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Always remember that you are absolutely unique ... just like everyone else.
