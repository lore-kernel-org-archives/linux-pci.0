Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:38684 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbCHGvz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Mar 2015 01:51:55 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1503071748530.5739@chino.kir.corp.google.com>
References: <1425776181-10219-1-git-send-email-yinghai@kernel.org>
	<1425776181-10219-2-git-send-email-yinghai@kernel.org>
	<alpine.DEB.2.10.1503071748530.5739@chino.kir.corp.google.com>
Date: Sat, 7 Mar 2015 22:51:53 -0800
Message-ID: <CAE9FiQWd71SxCf9=Nh_dBSKK2ecHC=s3-2R7dZJM9PGuR7ybzw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] x86: Kill E820_RESERVED_KERN
From: Yinghai Lu <yinghai@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Matt Fleming <matt.fleming@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Kosina <jkosina@suse.cz>, Chun-Yi Lee <jlee@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 7, 2015 at 5:59 PM, David Rientjes <rientjes@google.com> wrote:
>
> Hmm, although the bug is reported for a 3.12 kernel, I assume this is for
> stable 3.10+?  If so, it should apply fine with the exception of removing
> e820_reserve_setup_data() from setup_arch() rather than
> memblock_x86_reserve_range_setup_data().  Or is it for 3.2 as well and
> needs to be completely rebased for that kernel?

For 3.10+, we will need to following patches, otherwise will have warning for
SETUP_PCI with ioremap.

for 3.2 that does not SETUP_PCI, should be ok, but will need rebase.

Thanks

Yinghai
