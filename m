Return-Path: <SRS0=AkHN=R2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9B3C4360F
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CEC20896
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3DjYIL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfCWByl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:54:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37816 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfCWByl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 21:54:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so4228101wrm.4;
        Fri, 22 Mar 2019 18:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OY3qqnRvQXyuiyBXrrPcKpXKx3IxdvMN5IorLJTnqOs=;
        b=P3DjYIL+0HGF1cCb4i0PrKjOrxxcKJk8FGfgubwDXS9XzZ51Ms5W66A/aEYws1tpcT
         hJO6XRXnQI72DyAb6/32eVs6ctmlbJcYTKvensOFdjuGXNkNBxX+aX6GnTUxvRLD6MnD
         PgCluD1xzPk/8DrntfyEnogOjn2kf1bT3BYpkXNHmYDZ5dUfCdIIXR9qrOl4iWw+oDAw
         HgWrxx1vch/imUzea9Ih+40oZLtb/rdAIs7xJu1znCisMadifLcON8DEw0HaEEuPTgyn
         /u/rnFQZSQdJPblJWlQXx0FPNB9pSdc3wzY66I4FmOGkNCJW4Mto7fSPN/J2U+HOACx2
         /8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OY3qqnRvQXyuiyBXrrPcKpXKx3IxdvMN5IorLJTnqOs=;
        b=cpK5rTV5iCcne9k5Fsrji76GLIc3fUgcd+7uIKvmPHj1NS5MdCMoPjZ6mWk24XJw8x
         QhrbgCwe94W3yleWongkrwxDOJFmbQI3QWc9FACfj9GNW7FpudihGEfOBUyNxN14XxHt
         /5j4Ptxa72kK9G/joa9pd7lHF6973YOu7Qx8jbkXsDaRKFKMJ5r8H0SPIll3dYxcEUHv
         5YWXi5LtUX9LxvDiXV0kqaFjw1NkUOH7RbapSrfFx/TQCT65WfiEE3lPZSRp2INBm5G4
         ASkhBjN42Hx7HW878zvQfCHIlCqEDY5lgYno11HsvAI+bxgVgo+Q085sV0etPLSqeoxC
         FEtA==
X-Gm-Message-State: APjAAAWzOa57qpnK8ERt+EdImLUqeu/a7DWb6uTeBKXRgIDS3cuJ5hKc
        mhK0TPIyeobkIsYj4VA5OaHJISAa
X-Google-Smtp-Source: APXvYqz3PULtcSr5MgaKhDkN/zP5Z5F0Pi6m18MTNTfWpD3xLRY34aHJyka6Mh1z4dqaoVww8z/Azw==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr8027482wrr.297.1553306079250;
        Fri, 22 Mar 2019 18:54:39 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id a9sm13930303wmm.10.2019.03.22.18.54.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:54:38 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] PCI: rcar: Replace various variable types with
 unsigned ones for register values
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
References: <20190322023844.18574-1-marek.vasut@gmail.com>
 <20190322023844.18574-3-marek.vasut@gmail.com> <20190322084119.GI1005@kunai>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <b28f5e1d-b5fc-e88c-c8b5-21fc15aaceee@gmail.com>
Date:   Sat, 23 Mar 2019 02:28:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190322084119.GI1005@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/22/19 9:41 AM, Wolfram Sang wrote:
> 
>> @@ -508,7 +509,7 @@ static void phy_write_reg(struct rcar_pcie *pcie,
>>  				 unsigned int rate, unsigned int addr,
>>  				 unsigned int lane, unsigned int data)
> 
> What about converting 'addr' and 'data' here? Other than those, I didn't
> find other candidates in this driver.

Sure, fixed.

-- 
Best regards,
Marek Vasut
