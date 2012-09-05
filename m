Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 5 Sep 2012 03:29:32 +0100
From: Matthew Garrett <mjg@redhat.com>
To: Don Dutile <ddutile@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-efi@vger.kernel.org, mfleming@intel.com, dwmw2@infradead.org,
	bhelgaas@google.com
Subject: Re: [PATCH V3 3/4] PCI: Add support for non-BAR ROMs
Message-ID: <20120905022932.GA4087@srcf.ucam.org>
References: <1345739803-21017-1-git-send-email-mjg@redhat.com>
 <1345739803-21017-4-git-send-email-mjg@redhat.com>
 <5046B688.1070902@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5046B688.1070902@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 04, 2012 at 10:18:48PM -0400, Don Dutile wrote:
> >  	/*
> >+	 * Some devices may provide ROMs via a source other than the BAR
> >+	 */
> >+	if (pdev->rom&&  pdev->romlen) {
> >+		*size = pdev->romlen;
> >+		return phys_to_virt((phys_addr_t)pdev->rom);
>                        ^^^^^
>                          ioremap_nocache() ? ... or is caching rom ok?

If it's appearing through this pathway then it's not actually in ROM, 
the platform has pulled it out of somewhere else.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
