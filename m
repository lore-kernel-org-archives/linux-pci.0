Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58531 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab2JBNdH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 09:33:07 -0400
Received: by pbbrr4 with SMTP id rr4so8771526pbb.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 06:33:07 -0700 (PDT)
Date: Tue, 2 Oct 2012 06:33:03 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
Message-ID: <20121002133303.GA502@kroah.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
 <1349159588-15029-2-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349159588-15029-2-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 01, 2012 at 11:32:59PM -0700, Yinghai Lu wrote:
> To use to control the delay attach driver for specific device.
> 
> Will use bus notifier to toggle this bits when needed.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Without a whole lot more context as to why you want this change, no,
sorry, I'll not accept it.

greg k-h
