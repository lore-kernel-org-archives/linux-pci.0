Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:53714 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753429AbbALSxq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jan 2015 13:53:46 -0500
Received: by mail-ob0-f178.google.com with SMTP id gq1so23754789obb.9
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2015 10:53:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <22570652.F088Afk9OX@wuerfel>
References: <cover.1420499393.git.dhdang@apm.com> <94f9823d9a8c9c7ef819173f0a5ab06fb8fff408.1420499393.git.dhdang@apm.com>
 <22570652.F088Afk9OX@wuerfel>
From: Duc Dang <dhdang@apm.com>
Date: Mon, 12 Jan 2015 10:53:14 -0800
Message-ID: <CADaLND=C3AjdZpiMpom7+-Dgwc83NYo5pDjDWo+hrW7VDZ4m3A@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, Feng Kan <fkan@apm.com>,
	linux-pci@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 6, 2015 at 11:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 06 January 2015 08:15:41 Duc Dang wrote:
>> X-Gene v1 SOC supports total 2688 MSI/MSIX vectors coalesced into
>> 16 HW IRQ lines.
>>
>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>>
>
> I might be a little behind the latest development, but why is this
> not a struct msi_controller?

X-Gene V1 have a separate MSI block to handle MSI/MSIX and is shared
among 5 PCIe ports.
So in this driver for this MSI block, we implement X-Gene v1 sepcific
arch_teardown_msi_irqs,
arch_setup_msi_irqs and not using msi_controller struct.

Please let me know if this approach needs to be changed to follow
other implementations of MSI
drivers in latest kernel.
>
>         Arnd

Regards,
Duc Dang.
