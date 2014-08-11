Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 11 Aug 2014 10:54:09 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: 'Marc Zyngier' <marc.zyngier@arm.com>,
	'Mark Rutland' <Mark.Rutland@arm.com>,
	'Pawel Moll' <Pawel.Moll@arm.com>,
	'Catalin Marinas' <Catalin.Marinas@arm.com>,
	'Will Deacon' <Will.Deacon@arm.com>,
	"'tglx@linutronix.de'" <tglx@linutronix.de>,
	"Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>,
	"'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
	"'devicetree@vger.kernel.org'" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/4] irqchip: gic-v2m: Rework GICv2m Initialization
Message-ID: <20140811145409.GD5063@titan.lakedaemon.net>
References: <1407539836-9768-1-git-send-email-suravee.suthikulpanit@amd.com>
 <53E87ADA.6040204@arm.com>
 <02D2024799561B48A732D1A51CB969E836F74ABC@satlexdag05.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <02D2024799561B48A732D1A51CB969E836F74ABC@satlexdag05.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Suravee,

On Mon, Aug 11, 2014 at 01:30:50PM +0000, Suthikulpanit, Suravee wrote:
> Jason already created a branch irqchip/gic-v2m, which I have created
> my patch against.  So, what branch do you want me to re-create a patch
> against for you to review?

Ideally, against v3.17-rc1.  That's a few weeks away, though.  In the
mean time, please base against irqchip/core.  It has the relevant
patches that are going to be in v3.17-rc1.

thx,

Jason.
