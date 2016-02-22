Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:55983 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbcBVJp6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 04:45:58 -0500
In-Reply-To: <1455689164-12128-1-git-send-email-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com
Subject: Re: MAINTAINERS: Update EEH details and maintainership
Message-Id: <20160222094557.21B43140C49@ozlabs.org>
Date: Mon, 22 Feb 2016 20:45:57 +1100 (AEDT)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-17-02 at 06:06:04 UTC, Russell Currey wrote:
> Enhanced Error Handling could mean anything in the context of the entire
> kernel, so change the name to reference that it is both for PCI and
> powerpc.
> 
> EEH covers a bit more than the previously listed files, so add the headers
> and platform-specific code to the EEH maintained section.
> 
> In addition, I am taking over the maintainership.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/78c1cffdab7e5fc316be7d6a07

cheers
