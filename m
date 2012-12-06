Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41599 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab2LFAgp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Dec 2012 19:36:45 -0500
Message-ID: <50BFE88D.1000800@zytor.com>
Date: Wed, 05 Dec 2012 16:36:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-efi@vger.kernel.org, mfleming@intel.com, dwmw2@infradead.org,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Use PCI ROMs from EFI boot services
References: <1345739803-21017-1-git-send-email-mjg@redhat.com> <CAErSpo6dn_0b8Ngx9VT=ARs_UXQftEx=2Kczeqemtmo0XyKzuQ@mail.gmail.com> <20121203200241.GG5906@thinkpad-t410> <CAE9FiQVdpmmExrPrLf7HYVuo0cTY9Xjn6bWzObbuSSeQ-e1PbA@mail.gmail.com>
In-Reply-To: <CAE9FiQVdpmmExrPrLf7HYVuo0cTY9Xjn6bWzObbuSSeQ-e1PbA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/05/2012 04:15 PM, Yinghai Lu wrote:
> 
> -#ifndef CONFIG_DEBUG_BOOT_PARAMS
> -struct boot_params __initdata boot_params;
> -#else
>  struct boot_params boot_params;
> -#endif

> 
> No, that is not a right fix
> 
> We should only cache pointer to setup_data.
> 
> at the same time we should export setup_data into /sys, so kexec could
> append this pointer to command of
> second kernel, just like kexec append acpi_rsdp.
> That should address DavidW's concern.
> 

I don't see why that isn't the right fix.  We copy the data into
boot_params early in the boot; that *is* the official copy as far as the
kernel is concerned.

So this patch very much seems like The Right Thing.

	-hpa


