Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55725 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbaAKNHA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jan 2014 08:07:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [RFC PATCH 3/3] dt-bindings: pci: xgene pcie device tree bindings
Date: Sat, 11 Jan 2014 14:06:52 +0100
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Landley <rob@landley.net>, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	patches <patches@apm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jon Masters <jcm@redhat.com>
References: <1387785725-24262-1-git-send-email-tinamdar@apm.com> <201401071635.02006.arnd@arndb.de> <CACoXjckkovQdB5Pk3Tn4uGkm5+HuEfWYb6E1MiUOPpuZ2b7qNA@mail.gmail.com>
In-Reply-To: <CACoXjckkovQdB5Pk3Tn4uGkm5+HuEfWYb6E1MiUOPpuZ2b7qNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201401111406.52935.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday 11 January 2014, Tanmay Inamdar wrote:
> On Tue, Jan 7, 2014 at 7:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 07 January 2014, Tanmay Inamdar wrote:
> >> On Fri, Jan 3, 2014 at 1:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> >> >
> >> > Better use an anonymous clock?
> >>
> >> Sorry. Can you please elaborate?
> >
> > I mean drop the "clock-names" property.
> >
> Did you mean clock-names in pcie-clock node or pcie node? I can drop
> clock-names from pcie clock node. However if I drop clock-names from
> pcie node, then clk_get call from pcie host driver would result in
> failure. Right?

I meant drop it from the pcie node, and change the clk_get call
to pass NULL instead of the name, which will get the handle for
the only clock provided. You only need clock-names if you have
more than one clock in the device node and want to identify them.

The pcie-clock node should not have a "clock-names" property at
all, unless it has a "clocks" property as well and refers to
its clock parent with it.

I already noticed in another review that the xgene clocks get this
part wrong and that should be fixed for all those clock provides,
but it's unrelated to what I was talking about here.

	Arnd
