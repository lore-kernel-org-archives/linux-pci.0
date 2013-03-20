Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:42238 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755874Ab3CTBAh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Mar 2013 21:00:37 -0400
Message-ID: <51490A22.1080908@zytor.com>
Date: Tue, 19 Mar 2013 18:00:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Matthew Garrett <matthew.garrett@nebula.com>
CC: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 06/12] x86: Require CAP_COMPROMISE_KERNEL for IO port
 access
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com> <1363642353-30749-6-git-send-email-matthew.garrett@nebula.com>
In-Reply-To: <1363642353-30749-6-git-send-email-matthew.garrett@nebula.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/18/2013 02:32 PM, Matthew Garrett wrote:
> IO port access would permit users to gain access to PCI configuration
> registers, which in turn (on a lot of hardware) give access to MMIO register
> space. This would potentially permit root to trigger arbitrary DMA, so lock
> it down by default.
> 

Again, if you are going to do this, just kill bloody RAWIO.  Quite
frankly saying brainfucked SCSI drivers have abused it doesn't hold
water, because as far as you know those same commands can trigger
arbitrary DMA activity.

	-hpa

