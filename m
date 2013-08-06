Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54290 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756263Ab3HFURp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Aug 2013 16:17:45 -0400
Date: Tue, 6 Aug 2013 22:17:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	dougthompson@xmission.com, bhelgaas@google.com, jbeulich@suse.com,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3 V2] EDAC, AMD64_EDAC: Add PCI Device ID Functions 3
 and 4 for newer F15h models.
Message-ID: <20130806201742.GF14891@pd.tnic>
References: <1375483384-2302-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
 <1375483384-2302-2-git-send-email-Aravind.Gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1375483384-2302-2-git-send-email-Aravind.Gopalakrishnan@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 02, 2013 at 05:43:02PM -0500, Aravind Gopalakrishnan wrote:
> Adding PCI_DEVICE_ID_AMD_15H_NB_M30H_F3 and PCI_DEVICE_ID_AMD_15H_NB_M30H_F4
> for F15h model 30h. This is required for the file amd_nb.c

... and amd64_edac.c

Also, remember to read the comment at the beginning of
include/linux/pci_ids.h!

I fixed up the commit message when applying.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
