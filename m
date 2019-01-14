Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A0C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483F3204EC
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 18:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2K4SXQka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfANSF6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:05:58 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:40975 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfANSF6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 13:05:58 -0500
Received: by mail-io1-f54.google.com with SMTP id s22so18334326ioc.8
        for <linux-pci@vger.kernel.org>; Mon, 14 Jan 2019 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XsZJmuK30ARYLqZY4rsvSLoZCuqDV/f6jEVU/zVqkQE=;
        b=2K4SXQkaC+nxAJ2AOvg/GO4G9tqfZoRJX9ktI5njPE0xPWvwjmVV5S4h0WfJvE5Er/
         sXFrIiJ0LxM7n9skGNNdKh+MO/QofBNNn36sVcufWAGlbY+yLbROTWAxkO8rOzIh5Mbn
         otJPGs32qQ3iYkEhdClG2trh4ObbMU5bZk2alLJUuqs7FFIgh8dwxeJZP4uXztJzU1+t
         Jv7HWDWpJJftchToMmTwbE3Okp6xaFxMXqQdDmYGD2RPdKCxI1ya9GsDfq45SF/xLgn4
         lbihoaU+ArghZSAK0u4uE1VDc+MhgEtYag13HFQurnSPaj2Jn/h7Ka5r/TrBHlvBsne7
         lifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XsZJmuK30ARYLqZY4rsvSLoZCuqDV/f6jEVU/zVqkQE=;
        b=U4UWg1quCulv0/2Z5kPRsM6EueKXSPi2SMFdOX3vt67NEnl+mSd59xliMvYm7IrbKy
         7idbMcqzoQZEa2riWqgHC1AzbI++04Dlh0Dhtb7/tbOPmuBigMbUxpvZYxT549b5Py6y
         HSentCX9gVag1LhzzZALc7JjS3iLWlD6X5t1ugISPEbbCXyO0Cxa6CLfD9fwrWvONJ/7
         tzCwntQDINml3XnmwsINmOjGylJORGlSV/OBh0zyeiyktSkxauvsFtY24CTpooMfnD/G
         NbealjpwiMuquLxiKEKJ7d5SzscupYEfzSVhGsay6EyW6zaXRgGR+1uh8DWmmX1Kk06e
         Eruw==
X-Gm-Message-State: AJcUukcXGDzMCHBDV/c2zr3er3VcSUb9WWUdk9yBUMWxfjgLtuQRcGxD
        us4rISGOOSC66NYxewbjfRHfbA==
X-Google-Smtp-Source: ALg8bN7pRMn+7anYvrUb6w+bFnPcyeKK9M52+6R8+1exi7uvNiyWc2XevtfbxCF8OYqOdoJ2mM8DaQ==
X-Received: by 2002:a5d:9859:: with SMTP id p25mr16943328ios.64.1547489157441;
        Mon, 14 Jan 2019 10:05:57 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id g21sm491058itg.44.2019.01.14.10.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 10:05:56 -0800 (PST)
Subject: Re: Please remove warnings from msi.c:1269 and blk-mq-pci.c:52 some
 day
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        fin4478 fin4478 <fin4478@hotmail.com>,
        Dou Liyang <douliyangs@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org
References: <AM0PR06MB3969BE1DFD53EFF6228E1A0AA1800@AM0PR06MB3969.eurprd06.prod.outlook.com>
 <CAErSpo5B2m406Mk6SUUcnmF31OEa8vC5YQTKB0ws3z3F5y_fEw@mail.gmail.com>
 <20190114170338.GA27149@localhost.localdomain>
 <20190114180207.GC27149@localhost.localdomain> <20190114180516.GA8858@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a97735d4-b82b-d09f-7729-0e74d95475c9@kernel.dk>
Date:   Mon, 14 Jan 2019 11:05:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114180516.GA8858@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/14/19 11:05 AM, Christoph Hellwig wrote:
> On Mon, Jan 14, 2019 at 11:02:07AM -0700, Keith Busch wrote:
>> User fin4478 <fin4478@hotmail.com> informs me Ming's patch above fixes
>> the warnings, but responding to the mailing lists from that email account
>> are blocked for "security or policy reasons" and requested I forward
>> the successful test result.
>>
>> Christoph, Jens: may we queue this up for -rc3?
> 
> It is in my local queue for -rc3 already.

Great, thanks.

-- 
Jens Axboe

