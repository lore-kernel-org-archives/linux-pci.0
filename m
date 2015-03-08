Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:44277 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbCHB7R (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Mar 2015 20:59:17 -0500
Received: by igdh15 with SMTP id h15so12952499igd.3
        for <linux-pci@vger.kernel.org>; Sat, 07 Mar 2015 17:59:16 -0800 (PST)
Date: Sat, 7 Mar 2015 17:59:14 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Yinghai Lu <yinghai@kernel.org>
cc: Matt Fleming <matt.fleming@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Kosina <jkosina@suse.cz>, Chun-Yi Lee <jlee@suse.com>,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/8] x86: Kill E820_RESERVED_KERN
In-Reply-To: <1425776181-10219-2-git-send-email-yinghai@kernel.org>
Message-ID: <alpine.DEB.2.10.1503071748530.5739@chino.kir.corp.google.com>
References: <1425776181-10219-1-git-send-email-yinghai@kernel.org> <1425776181-10219-2-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 7 Mar 2015, Yinghai Lu wrote:

> Now we are using memblock to do early resource reserver/allocation
> instead of using e820 map directly, and setup_data is reserved in
> memblock early already.
> Also kexec generate setup_data and pass pointer to second kernel,
> so second kernel reserve setup_data by their own.
> (Now kexec-tools create SETUP_EFI and SETUP_E820_EXT).
> 
> We can kill E820_RESERVED_KERN and not touch e820 map at all.
> 
> That will fix bug in mark_nonsave_region that can not handle that
> case: E820_RAM and E820_RESERVED_KERN ranges are continuous and
> boundary is not page aligned.
> 
> Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=913885

Is this the bug referenced in the commit message that is fixed?  If so, 
it's only a bug for resume, correct?  I'm not sure if that's clear enough 
just from the commit message, I was looking at this patch for an e820 
problem I'm currently facing on 3.3.

> Reported-by: "Lee, Chun-Yi" <jlee@suse.com>
> Tested-by: "Lee, Chun-Yi" <jlee@suse.com>
> Cc: "Lee, Chun-Yi" <jlee@suse.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: stable@vger.kernel.org

Hmm, although the bug is reported for a 3.12 kernel, I assume this is for 
stable 3.10+?  If so, it should apply fine with the exception of removing 
e820_reserve_setup_data() from setup_arch() rather than 
memblock_x86_reserve_range_setup_data().  Or is it for 3.2 as well and 
needs to be completely rebased for that kernel?
