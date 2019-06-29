Return-Path: <SRS0=XjGt=U4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AB5C4321A
	for <linux-pci@archiver.kernel.org>; Sat, 29 Jun 2019 08:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495532083B
	for <linux-pci@archiver.kernel.org>; Sat, 29 Jun 2019 08:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF2IBq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 29 Jun 2019 04:01:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38378 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfF2IBq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jun 2019 04:01:46 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hh8Iq-0002C3-11; Sat, 29 Jun 2019 10:01:44 +0200
Date:   Sat, 29 Jun 2019 10:01:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Megha Dey <megha.dey@linux.intel.com>
cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        megha.dey@intel.com
Subject: Re: [RFC V1 RESEND 3/6] x86: Introduce the dynamic teardown
 function
In-Reply-To: <1561162778-12669-4-git-send-email-megha.dey@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1906290959400.1802@nanos.tec.linutronix.de>
References: <1561162778-12669-1-git-send-email-megha.dey@linux.intel.com> <1561162778-12669-4-git-send-email-megha.dey@linux.intel.com>
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

Megha,

On Fri, 21 Jun 2019, Megha Dey wrote:
>  
> +void default_teardown_msi_irqs_grp(struct pci_dev *dev, int group_id)
> +{
> +	int i;
> +	struct msi_desc *entry;
> +
> +	for_each_pci_msi_entry(entry, dev) {
> +		if (entry->group_id == group_id && entry->irq) {
> +			for (i = 0; i < entry->nvec_used; i++)
> +				arch_teardown_msi_irq(entry->irq + i);

With proper group management this whole group_id muck goes away. You hand
in a group and clean it up and if done right then you don't need a new
interface at all simply because everything is group based.
 
Thanks,

	tglx
