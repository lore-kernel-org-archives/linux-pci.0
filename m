Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3C0C10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 23:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1959620674
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 23:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6pYsKUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfDVXpb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:45:31 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54268 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfDVXpb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2019 19:45:31 -0400
Received: by mail-it1-f196.google.com with SMTP id y204so20555782itf.3;
        Mon, 22 Apr 2019 16:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DqDA/Qes9q8m3B2HqjXGZEMMl+zuf4YvngpRBo4X+PI=;
        b=B6pYsKUPqRTCn2zgRgKWbuADyrY7nrtHY2IYO1Y7Plin/gkWg7LDyPesnH4Ou2/Ipy
         IP58jpnCkgXqKiPXpoh3/WOEgcv8+w4QUYglhBFASkrrH1w6BcLtpVG9oS4OgNGwiwGE
         E4x5pD6sNKAMBWhER2nHbOFpRn8ItFc0vPxBR3+LXmuO8LBhv6EHMwAARu5hYbMRwW3G
         LO0fhMIkjJOA47nuMBtG6L1ekVkJlLrcNZQZvB62HySo0sUGD1L+Z7NRYgw5dN0DYEDA
         Eip18/SxxtHIa/pbPoN7Xmp4RV4YTi0dzU26vemRzMitua2Vr+/vbnOSspK1UQKPVMg0
         IUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DqDA/Qes9q8m3B2HqjXGZEMMl+zuf4YvngpRBo4X+PI=;
        b=m0C5sm/3Ne7G54Z2YyrT4JJxsL2TBEPyD5YNlSUUKWP7js9WRlX8nrW2jsNej1F7iQ
         Uu73fZHMWgKIgfzfMjITGJgDe4gv7sr5ffB+69bLj6+kc+axwA4vLtFbt0ihl9Ltnn9T
         E3rulXz6mg3J67/XsGNciyBsTohm4atYg2cp4PN/+atQ0OEa/GgY8hUshfrN4a13+vFj
         1YvrVBCe0laZR00Kfn1Ebuo1vgIhVLlhk1tJdhRdNbzB1g8NCH3iEOQmkeyJvyhPked9
         jKm1wA3Y2cwzGL2GuTjh7pqqsEJdNl1yyST/3ucTv+KFqv/9Mig7DzmKtyJO+a5gYOsd
         VDlw==
X-Gm-Message-State: APjAAAXIZa+rroC2BJndILakUcA7GX7DlEcRt0tabJwbKQYoHipLK0qY
        j7j2Wtei++K8TqFAFm1q9JUiDr5z
X-Google-Smtp-Source: APXvYqwJ4j9w2Jj7DwgcnfiaSt1xw23s8MhVaZm+HFdK/i3btrmwL8mRvU9HD8NWxp3Nz//dcXfcMA==
X-Received: by 2002:a05:660c:209:: with SMTP id y9mr661675itj.31.1555976729838;
        Mon, 22 Apr 2019 16:45:29 -0700 (PDT)
Received: from nukespec.gtech ([2601:2c1:8501:182d::6fe])
        by smtp.gmail.com with ESMTPSA id t2sm6887344itb.37.2019.04.22.16.45.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 16:45:29 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] PCI / ACPI: Do not export pci_get_hp_params()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190208162414.3996-1-mr.nuke.me@gmail.com>
 <20190208162414.3996-2-mr.nuke.me@gmail.com>
 <20190422205845.GM173520@google.com>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <0b2b2396-b60b-ad25-d4ab-e3633fd93d0c@gmail.com>
Date:   Mon, 22 Apr 2019 18:45:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422205845.GM173520@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/22/19 3:58 PM, Bjorn Helgaas wrote:
> On Fri, Feb 08, 2019 at 10:24:11AM -0600, Alexandru Gagniuc wrote:
>> This is only used within drivers/pci, and there is no reason to make
>> it available outside of the PCI core.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> Applied the whole series to pci/hotplug for v5.2, thanks!
> 
> I dropped the "list" member from struct hpx_type3 because it didn't
> seem to be used.

That's a good call. That was a vestigial appendage from when I first 
intended to store a list of registers in memory. I'm glad we didn't end 
up needing a list.

Alex
