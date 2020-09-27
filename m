Return-Path: <SRS0=D2E3=DE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B11C47420
	for <linux-pci@archiver.kernel.org>; Sun, 27 Sep 2020 04:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69C8207EA
	for <linux-pci@archiver.kernel.org>; Sun, 27 Sep 2020 04:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgI0EZu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 27 Sep 2020 00:25:50 -0400
Received: from smtprelay0047.hostedemail.com ([216.40.44.47]:60954 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726478AbgI0EZu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 00:25:50 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 00:25:49 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 1C49018009059
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2020 04:16:37 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C0D3C181D330D;
        Sun, 27 Sep 2020 04:16:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cart93_150a0df27176
X-Filterd-Recvd-Size: 1792
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Sep 2020 04:16:33 +0000 (UTC)
Message-ID: <5e22dba6543b4fc09c5c18c839eab42bd31b18f6.camel@perches.com>
Subject: Re: [PATCH 4/5 V2] PCI: only return true when dev io state is
 really changed
From:   Joe Perches <joe@perches.com>
To:     Ethan Zhao <haifeng.zhao@intel.com>, bhelgaas@google.com,
        oohall@gmail.com, ruscur@russell.cc, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, stuart.w.hayes@gmail.com,
        mr.nuke.me@gmail.com, mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com
Date:   Sat, 26 Sep 2020 21:16:32 -0700
In-Reply-To: <20200927032829.11321-5-haifeng.zhao@intel.com>
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
         <20200927032829.11321-5-haifeng.zhao@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2020-09-26 at 23:28 -0400, Ethan Zhao wrote:
> simplify the pci_dev_set_io_state() function to only return true
> when dev->error_state is changed.
[]
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
[]
> @@ -362,35 +362,11 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
>  	bool changed = false;
[]
> +	if (dev->error_state == new)
> +		return changed;
> +
> +	dev->error_state = new;
> +	changed = true;
>  	return changed;
>  }

This would be simpler removing the unnecessary
changed automatic

...

	if (dev->error_state == new)
		return false;

	dev->error_state = new;

	return true;
}


