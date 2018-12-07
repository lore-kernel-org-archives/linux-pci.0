Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBE0C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7125D2054F
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CRmSzkoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7125D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLGQUe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:20:34 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:52744 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeLGQUe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 11:20:34 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 378CD10C15F7;
        Fri,  7 Dec 2018 08:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544199634; bh=nFFJDy1kaz12Jt57JfoHa6g/lrKUobwFfoIZdrNwkjo=;
        h=From:Subject:To:CC:References:Date:In-Reply-To:From;
        b=CRmSzkoPnXb/3qQBv91H9UcYvZZAu2buRAfo3aGKSJDnEvvlCNKNwuj+k4qCSEThB
         IZfZUkSnOAAKuIyktg81LN2zppY8JbZ5ShORklYwu14EjVvu6IbU5hLrE19SCqLwnW
         LW5to7VDsESw+cZL5HJILkK0qaBpCrU5otTyKiuI4hQPh+P2JtQi/s3wCRVYhVZe5H
         A7WjK4JXoVH0TfZTSy47TUjkjRFytmvsgksqLrj1mJrEIaNUIRDDny2jnsm8smiT5y
         0fssQWxWVqcDhzsv9a9+7TX/OMZEHVYdmjS/353Sz3WSyOzkJ6eNv44zhckuRM9OHb
         sTWwp91s9posQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 16EF03B4E;
        Fri,  7 Dec 2018 08:20:34 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Dec 2018 08:20:34 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Dec 2018 17:20:32 +0100
Received: from [10.107.19.20] (10.107.19.20) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Dec 2018 17:20:31 +0100
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
 <86a7mcdlwg.wl-marc.zyngier@arm.com>
 <9b63c20b-f928-7c40-2734-00ed783625f5@synopsys.com>
 <1543247559.18519.13.camel@impinj.com> <86d0qrrmbc.wl-marc.zyngier@arm.com>
Message-ID: <f991976a-dcc1-b23e-9a78-e82a622e207e@synopsys.com>
Date:   Fri, 7 Dec 2018 16:16:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <86d0qrrmbc.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.20]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

(snip)

I was able to reproduce Trent's problem in my configuration while developing the
eDMA driver, always having lost the second interrupt when an interrupt burst
occurs (observed in 50 trials).

After applying Marc's patch series, I stopped losing the second interrupt when
an interrupt burst occurs (I ran about 50 trials).

I can say with greater certainty that this fix solves the reported problem.

Regards,
Gustavo
