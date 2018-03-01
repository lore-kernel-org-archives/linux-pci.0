Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45847 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966207AbeCAGSA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Mar 2018 01:18:00 -0500
Subject: Re: [PATCH v3 1/6] jailhouse: Provide detection for non-x86 systems
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: jailhouse-dev@googlegroups.com,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
References: <cover.1519882849.git.jan.kiszka@siemens.com>
 <558f5cbae432ae029e2d8ee9b0ef44d837318625.1519882849.git.jan.kiszka@siemens.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <18fdcca5-1afb-23ea-07f6-b24eabdc04a0@suse.com>
Date: Thu, 1 Mar 2018 07:17:57 +0100
MIME-Version: 1.0
In-Reply-To: <558f5cbae432ae029e2d8ee9b0ef44d837318625.1519882849.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/03/18 06:40, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Implement jailhouse_paravirt() via device tree probing on architectures
> != x86. Will be used by the PCI core.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Documentation/devicetree/bindings/jailhouse.txt |  8 ++++++++
>  arch/x86/include/asm/jailhouse_para.h           |  2 +-
>  include/linux/hypervisor.h                      | 17 +++++++++++++++--

I'd appreciate if you'd Cc: the maintainers of the touched files...

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
