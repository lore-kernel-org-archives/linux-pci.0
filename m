Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34706 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbbGNWfl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 18:35:41 -0400
Received: by oiab3 with SMTP id b3so16560622oia.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 15:35:41 -0700 (PDT)
Date: Tue, 14 Jul 2015 17:35:37 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 35/42] x86, boot, PCI: Convert SETUP_PCI data to list
Message-ID: <20150714223537.GQ24416@google.com>
References: <1436300428-21163-1-git-send-email-yinghai@kernel.org>
 <1436300428-21163-36-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436300428-21163-36-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 07, 2015 at 01:20:21PM -0700, Yinghai Lu wrote:
> So we could avoid ioremap every time later.

The changelog (not just the subject) should say what you're doing.

> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 16ace12..32d4f21 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c

> +struct firmware_setup_pci_entry {
> +	struct list_head list;
> +	uint16_t vendor;
> +	uint16_t devid;
> +	uint64_t pcilen;

Is there a reason to use uint16_t and uint64_t instead of u16 and u64?

> +	unsigned long segment;
> +	unsigned long bus;
> +	unsigned long device;
> +	unsigned long function;
> +	phys_addr_t romdata;
> +};
