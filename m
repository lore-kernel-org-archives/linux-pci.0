Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f73.google.com ([209.85.213.73]:49236 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbaEUQIf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 May 2014 12:08:35 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so372094yha.4
        for <linux-pci@vger.kernel.org>; Wed, 21 May 2014 09:08:34 -0700 (PDT)
References: <1400649810-11065-1-git-send-email-gwshan@linux.vnet.ibm.com>
From: Greg Thelen <gthelen@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v2] PCI: Fix return value from pci_user_{read,write}_config_*()
In-reply-to: <1400649810-11065-1-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Wed, 21 May 2014 09:00:34 -0700
Message-ID: <xr93lhtvm89p.fsf@gthelen.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On Tue, May 20 2014, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:

> PCI accessors from user space pci_user_{read,write}_config_*()
> return negative error number, which was introduced by commit
> 34e32072 ("PCI: handle positive error codes"). That patch coverts
> all positive error numbers from platform specific PCI config
> accessors to -EINVAL. The upper layer calling to those PCI config
> accessors hardly know the specific cause from the return value
> when hitting failures.
>
> The patch fixes the issue by doing the conversion (from positive
> to negative) using existing function pcibios_err_to_errno().
>
> v2: pcibios_err_to_errno() translates unrecognized value to -ERANGE.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Acked-by: Greg Thelen <gthelen@google.com>
