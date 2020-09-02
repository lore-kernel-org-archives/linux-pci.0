Return-Path: <SRS0=cO2L=CL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3D0C433E7
	for <linux-pci@archiver.kernel.org>; Wed,  2 Sep 2020 22:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2124020767
	for <linux-pci@archiver.kernel.org>; Wed,  2 Sep 2020 22:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599087291;
	bh=1hW5kK/Njw86oLEnRxfrgC0dQ6uHQ5uW+j2YeKTOfco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vMtcjXip0i00QHqZMHDMNQNWiwWIN90mirTz6wp0EdrMB+CnJ6iPzcIb7MSXY8ezg
	 8FhpvNmHRybx6pMj8sLIAOF0cBWAgE++PzTaHlcvKarmq8YvLlqw8Qqu1lP83NUKCb
	 6wC4AnRjD2EZ35pnStca3tXxpUe/aqE6mHzFcovg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBWyu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgIBWyu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 18:54:50 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3AD02078E;
        Wed,  2 Sep 2020 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599087288;
        bh=1hW5kK/Njw86oLEnRxfrgC0dQ6uHQ5uW+j2YeKTOfco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggliH6W8V3O+VQRG6Wbx2htraCrN+um/4joPY1T1lhD92f4ORXXvwbpLqURZ/ma4c
         vHKpruHPmtZcN4Y2THfRfn5hrIIlRezEgl922fvOGb6JTr4ZMu8Cv6k0N8pCF5RtM8
         YLKkIFUo8wnIwplAgCuOQfSXeiXnujIePzXXkGBA=
Date:   Thu, 3 Sep 2020 07:54:39 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     David Fugate <david.fugate@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        jonathan.derrick@intel.com, Mario.Limonciello@dell.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Huffman, Amber" <amber.huffman@intel.com>, david.fugate@intel.com
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Message-ID: <20200902225439.GA24219@redsun51.ssa.fujisawa.hgst.com>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
 <20200825062320.GA27116@infradead.org>
 <08080FC7-861B-472A-BD7D-02D33926677F@canonical.com>
 <20200825065634.GA2691@infradead.org>
 <c19782e36c9b4a8319f2f16102e1823dc6a33d3c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19782e36c9b4a8319f2f16102e1823dc6a33d3c.camel@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 01:48:19PM -0600, David Fugate wrote:
> Over the years, I've been forwarded numerous emails from VMD customers 
> praising it's ability to prevent Linux kernel panics upon hot-removals
> and inserts of U.2 NVMe drives.

The same nvme and pcie hotplug drivers are used with or without VMD
enabled. Where are the bug reports for linux kernel panics? We have a
very real interest in fixing such issues.
