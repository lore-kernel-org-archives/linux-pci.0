Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41928 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab2G0PLJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jul 2012 11:11:09 -0400
Date: Fri, 27 Jul 2012 10:11:06 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Matthew Garrett <mjg@redhat.com>
Cc: matt.fleming@intel.com, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH 3/4] PCI: Add support for non-BAR ROMs
Message-ID: <20120727151106.GB13122@thinkpad-t410>
References: <1343340169-7772-1-git-send-email-mjg@redhat.com>
 <1343340169-7772-4-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343340169-7772-4-git-send-email-mjg@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 26, 2012 at 06:02:48PM -0400, Matthew Garrett wrote:
> +		return phys_to_virt(pdev->rom);

This line is giving me a "makes integer from pointer without a cast"
warning.

