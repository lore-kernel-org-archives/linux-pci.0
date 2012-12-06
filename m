Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45638 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab2LFASZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 19:18:25 -0500
Date: Thu, 6 Dec 2012 00:18:19 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-efi@vger.kernel.org,
	mfleming@intel.com, dwmw2@infradead.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Use PCI ROMs from EFI boot services
Message-ID: <20121206001819.GA30527@srcf.ucam.org>
References: <1345739803-21017-1-git-send-email-mjg@redhat.com>
 <CAErSpo6dn_0b8Ngx9VT=ARs_UXQftEx=2Kczeqemtmo0XyKzuQ@mail.gmail.com>
 <20121203200241.GG5906@thinkpad-t410>
 <CAE9FiQVdpmmExrPrLf7HYVuo0cTY9Xjn6bWzObbuSSeQ-e1PbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVdpmmExrPrLf7HYVuo0cTY9Xjn6bWzObbuSSeQ-e1PbA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 05, 2012 at 04:15:56PM -0800, Yinghai Lu wrote:

> at the same time we should export setup_data into /sys, so kexec could
> append this pointer to command of
> second kernel, just like kexec append acpi_rsdp.
> That should address DavidW's concern.

Why should the kernel export data to userspace just so that that data 
can be passed back into the kernel?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
