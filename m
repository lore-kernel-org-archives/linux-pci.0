Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45658 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbaDPUPk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Apr 2014 16:15:40 -0400
Date: Wed, 16 Apr 2014 13:15:41 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] pci_ids: Remove old serial device IDs
Message-ID: <20140416201541.GA25148@kroah.com>
References: <20140331151929.7bd3afef@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140331151929.7bd3afef@endymion.delvare>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 31, 2014 at 03:19:29PM +0200, Jean Delvare wrote:
> These IDs are no longer referenced since kernel 3.1 so I suppose we
> can remove them from pci_ids.h.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
