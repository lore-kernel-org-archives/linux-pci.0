Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D58C282CA
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 14:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5861222B2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 14:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="noxi15mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbfBMOgP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:36:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37054 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389390AbfBMOgL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 09:36:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so1222373pgq.4
        for <linux-pci@vger.kernel.org>; Wed, 13 Feb 2019 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1E5DPm3qgeniIx5Gi272hRsM9mfOnn/4ZxCuFF39vOg=;
        b=noxi15mCVj5J1M0qcQepb/SBoqa0JfYACQW52WNKPyrf+a3v3mUnq1zNP5nkR+IbVL
         0OAGEwVoR1uJwPtJUG8GcARF2PBYunnzNUIHBPtCDlZ4rxJl4PC/LwyffJLk2DjOkAAr
         6jG2Yxpx1VdQDUkKg1abt0m/HM5K5xlGo48gVBsXBHg/Z9buu558QNXw1U2CviOZhgM0
         IfjaOP8eA+ul6x0XoEk6c00TCKv53O0POpuVBmjU2+Wgd+KdvlQC2fd8Q2DXcWEGgEz4
         xjb+yBd8Xcl6s4euiWjEhAtg/aSNWiE0PUZlhtdQ0rc9QCfOQo2bCvnmxnez7WXYMDmR
         EtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1E5DPm3qgeniIx5Gi272hRsM9mfOnn/4ZxCuFF39vOg=;
        b=iE+0h82YF/kZ95txx3wAD7wOorVMDGbYLIAy4kY7LB6BWdU9WOfg9TaMH+rHanA1/1
         ONHumkeFtJqqSHcs4l4a8Bpa2yMXBrVPA1acT58KesVy1OLSbGR22jHtxlD2YGSsL3tI
         seACip6UrJ7SqoB7GSVID1WYJ3FZdcnLYdH6e6mJ7Wl2ilu4nltRH2OTMW9CPC622+KV
         +89Q/+LAuoGqBeguNVPjs2jmhw1xRPYLAbUFFGu+uYFpI8AHuxNABovJgbvnYX9PDakq
         f9C6+7qzV/0b3gApgi/KDgxbdLelhcLf2hwVOam9jmqdY/N9uWurBzXP3Q7zDrqaTq5j
         5E+A==
X-Gm-Message-State: AHQUAuZGHeKpKRRHdAyMyBC40Lqx0KTGSHzZdXrpds4hU+cCfTkPw9kN
        ZfIYHe9nrIXxlAJXiCqcfNYS8Q==
X-Google-Smtp-Source: AHgI3IbSWS/hKCdO37Y5ezGagJqTKDYszunhWrg0C1ii8PYrXULU3X2OLEO99KGTo8vggM58V82NHg==
X-Received: by 2002:a63:89c7:: with SMTP id v190mr715030pgd.370.1550068570200;
        Wed, 13 Feb 2019 06:36:10 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm74152165pfh.42.2019.02.13.06.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 06:36:09 -0800 (PST)
Subject: Re: [PATCH V3 0/5] genirq/affinity: add .calc_sets for improving IRQ
 allocation & spread
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a026c441-d433-2391-796d-3d67d233ab04@kernel.dk>
Date:   Wed, 13 Feb 2019 07:36:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213105041.13537-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/13/19 3:50 AM, Ming Lei wrote:
> Hi,
> 
> Currently pre-caculated set vectors are provided by driver for
> allocating & spread vectors. This way only works when drivers passes
> same 'max_vecs' and 'min_vecs' to pci_alloc_irq_vectors_affinity(),
> also requires driver to retry the allocating & spread.
> 
> As Bjorn and Keith mentioned, the current usage & interface for irq sets
> is a bit awkward because the retrying should have been avoided by providing
> one resonable 'min_vecs'. However, if 'min_vecs' isn't same with
> 'max_vecs', number of the allocated vectors is unknown before calling
> pci_alloc_irq_vectors_affinity(), then each set's vectors can't be
> pre-caculated.
> 
> Add a new callback of .calc_sets into 'struct irq_affinity' so that
> driver can caculate set vectors after IRQ vector is allocated and
> before spread IRQ vectors.

Much improved, thanks for doing this work. You can add

Reviewed-by: Jens Axboe <axboe@kernel.dk>

if you want.

-- 
Jens Axboe

