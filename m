Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43816 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab2G2VxK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2012 17:53:10 -0400
Date: Sun, 29 Jul 2012 22:53:01 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: matt.fleming@intel.com, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] Fix priority of non-BAR ROM data
Message-ID: <20120729215301.GA27358@srcf.ucam.org>
References: <1343407934-459-1-git-send-email-mjg@redhat.com>
 <1343407934-459-3-git-send-email-mjg@redhat.com>
 <1343598582.15288.4.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343598582.15288.4.camel@shinybook.infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 29, 2012 at 10:49:42PM +0100, David Woodhouse wrote:
> +	 * Some devices may provide ROMs via a source other than the BAR
> +	 */
> +	if (pdev->rom && pdev->romlen) {
> +		*size = pdev->romlen;
> +		return phys_to_virt(pdev->rom);

Needs casting. My mistake.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
