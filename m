Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:7010 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753211AbdF2UOA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2017 16:14:00 -0400
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
To: "'Logan Gunthorpe'" <logang@deltatee.com>,
        <linux-ntb@googlegroups.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: "'Jon Mason'" <jdmason@kudzu.us>,
        "'Dave Jiang'" <dave.jiang@intel.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Kurt Schwemmer'" <kurt.schwemmer@microsemi.com>,
        "'Stephen Bates'" <sbates@raithlin.com>,
        "'Serge Semin'" <fancer.lancer@gmail.com>
References: <20170629032648.3073-1-logang@deltatee.com> <20170629032648.3073-7-logang@deltatee.com> <000301d2f103$3310ca60$99325f20$@dell.com> <079047c1-6612-2814-e147-844fabd56b75@deltatee.com>
In-Reply-To: <079047c1-6612-2814-e147-844fabd56b75@deltatee.com>
Subject: RE: [PATCH 06/16] ntb: add check and comment for link up to mw_count and mw_get_align
Date: Thu, 29 Jun 2017 16:13:40 -0400
Message-ID: <000401d2f114$3499f2b0$9dcdd810$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Logan Gunthorpe
> On 6/29/2017 12:11 PM, Allen Hubbe wrote:
> > Nak.  This breaks a work around for stability issues on some =
hardware.  I am ok with changing the
> comment to say, this is only supported when called after link up.  I =
would still like to allow these
> to be called at any time.  Specific hardware drivers like Switchtec =
may return an error.  Upstream
> drivers, of course, should call these after link up: patch 5/16 part =
of this set looks good.
>=20
> If absolutely necessary I can leave this out. But in terms of =
interface
> design it's _so_ much better to have it in. This change would bring =
the
> score from a 3 to a 5 on Rusty Russel's Hard to Misuse ranking[1]. To
> quote Rusty:
>=20
> "3. Read the documentation and you'll get it right.
> People only read instructions after they've already tied themselves =
into
> a knot. Then they skim them for keywords and don't read your warnings. =
I
> don't give an example of this; if this is the best an interface can =
get
> do, it's in trouble."
>=20
> Can someone not just fix the out-of-tree code? And since when is
> out-of-tree code reasonable justification for what's done in upstream?

Unfortunately, it is to work around hardware errata.  That is not so =
trivial to fix.

The workaround in software is also not acceptable upstream, for doing =
things like writing directly to the peer's interrupt controller =
registers, bypassing the ntb doorbells.

>=20
> Logan
>=20
> [1]http://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html
