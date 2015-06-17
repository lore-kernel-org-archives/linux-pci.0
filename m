Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150616165033.9306.78046.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150616165033.9306.78046.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 17 Jun 2015 17:28:35 -0500
Message-ID: <CAErSpo6TOmGR4xdVq4Zx1X5Ej0gjh8NN3vz0ycYgsCKLNjEBfQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/PCI: enable pci=use_crs for more machines
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, dayer3@gmail.com,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 16, 2015 at 11:55 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> We have a few reports of sound devices not working because the BIOS didn't
> assign space for the device and the PCI core put it at an address that
> doesn't work.
>
> The Foxconn system has two PCI host bridges, and without the information
> from _CRS, the PCI core assigns space under the wrong bridge.
>
> We also have reports from pre-2008 systems (where we normally ignore _CRS)
> that support more than 32 physical address bits.  After d56dbf5bab8c ("PCI:
> Allocate 64-bit BARs above 4G when possible"), we prefer to use that high
> space when we can, but it seems the host bridge doesn't respond to it.
>
> _CRS tells us how to avoid both problems, so these patches enable it for
> these cases.
>
> ---
>
> Bjorn Helgaas (2):
>       x86/PCI: Use host bridge _CRS info on Foxconn K8M890-8237A
>       x86/PCI: Use host bridge _CRS info on systems with >32 bit addressing

I applied both patches to pci/resource for v4.2.
