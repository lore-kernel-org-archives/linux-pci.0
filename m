Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:59409 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbaCFVJj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Mar 2014 16:09:39 -0500
Received: by mail-vc0-f180.google.com with SMTP id ks9so3254439vcb.11
        for <linux-pci@vger.kernel.org>; Thu, 06 Mar 2014 13:09:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2ba22558b5db90740d5833c35570c3e7cc1e359e.1394128952.git.agordeev@redhat.com>
References: <cover.1394128952.git.agordeev@redhat.com>
	<2ba22558b5db90740d5833c35570c3e7cc1e359e.1394128952.git.agordeev@redhat.com>
Date: Thu, 6 Mar 2014 13:09:39 -0800
Message-ID: <CAPcyv4jW19zxApviDdbofbXB1OvvN2sCriL3Paszfk9o3T8x0w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/4] ioat: Use pci_enable_msix_exact() instead
 of pci_enable_msix()
From: Dan Williams <dan.j.williams@intel.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 6, 2014 at 12:11 PM, Alexander Gordeev <agordeev@redhat.com> wrote:
> As result of deprecation of MSI-X/MSI enablement functions
> pci_enable_msix() and pci_enable_msi_block() all drivers
> using these two interfaces need to be updated to use the
> new pci_enable_msi_range()  or pci_enable_msi_exact()
> and pci_enable_msix_range() or pci_enable_msix_exact()
> interfaces.
>
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> ---

Can you point me to the background for this change.  From the
changelog I have no idea what this patch does or why I need to apply
it.
