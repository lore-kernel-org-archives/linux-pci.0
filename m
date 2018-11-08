Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B8C43441
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 23:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E4920857
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 23:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX4Fq3mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E4920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeKIJ3e (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbeKIJ3e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 04:29:34 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EE12081D;
        Thu,  8 Nov 2018 23:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541721097;
        bh=0MMIe8Fdp3N8poRuOsUcNeLtbIOFsxYbwuvN10aDJ9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jX4Fq3miU65JoT/BSGDbBCEET4MdOiyZe/O4jRrSC3oMuHBT7wpA0zDI0FUGbN145
         /r4QGsoprE8WsppdK0Dp+0iqm14gL6buWUXIzygjMk+EBFWb0F4kQBrw3dL3a7x1Ln
         O2tmppwTtChBf141zseGW7k2MUzHH6APwPDLSQhk=
Date:   Thu, 8 Nov 2018 17:51:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zubin Mithra <zsm@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        hch@infradead.org, groeck@chromium.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC] x86/pci: Mark pci_root_ops as const
Message-ID: <20181108235134.GH41183@google.com>
References: <20181108171115.216060-1-zsm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108171115.216060-1-zsm@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Zubin,

On Thu, Nov 08, 2018 at 09:11:15AM -0800, Zubin Mithra wrote:
> pci_root_ops is only written to from within intel_mid_pci_init. This
> is linked in only when CONFIG_X86_INTEL_MID is set. If not for this,
> pci_root_ops could be marked as const.
> 
> Fix this by replacing pci_root_ops usage with pci_root_ops_ptr. If
> CONFIG_X86_INTEL_MID is set, pci_root_ops_ptr will be set to
> intel_mid_pci_ops inside intel_mid_pci_init.
> 
> Introduce pci_acpi_set_ops for intel_mid_pci_init to set
> acpi_pci_root_ops.pci_ops.
> 
> This also means that intel_mid_pci_ops cannot be freed after init, hence
> remove __initconst.
> 
> Signed-off-by: Zubin Mithra <zsm@chromium.org>
> ---
>  arch/x86/include/asm/pci_x86.h |  4 +++-
>  arch/x86/pci/acpi.c            |  5 +++++
>  arch/x86/pci/common.c          |  5 +++--
>  arch/x86/pci/intel_mid_pci.c   |  5 +++--
>  drivers/pci/access.c           |  4 ++--
>  drivers/pci/probe.c            |  4 ++--
>  include/linux/pci-acpi.h       |  2 +-
>  include/linux/pci.h            | 11 ++++++-----
>  8 files changed, 25 insertions(+), 15 deletions(-)

Can you:

  - Split this into an x86 patch and a PCI core patch (if possible)?
  - Make the same fixes for other arches?

Bjorn
