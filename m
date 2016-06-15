Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 15 Jun 2016 09:56:58 +0100
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
Subject: Re: [PATCH V6 5/7] irqchip/gicv3-its: Probe ITS in the ACPI way
Message-ID: <20160615095658.48b52888@arm.com>
In-Reply-To: <1465828873-23498-6-git-send-email-tn@semihalf.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
	<1465828873-23498-6-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 13 Jun 2016 16:41:11 +0200
Tomasz Nowicki <tn@semihalf.com> wrote:

> ITS is prepared for being initialized different than DT,
> therefore we can initialize it in ACPI way. We collect register base
> address from MADT table and pass mandatory info to firmware-agnostic
> ITS init call.
> 
> Use here IORT lib to register ITS domain which then can be found and
> used on to build another PCI MSI domain in hierarchical stack domain.
> 
> NOTE: Waiting for proper ITS and NUMA node relation description in IORT
> table, we pass around NUMA_NO_NODE to the its_probe_one init call.
> This means that Cavium ThunderX erratum 23144 (pass1.1 only)
> is not supported for ACPI boot method yet.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
