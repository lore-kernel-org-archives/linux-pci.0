Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 15 Jun 2016 10:00:34 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net,
	bhelgaas@google.com, lorenzo.pieralisi@arm.com,
	robert.richter@caviumnetworks.com, shijie.huang@arm.com,
	Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
	al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org,
	Catalin.Marinas@arm.com, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, andrea.gallo@linaro.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 6/7] irqchip/gicv3-its: Factor out code that might be
 reused for ACPI
Message-ID: <20160615100034.3393b90c@arm.com>
In-Reply-To: <1465828873-23498-7-git-send-email-tn@semihalf.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
	<1465828873-23498-7-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 13 Jun 2016 16:41:12 +0200
Tomasz Nowicki <tn@semihalf.com> wrote:

> Firmware agnostic code lands in common functions which do necessary
> domain initialization based on unique domain handler. DT specific
> code goes to DT specific init call.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
