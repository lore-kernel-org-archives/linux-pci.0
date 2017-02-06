Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:47769 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdBFVdh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 16:33:37 -0500
Date: Mon, 6 Feb 2017 22:35:28 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170206213528.GD679@wunner.de>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
 <20170203055200.GA29413@wunner.de>
 <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
 <20170204081254.GA29595@wunner.de>
 <20170204185607.GA29957@wunner.de>
 <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
 <20170204233443.GA234@wunner.de>
 <CAE9FiQW5SQsQfRCz9sor4kufogTRVpHXekPHSi8MSi46mvXGLQ@mail.gmail.com>
 <20170205073454.GA253@wunner.de>
 <20170206103706.GE19313@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206103706.GE19313@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 12:37:06PM +0200, Mika Westerberg wrote:
> On Sun, Feb 05, 2017 at 08:34:54AM +0100, Lukas Wunner wrote:
> > @Mika, Rafael: Are you aware of Skylake machines with unreliable link
> > training, or perhaps errata of Skylake chips related to link training
> > on hotplug ports?
> 
> According to the 100-series (the chipset used with Skylake) errata
> below, I don't see any mentions related to PCIe link training issues.
> 
> http://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/100-series-chipset-spec-update.pdf

Yinghai Lu responded off-list that the hardware in question is an
unreleased / secret Intel product, so this particular issue cannot
be expected to be documented publicly at this point.

Of course this raises the question whether issues with unreleased
products can at all be considered valid regressions, given that the
final product may not regress.  It seems like a novelty to me that
patches would get reverted for something like this, but we'll see.

Lukas
