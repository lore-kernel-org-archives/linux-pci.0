Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53093 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab2CWQ14 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2012 12:27:56 -0400
Date: Fri, 23 Mar 2012 16:27:48 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Shaohua Li <shli@kernel.org>
Cc: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
Subject: Re: [patch]pci: fix a panic in pcie_aspm_init_link_state
Message-ID: <20120323162747.GA23376@srcf.ucam.org>
References: <4F6AA586.70403@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F6AA586.70403@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 22, 2012 at 12:07:34PM +0800, Shaohua Li wrote:
> 
> My desktop always painc in pcie_aspm_init_link_state. Looks commit
> 4949be16822e92 causes it. The FADT declaims the system doesn't support ASPM.
> Below patch fixes the painc for me. I'm quite strange we still touch aspm
> registers even aspm_disabled.

If the device gives us ASPM control via _OSC and the FADT indicates that 
the system doesn't support ASPM, we want to clear the ASPM state - so we 
can't simply disable ASPM in that case. Can you get the actual 
backtrace?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
