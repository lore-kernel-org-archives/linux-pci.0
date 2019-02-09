Return-Path: <SRS0=+kTV=QQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D2DC282C4
	for <linux-pci@archiver.kernel.org>; Sat,  9 Feb 2019 04:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84EF20857
	for <linux-pci@archiver.kernel.org>; Sat,  9 Feb 2019 04:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549687799;
	bh=PGtu0pA/JtItYzRoRmABrQ3G0J/7sQmRTN81aqMQIpc=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=hMSedga53Ny9hO0VLmEa3Ya+02cF4QNm/MkaL0LwS3cAFMvpSceVIVt/JA1/iNKnH
	 VKBN6neIBHOZhzpc/N11caW4Zun7xYQPKuKxQnwa+HITchISm70XG3cAQ4AabP58rF
	 JGq8CuWzcSX7v7L1UpWnbXghNSTXJm9gbx8ED8/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBIEt6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:49:58 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36146 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBIEt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 23:49:58 -0500
Received: by mail-yb1-f193.google.com with SMTP id h40so2297452ybj.3;
        Fri, 08 Feb 2019 20:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QL2RsmZDJC4oEMkF7amfJkSs5ccPd41qn8Q4JrYPDRw=;
        b=Hsf04Xr2xX7bpM5rS3O+qS+O/NgAgcw36dfHQz4UF/wSmnvOwqpjGgBjM/nxrYF0kM
         os20lR1y0hBb36AUxw023Jds/n0Te9J8jzJRXz/m+9KnQccky/BkwmmOFJ6jLS0IqJdh
         UxsvdKbhywlDZvRJhlxIZOoCZZrVCZLIXT9DJVJiMd6K1gkRGUiQIWGfGXiIqqLmEWZd
         l5UnyxCYwE7Fm7I0vKAfXtj49j0hmk35hA3T5cwZ6Sm8TgoQJW/CqMBFe9qNKbNe5O8M
         qJCp8F6uzPmQHOusBlRmrW3WN4XAl+l2PMVOwd29evB4DlkA/ot3u1nPYfrpUmeooB1c
         VrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QL2RsmZDJC4oEMkF7amfJkSs5ccPd41qn8Q4JrYPDRw=;
        b=mdJb2mobhcs6h3PZM/Ho+K+3dJmzdFOZTzF7pdX0CvFSAsLxqmkhA1z19LA72ERD3N
         YIMCg2/wEc53Rk47aA9JjEvQz3BW1LAYelqnjwitIEc9qTDUisbQZO5YAbAEgWAXNJ8Q
         lWLTSFJH/691EELn0l0uJ3lnLHyPLtk+aYH2U2ZCbqtzkkoxQR72fp7EsqH6TtuQjvum
         oiaqijpxTnybWXG9hHwUCaeS+36JjJ0Dhk2DComvDM4cgVUHvhXu+jmlztEfdND8N8kd
         Oi+wowNwoTqSHV7eIylzE6KSeYCskFNQdM2mZSYGNnRmL4zplhsCDavi6zI/kLl3/T1n
         Q4cg==
X-Gm-Message-State: AHQUAuaEZu7smxoKylJ0inyJS7uQdJW/O8WQMipU/n3bXncLzBVGeSLl
        ATr36SEZjwFUjX7Jx6zhiL0=
X-Google-Smtp-Source: AHgI3Ia5/WvFSsxfghOtjo6CHBIBgaO1wkjuFwcMziw0QSCGETDKucFvmz43Fsezq01t2uE72ZMwUg==
X-Received: by 2002:a25:2008:: with SMTP id g8mr20353199ybg.167.1549687797612;
        Fri, 08 Feb 2019 20:49:57 -0800 (PST)
Received: from [192.168.0.111] (cpe-174-109-247-98.nc.res.rr.com. [174.109.247.98])
        by smtp.gmail.com with ESMTPSA id h189sm1495662ywd.24.2019.02.08.20.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 20:49:56 -0800 (PST)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
To:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
 <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
 <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
 <351a1a1d-2517-5021-e7cd-99d700e17f4c@linux.intel.com>
Message-ID: <815f2621-fc28-bff4-c300-cce7514cfe71@kernel.org>
Date:   Fri, 8 Feb 2019 23:49:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <351a1a1d-2517-5021-e7cd-99d700e17f4c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/8/2019 8:02 PM, sathyanarayanan kuppuswamy wrote:
>> This means that you should probably have some kind of version check
>> here.
> 
> There is no version field in ATS v1.0 spec. Also, If I follow the 
> history log in PCI spec, I think ATS if first added at v1.2. Please 
> correct me if I am wrong.

v1.2 was incorporated into PCIe spec at that time. However, the ATS spec
is old and there could be some HW that could claim to be ATS compatible.
I know AMD GPUs declare ATS capability.

See this ECN

https://composter.com.ua/documents/ats_r1.1_26Jan09.pdf

You need to validate the version field from ATS capability header to be
1 before reading this register.

See Table 5-1:  ATS Extended Capability Header
