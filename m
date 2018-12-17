Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38206C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0643A20874
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545066068;
	bh=6auooRPsrcQk7GV+dsoc0ZOfh+31FXAnH3P5a0TMKTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sSDmGA/jyXaBDSuPQAEXQ1z4Mw3Lw55CIgqxLe8wJ5CNA5j7UJ10mFhTHIyt76SxT
	 cIIHoBdZB2KlNWMoPK1TTMZbt7pMiR97KeKp1C/bX7IMS/xu8f3VTCt7MiEqpRKqr1
	 vk/LmqeNt4XfeATH2ZUB5Yljp88xerQUgYraiWYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeLQRBC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:01:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44332 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeLQRBC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 12:01:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so13026392wrt.11;
        Mon, 17 Dec 2018 09:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LvX8+wXVi6Ez+Z+a8Vcs5LlmR6VFE/NIH6mI0wRHq3s=;
        b=Hr1bhpVqnXrEzKg/3F+HqZiZxRYuAGtfQ9fPWtxRQ4QjGx+9Umw7yHpBALn/qyU8sQ
         RabjcAe1MuNGz9fCsw/0Hj5zNTJJB3lC4ffm3Z0zM6grkgdTLEPepH2qkTv9Rz+EAEps
         oQU76TBzGIf49thieCaSEJc/NbHDyJGkzdSqw24Vju4yBFo4MRSE1o6d9KHDAFzqBON1
         Vp8mDOB4/0WVCi/TmFqlzkqhKBymCOodnOBty4JBheQbPZorCPNIQE4HlHDUhaV27XAZ
         AK6ZfGtp0rg53QiqfYB+Qts7bQENatlaky6rb6K9XTohaUcr+LMS1d6aPNWI5bff+u4P
         l1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LvX8+wXVi6Ez+Z+a8Vcs5LlmR6VFE/NIH6mI0wRHq3s=;
        b=gkHcY0Vtt8aQwOSQQhyFgHmclShm+JdX0hhE4/0uvjEQA4fOxB3tN2D6tORbwcf8h5
         Rst+/UfiyhBgmajSI4Db39qt4xT/DdVmREnYHFsEQHRfNdNmVZwfiYxAf+K06fU+xIFM
         sGEyhq5Is97zkuCm4jaLiEpUsP5Ccss/kiVF7p7jAGNAm4eIsjgHMaJHb3Gkhg7iwwcY
         lqR6+TbqNpxOrqBp5HCNtvPM4LFXZqKZ3sF2SkAAzQ/3JFz4Z6smHl+g71Y28O+LfWiQ
         xTRakXyN6k8LUPiDsdF+Red/nsgXXh5UI+js4ruCD93vGRK3tSMKdnmVWUBEHNXoM3ON
         RNhA==
X-Gm-Message-State: AA+aEWbrvj7iGW8ONKDXc7xS25MhLWFlStSE+ye44KT5M8zYZaCkJiB8
        y+D73M2LM9LE3eDlw8HUJs4=
X-Google-Smtp-Source: AFSGD/Xu9e3AICDr+A0csoS2Y/N4kHbkZOZewvvesH4KPdp6P366G9PyH63BB2hChCXG61a8liJffw==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr11602804wru.28.1545066060157;
        Mon, 17 Dec 2018 09:01:00 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q3sm859631wrn.84.2018.12.17.09.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:00:59 -0800 (PST)
Date:   Mon, 17 Dec 2018 18:00:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Otavio Pontes <otavio.pontes@intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: [PATCH v10 3/6] PCI/ACPI: Allow ACPI to be built without
 CONFIG_PCI set
Message-ID: <20181217170056.GA20499@gmail.com>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-4-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215010247.26101-4-okaya@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


* Sinan Kaya <okaya@kernel.org> wrote:

> We are compiling PCI code today for systems with ACPI and no PCI
> device present. Remove the useless code and reduce the tight
> dependency.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # PCI parts

If this is targeted for the ACPI tree:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
