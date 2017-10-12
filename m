Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0070.outbound.protection.outlook.com ([104.47.41.70]:65370
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752797AbdJLN17 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Oct 2017 09:27:59 -0400
Date: Thu, 12 Oct 2017 15:27:45 +0200
From: Robert Richter <robert.richter@cavium.com>
To: bhelgaas@google.com
Cc: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wilson.Snyder@cavium.com, alex.williamson@redhat.com
Subject: Re: [PATCH v6] PCI: quirks: update Cavium ThunderX ACS quirk
 implementation
Message-ID: <20171012132745.GH18024@rric.localdomain>
References: <1506344920-24016-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On 27.09.17 11:20:39, Vadim Lomovtsev wrote:
> This commit makes Cavium PCI ACS quirk applicable only to Cavium
> ThunderX (CN8XXX) family PCIE Root Ports which has limited PCI capabilities
> in terms of no ACS support advertisement. However, the RTL internally
> implements similar protection as if ACS had completion/request redirection,
> upstream forwarding and validation features enabled.
> 
> Current quirk implementation doesn't take into account PCIERCs which
> also needs to be quirked. So the pci device id check mask is updated
> and check of device ID moved into separate function.
> 
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>

ping on this patch too for pci/host-thunder. Do you think we can mark
this stable for 4.11? Since there is a dependent patch not yet in
stable (b77d537d00, should be added to stable too) there might be
conflicts. But maybe this could be figured out once the patch is
considered for inclusion into stable.

Thanks,

-Robert

> ---
> 	v5 -> v6: comment typo fix: change 0xa00 to 0xa000
> 
>  drivers/pci/quirks.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
