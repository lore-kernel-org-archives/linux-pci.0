Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 29 Aug 2016 11:02:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roland Singer <roland.singer@desertbit.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: Kernel Freeze with American Megatrends BIOS
Message-ID: <20160829160210.GA24451@localhost>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-acpi, linux-kernel, dri-devel]

Hi Roland,

I have no idea how to debug this problem.  Are you seeing something
that suggests it may be a PCI problem?

On Tue, Aug 23, 2016 at 11:23:45AM +0200, Roland Singer wrote:
> Hi,
> 
> hope somebody can help me fix this kernel problem which affects the following machines:
> 
> - Clevo P651RA (i7-6700HQ/GTX 965M, part of the P6xxRx family which are also affected)
> - MSI GE62 Apache Pro (i7-6700HQ/GTX 960M)
> - Gigabyte P35V5 (i7-6700HQ/GTX 970M)
> - Razer Blade 14" (2016) (i7-6700HQ/GTX 970M) (BIOS 5.11, 04/07/2016)
> 
> 
> The kernel freezes if the graphical user session (Xorg & Wayland) is
> started with a switched off discrete GPU card (NVIDIA).
> If the discrete GPU is switched off after the graphical session start,
> then everything works as expected, until the graphical session is restarted.
> 
> This problem seams to be linked to specific BIOS settings. If the computer
> is started with the following command line:
> 
> acpi_osi=! acpi_osi="Windows 2009"
> 
> then the kernel freeze does not occur anymore. However this required a special
> ACPI DSDT firmware patch for the Razer Blade 2016 laptop:
> 
> https://github.com/m4ng0squ4sh/razer_blade_14_2016_acpi_dsdt
> 
> I strongly recommend to fix this in the kernel and I am ready to help and solve
> this problem with some help.
> 
> Here is a link to the GitHub issue with further information:
> 
> https://github.com/Bumblebee-Project/Bumblebee/issues/764#issuecomment-241212595
> 
> Here are some more detailed information:
> 
> https://github.com/Lekensteyn/acpi-stuff/blob/master/Clevo-P651RA/notes.txt
> 
> Hope somebody can help.
