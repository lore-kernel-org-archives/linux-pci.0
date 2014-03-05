Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1394053603-3724-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1394053603-3724-1-git-send-email-suravee.suthikulpanit@amd.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 5 Mar 2014 14:24:12 -0700
Message-ID: <CAErSpo4MMJh9b0aivwGSbxCMVw24He1+Vo_LH0R0E+fYM5aThg@mail.gmail.com>
Subject: Re: [PATCH 0/3] amd/pci: Add AMD hostbridge supports for newer AMD systems
To: suravee.suthikulpanit@amd.com
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	kim.naru@amd.com,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-acpi]

On Wed, Mar 5, 2014 at 2:06 PM,  <suravee.suthikulpanit@amd.com> wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>
> The current code only supports upto AMD hostbridge for family11h.
> This causes PCI numa_node information to be reported incorrectly
> for newer family with multi sockets.

Where is the incorrect reporting?  In ACPI tables?  Is this patch a
way to cover up firmware defects in the ACPI description?  Or is this
for machines without ACPI (it seems unlikely that machines with new
AMD processors would not have ACPI)?

The whole point of ACPI is that we shouldn't need to update the kernel
for new hardware, so if there's a firmware bug, it should be fixed, or
if the ACPI spec isn't powerful enough, it should be extended.

> This patch set introduces the logic to discover AMD hostbridges.
>
> Note:
>     * Patch 1 and 2 are functional changes.
>     * Patch 3 is code clean up/restructuring
>
> Suravee Suthikulpanit (3):
>   amd/pci: Add supports for generic AMD hostbridges
>   amd/pci: Support additional MMIO ranges capabilities
>   amd/pci: Miscellaneous code clean up for early_fillup_mp_bus_info
>
>  arch/x86/pci/amd_bus.c |  376 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 251 insertions(+), 125 deletions(-)
>
> --
> 1.7.10.4
>
>
