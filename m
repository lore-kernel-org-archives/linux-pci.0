Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1381353063.2050.24.camel@joe-AO722>
Subject: Re: [PATCH] MAINTAINERS: Add arch/x86/pci to PCI file patterns
From: Joe Perches <joe@perches.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Oct 2013 14:11:03 -0700
In-Reply-To: <20131009210219.31110.62076.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131009210219.31110.62076.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey Bjorn

On Wed, 2013-10-09 at 15:02 -0600, Bjorn Helgaas wrote:
> I handle many arch/x86/pci changes, so help those patches get to the
> PCI patchwork.

[]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e61c2e8..d1ab647 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6338,6 +6338,7 @@ S:	Supported
>  F:	Documentation/PCI/
>  F:	drivers/pci/
>  F:	include/linux/pci*
> +F:	arch/x86/pci/*

This could be

F:	arch/x86/pci/

so that if anyone ever sticks a subdirectory
in there, you'd still get notified.


