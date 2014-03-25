Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:61389 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbaCYT5a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Mar 2014 15:57:30 -0400
Received: by mail-ig0-f177.google.com with SMTP id ur14so2579358igb.4
        for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2014 12:57:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140325140510.GF17163@e106497-lin.cambridge.arm.com>
References: <1395270762-6055-1-git-send-email-tinamdar@apm.com>
 <1395270762-6055-2-git-send-email-tinamdar@apm.com> <CA+sq2CchcWBieGEH33AJFj6HYy-yiJFgzX94Gtsoho2k3z65eA@mail.gmail.com>
 <CACoXjcn2LuhJsNLpCgfvqT6AQEb1pw70N9GNfgCgZ88myGMNBg@mail.gmail.com> <20140325140510.GF17163@e106497-lin.cambridge.arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Mar 2014 13:56:45 -0600
Message-ID: <CAErSpo5uyJxvYk42pf0mxRNO6ZSFmQW4AHfe1qGBMDoUiD0BHw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] pci: APM X-Gene PCIe controller driver
To: Tanmay Inamdar <tinamdar@apm.com>,
	Sunil Kovvuri <sunil.kovvuri@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Rob Landley <rob@landley.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	patches <patches@apm.com>, "jcm@redhat.com" <jcm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 25, 2014 at 8:05 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:

> ... I'm a bit baffled by pci_claim_resource()
> as it doesn't seem to be used by some architectures. Does it mean it
> is not needed unless you have some BIOS setting up resources for you
> and in that case you need to go and claim the resource?

Many architectures don't use pci_claim_resource() yet.  I'm trying to
unify this so all architectures do use it, but it's taking me a long
time to get this done.

Bjorn
