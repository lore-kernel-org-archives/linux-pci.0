Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A07C07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 16:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5782086D
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 16:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBUJ2OUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5782086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeLKQ1S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:27:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45127 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeLKQ1S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Dec 2018 11:27:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so6847671pgc.12;
        Tue, 11 Dec 2018 08:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LcdxETSJ8fzBjx5LqF+wJ2pQmSCMcXLgwJEArEe+XLk=;
        b=gBUJ2OUJZsl2s/RkBVNYxShA1TMx/30Tukra7shw3W5M55wP8ax/RfnjCSyUrNiVMb
         geAK7NjGeq8RgRsBdWDD9aFU9uL9/iZ5v18B6IMFKswUhXHtaNqS4y8lPkWPhMWxF73d
         LfoG4Oeubq+oyemBbF2WvgqkTR9rkjhBIGT+rkAjAZeSsS21YHj2msOXK7Mq57s+Wweq
         TGxgOVRrIk36s0sauCCbtYrYmFTo/mcXofWc27awAaxeywjd+V6OB9JQIRLMP/rVWDKb
         gHopTbDMUx4cLAmy1u/C4/Pf493cFiG/FPyvbhHDoYRG5WKAJxMRuxKAaFIabwKweRx7
         HSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LcdxETSJ8fzBjx5LqF+wJ2pQmSCMcXLgwJEArEe+XLk=;
        b=Z6DrZCsPUILlDGtkS3/Jtc6QcXtdvLa3HgJVP90Oqq5qpmjhU1ZtKWN7JHTfqZvFI/
         tPGpA/KIsESvTy6J7hWr9RYZlr7oWAK+hQB7Euh1TIyUbkescJgXA+GtDIh+XtsX26KF
         CYSXvD8lpFvn4DltWlN1KaMky4szqDAw/tsgKB73QZ/BW+dlFIJFBdETAxqumvQgQgGo
         NOYOqsn68FVDXDVmmaZ8tlgJFdsUleK7Ien0Y82+/l9vD/Sn4MtHW0LTc2GssfGWf6kP
         adcAhUuOrs83b8lMXHziJ2/ltaNne0oL2w1zDFnaWgfPZBZbZYr4whs6gXo6vBToeiic
         NJqA==
X-Gm-Message-State: AA+aEWbJQbXOWTmLtwHpjeljR9HqVW+S4u+awQ2dVLyZ+rhH7HQUN+Fx
        D+R2QDDCnaswiw57z00vNcE=
X-Google-Smtp-Source: AFSGD/UftvdFHcdYQdVouyoqyxbbcy4aKFOuUoNtzH1oL++zPp2sIDIXC2/4TPH3iwn/CuMT27l12g==
X-Received: by 2002:a62:1c7:: with SMTP id 190mr16979334pfb.46.1544545637512;
        Tue, 11 Dec 2018 08:27:17 -0800 (PST)
Received: from localhost.localdomain ([104.238.160.83])
        by smtp.gmail.com with ESMTPSA id t67sm27010146pfd.90.2018.12.11.08.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 08:27:16 -0800 (PST)
Subject: Re: [PATCH 3/3] irq/affinity: Fix a possible breakage
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, bhelgaas@google.com,
        douliyang1@huawei.com
References: <20181204155122.6327-1-douliyangs@gmail.com>
 <20181204155122.6327-4-douliyangs@gmail.com>
 <alpine.DEB.2.21.1812050926380.16874@nanos.tec.linutronix.de>
From:   Dou Liyang <douliyangs@gmail.com>
Message-ID: <4b5830d3-0656-dc17-abb7-b6145c7516a0@gmail.com>
Date:   Wed, 12 Dec 2018 00:27:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812050926380.16874@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi tglx,
on 2018/12/5 16:28, Thomas Gleixner wrote:
> On Tue, 4 Dec 2018, Dou Liyang wrote:
> 
>> In case of irq_default_affinity != cpu_possible_mask, setting the affinity
>> for the pre/post vectors to irq_default_affinity is a breakage.
> 
> Why so? All interrupts which are not managed get te default affinity
> mask. It can be different than cpu_possible_mask, but that's what the admin
> has set. The affinity of these non-managed interrupts can still be set via
> /proc/... so where is the breakage?

I misunderstood it. please ignore this, ;-)

Thanks,
	dou
