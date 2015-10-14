Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34695 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbbJNIc1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2015 04:32:27 -0400
MIME-Version: 1.0
In-Reply-To: <6044983.WR9BTgsOaA@wuerfel>
References: <1444790492-4051-1-git-send-email-lftan@altera.com>
	<1444790492-4051-4-git-send-email-lftan@altera.com>
	<6044983.WR9BTgsOaA@wuerfel>
Date: Wed, 14 Oct 2015 16:32:25 +0800
Message-ID: <CAFiDJ58Uwpv=xUXbBNQcd4FQq=fHGhtCnjTb7TKQBJ0TOxRLig@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] pci:host: Add Altera PCIe host controller driver
From: Ley Foon Tan <lftan@altera.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 14, 2015 at 4:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 14 October 2015 10:41:29 Ley Foon Tan wrote:
>> +static int altera_pcie_remove(struct platform_device *pdev)
>> +{
>> +     struct altera_pcie *pcie = platform_get_drvdata(pdev);
>> +
>> +     altera_pcie_free_irq_domain(pcie);
>> +     platform_set_drvdata(pdev, NULL);
>> +     return 0;
>> +}
>
> I just noticed this. Does it actually work to unload the module
> and tear down all the pci_dev structures in a safe way?
Good catch. It only can be compiled as builtin-moduley now, so we can
remove this _remove callback function.
Thanks.

Regards
Ley Foon
