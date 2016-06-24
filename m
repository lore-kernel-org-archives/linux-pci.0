Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36459 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbcFXLEG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2016 07:04:06 -0400
Received: by mail-lf0-f43.google.com with SMTP id q132so113614736lfe.3
        for <linux-pci@vger.kernel.org>; Fri, 24 Jun 2016 04:04:05 -0700 (PDT)
Subject: Re: [PATCH V7 0/8] Introduce ACPI world to ITS irqchip
To: bhelgaas@google.com
References: <1466420541-20101-1-git-send-email-tn@semihalf.com>
Cc: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
	rjw@rjwysocki.net, lorenzo.pieralisi@arm.com,
	robert.richter@caviumnetworks.com, shijie.huang@arm.com,
	Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
	al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org,
	Catalin.Marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, andrea.gallo@linaro.org,
	linux-pci@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <576D13A1.7010205@semihalf.com>
Date: Fri, 24 Jun 2016 13:04:01 +0200
MIME-Version: 1.0
In-Reply-To: <1466420541-20101-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20.06.2016 13:02, Tomasz Nowicki wrote:
> The series builds the PCI/MSI domain stack based on initial IORT driver
> which is added in first place. As a reference please see IORT spec:
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>
> Tested on Cavium ThunderX server. The patches can be found here:
> https://github.com/semihalf-nowicki-tomasz/linux.git (its-acpi-v7)
>

Hi Bjorn,

I know it is vacation time :) but would you mind to have a look at 
respective patches ? Your ACK is major thing for PCI part.

Thanks,
Tomasz
