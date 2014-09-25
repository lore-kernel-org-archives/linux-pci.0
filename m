Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: andreas.noever@gmail.com
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.or,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	matthew.garrett@nebula.com
Subject: Re: [PATCH v2 0/3] ACPI: Improve behaviour on Apple hardware
Date: Fri, 26 Sep 2014 01:45:23 +0200
Message-ID: <3743885.VmnRMnvucd@vostro.rjw.lan>
In-Reply-To: <cover.1411211725.git.andreas.noever@gmail.com>
References: <cover.1411211725.git.andreas.noever@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, September 20, 2014 01:19:44 PM andreas.noever@gmail.com wrote:
> From: Andreas Noever <andreas.noever@gmail.com>
> 
> This is a resend of Matthew's patches from https://lkml.org/lkml/2014/6/1/165
> which are needed to fully support Thunderbolt on Apple hardware:
> > Apple hardware behaves differently depending on whether or not the OS claims
> > to be Darwin. Failing to report Darwin results in some hardware being
> > disabled.  However, claiming to be Darwin also alters the behaviour of
> > battery reporting and PCI handling. These patches add support for reporting
> > Darwin support and fixing up the behavioural quirks that are exposed as a
> > result.
> Without these patches the firmware will cut power to the controller after
> suspend (at the latest) and the thunderbolt driver will fail.
> 
> I have reordered them such that the two battery fixes/quirks come before the
> _OSI change that breaks battery reporting. I have also merged "ACPI: Don't call
> PCI OSC on Apple hardware when claiming to be Darwin" into "ACPI: Support
> _OSI("Darwin") correctly" to avoid (temporarily) breaking hotplug events and
> modified the patch to not touch ACPICA, as requested by Rafael.
> 
> Matthew Garrett (3):
>   ACPI: Don't assume the existence of an SBS charger
>   ACPI: Disable smart battery manager on Apple
>   ACPI: Support _OSI("Darwin") correctly
> 
>  drivers/acpi/osl.c      | 10 +++++++
>  drivers/acpi/pci_root.c | 14 +++++++++
>  drivers/acpi/sbs.c      | 80 +++++++++++++++++++++++++++++++++++++++----------
>  3 files changed, 89 insertions(+), 15 deletions(-)

I've queued up this series for 3.18, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
