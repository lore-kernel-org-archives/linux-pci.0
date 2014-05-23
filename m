Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:51590 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbaEWTTa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 May 2014 15:19:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 0/4] Support for Generic PCI Host Controller
Date: Fri, 23 May 2014 21:19:23 +0200
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, jgunthorpe@obsidianresearch.com,
	sthokal@xilinx.com
References: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
In-Reply-To: <1400863915-24135-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201405232119.23891.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 23 May 2014, Will Deacon wrote:
>   - Removed redundant MIGHT_HAVE_PCI selections from multiplatform-enabled
>     SoCs
> 
>   - Included patch from Srikanth for generic Configuration Space access to
>     be factored out and used by other drivers
> 
>   - Fixed minor issue in I/O port allocation (I had a >= instead of a >)
> 

It seems strange that you include the patch from Srikanth but then use
a separate copy of the same code in patch 2. Is that intentional?

	Arnd
