Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5337EC433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 07:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABB220858
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 07:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABB220858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeITNHa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:07:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34434 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbeITNHa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2018 09:07:30 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2tKn-0000Ie-IE; Thu, 20 Sep 2018 09:25:09 +0200
Date:   Thu, 20 Sep 2018 09:25:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
cc:     Pu Wen <puwen@hygon.cn>, "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
In-Reply-To: <d05c7aa5-05ba-5ac2-c70f-414d9539925f@amd.com>
Message-ID: <alpine.DEB.2.21.1809200923190.1425@nanos.tec.linutronix.de>
References: <cover.1536550549.git.puwen@hygon.cn> <035e5d0a4f2a0edf68ca0f1019e47b878eaa5da6.1536550550.git.puwen@hygon.cn> <d05c7aa5-05ba-5ac2-c70f-414d9539925f@amd.com>
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

On Wed, 19 Sep 2018, Lendacky, Thomas wrote:
> 
> To be compatible with "before this patch" you should probably do:
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> 		root_ids = hygon_root_ids;
> 		misc_ids = hygon_nb_misc_ids;
> 		link_ids = hygon_nb_link_ids;
> 	} else {
> 		root_ids = amd_root_ids;
> 		misc_ids = amd_nb_misc_ids;
> 		link_ids = amd_nb_link_ids;
> 	}
> 
> That way they are always the AMD values if not your chip.

And please can we have a comment why this is called on anything which is
not AMD or HYGON. It's all but obvious and clearly unexpected.

Thanks,

	tglx
