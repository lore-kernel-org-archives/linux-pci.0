Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34002 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab2B1VfY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2012 16:35:24 -0500
Received: by wgbdt10 with SMTP id dt10so2592811wgb.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2012 13:35:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120228213135.GA30986@burratino>
References: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com> <20120228213135.GA30986@burratino>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 Feb 2012 14:35:03 -0700
Message-ID: <CAErSpo62a5mc5gngDcUUY6UKO8UD7tBbRcyGrdLFqNbBYWUKww@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: do not tie MSI MS-7253 use_crs quirk to BIOS version
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>,
	Carlos Luna <caralu74@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 28, 2012 at 2:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Carlos was getting
>
>        WARNING: at drivers/pci/pci.c:118 pci_ioremap_bar+0x24/0x52()
>
> when probing his sound card, and sound did not work.  After adding
> pci=use_crs to the kernel command line, no more trouble.
>
> Ok, we can add a quirk.  dmidecode output reveals that this is an MSI
> MS-7253, for which we already have a quirk, but the short-sighted
> author tied the quirk to a single BIOS version, making it not kick in
> on Carlos's machine with BIOS V1.2.  If a later BIOS update makes it
> no longer necessary to look at the _CRS info it will still be
> harmless, so let's stop trying to guess which versions have and don't
> have accurate _CRS tables.
>
> Addresses https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5533
> Also see <https://bugzilla.kernel.org/show_bug.cgi?id=42619>.

Thanks, Jonathan.  I was going to do this, but you saved me the trouble :)

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> Reported-by: Carlos Luna <caralu74@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi,
>
> Could you squash this into the patch "x86/PCI: use host bridge _CRS
> info on MSI MS-7253", if it's not too late?  Sorry for the thinko.
>
> Thanks,
> Jonathan
>
>  arch/x86/pci/acpi.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 2c5cbdb5d602..d066e11159f3 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -68,7 +68,6 @@ static const struct dmi_system_id pci_use_crs_table[] __initconst = {
>                        DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
>                        DMI_MATCH(DMI_BOARD_NAME, "MS-7253"),
>                        DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies, LTD"),
> -                       DMI_MATCH(DMI_BIOS_VERSION, "V1.6"),
>                },
>        },
>
> --
> 1.7.9.2
>
