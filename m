Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D7C7EE24
	for <linux-pci@archiver.kernel.org>; Fri,  2 Jun 2023 13:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjFBNIv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbjFBNIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 09:08:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC81B8
        for <linux-pci@vger.kernel.org>; Fri,  2 Jun 2023 06:08:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso19802955e9.1
        for <linux-pci@vger.kernel.org>; Fri, 02 Jun 2023 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1685711327; x=1688303327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ge2ZWTqQqB7VtQi83p67sX1MxSP3JI5IkbmyB0nuqkA=;
        b=eadb1t9syu7FaqbHDVIYklH0WsjLA+1lfy2fbOkCvdelbjrzSoi/neyCRJ6E/HWYn9
         uKt60y67PkXShD8knec4yorjCa8lUi8YX0UmCLJwNMIVxoIacWtez2ehghjUYP9mZjzj
         zb4M9+PSaR9XncwoQxUBnwxPB9AAvEh52M9H7i/kyztMxa96B+z7oY+PG3x8Zbrge19z
         rDG8AroxbxuBPpIQGnNg/e6q+31dXPzfI217kr9GgPUHtOG8uJq227TLg9UwvOniGAn4
         cp8JQJU+ItKkCw92UmAZ/+DYp+lGJD8NpVT+y4I9cFMEVeV3lSMGHFw+x+5EFSeOCmCE
         sDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711327; x=1688303327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ge2ZWTqQqB7VtQi83p67sX1MxSP3JI5IkbmyB0nuqkA=;
        b=heiC2aTBqySByHPr+oyGi1cbhaBs7eWLji6cqW8er0KK2gX0RvS6vJtUo5HMVtiukk
         QFMxPMRfq+6LxEUk1IfaFtJaBWODPAJMLgR/7L97ug44LvInyvnHEik7lodrqWFUwsE4
         C+QTxer/YLwpxcmOcpog+dNnPKayPLMEeRXKMmMAQt30x3xNqnyMmPGk/FywLnbI3fPh
         nzntqBnFAjN7tMCgQLRZvOVKSiuqnArEtKNQ2QSJOf7CXpWv8x66oCvLZAJM7agCHeZ2
         upLvQlqs9TbxYoOLGf8oyryv52sbB4519vT0RpjZdU/rFiqiX44g6pcoq1tHvdzxAADP
         rHnw==
X-Gm-Message-State: AC+VfDyHwhhIYMVLeaTp+DqHw2mxLAIL5JxTOrOfF2bgoVceD0yUVwe7
        Y7LGPWVfwqwqAsCKM3BXhFVEBw==
X-Google-Smtp-Source: ACHHUZ56MC0RtLKxfwG4pkgTzQeNAanMGtfELh8q+jWmh0lIPG+6cl0s6AhjLfjN5llXwtP4lY5nqA==
X-Received: by 2002:a1c:7712:0:b0:3f4:2737:a016 with SMTP id t18-20020a1c7712000000b003f42737a016mr2132529wmi.29.1685711327239;
        Fri, 02 Jun 2023 06:08:47 -0700 (PDT)
Received: from [10.35.5.28] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id u8-20020a7bc048000000b003f4b6bcbd8bsm1916040wmc.31.2023.06.02.06.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:08:46 -0700 (PDT)
Message-ID: <b289fea8-e4c8-0fda-d637-daf5e85c66f6@sifive.com>
Date:   Fri, 2 Jun 2023 14:08:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2] pci: add PCI_EXT_CAP_ID_PL_32GT define
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Jude Onyenegecha <jude.onyenegecha@codethink.co.uk>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>
References: <ZHe+E7+GOgnP2fmM@bhelgaas>
Content-Language: en-GB
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <ZHe+E7+GOgnP2fmM@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31/05/2023 22:37, Bjorn Helgaas wrote:
> On Wed, May 31, 2023 at 10:57:13AM +0100, Ben Dooks wrote:
>> From: Ben Dooks <ben.dooks@sifive.com>
>>
>> Add the define for PCI_EXT_CAP_ID_PL_32GT for drivers that
>> will want this whilst doing Gen5/Gen6 accesses.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> I applied this to pci/enumeration for v6.5, thanks.
> 
> But I'm very curious about where you expect this to be used.

We have an upcoming driver that has gen5 phy and config requirements.

