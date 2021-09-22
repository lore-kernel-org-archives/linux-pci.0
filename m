Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED8DC433FE
	for <linux-pci@archiver.kernel.org>; Wed, 22 Sep 2021 09:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A646120F
	for <linux-pci@archiver.kernel.org>; Wed, 22 Sep 2021 09:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhIVJHK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 22 Sep 2021 05:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhIVJHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 05:07:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4CFC061756;
        Wed, 22 Sep 2021 02:05:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y28so9446929lfb.0;
        Wed, 22 Sep 2021 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=slTV8Z+Iv2BeDlB5S8f95ONxlbcf+1pDh0QE8l9nOEQ=;
        b=i9ybnsQOHqvEQtNO8h8rCxJSYZ2KdpWaRkkklCBkdcnv2uAiGeCZTdps5AZ9IdLD+6
         fUgJEM/xTy+OYkQCWikMkOj1VEz0eGkRqlacxozWV8TgQLnHKbfynB3S0ZZh9EmZMOIB
         kHfKY+x4d+Unto9hAHYs9EbtHAvm2AQb8a8pPuSrAvITP7zONZIJyNcDM7eAj10Axlqy
         /2kg1DlfX3YZlu80orQZy0/Svk2ewGFtIcAj7k89HY1jKl0YIGOoNQ9C0ez4sAyzgH1B
         bYlR+1aj3Z6zWw9QTZMGUwr8zetRnFtxOjxdJAMd7CSXCvjzP3bWJEqtsDF4s3JJzUWQ
         GmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=slTV8Z+Iv2BeDlB5S8f95ONxlbcf+1pDh0QE8l9nOEQ=;
        b=rOJBdD3LxkUiQuzFd/kr+76C/bYg/Hiux8V5xdWpiq5R0aRjzH5E4BzfdUvCECME1Z
         yDkmS3KWS8j6dGNK3jtDdL3mK7TabEodpuZmMq6k85n/FQXXe3/TZFtU3YziGthEN6wF
         avmgrz+Ut2Ho5GnF5+MkDjNWaQTlB3NJMcbO02FNdPhpEpwIVTOXaK85Br9052I4CCIP
         EJFqk8jb5+MdTLuzkyk/0H/jAiMYOJQMyA13HstWNfpnHvoKP7/N3mdCBtbBjs/M3vsV
         kGoFlmfFpd/AorFpSWQVJxxxkMKNqTAKsVLkRTBwKnAXN1PVC/0wEYtWRl3f9x+3jNGg
         EJSQ==
X-Gm-Message-State: AOAM530mlrWZYEXjN5viq5cek1qFcGfQcpu2yjomG1JsGRCAK9BJP24t
        18Nhu2lvR9uEKa/1ResQMiVVLkOhF4A=
X-Google-Smtp-Source: ABdhPJwL3StTJaATi8gW/oPBglzRA+pg+wjzoIU2iSmykApHc1N/aLAA8Z8OAG+eKmfCXrr0WzYbbw==
X-Received: by 2002:a05:6512:3a8d:: with SMTP id q13mr11428478lfu.198.1632301535369;
        Wed, 22 Sep 2021 02:05:35 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.79.80])
        by smtp.gmail.com with ESMTPSA id v12sm184574ljp.124.2021.09.22.02.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 02:05:34 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add myself as maintainer of the
 MT7621 PCI controller driver
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, john@phrozen.org,
        devicetree@vger.kernel.org, tsbogend@alpha.franken.de,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org
References: <20210922050035.18162-1-sergio.paracuellos@gmail.com>
 <20210922050035.18162-4-sergio.paracuellos@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <06500d9d-4156-f9df-956c-7306a2984a3e@gmail.com>
Date:   Wed, 22 Sep 2021 12:05:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210922050035.18162-4-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22.09.2021 8:00, Sergio Paracuellos wrote:

> Add myself as maintainer of the PCie Controlller driver for

     PCIe Controller. :-)

> MT7621 SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
[...]

MBR, Sergei

