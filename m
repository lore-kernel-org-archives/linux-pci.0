Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02933C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 20:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B0A218D8
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 20:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549917316;
	bh=3jDQwnRz/p/blpP5NJhVM/v/GNO91OWCupemhUCpwaE=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=cYdIFXGN1DWbgBLAHpo8ppV7xmla7kxGpOL8y+7lhbeNr6wOU99HLulT2vvQxcvGT
	 Xd51+/7aQR8P8YzqQiDVY2rMkT+T6Yfu6g7L75CHFjDg53IsCpPS5+/DqC8Mnkq8la
	 cb6R3+Yj1Boyc1/0mwdPsKSJId5wm9jHj6QtNoqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBKUfQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:35:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41281 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfBKUfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 15:35:15 -0500
Received: by mail-qk1-f194.google.com with SMTP id u188so7305022qkh.8;
        Mon, 11 Feb 2019 12:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NzkMLHlmh/2mUIvkidKlXjIkFy1c+76A+Xd7Q1175rQ=;
        b=GZ5IliSVxhFVU0qk3/hSzopZlizwQa2O5Q2KY80oIgUVAoaEz2G8tR9gdJZPsTkfZ/
         nLRXZv4kGrI6vgzzz1+0w9RJg+6c4RHWjrA+hlzX++WVII3sDEsaBkZLjkcYvXoSbdKa
         PkcwakhJZvkCQXejUOSih5f7ZCLlOX70QXqNaSfD/SlahamxT7WUM8Us9GbBdVQVujH+
         6+ZDWn4jEfHTHtWkI5xH/vnCngsl923sNn+yB0StJYNs0+6pfdYTcvM9JiEvNmeg/YZc
         1b9ydd0DPJqvG98xbPDbgxMCw+7nnyylYufPbWvguM4PRq5k2Or56wZYBvzd4hpZY0sB
         rBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NzkMLHlmh/2mUIvkidKlXjIkFy1c+76A+Xd7Q1175rQ=;
        b=aHSZw+xk8P1H0AY6VG5Io2CFgozdRHF8vt0ypcERWQf/APeQxqnnLwOeKVZB0QS1N+
         b5F2MLO4xXZIKRdOEZ1Mq+L2QuWyBM/sflDxOcNQiHBOMcDCiZ+WAyIqZzc3nPaFv49n
         ZFmP3Wqj1USJ4Bzh+izC6E1LfdSYzlxNZnjKazHsnp7nbc7B8XTdqIGTlEfLFs79Ecst
         5lHHsZksSiJpWOMOHm86Dv6+KwWAr+h1FCovLV6XixLkEytbu/jSJYHRGGluinwmfgxD
         YgSg2+WpGiDA08amz9fWtv2kb8ZERktVUN0XMLJOPOF6PUiecDCBhSWQKPfnjY+xDCgD
         Z38A==
X-Gm-Message-State: AHQUAuY5sDbGvZuyK9/EA6F1QxRr+Cq8zewjhcHPH1pu8z7uLDc0LyFg
        /l1KElRjT1Vy5ReRcm60hEA=
X-Google-Smtp-Source: AHgI3IYcSQ64HD+iqxa0zU9DfKmDSQRTaZBHwxxwh/f4es0sNeCrO5e9bbXXAxWHY+fz43/e/BxANA==
X-Received: by 2002:a37:c30d:: with SMTP id a13mr90085qkj.18.1549917314552;
        Mon, 11 Feb 2019 12:35:14 -0800 (PST)
Received: from ?IPv6:2001:4898:4070:71:3025:7b73:eee8:a16e? ([2001:4898:8010:1:f0f4:7b73:eee8:a16e])
        by smtp.gmail.com with ESMTPSA id f3sm10861727qkj.24.2019.02.11.12.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 12:35:13 -0800 (PST)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        joro@8bytes.org, dwmw2@infradead.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
 <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
 <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
 <351a1a1d-2517-5021-e7cd-99d700e17f4c@linux.intel.com>
 <815f2621-fc28-bff4-c300-cce7514cfe71@kernel.org>
 <20190211191549.GA12090@otc-nc-03>
Message-ID: <a2fcfb40-cc07-87fa-dc52-72c979d9900b@kernel.org>
Date:   Mon, 11 Feb 2019 15:35:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211191549.GA12090@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/11/2019 2:15 PM, Raj, Ashok wrote:
> It seems rather odd we have to check for ATS version.
> 
> I always assumed unspecified bits (Reserved) must be 0. We only check
> this if ATS is enabled, and this particular bit wasn't given away for another
> feature.
> 
> Is it really required to check for ATS version before consuming this?

Reading again, it looks like version check is not necessary since it
is implied by the presence of this bit per this paragraph.

Page Aligned Request – If Set, indicates the Untranslated Address is 
always aligned to a 4096 byte boundary.  Setting this bit is 
recommended.  This bit permits software to distinguish between 
implementations compatible with earlier version of this specification 
that permitted a requester to supply anything in bits [11:2].
