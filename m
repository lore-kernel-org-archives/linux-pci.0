Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50286 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab2LEUXG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 15:23:06 -0500
Date: Wed, 5 Dec 2012 20:22:54 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-efi@vger.kernel.org, mfleming@intel.com, dwmw2@infradead.org,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Use PCI ROMs from EFI boot services
Message-ID: <20121205202254.GA25398@srcf.ucam.org>
References: <1345739803-21017-1-git-send-email-mjg@redhat.com>
 <CAErSpo6dn_0b8Ngx9VT=ARs_UXQftEx=2Kczeqemtmo0XyKzuQ@mail.gmail.com>
 <20121203200241.GG5906@thinkpad-t410>
 <CAErSpo7S2+Vt+9bkGLx_=AY9aSGCvAnkHfqu01gTj=eKs7btNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo7S2+Vt+9bkGLx_=AY9aSGCvAnkHfqu01gTj=eKs7btNw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 05, 2012 at 01:09:25PM -0700, Bjorn Helgaas wrote:

> That's right; nobody stepped up to fix the section mismatch.  I'm
> happy to fold in your fix, especially if Matthew acks it.

Yes, sorry, I've been way behind on pretty much everything for the past 
few months. Please do add my Ack.

> David, Eric, what about the kexec question?  It looks to me like this
> wouldn't make things worse than they are today.  If I understand
> correctly, today we don't use ROM data from EFI on either an initial
> boot or a kexec.  After this patch, we could use EFI ROM data on the
> initial boot, but not after a kexec.  So it's worse in the sense that
> the kexec case doesn't match the initial boot, but at least it's not
> something that used to work and is now broken.

I think I'd agree here - it's not ideal, but it's no more broken than 
the current situation.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
