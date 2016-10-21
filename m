Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V4 2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize
 function"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-3-git-send-email-okaya@codeaurora.org>
 <20161021015814.GC31044@localhost> <20161021144535.GB877@localhost>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
 Len Brown <len.brown@intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, agross@codeaurora.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Pavel Machek <pavel@ucw.cz>, linux-arm-msm@vger.kernel.org,
 wim@djo.tudelft.nl, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2a824792-486a-6251-4931-c5cc6fd67978@codeaurora.org>
Date: Fri, 21 Oct 2016 09:13:06 -0700
MIME-Version: 1.0
In-Reply-To: <20161021144535.GB877@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/21/2016 7:45 AM, Bjorn Helgaas wrote:
> [1] http://marc.info/?l=linux-acpi&m=145580159209240&w=2)
> 
>> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Wait a minute, I still have a question here: what about other ACPI
> arches (ia64, arm64)?  Don't they need to call acpi_penalize_sci_irq()
> somewhere?
> 

ACPI ARM64 architecture implements reduced ACPI profile which doesn't
have GED object. Instead, ARM64 architecture uses onchip peripherals
for similar functionality. If there is a need to signal interrupts,
this is done by ACPI Notify in ASL or if absolutely needed using
ACPI Generic Event Device (GED).

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
