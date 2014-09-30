Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57006 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbaI3PP4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Sep 2014 11:15:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Rob Herring <robh@kernel.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of/pci: add pci_pio_to_address dummy for !CONFIG_OF
Date: Tue, 30 Sep 2014 17:15:19 +0200
Message-ID: <2033939.5UfzeSiRKs@wuerfel>
In-Reply-To: <20140930144506.GQ841@e106497-lin.cambridge.arm.com>
References: <706416181.hbVGLDA3o6@wuerfel> <20140930144506.GQ841@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 30 September 2014 15:45:06 Liviu Dudau wrote:
> 
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> Is that triggered by shmobile_defconfig?
> 
> 

No, I only found it using randconfig testing, shmobile enables CONFIG_OF by
default.

	Arnd
