Return-Path: <SRS0=b5K0=D3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CAC4363D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Oct 2020 14:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4295C22249
	for <linux-pci@archiver.kernel.org>; Tue, 20 Oct 2020 14:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t0yRH0YF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i62r4hnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407889AbgJTOQ4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Oct 2020 10:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407843AbgJTOQz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2020 10:16:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860AAC0613E6;
        Tue, 20 Oct 2020 07:16:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603203413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y4j/jlD3xH1hIPmnRimMNEHfyReLuBug0kSJdYGLDZI=;
        b=t0yRH0YFC/n/d0l325g1g0JhblRbNkPW3BVDIyb+F8lusCrsxVjj4xzkXPw/Nvwx7UxE1K
        Vufxd0mOwUR3cEOF/abhAHTCyhgONpu/F2rFc4vz9WnR8qCTb9zjNoVHp3CbK6miOmQK0S
        gtlGwzghB2PA3pkPRUNl+2yyboAmGJQ3UNMLbU1p4blxlri4dogPyBWNZtOEh/2gRbnLU1
        T9+Z0A+l+7NBNxE9DjN9JMrNZsAYFjhaH/UvwP0qXuH680clZ21H4YttTc0IqLOgfALoDf
        v/Cxy/s6qvIhBJAqVcPmGE2WZ9ynjvs9P4KYVcaq7n8qiaypdzKSzedAFM1/bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603203413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y4j/jlD3xH1hIPmnRimMNEHfyReLuBug0kSJdYGLDZI=;
        b=i62r4hnTA8GOzp3DZqiFe48GBrMmgNmkT35gUCsmZuKo662RRxjarZreuX1S3duTNrW69/
        9ng1HHw/l4f6xJCg==
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        frederic@kernel.org, mtosatti@redhat.com, sassmann@redhat.com,
        jesse.brandeburg@intel.com, lihong.yang@intel.com,
        helgaas@kernel.org, nitesh@redhat.com, jeffrey.t.kirsher@intel.com,
        jacob.e.keller@intel.com, jlelli@redhat.com, hch@infradead.org,
        bhelgaas@google.com, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, thomas.lendacky@amd.com,
        jiri@nvidia.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        lgoncalv@redhat.com
Subject: Re: [PATCH v4 4/4] PCI: Limit pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <20200928183529.471328-5-nitesh@redhat.com>
References: <20200928183529.471328-1-nitesh@redhat.com> <20200928183529.471328-5-nitesh@redhat.com>
Date:   Tue, 20 Oct 2020 16:16:52 +0200
Message-ID: <87v9f57zjf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28 2020 at 14:35, Nitesh Narayan Lal wrote:
>  
> +	hk_cpus = housekeeping_num_online_cpus(HK_FLAG_MANAGED_IRQ);
> +
> +	/*
> +	 * If we have isolated CPUs for use by real-time tasks, to keep the
> +	 * latency overhead to a minimum, device-specific IRQ vectors are moved
> +	 * to the housekeeping CPUs from the userspace by changing their
> +	 * affinity mask. Limit the vector usage to keep housekeeping CPUs from
> +	 * running out of IRQ vectors.
> +	 */

This is not true for managed interrupts. The interrupts affinity of
those cannot be changed by user space.

> +	if (hk_cpus < num_online_cpus()) {
> +		if (hk_cpus < min_vecs)
> +			max_vecs = min_vecs;
> +		else if (hk_cpus < max_vecs)
> +			max_vecs = hk_cpus;
> +	}

So now with that assume a 16 core machine (HT off for simplicity)

17 Requested interrupts (1 general, 16 queues)

Managed interrupts will allocate

   1  general interrupt which is free movable by user space
   16 managed interrupts for queues (one per CPU)

This allows the driver to have 16 queues, i.e. one queue per CPU. These
interrupts are only used when an application on a CPU issues I/O.

With the above change this will result

   1  general interrupt which is free movable by user space
   1  managed interrupts (possible affinity to all 16 CPUs, but routed
      to housekeeping CPU as long as there is one online)

So the device is now limited to a single queue which also affects the
housekeeping CPUs because now they have to share a single queue.

With larger machines this gets even worse.

So no. This needs way more thought for managed interrupts and you cannot
do that at the PCI layer. Only the affinity spreading mechanism can do
the right thing here.

Thanks,

        tglx
