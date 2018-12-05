Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EFCC04EBF
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 08:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3388A20879
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 08:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3388A20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeLEI26 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:28:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47042 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeLEI26 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2018 03:28:58 -0500
Received: from 93-63-223-40.ip29.fastwebnet.it ([93.63.223.40] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gUSY9-0006AV-HM; Wed, 05 Dec 2018 09:28:53 +0100
Date:   Wed, 5 Dec 2018 09:28:34 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dou Liyang <douliyangs@gmail.com>
cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, bhelgaas@google.com,
        douliyang1@huawei.com
Subject: Re: [PATCH 3/3] irq/affinity: Fix a possible breakage
In-Reply-To: <20181204155122.6327-4-douliyangs@gmail.com>
Message-ID: <alpine.DEB.2.21.1812050926380.16874@nanos.tec.linutronix.de>
References: <20181204155122.6327-1-douliyangs@gmail.com> <20181204155122.6327-4-douliyangs@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 Dec 2018, Dou Liyang wrote:

> In case of irq_default_affinity != cpu_possible_mask, setting the affinity
> for the pre/post vectors to irq_default_affinity is a breakage.

Why so? All interrupts which are not managed get te default affinity
mask. It can be different than cpu_possible_mask, but that's what the admin
has set. The affinity of these non-managed interrupts can still be set via
/proc/... so where is the breakage?

Thanks,

	tglx
