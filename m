Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5465C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 21:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8113E20854
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 21:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWZ5FyyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfCMVwp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:52:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52483 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCMVwp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2019 17:52:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id f65so838172wma.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2019 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NQPQNUXHaMVqixEqanCMUJqVcKpUFAyrSTDqnVRbEII=;
        b=FWZ5FyyVZzFp44x3Rvnc3Kdzk5DeLhyWxgKSIq9Rk7Vu5a2DZzLyOq6JcN8JytYDF4
         g2D6pdFWOYNDBQokxZRLdCkclWSjz2UGgbM7BNQ4ZPRiOtfxfqszPPTy8AcaZAc7PYFb
         2LHcfdddHBrYk7ilhRIkFU98LZ8bPz1cx66vdKfaGo0R+QH5WHPnA4N8YC9Aq49hqgYW
         5UjC+lz7obv2tAOviEQPQoIBOd9Dxzv2pbo5gADwpGkRO+6jADr2mnosW+eafo8KdIUc
         3VAv/pnaCrE0nw1sOqqvt/hLzOV4UH2PGBHzQaL4o9uxaWd1dL7Dji7/Uu5oGw0EjpTt
         43yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NQPQNUXHaMVqixEqanCMUJqVcKpUFAyrSTDqnVRbEII=;
        b=fcILSACEnAyqLBo05MRbw14fvhASDpxhCMZt5etPIRwxYF9OkbCaMIWW+rmf7KHGzL
         7nGtGkrOXpcqt1PmqU1d00i/getr6WHTCHDhAiWJ27Ir+F+RkJ9LeA9GfgMFiGFgovNw
         QvNUz2YxsmvVT2Qvucrv8AMothq/yRO/5f/oQpq5Rm8e2YRBm2scTbeRI2KcNGh7pPmn
         Jb/X1iVimSgdrtwKFABcBsUQYlnOsOzbLK/b+ac507PlEbiopVGFug28lu+oyieGUPLk
         Eujb0LBuCSYN6i/XN9ppCiHKACxpt6+7/TqUs29nArePv3hnc/czxXS2KnbrUFl3uYZd
         IBIA==
X-Gm-Message-State: APjAAAVu6s+NUwOvZQHKirOzXsm2lN7qKfbxnNYvVlvCbfvsvCl14gBf
        x+nNgCXHoq3uubHjwK5nIxKg5g==
X-Google-Smtp-Source: APXvYqzVyu+XogAkmn97yC1v/MFovyGxZsHIKg/6w2Of8IwuedHo/Smf12bxi8DHap5+1WsqnOELdQ==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr171476wmi.99.1552513963682;
        Wed, 13 Mar 2019 14:52:43 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id p16sm25516836wro.25.2019.03.13.14.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 14:52:42 -0700 (PDT)
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <29664b43-535c-c4b1-a93d-18f49687f929@linaro.org>
Date:   Wed, 13 Mar 2019 21:52:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2f901228-52db-7661-8257-ca8fd2ff2a46@free.fr>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 13/03/2019 20:39, Marc Gonzalez wrote:
>> working without patch :https://paste.ubuntu.com/p/TJm4hgjGW4/
>>
>> I have not debugged it any further other than just testing the patch.
>> Let me know if you need any more dumps for more debug.
> Could you pastebin the output of lspci -vvv -n in the working case?
This was already in my original reply:
working without patch : https://paste.ubuntu.com/p/TJm4hgjGW4/

--srini
