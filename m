Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35883 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab2LFA6Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 19:58:24 -0500
In-Reply-To: <50BFE890.5070109@zytor.com>
References: <1345739803-21017-1-git-send-email-mjg@redhat.com> <CAErSpo6dn_0b8Ngx9VT=ARs_UXQftEx=2Kczeqemtmo0XyKzuQ@mail.gmail.com> <20121203200241.GG5906@thinkpad-t410> <CAE9FiQVdpmmExrPrLf7HYVuo0cTY9Xjn6bWzObbuSSeQ-e1PbA@mail.gmail.com> <20121206001819.GA30527@srcf.ucam.org> <50BFE50C.8030008@zytor.com> <CAE9FiQX+M+VynyERC0W3y8rvr1tBxWnuBqJ6E-ywC_=HvJE66g@mail.gmail.com> <50BFE890.5070109@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Use PCI ROMs from EFI boot services
From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Wed, 05 Dec 2012 19:57:55 -0500
To: "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-efi@vger.kernel.org,
	mfleming@intel.com, dwmw2@infradead.org,
	"Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <d8d553fb-1571-4fdc-833c-92b80e15bc25@email.android.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



"H. Peter Anvin" <hpa@zytor.com> wrote:

>I don't think there is anything security-sensitive about that
>information, at least not to root.  I could be wrong, of course; I
>wouldn't mind security people telling me about that.

I don't think there's anything at present, but we'll want to pass the hibernation encryption key from the bootloader to the kernel in the near future. setup_data seems like the easiest way to do that. 

-- 
Matthew Garrett | mjg59@srcf.ucam.org
