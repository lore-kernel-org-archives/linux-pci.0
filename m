Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB126C4360F
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 11:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BCE21019
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 11:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOj6bEhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfCNLKY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:10:24 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:34714 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfCNLKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 07:10:23 -0400
Received: by mail-wr1-f54.google.com with SMTP id k1so4859683wre.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2019 04:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/JDj8TyDj39QEhF6L2k0Ejw4vMVzg6xp1kxfqEmJmRU=;
        b=QOj6bEhQ0uWHIGjwGl/CDLhOGfJkuTn1GmeGmqGin19w0OJbhWRuXQwmvY49uvJ/tu
         Af/4fpXRBW0U84JCOQjlyK1glEbDjdIEWhiQ941osgEgnzrlQ/6bmjgpng3HHCj/H0/c
         9QECQ6k3pC3tpPJjz/LP47mArfbyDQbUr7HSq5f53aarQJqb2iK/zxsIaocg064b9j1D
         QD4c7Lt6oLaRXzDS8G2/jHdh0+8RRHJnhReIEpK2a3meIbBEvQrOTf86Vx/B0DGeKgDy
         GZUjORqh7+MiENo7fou9VSsemabK6B3T0nt2v8LaBSk71Ck0FZOBrbcUeKZINwruNQik
         g5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/JDj8TyDj39QEhF6L2k0Ejw4vMVzg6xp1kxfqEmJmRU=;
        b=XRhUT539xoK2C6/l2b79EIJpVdSujNowrmktbrRUgEfPxdebTF7OZieUqio2RjI7Uo
         uPcHpkmvwOGiKJW1CjO9nFF80gW1Y0ag9C+Z1xXmvUfg5zbwx08yRMQBo7mTnL5gQgXX
         bmDFDtWMd9V6lurWeCj6a2rU4zTUwJmhY+tfcxXJlOgvghvAlGxXxmjL8JLsxuNUkp0U
         voC5NpvzgTNSCcGyBtyAusGqUJ8MyMv4kdwSm5cdPLRDPUZkhQCOjJUtKj+egxDgoSy0
         7Cy1tIlTT9sHb/HS0M4nM2JbfWSYwJnC1q2F130GmhOBX8aVkQDHltRut1ZHx5UXOvVh
         qYew==
X-Gm-Message-State: APjAAAVkwLTCdXoAY8EnWXZEZ7l/B8Ih+SZ8tbJbGer/CmF8jAGPrA7T
        In84BcFSUawjP4fOSmriOokNmg==
X-Google-Smtp-Source: APXvYqyCW2aPuN2kBaWHCjx7eGFufkJ44XHzzz5KX3cZv0V0uP9+z83pG16rGQkqn/eAx2cmegTE+A==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr30123450wrx.243.1552561821743;
        Thu, 14 Mar 2019 04:10:21 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id g2sm15622832wrh.7.2019.03.14.04.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:10:20 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: qcom: Use default config space read function
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
 <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
 <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
 <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
 <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
 <3c76613e-e60d-94b8-dd6f-b8f4e1928263@linaro.org>
 <2f901228-52db-7661-8257-ca8fd2ff2a46@free.fr>
 <29664b43-535c-c4b1-a93d-18f49687f929@linaro.org>
 <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9c5a7620-e9ed-82d6-0708-34fe33e39030@linaro.org>
Date:   Thu, 14 Mar 2019 11:10:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <b0e0dc68-4be9-1b0f-7528-fb7d143fea2b@free.fr>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 13/03/2019 22:26, Marc Gonzalez wrote:
> I needed to see the numeric values, hence the -n flag;-)
> 
> 	lspci -vvv -n
> 

Here is the output: https://paste.ubuntu.com/p/kFWZ4kXCxT/

Thanks,
srini

> Regards.
