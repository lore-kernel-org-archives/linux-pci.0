Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61210 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbaEaSlU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 31 May 2014 14:41:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Kumar Gala <galak@codeaurora.org>,
	Rob Herring <robherring2@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] pci: Add IORESOURCE_BIT entry for PCIe ECAM resources.
Date: Sat, 31 May 2014 20:41:04 +0200
Message-ID: <4756033.LkcFQN0chs@wuerfel>
In-Reply-To: <1401496601-31983-2-git-send-email-Liviu.Dudau@arm.com>
References: <20140530233034.GH1677@bart.dudau.co.uk> <1401496601-31983-1-git-send-email-Liviu.Dudau@arm.com> <1401496601-31983-2-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday 31 May 2014 01:36:40 Liviu Dudau wrote:
> We would like to be able to describe PCIe ECAM resources as
> IORESOURCE_MEM blocks while distinguish them from standard
> memory resources. Add an IORESOURCE_BIT entry for this case.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

I still don't see any value in this at all. What is the advantage
of doing this opposed to just having a standardized 'reg' property
for a particular compatible string?

	Arnd
