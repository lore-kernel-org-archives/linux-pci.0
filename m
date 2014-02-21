Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41600 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944AbaBUAGn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 19:06:43 -0500
Date: Thu, 20 Feb 2014 19:06:40 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Andrew Murray <amurray@embedded-bits.co.uk>
Cc: linux-pci@vger.kernel.org, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH] PCI: mvebu: Remove unnecessary use of 'conf_lock'
 spinlock
Message-ID: <20140221000639.GW7862@titan.lakedaemon.net>
References: <1392931935-21313-1-git-send-email-amurray@embedded-bits.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392931935-21313-1-git-send-email-amurray@embedded-bits.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 09:32:15PM +0000, Andrew Murray wrote:
> Serialization of configuration accesses is provided by 'pci_lock' in
> drivers/pci/access.c thus making the driver's 'conf_lock' superfluous.
> 
> Signed-off-by: Andrew Murray <amurray@embedded-bits.co.uk>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
