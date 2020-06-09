Return-Path: <SRS0=ztgn=7W=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6765DC433E0
	for <linux-pci@archiver.kernel.org>; Tue,  9 Jun 2020 18:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4423E206C3
	for <linux-pci@archiver.kernel.org>; Tue,  9 Jun 2020 18:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib/0HdtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbgFISPw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388774AbgFISPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 14:15:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7295C05BD1E;
        Tue,  9 Jun 2020 11:15:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so22364591wru.12;
        Tue, 09 Jun 2020 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TDeKr1HAesXBQgM+IuvcyLWHrtpuB78uSNiXvj3O+1s=;
        b=ib/0HdtHVozoKsTp2b8sWLvSkHg6ZZk0P2rBq035OwmjNQ9zRgW4In76JkVtl7p2Xq
         J02jkjG7fWRm9n9MbqVGSo22x7mhDbdUGXhYP0ChE0NJDjGt97n/VHEh5B9y9iR/snsx
         EoQ6YuwqfOn3NIBNwGRgj4opCw98aXZ44boJl+iAQcEklNaKPpTGEDuBGPqivYmnFG+n
         1Q6c6F03UdjmL9ZNngHKXx7K1C6h+NWE+oUkiyAJCkTPR2Lm2EbmB/BeVpu22A9AzebZ
         StMVW93S5BNxgJhhi6EU4jqUUKLAxAN3gKD7wncF3ylcaZYppQVcQSIbap0XI0v/W/TM
         hW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TDeKr1HAesXBQgM+IuvcyLWHrtpuB78uSNiXvj3O+1s=;
        b=nqUscvkSWbHFtSwcA10ZLU4IsVF09584xZ/iagdjqnhhdBOkSNfHVEQlS0l5wNRwVk
         cLWDonGHzh0K1KVRCsUeEafOqYY9VYQ8WiOrUNmrZRTlXdGwWKkmyZdJRnmN6vr+NfQk
         1MVarM3sMsmxOGIe1f15J6ebgjtW70fJHtuMP8gaE1fT5QM0bSoyca8Czpb9ptuHGasU
         rmkYHfrh535eHMeZRQFrbDdhKpoT28GQ3sFAvco9SAFY2QXryQ9oAtCwtodTaJ7bMcag
         BLeYcTK72vXuNrOxnIyDOcnzXHaF3wL9xZg5zBEwXK7WSFAtmyLpldSRDK4+hx8fji7r
         d+WA==
X-Gm-Message-State: AOAM532CePWos/G5OGNtjJLhRcB+px3Jli2QM9TXBTlKJFa/CTlSB3i8
        ibON8EPaivbQvU9SGwTMvmc=
X-Google-Smtp-Source: ABdhPJxrKaokqHqKhJi6lQipwFbwJcjsTCo+9Ts9grya2F9blBNHVieAVdnfItI+alcaSc0oBouY+A==
X-Received: by 2002:adf:a4dd:: with SMTP id h29mr6177242wrb.372.1591726535306;
        Tue, 09 Jun 2020 11:15:35 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id k21sm4575975wrd.24.2020.06.09.11.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 11:15:34 -0700 (PDT)
Subject: Re: [PATCH v2 9/9] Revert "PCI: brcmstb: Wait for Raspberry Pi's
 firmware when present"
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
 <20200609175003.19793-10-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3f1f622d-eac2-6def-6006-f612c4aed1e1@gmail.com>
Date:   Tue, 9 Jun 2020 11:15:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609175003.19793-10-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/9/2020 10:50 AM, Nicolas Saenz Julienne wrote:
> This reverts commit 44331189f9082c7e659697bbac1747db3def73e7.
> 
> Now that the VL805 init routine is run through a reset controller driver
> the device dependencies are being taken care of by the device core. No
> need to do it manually here.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
