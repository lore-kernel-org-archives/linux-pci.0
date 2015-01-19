Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50318 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbASQ7a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jan 2015 11:59:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Rob Herring <robherring2@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH 0/3] drivers: port PCIe designware to new DT parsing API
Date: Mon, 19 Jan 2015 17:59 +0100
Message-ID: <1539153.bO1tVUM2dB@wuerfel>
In-Reply-To: <CAL_JsqLYg9vhFVmf=O4YLPfboj-dyoCR0H5dzBbMC3PeAEOwhQ@mail.gmail.com>
References: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com> <CAL_JsqLYg9vhFVmf=O4YLPfboj-dyoCR0H5dzBbMC3PeAEOwhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 19 January 2015 10:40:39 Rob Herring wrote:
> 
> I don't really like exposing ranges to host drivers. We've worked to
> not do that. So perhaps we need to rethink the API. I think we need to
> provide each range as a pair of resources which are the CPU address
> and PCI address. Perhaps an iterator is kind of pointless here. We do
> different things for each one. Are there cases with more than a single
> i/o space, non-prefetch memory and prefetch memory range? Perhaps we
> should just get the i/o and memory resources as separate calls. Just
> tossing out some ideas here.

Nice idea, that could be similar to platform_get_resource().

We probably also need the distinction between CPU address and (parent)
bus address here. In most drivers they are the same, but we actually
need to program the latter one into the PCI host bridge registers.

	Arnd
