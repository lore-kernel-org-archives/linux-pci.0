Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD20EC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 06:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A7420843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 06:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JieEl9Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfDWGGM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:06:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44441 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWGGM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 02:06:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so9629399wrs.11;
        Mon, 22 Apr 2019 23:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RE8Uf9xNxEeknuHtcf7DpO5fd7NyR8TKdNcXZDy770Y=;
        b=JieEl9Ro8tnvVofBRiquMhTLE4DZO0m3zVO/q4HWqdGKScUKOqAhYbf61RRqTSIWtm
         MwSj3+JC6OFl7zaSb4d3ToOxyzTOaCrgKdz5iddquJ94btnYLm4k+smfjp3PvCFwO5IL
         PRBAl9EL9HLgPEcHXwcAdOHNtHd4Q90nJXZS2prdeVvj11OKV9mHA6fv94PPCLAVgVl/
         RM1Xs+2pGyf1iSiK1Jxi7d/AeQ/uRSE2v5WRde7RgFXIGFw68TeC2PJExZ4ypG1TVeYs
         qHn+dsuz0HvzsixmmViQbSHtC6kUDDPGVuxxpM57JFEbX6ZRUJVhHjyM0o2EZczu5YUQ
         xgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RE8Uf9xNxEeknuHtcf7DpO5fd7NyR8TKdNcXZDy770Y=;
        b=Lipxh+q6Fle4B8+i7cXe34n+nJqkt0CLZdPwmlLHR9pFPvg1ePSJTROdYEYGgdau08
         I9+ymJs1Ig5VD906t9ge0WSTlQujHEpuGaPekEJ2lsAA6sQ2XkUR/bD/rgipXQFWYiCj
         LizOZxTQayP0Lmod8rPJjd+GJtprYt/SZiFjKfkZl78MyKYFCkHdahbe61DQ6VjfonD+
         i2QsDd5FqFVcfoofbXsKIKXe2arWwn66ToCiA3PVkULstKk2IT/Ssr8ndIFjuWj4Jaev
         HiwahHuYCF2m2bkJ62kvktXQ/8QUKCH4LRNkyVdfhSBRGNgBHdQ3zEoIvmNWJpvN5WCx
         sjPg==
X-Gm-Message-State: APjAAAWRmmKbrZrTYuczk27yOYgC5YGqKU7TT1nTijN42yKMs+AJUred
        3/1Xjvu/B7C7iWGG+g5ogL7JMKI3vlE=
X-Google-Smtp-Source: APXvYqzC98YHxVJRlizmw4SCeLGCSjK4pCi6vq7o5oyKyp3ULOfWck+kG1iqvHBJMF+EO1TWO56PxQ==
X-Received: by 2002:adf:f90c:: with SMTP id b12mr15182347wrr.63.1555999569868;
        Mon, 22 Apr 2019 23:06:09 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:79fb:d026:7e2:4e79? (p200300EA8BD4570079FBD02607E24E79.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:79fb:d026:7e2:4e79])
        by smtp.googlemail.com with ESMTPSA id y197sm15235895wmd.34.2019.04.22.23.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 23:06:09 -0700 (PDT)
Subject: Re: [PATCH 0/3] PCI: add help pci_dev_id
To:     Bjorn Helgaas <helgaas@kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <b193514c-23d1-e090-7ddb-40371595f3a7@gmail.com>
 <20190419.151338.2080189024614749302.davem@davemloft.net>
 <20190422132020.GK173520@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <14c5ed05-da19-db71-c811-e6457925a069@gmail.com>
Date:   Tue, 23 Apr 2019 08:05:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422132020.GK173520@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22.04.2019 15:20, Bjorn Helgaas wrote:
> On Fri, Apr 19, 2019 at 03:13:38PM -0700, David Miller wrote:
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>> Date: Fri, 19 Apr 2019 20:27:45 +0200
>>
>>> In several places in the kernel we find PCI_DEVID used like this:
>>> PCI_DEVID(dev->bus->number, dev->devfn) Therefore create a helper
>>> for it.
>>
>> I'll wait for an ACK from the PCI folks on patch #1.
> 
> #1 and #2 touch PCI, #3 is a trivial r8169 patch.  There are a few
> other places where this helper could be used (powernv/npu-dma.c,
> amdkfd/kfd_topology.c, amd_iommu.c, intel-iommu.c,
> intel_irq_remapping.c, stmmac_pci.c, chromeos_laptop.c).
> 
> I think it would be easier for me to collect acks for the trivial
> changes to those places and merge the whole shebang via PCI.
> 
> Heiner, do you want to update those other places, too?
> 
Yes, will do so.

> Bjorn
> 
Heiner
