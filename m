Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:32973 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbcAMQed (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2016 11:34:33 -0500
Received: by mail-io0-f176.google.com with SMTP id q21so423767304iod.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2016 08:34:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAENNV6JHnwNWDi3ACRE+p3fvMzii+di-CRkH-wO4qwEa9nNN7g@mail.gmail.com>
References: <CAENNV6JHnwNWDi3ACRE+p3fvMzii+di-CRkH-wO4qwEa9nNN7g@mail.gmail.com>
Date: Wed, 13 Jan 2016 14:34:33 -0200
Message-ID: <CAOMZO5AwpQdmcD2onLis-ZpktRjyAvfDKCxJa7QQGbY0QRo4LQ@mail.gmail.com>
Subject: Re: i.MX6 PCI GPR8 Settings
From: Fabio Estevam <festevam@gmail.com>
To: Justin Waters <justin.waters@timesys.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sean Cross <xobs@kosagi.com>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 13, 2016 at 2:14 PM, Justin Waters
<justin.waters@timesys.com> wrote:
> Hello,
>
> I've been working with a custom board based on an i.MX6, and noticed
> that the GPR8 settings for the PCIe pins are hard coded to specific
> values. We would like to customize these values for our specific
> hardware.
>
> While it's certainly possible to simply change the hard coding, it
> strikes me that these should most likely be configurable via the
> device tree. My initial thinking would be to create a number of
> properties that would be defined in a dts file, e.g.
> fsl,pci-deemph-gen1 = < 0>, but perhaps there's a better way to handle
> this. I'm happy to put something together, but I'd like to know that
> I'm on the right track. I'd appreciate any feedback.

Looks like a good idea.

Adding Lucas for his comments.
