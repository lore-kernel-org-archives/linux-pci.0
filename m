Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from yes.iam.tj ([109.74.197.121]:51092 "EHLO iam.tj"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964850AbeAXSZr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jan 2018 13:25:47 -0500
Received: from [10.254.1.52] (jeeves.iam.tj [82.71.24.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by iam.tj (Postfix) with ESMTPSA id CD7DE340FF
        for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2018 18:18:01 +0000 (GMT)
Subject: Re: Regression: bug #81431 (v3.15..V3.16) pci=realloc fails to modify
 bridge windows, causing devices to fail BAR allocation
From: Tj <linux@iam.tj>
To: linux-pci@vger.kernel.org
References: <5581B850.4010406@iam.tj>
Message-ID: <610ce40c-ae0c-5dc5-a985-33c2d79c9d70@iam.tj>
Date: Wed, 24 Jan 2018 18:18:01 +0000
MIME-Version: 1.0
In-Reply-To: <5581B850.4010406@iam.tj>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This regression is still present in 4.15-rc9. It's been ongoing since
3.16. Could someone take a look so it can finally be fixed?

https://bugzilla.kernel.org/show_bug.cgi?id=81431

On 17/06/15 19:11, TJ wrote:
> I've finally had the opportunity to bisect this regession down to:
> 
>  PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources
> 
> commit 5b28541552ef5eeffc41d6936105f38c2508e566
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Mon May 19 17:01:55 2014 -0600
> 
> The patch is quite involved so could someone with familiarity with the
> allocation strategies take a look please?
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=81431
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
