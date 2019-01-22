Return-Path: <SRS0=s1t5=P6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA7AC282C5
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 06:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930D020861
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jan 2019 06:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfAVGuk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jan 2019 01:50:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49555 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfAVGuj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jan 2019 01:50:39 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1glptN-0004L9-GU
        for linux-pci@vger.kernel.org; Tue, 22 Jan 2019 06:50:37 +0000
Received: by mail-pf1-f198.google.com with SMTP id e89so17567535pfb.17
        for <linux-pci@vger.kernel.org>; Mon, 21 Jan 2019 22:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oD0F81rGvS3sGoFVD/u+0PkA8WS8jGUV1TJvWS7JNo0=;
        b=lFGCAv8Zn8Xrz0X//q6191hYWWh7afI9DZ6I6mg2/2n4wgUVslYO/NlpAsiPwlUgBT
         YHYqdJGGcjAoWuLFHq/oPW+I7uqDCc3zG/2rO+wy4u6PUGgCQBLOEjcCheLPrFk0U/X3
         L95ZQ88fIl1opEM80KwI+pmhoXjM49rx03dO9OhiRtBSFKXDAuaZn5NziozcJZJbbgql
         z1R4VN2p4wrA4ZkGlSv8HgdwdKqmqR8nM4bifUMnsKddks0Hxb2yO6+MK3gGOFTx1slv
         wP/aXK1mKChxjOIzCLgVEeAVkrqnUdm+Bj0tYD/INuJCzRIl55m5Fh/Sg0XzAFdghp4B
         GinA==
X-Gm-Message-State: AJcUukfBeMp1SfgWS+PAyQ4SpSjwab+8iL+ylkb0eIvKEmM/spc1IZxu
        jUY/UeDuLh+oSZuNq0UJYYYqsYP1LpvE9+5OkuEXBE/Zu1sa2PUMjMyiEon5LE1ACtYao9m7Yox
        dkbVNFh0Djs7P8b36xN6VWhfBoNxRbIbtDxdsjg==
X-Received: by 2002:a62:c613:: with SMTP id m19mr32654460pfg.207.1548139836197;
        Mon, 21 Jan 2019 22:50:36 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4EPhjBA0wMpiPkhvYnW7hASHktLHT72NtfYUxRbFkcrxjLdXVsQ77WCgMgoKfmOIWgZ3wOkg==
X-Received: by 2002:a62:c613:: with SMTP id m19mr32654449pfg.207.1548139835883;
        Mon, 21 Jan 2019 22:50:35 -0800 (PST)
Received: from 2001-b011-380f-13aa-b45c-a4ba-4b7e-e3b3.dynamic-ip6.hinet.net (2001-b011-380f-13aa-b45c-a4ba-4b7e-e3b3.dynamic-ip6.hinet.net. [2001:b011:380f:13aa:b45c:a4ba:4b7e:e3b3])
        by smtp.gmail.com with ESMTPSA id i193sm53208773pgc.22.2019.01.21.22.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 22:50:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190122064544.27426-1-kai.heng.feng@canonical.com>
Date:   Tue, 22 Jan 2019 14:50:31 +0800
Cc:     Len Brown <lenb@kernel.org>, bhelgaas@google.com,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8B11DF49-9E4A-43D1-899D-10BABDAAAD7E@canonical.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Jan 22, 2019, at 14:45, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> There are some e1000e devices can only be woken up from D3 one time, by
> plugging ethernet cable. Subsequent cable plugging does set PME bit
> correctly, but it still doesn't get woken up.
> 
> Since e1000e connects to the root complex directly, we rely on ACPI to
> wake it up. In this case, the GPE from _PRW only works once and stops
> working after that.
> 
> So introduce a new PCI quirk, to avoid clearing pme_poll flag for buggy
> platform firmwares that have unreliable GPE wake.

Forgot this:
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202181

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> drivers/pci/pci-acpi.c | 2 +-
> drivers/pci/quirks.c   | 8 ++++++++
> include/linux/pci.h    | 1 +
> 3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e1949f7efd9c..184e2fc8a294 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -430,7 +430,7 @@ static void pci_acpi_wake_dev(struct acpi_device_wakeup_context *context)
> 
> 	pci_dev = to_pci_dev(context->dev);
> 
> -	if (pci_dev->pme_poll)
> +	if (pci_dev->pme_poll && !pci_dev->unreliable_acpi_wake)
> 		pci_dev->pme_poll = false;
> 
> 	if (pci_dev->current_state == PCI_D3cold) {
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b0a413f3f7ca..ed4863496fa8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4948,6 +4948,14 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
> DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
> 
> +static void quirk_unreliable_acpi_wake(struct pci_dev *pdev)
> +{
> +	pci_info(pdev, "ACPI Wake unreliable, always poll PME\n");
> +	pdev->unreliable_acpi_wake = 1;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bb, quirk_unreliable_acpi_wake);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bd, quirk_unreliable_acpi_wake);
> +
> /*
>  * Some IDT switches incorrectly flag an ACS Source Validation error on
>  * completions for config read requests even though PCIe r4.0, sec
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c2f082..d22065c1576f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -331,6 +331,7 @@ struct pci_dev {
> 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
> 					   can be generated */
> 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
> +	unsigned int	unreliable_acpi_wake:1;	/* ACPI Wake doesn't always work */
> 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
> 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
> 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
> -- 
> 2.17.1
> 

