Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51149 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbbFKRqI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jun 2015 13:46:08 -0400
Date: Thu, 11 Jun 2015 10:46:07 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: jakeo@microsoft.com
Cc: kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, mebersol@microsoft.com, haiyangz@microsoft.com
Subject: Re: [PATCH 2/6] drivers:hv: Move MMIO range picking from
 hyper_fb.mod to hv_vmbus.mod
Message-ID: <20150611174607.GB22639@kroah.com>
References: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
 <1434039747-44535-3-git-send-email-jakeo@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434039747-44535-3-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 11, 2015 at 04:22:23PM +0000, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>

No changelog body text at all?  That's a sure way to get a patch
instantly deleted from my queue...

