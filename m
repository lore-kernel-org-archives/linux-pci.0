Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:39304 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab2LFAXZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 19:23:25 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-efi@vger.kernel.org, mfleming@intel.com, dwmw2@infradead.org,
	"H. Peter Anvin" <hpa@zytor.com>
References: <1345739803-21017-1-git-send-email-mjg@redhat.com>
	<CAErSpo6dn_0b8Ngx9VT=ARs_UXQftEx=2Kczeqemtmo0XyKzuQ@mail.gmail.com>
	<20121203200241.GG5906@thinkpad-t410>
	<CAE9FiQVdpmmExrPrLf7HYVuo0cTY9Xjn6bWzObbuSSeQ-e1PbA@mail.gmail.com>
	<20121206001819.GA30527@srcf.ucam.org>
Date: Wed, 05 Dec 2012 16:23:07 -0800
In-Reply-To: <20121206001819.GA30527@srcf.ucam.org> (Matthew Garrett's message
	of "Thu, 6 Dec 2012 00:18:19 +0000")
Message-ID: <87vccgm3kk.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: Use PCI ROMs from EFI boot services
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Matthew Garrett <mjg59@srcf.ucam.org> writes:

> On Wed, Dec 05, 2012 at 04:15:56PM -0800, Yinghai Lu wrote:
>
>> at the same time we should export setup_data into /sys, so kexec could
>> append this pointer to command of
>> second kernel, just like kexec append acpi_rsdp.
>> That should address DavidW's concern.
>
> Why should the kernel export data to userspace just so that that data 
> can be passed back into the kernel?

Because it is useful for more than just kexec and because that is the
current architecture.

Eric

