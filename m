Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34318 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbcA2GcN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2016 01:32:13 -0500
Received: by mail-vk0-f48.google.com with SMTP id e185so36870683vkb.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Jan 2016 22:32:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <HK2PR0601MB1393A8E38392D17EC2DD7900F5C40@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <20160120160427.GD13437@red-moon>
	<569FB210.9090605@codeaurora.org>
	<20160120181003.GF13437@red-moon>
	<HK2PR0601MB1393A8E38392D17EC2DD7900F5C40@HK2PR0601MB1393.apcprd06.prod.outlook.com>
Date: Fri, 29 Jan 2016 12:02:12 +0530
Message-ID: <CAHM4w1kJKcH4uA113-6QC_tseM+Cv1Jubare8ex6YxAfSpdbNw@mail.gmail.com>
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sinan Kaya <okaya@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 22, 2016 at 9:58 PM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> > Resources claiming and assignment should be managed in arch code,
> > not in host controllers specific code, and that's the reason I
> > complained in this RFC about the scattering of PCI_PROBE_ONLY flag
> > checks in host drivers, it is becoming unmanageable (if useful
> > at all on designware and rcar, I would like to know if there are
> > PCI_PROBE_ONLY set-ups probing those host drivers).
>
> I am pretty sure  there are no rcar set-ups that use PCI_PROBE_ONLY,
> so I am happy for that code to go.
>

I do not remember either any designware platform which has required
and tested PCI_PROBE_ONLY.

~Pratyush
