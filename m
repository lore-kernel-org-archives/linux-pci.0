Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbdEaL3R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 May 2017 07:29:17 -0400
Reply-To: jtoppins@redhat.com
Subject: Re: [PATCH v2 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
 boot for X-Gene v1
References: <1493340847-25720-1-git-send-email-kdinh@apm.com>
To: Khuong Dinh <kdinh@apm.com>, lorenzo.pieralisi@arm.com,
        marc.zyngier@arm.com, msalter@redhat.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, jcm@redhat.com
Cc: patches@apm.com, Duc Dang <dhdang@apm.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Jonathan Toppins <jtoppins@redhat.com>
Message-ID: <a33cec72-e4ab-60cb-7173-41043f4a9120@redhat.com>
Date: Wed, 31 May 2017 07:29:15 -0400
MIME-Version: 1.0
In-Reply-To: <1493340847-25720-1-git-send-email-kdinh@apm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/27/2017 08:54 PM, Khuong Dinh wrote:
> From: Khuong Dinh <kdinh@apm.com>
> 
> This patch makes pci-xgene-msi driver ACPI-aware and provides
> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
> 
> Signed-off-by: Khuong Dinh <kdinh@apm.com>
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> v2:
>  - Verify with BIOS version 3.06.25 and 3.07.09
> v1:
>  - Initial version


Hoping I just missed it, but was a follow-up (v3) ever provided for
this? It seems this thread ended with the expectation that a v3 would be
provided to address the sequencing issue.

Regards,
-Jon
