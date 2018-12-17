Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E8C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 19:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5BC21848
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 19:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545074882;
	bh=Dl221tPebdxGRptWzz4ORsCN/ltAFjr4Rdre6Ww+8Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=salFEANKUiO9fIRltb9Jwd0J08jKqj/Zj9Vh9AyxETzgSYwV2VL1f98y+XpmiToTX
	 6kl5RZLRkt5zwYp/RI/GKVVvZ11wp2WvqhhKc2sEDMAqTeLOS+n/TNbtq+GBnZQz7a
	 m5Y8T9/+c8k9n5Gvk96Kho+ol3/ELMszcoORHBSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeLQT2C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbeLQT2B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 14:28:01 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBCC214D8;
        Mon, 17 Dec 2018 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545074881;
        bh=Dl221tPebdxGRptWzz4ORsCN/ltAFjr4Rdre6Ww+8Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSbzBN6WNqin+3I8hmTRjU8CCiCaxlh6p3HRMovojs7VkcpvuTCFnv9tjbS6sFver
         jEMXedQnHlxlNoAdxssDZ19fPbZlFsPzBt7k3OYOuhw9raOyPLGSsHTADqZXG8Jfol
         OFk5j76xXqEL20MhixdBMwUWbURXt89uf08wB+yg=
Date:   Mon, 17 Dec 2018 13:28:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>
Subject: Re: [PATCH v1 2/2] PCI/ACPI: alloc ACPI to be built without PCI
 support
Message-ID: <20181217192800.GB28981@google.com>
References: <20181201204137.1786-1-okaya@kernel.org>
 <20181201204137.1786-2-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201204137.1786-2-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/alloc/Allow/ in subject

On Sat, Dec 01, 2018 at 08:41:36PM +0000, Sinan Kaya wrote:
> We are compiling PCI code today for systems with ACPI and no PCI
> device present. Remove the useless code and reduce the tight
> dependency.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
