Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:58043 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070AbcDDKhM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Apr 2016 06:37:12 -0400
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel\@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	<CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
	<CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
	<CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
	<CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
	<CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
	<CAOMZO5A2osG3=mTaCayYfMokUj-vT+Udq9ckq45b1yaUP9Tn3g@mail.gmail.com>
	<CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
	<1459241739.2565.9.camel@pengutronix.de> <m3shz9in52.fsf@t19.piap.pl>
	<1459248921.2565.15.camel@pengutronix.de> <m3oa9widxk.fsf@t19.piap.pl>
	<CAJ+vNU0iKSXrKmA6jzdw5R5K3TnR3qftVn-8Ou5chHdz5aTpTA@mail.gmail.com>
Date: Mon, 04 Apr 2016 12:37:07 +0200
In-Reply-To: <CAJ+vNU0iKSXrKmA6jzdw5R5K3TnR3qftVn-8Ou5chHdz5aTpTA@mail.gmail.com>
	(Tim Harvey's message of "Thu, 31 Mar 2016 09:19:31 -0700")
Message-ID: <m337r1irsc.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tim,

> So perhaps there is something else going on with the tw8689
> device/driver that is causing it to not work with MSI. We have an
> avc8000 miniPCIe with tw8689 here and can test if you send me your
> patches that enable tw8689 with msi.

I think you can use this:
http://git.linuxtv.org/hverkuil/media_tree.git/log/?h=tw686x

> Regardless of MSI working in our tests we still disable it because of
> it breaking legacy irqs and for performance reasons.

So do I. However I'm also using Fedora 23 and this means I have to
recompile the kernel, since they build it with MSI enabled.
I think we should fix it, either by disabling in run time, or making it
work.

Performance-wise, I found it "surprising" that one can't have multiple
MSIs with separate hw vector for each.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
