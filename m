Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:59333 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758182Ab2IYQXP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 12:23:15 -0400
Message-ID: <5061DA6E.3040008@pobox.com>
Date: Tue, 25 Sep 2012 12:23:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 09/29] PCI, libata: remove find_bridge in acpi_bus_type
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org> <1348561590-28067-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-10-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/25/2012 04:26 AM, Yinghai Lu wrote:
> The struct member is not used anymore, remove it.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: linux-ide@vger.kernel.org
> ---
>   drivers/ata/libata-acpi.c |    6 ------
>   1 files changed, 0 insertions(+), 6 deletions(-)

Acked-by: Jeff Garzik <jgarzik@redhat.com>



