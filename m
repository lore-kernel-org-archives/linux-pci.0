Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34349 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965092AbaKLDsS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 22:48:18 -0500
Received: by mail-oi0-f49.google.com with SMTP id u20so7865583oif.8
        for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2014 19:48:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <002d01cffe28$ce2f5870$6a8e0950$%han@samsung.com>
References: <002d01cffe28$ce2f5870$6a8e0950$%han@samsung.com>
Date: Wed, 12 Nov 2014 09:18:17 +0530
Message-ID: <CAKohpomSy2LGPDMTWuJJmEzEspoqJmq=yB_uVF3xaCRxjBF9WQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: spear: Remove unnecessary OOM message
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12 November 2014 08:59, Jingoo Han <jg1.han@samsung.com> wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. This patch
> fixes the following checkpatch warning.
>
>   WARNING: Possible unnecessary 'out of memory' message
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pci/host/pcie-spear13xx.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
