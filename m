Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55414 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbaFQTUB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jun 2014 15:20:01 -0400
Date: Tue, 17 Jun 2014 12:23:57 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Liu <jeff.liu@oracle.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 13/24] drivers/pci: return actual error on pci_slot_init
Message-ID: <20140617192357.GB4628@kroah.com>
References: <53A0513C.2070103@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53A0513C.2070103@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 17, 2014 at 10:31:24PM +0800, Jeff Liu wrote:
> From: Jie Liu <jeff.liu@oracle.com>
> 
> Return the actual error code if call kset_create_and_add() failed
> at pci_slot_init().
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Jie Liu <jeff.liu@oracle.com>
> ---
>  drivers/pci/slot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Bjorn, please do not take this patch.

thanks,

greg k-h
