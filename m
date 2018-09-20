Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFF5ECE561
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 09:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C10121526
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 09:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C10121526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeITPWJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:22:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35445 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbeITPWJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2018 11:22:09 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2vQb-00035q-Qv; Thu, 20 Sep 2018 11:39:17 +0200
Date:   Thu, 20 Sep 2018 11:39:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pu Wen <puwen@hygon.cn>
cc:     Rong Chen <rong.a.chen@intel.com>, bp@alien8.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, lkp@01.org
Subject: Re: [LKP] [x86/pci] 7ffb31888c: PANIC:early_exception
In-Reply-To: <7e9e862a-e890-775f-ed92-74c591c7deb6@hygon.cn>
Message-ID: <alpine.DEB.2.21.1809201138230.3243@nanos.tec.linutronix.de>
References: <20180919031923.GC8820@shao2-debian> <4f5166f8-97b8-a58f-3e5d-19d1751a4601@hygon.cn> <dfc09a36-cfc5-0479-a862-696c224f9a19@intel.com> <7e9e862a-e890-775f-ed92-74c591c7deb6@hygon.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 20 Sep 2018, Pu Wen wrote:
> On 2018/9/20 8:26, Rong Chen wrote:
> > On 09/19/2018 09:53 PM, Pu Wen wrote:
> > > I cannot reproduce this panic on Hygon Dhyana platform. I tired lkp-tests
> > > both in Ubuntu 16.04 (with gcc-5) and Ubuntu 18.04 (with gcc-7).
> > > What kind of host do you use to run the qemu? A Intel one or AMD one?
> > It's a Intel one,
> > 
> > model: Nehalem-EX
> > memory: 224G
> > nr_node: 4
> > nr_cpu: 64
> > nr_socket: 4
> > brand: Intel(R) Xeon(R) CPU X7560 @ 2.27GHz
> 
> I reproduced the PANIC by running lkp-tests with a Intel machine.
> 
> The reason is that the function early_is_amd_nb is called even if
> running on Intel machine. At this case the misc_ids is NULL so the
> PANIC occur.
> 
> I'll rework a patch to solve this problem, either restore the default
> value of misc_ids with the original AMD one or not call early_is_amd_nb
> on Intel platform.

Return when !AMD and !HYGON is the right thing to do. No point in checking
device ids which cannot happen in the first place.

Thanks,

	tglx
