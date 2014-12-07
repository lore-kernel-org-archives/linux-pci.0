Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:41673 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbaLGUlc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Dec 2014 15:41:32 -0500
Received: by mail-lb0-f180.google.com with SMTP id l4so2785882lbv.25
        for <linux-pci@vger.kernel.org>; Sun, 07 Dec 2014 12:41:30 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	kernel-janitors@vger.kernel.org, joe@perches.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/20] PCI: fix misspelling of current function in string
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
	<1417980062-25151-4-git-send-email-Julia.Lawall@lip6.fr>
Date: Sun, 07 Dec 2014 21:41:28 +0100
In-Reply-To: <1417980062-25151-4-git-send-email-Julia.Lawall@lip6.fr> (Julia
	Lawall's message of "Sun, 7 Dec 2014 20:20:45 +0100")
Message-ID: <87lhmj42h3.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 07 2014, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> Replace a misspelled function name by %s and then __func__.
>
> The function name begins with pci, not cpci.
...
>  	result = cpci_hotplug_init(debug);
>  	if (result) {
> -		err("cpci_hotplug_init with error %d\n", result);
> +		err("%s with error %d\n", __func__, result);
>  		return result;
>  	}

This one seems to be a false positive; I think the err() is reporting on
the result from the call of the function which is indeed called
cpci_hotplug_init.

I just skimmed the rest quickly, but they seem ok.

Rasmus
