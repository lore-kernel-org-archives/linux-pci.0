Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33059 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdA0Vq7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2017 16:46:59 -0500
Received: by mail-pg0-f47.google.com with SMTP id 204so84321404pge.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Jan 2017 13:46:59 -0800 (PST)
Subject: Re: [PATCH 0/2] PCI: iproc: MPS fix and quirks
To: Jon Mason <jon.mason@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <55c4e250-1317-0ddb-33f8-914f966f6c99@broadcom.com>
Date: Fri, 27 Jan 2017 13:46:56 -0800
MIME-Version: 1.0
In-Reply-To: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The entire patch set looks good to me. Thanks!

Acked-by: Ray Jui <ray.jui@broadcom.com>

On 1/27/2017 1:44 PM, Jon Mason wrote:
> A patch that corrects an issue where the MPS could not be set, and
> another that fixes some quirks in the PAXC
> 
> Jon Mason (2):
>   PCI: iproc: allow the MPS to be set
>   PCI: Add quirk entry for NS2 PAXC PCI
> 
>  drivers/pci/host/pcie-iproc.c |  5 ++++-
>  drivers/pci/quirks.c          | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
